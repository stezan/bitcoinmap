import 'package:bitcoin_map/presentation/components/shops_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/elements_provider.dart';

class BitcoinListScreen extends ConsumerWidget {
  const BitcoinListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shopsAsyncValue = ref.watch(filteredShopsProvider);

    return shopsAsyncValue.when(
      data: (shops) {
        return ShopsListView(shops: shops);
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
