import 'package:bitcoin_map/presentation/components/user_location_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../domain/user_location_provider.dart';
import '../components/circle_button_view.dart';
import '../components/elements_marker_cluster_view.dart';
import '../components/header_view.dart';
import 'filter_screen.dart';

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
    return Scaffold(
      appBar: null,
      body: Stack(
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
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Header(),
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
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => const FilterScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(0.0, 1.0);
                const end = Offset.zero;
                const curve = Curves.ease;

                final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                final offsetAnimation = animation.drive(tween);

                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              },
            ),
          );
        },
        child: const Icon(Icons.filter_list),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
