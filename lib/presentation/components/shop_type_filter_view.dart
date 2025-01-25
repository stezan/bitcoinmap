import 'package:flutter/material.dart';

class ShopTypeFilter extends StatelessWidget {
  final Set<String?> shopTypes;
  final String? selectedShopType;
  final ValueChanged<String?> onSelected;

  const ShopTypeFilter({
    super.key,
    required this.shopTypes,
    required this.selectedShopType,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final List<String?> sortedShopTypes = shopTypes.toList();
    if (selectedShopType != null && sortedShopTypes.contains(selectedShopType)) {
      sortedShopTypes.remove(selectedShopType);
      sortedShopTypes.insert(0, selectedShopType);
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height - 200,
      child: SingleChildScrollView(
        child: Wrap(
          direction: Axis.horizontal,
          spacing: 8.0,
          runSpacing: 4.0,
          children: sortedShopTypes.map((shopType) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: shopType != null
                  ? ChoiceChip(
                      label: Text(shopType),
                      selected: selectedShopType == shopType,
                      onSelected: (selected) {
                        onSelected(selected ? shopType : null);
                      },
                    )
                  : const SizedBox.shrink(),
            );
          }).toList(),
        ),
      ),
    );
  }
}
