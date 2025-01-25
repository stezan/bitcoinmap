import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterNotifier extends StateNotifier<String?> {
  FilterNotifier() : super(null);

  String? get filter => state;

  void setFilter(String? filter) {
    state = filter;
  }
}

final filterProvider = StateNotifierProvider<FilterNotifier, String?>((ref) {
  return FilterNotifier();
});
