import 'package:bitcoin_map/presentation/screen/bitcoin_map_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/header_view.dart';
import 'bitcoin_list_screen.dart';

class AroundYouScreen extends ConsumerStatefulWidget {
  const AroundYouScreen({super.key});

  @override
  ConsumerState<AroundYouScreen> createState() => _AroundYouScreenScreenState();
}

class _AroundYouScreenScreenState extends ConsumerState<AroundYouScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Column(
        children: [
          Header(
            onChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: const [BitcoinMapScreen(), BitcoinListScreen()],
            ),
          ),
        ],
      ),
    );
  }
}
