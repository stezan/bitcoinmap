import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/shops_provider.dart';
import '../components/shops_list_view.dart';

class ShopsListScreen extends ConsumerWidget {
  const ShopsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shopsAsyncValue = ref.watch(shopsProvider);

    return shopsAsyncValue.when(
      data: (shops) {
        return ShopsListView(shops: shops);
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
