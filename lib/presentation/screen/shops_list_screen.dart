import 'package:bitcoin_map/domain/model/bitcoin_shop_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/shops_provider.dart';
import '../components/element_details_view.dart';
import '../components/section_header_view.dart';
import '../components/list/shops_list_view.dart';
import 'package:bitcoin_map/presentation/components/list/list_ui_model.dart';

class ShopsListScreen extends ConsumerStatefulWidget {
  const ShopsListScreen({super.key});

  @override
  _ShopsListScreenState createState() => _ShopsListScreenState();
}

class _ShopsListScreenState extends ConsumerState<ShopsListScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final shopsAsyncValue = ref.watch(shopsProvider);

    return shopsAsyncValue.when(
      data: (shops) {
        final filteredShops = shops.where((shop) {
          return shop.name.toLowerCase().contains(_searchQuery.toLowerCase());
        }).toList();

        return Column(
          children: [
            SectionHeaderView(
              count: filteredShops.length,
              searchDelegate: ShopsSearchDelegate(
                shops: shops,
                onSearch: (query) {
                  setState(() {
                    _searchQuery = query;
                  });
                },
              ),
            ),
            Expanded(
              child: ShopsListView(
                  models: filteredShops.map((shop) => ListUiModel(title: shop.name, subtitle: shop.getAddress())).toList(),
                  onTap: (index) {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return ElementDetailsSheet(element: shops[index]);
                      },
                      showDragHandle: true,
                    );
                  }),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}

class ShopsSearchDelegate extends SearchDelegate<String> {
  final List<BitcoinShopModel> shops;
  final ValueChanged<String> onSearch;

  ShopsSearchDelegate({required this.shops, required this.onSearch});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          onSearch(query);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = shops.where((shop) {
      return shop.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ShopsListView(models: results.map((shop) => ListUiModel(title: shop.name, subtitle: shop.getAddress())).toList(), onTap: (index) {});
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = shops.where((shop) {
      return shop.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ShopsListView(models: suggestions.map((shop) => ListUiModel(title: shop.name, subtitle: shop.getAddress())).toList(), onTap: (index) {});
  }
}
