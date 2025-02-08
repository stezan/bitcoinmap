import 'package:bitcoin_map/domain/model/bitcoin_shop_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/shops_provider.dart';
import '../components/shops_list_view.dart';

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
            Container(
              padding: EdgeInsets.all(8),
              color: Theme.of(context).colorScheme.onPrimary,
              child: Row(
                children: [
                  Text("${filteredShops.length.toString()} shops found"),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      showSearch(
                        context: context,
                        delegate: ShopsSearchDelegate(
                          shops: shops,
                          onSearch: (query) {
                            setState(() {
                              _searchQuery = query;
                            });
                          },
                        ),
                      );
                    },
                    icon: Icon(Icons.search),
                  ),
                ],
              ),
            ),
            Expanded(child: ShopsListView(shops: filteredShops)),
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

    return ShopsListView(shops: results);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = shops.where((shop) {
      return shop.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ShopsListView(shops: suggestions);
  }
}
