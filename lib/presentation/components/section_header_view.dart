import 'package:flutter/material.dart';

class SectionHeaderView extends StatelessWidget {
  final int count;
  final SearchDelegate searchDelegate;

  const SectionHeaderView({
    super.key,
    required this.count,
    required this.searchDelegate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      color: Theme.of(context).colorScheme.onPrimary,
      child: Row(
        children: [
          Text(
            "$count found",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Spacer(),
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: searchDelegate);
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
    );
  }
}
