import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/user_location_provider.dart';

class UserLocationLayer extends ConsumerWidget {
  final MapController mapController;

  const UserLocationLayer({super.key, required this.mapController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocation = ref.watch(userLocationProvider);

    if (currentLocation == null) {
      return Container();
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      mapController.move(
        LatLng(currentLocation.latitude!, currentLocation.longitude!),
        mapController.camera.zoom,
      );
    });

    return CircleLayer(
      circles: [
        CircleMarker(
          point: LatLng(currentLocation.latitude!, currentLocation.longitude!),
          color: Colors.blue.withOpacity(0.7),
          borderStrokeWidth: 1,
          borderColor: Colors.blue,
          radius: 8,
        ),
      ],
    );
  }
}
