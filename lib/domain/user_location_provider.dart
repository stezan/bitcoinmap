import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';

final userLocationProvider = StateNotifierProvider<UserLocationNotifier, LocationData?>((ref) {
  return UserLocationNotifier();
});

class UserLocationNotifier extends StateNotifier<LocationData?> {
  UserLocationNotifier() : super(null) {
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    final location = Location();
    final currentLocation = await location.getLocation();
    state = currentLocation;
  }
}