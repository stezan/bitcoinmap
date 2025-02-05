import 'package:bitcoin_map/presentation/components/main_button_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/filter_provider.dart';
import '../../domain/shop_types_provider.dart';
import '../components/shop_type_filter_view.dart';

class FilterScreen extends ConsumerStatefulWidget {
  const FilterScreen({super.key});

  @override
  FilterScreenState createState() => FilterScreenState();
}

class FilterScreenState extends ConsumerState<FilterScreen> {
  String _searchQuery = '';
  String? _selectedShopType;

  @override
  void initState() {
    super.initState();
    final filter = ref.read(filterProvider.notifier).shopType;
    if (filter != null) {
      _selectedShopType = filter;
    }
  }

  @override
  Widget build(BuildContext context) {
    final shopTypes = ref.watch(shopTypesProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Filter shops'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Search shop types',
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (query) {
                    setState(() {
                      _searchQuery = query;
                    });
                  },
                ),
                const SizedBox(height: 16),
                shopTypes.when(
                  data: (shopTypes) {
                    final filteredShopTypes =
                        shopTypes.where((shopType) => shopType.toLowerCase().contains(_searchQuery.toLowerCase())).toList().toSet();

                    return ShopTypeFilter(
                      shopTypes: filteredShopTypes,
                      selectedShopType: _selectedShopType,
                      onSelected: (shopType) {
                        setState(() {
                          _selectedShopType = shopType;
                        });
                      },
                    );
                  },
                  loading: () => const CircularProgressIndicator(),
                  error: (error, stack) => Text('Error: $error'),
                ),
                const Spacer(),
                Center(
                  child: MainButtonView(
                      onPressed: () {
                        ref.read(filterProvider.notifier).setFilter(_selectedShopType);
                        Navigator.pop(context, _selectedShopType);
                      },
                      text: 'Apply filter'),
                )
              ],
            ),
          ),
        ));
  }
}
