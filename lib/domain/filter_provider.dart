import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DisplayedMarkersNotifier extends StateNotifier<int?> {
  DisplayedMarkersNotifier() : super(null);

  void setDisplayedMarkers(int number) {
    state = number;
  }
}

final displayedMarkersProvider = StateNotifierProvider<DisplayedMarkersNotifier, int?>((ref) {
  return DisplayedMarkersNotifier();
});

class FilterNotifier extends StateNotifier<FilterState> {
  FilterNotifier() : super(FilterState());

  String? get shopType => state.shopType;

  LatLngBounds? get bounds => state.bounds;

  void setFilter(String? shopType) {
    state = state.copyWithShopType(shopType);
  }

  void setBounds(LatLngBounds? bounds) {
    state = state.copyWithBounds(bounds);
  }
}

final filterProvider = StateNotifierProvider<FilterNotifier, FilterState>((ref) {
  return FilterNotifier();
});

class FilterState {
  final String? shopType;
  final LatLngBounds? bounds;

  FilterState({this.shopType, this.bounds});

  FilterState copyWithBounds(LatLngBounds? bounds) {
    return FilterState(
      shopType: shopType,
      bounds: bounds,
    );
  }

  FilterState copyWithShopType(String? shopType) {
    return FilterState(
      shopType: shopType,
      bounds: bounds,
    );
  }
}
