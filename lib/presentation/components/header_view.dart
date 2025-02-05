import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/elements_provider.dart';
import '../../domain/filter_provider.dart';
import '../../utils/utils.dart';

class Header extends ConsumerWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final markersAsyncValue = ref.watch(filteredMarkersProvider);
    final selectedShopType = ref.watch(filterProvider);

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8),
      color: Theme.of(context).colorScheme.primary.withOpacity(1),
      child: Text(
        markersAsyncValue.when(
          data: (markers) => selectedShopType != null
              ? '${humanizeNumberWithDotSeparator(markers.length)} ${selectedShopType.toLowerCase()} places around the world'
              : '${humanizeNumberWithDotSeparator(markers.length)} places around the world',
          loading: () => 'Loading...',
          error: (error, stackTrace) => 'Error: $error',
        ),
        style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onPrimary),
      ),
    );
  }
}
