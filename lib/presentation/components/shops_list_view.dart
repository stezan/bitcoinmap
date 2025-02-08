import 'package:bitcoin_map/domain/model/bitcoin_shop_model.dart';
import 'package:flutter/material.dart';
import '../components/element_details_view.dart';

class ShopsListView extends StatelessWidget {
  final List<BitcoinShopModel> shops;

  const ShopsListView({super.key, required this.shops});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
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
            title: Text(
              shop.name,
              style: TextStyle(fontSize: 16),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: shop.getAddress() != null
                ? Text(
                    shop.getAddress()!,
                    style: TextStyle(fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                : null,
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 12,
            ),
          ),
        );
      },
    );
  }
}
