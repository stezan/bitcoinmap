import 'package:flutter/material.dart';
import 'list_ui_model.dart';

class ShopsListView extends StatelessWidget {
  final List<ListUiModel> models;
  final ValueChanged<int> onTap;

  const ShopsListView({super.key, required this.models, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      separatorBuilder: (context, index) => const Divider(),
      itemCount: models.length,
      itemBuilder: (context, index) {
        final shop = models[index];
        return ListTile(
          title: Text(shop.title, style: TextStyle(fontSize: 16), maxLines: 1, overflow: TextOverflow.ellipsis),
          subtitle: shop.subtitle != null ? Text(shop.subtitle!, style: TextStyle(fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis) : null,
          trailing: const Icon(Icons.arrow_forward_ios, size: 12),
          onTap: () {
            onTap(index);
          },
        );
      },
    );
  }
}
