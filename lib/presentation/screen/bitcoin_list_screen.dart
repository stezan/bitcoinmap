import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/elements_provider.dart';

class BitcoinListScreen extends ConsumerWidget {
  const BitcoinListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final markersAsyncValue = ref.watch(filteredMarkersProvider);

    return markersAsyncValue.when(
      data: (markers) {
        return ListView.builder(
          itemCount: markers.length,
          itemBuilder: (context, index) {
            final marker = markers[index];
            return ListTile(
              title: Text(marker.element.name),
              onTap: () {
                // Handle tap on the list item if needed
              },
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
