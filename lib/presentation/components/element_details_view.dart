import 'package:bitcoin_map/presentation/components/shop_type_view.dart';
import 'package:flutter/material.dart';
import '../../domain/model/bitcoin_shop_model.dart';
import 'element_details_action_view.dart';

class ElementDetailsSheet extends StatelessWidget {
  final BitcoinShopModel element;

  const ElementDetailsSheet({super.key, required this.element});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(element.name, style: textTheme.headlineSmall),
          element.description == null ? const SizedBox() : Text(element.description!, style: textTheme.bodyMedium),
          element.shopType == null
              ? const SizedBox()
              : Column(
                  children: [
                    const SizedBox(height: 4.0),
                    ShopTypeView(
                      shopType: element.shopType!,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ],
                ),
          element.getAddress() == null
              ? const SizedBox()
              : Column(
                  children: [
                    const SizedBox(height: 8.0),
                    Text(element.getAddress()!, style: textTheme.bodyMedium),
                  ],
                ),
          const SizedBox(height: 16.0),
          ElementDetailsActionsView(element: element),
        ],
      ),
    );
  }
}
