import 'package:bitcoin_map/presentation/components/element_details_view.dart';
import 'package:bitcoin_map/presentation/components/list/list_ui_model.dart';
import 'package:bitcoin_map/presentation/components/list/shops_list_view.dart';
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
        return ShopsListView(
            models: shops.map((shop) => ListUiModel(title: shop.name, subtitle: shop.getAddress())).toList(),
            onTap: (index) {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return ElementDetailsSheet(element: shops[index]);
                },
                showDragHandle: true,
              );
            });
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
