import 'package:bitcoin_map/presentation/components/user_location_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../domain/filter_provider.dart';
import '../../domain/user_location_provider.dart';
import '../components/circle_button_view.dart';
import '../components/elements_marker_cluster_view.dart';

class BitcoinMapScreen extends ConsumerStatefulWidget {
  const BitcoinMapScreen({super.key});

  @override
  BitcoinMapViewState createState() => BitcoinMapViewState();
}

class BitcoinMapViewState extends ConsumerState<BitcoinMapScreen> {
  final MapController _mapController = MapController();

  final Widget tileLayer = TileLayer(
    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
    userAgentPackageName: 'com.stzan.bitcoinmap',
    panBuffer: 0,
    tileProvider: CancellableNetworkTileProvider(),
  );

  final Widget attribution = RichAttributionWidget(
    alignment: AttributionAlignment.bottomLeft,
    attributions: [
      TextSourceAttribution(
        'OpenStreetMap contributors',
        onTap: () => {launchUrl(Uri.parse('https://openstreetmap.org/copyright'))},
      ),
    ],
  );

  void _centerMapOnUserLocation() {
    final currentLocation = ref.watch(userLocationProvider);
    if (currentLocation != null) {
      _mapController.move(
        LatLng(currentLocation.latitude!, currentLocation.longitude!),
        _mapController.camera.zoom,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: const MapOptions(
              initialZoom: 14.0,
              maxZoom: 19.0,
              minZoom: 3.0,
              initialCenter: LatLng(41.8719, 12.5674),
              interactionOptions: InteractionOptions(
                flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
              )),
          children: [
            tileLayer,
            attribution,
            ElementsMarkerCluster(mapController: _mapController),
            UserLocationLayer(mapController: _mapController),
          ],
        ),
        Positioned(
          bottom: 16,
          right: 0,
          child: CircularIconButton(
            onPressed: _centerMapOnUserLocation,
            icon: Icons.my_location,
          ),
        ),
      ],
    );
  }
}
