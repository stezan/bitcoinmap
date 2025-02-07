import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/elements_provider.dart';
import '../components/element_details_view.dart';

class BitcoinListScreen extends ConsumerWidget {
  const BitcoinListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shopsAsyncValue = ref.watch(filteredShopsProvider);

    return shopsAsyncValue.when(
      data: (shops) {
        return ListView.separated(
          separatorBuilder: (context, index) => const Divider(),
          itemCount: shops.length,
          itemBuilder: (context, index) {
            final shop = shops[index];
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return ElementDetailsSheet(element: shop);
                  },
                  showDragHandle: true,
                );
              },
              child: ListTile(
                title: Text(shop.name),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
