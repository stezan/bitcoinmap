import 'package:bitcoin_map/presentation/components/visualisation_type_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/elements_provider.dart';
import '../../domain/filter_provider.dart';
import '../../utils/utils.dart';
import '../screen/filter_screen.dart';

class Header extends ConsumerWidget {
  final ValueChanged<int> onChanged;

  const Header({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final markersAsyncValue = ref.watch(filteredMarkersProvider);
    final selectedShopType = ref.watch(filterProvider);

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8),
      color: Theme.of(context).colorScheme.primary.withOpacity(1),
      child: Row(
        children: [
          GestureDetector(
            child: Icon(
              Icons.filter_list,
              color: Theme.of(context).colorScheme.onPrimary,
              size: 32,
            ),
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const FilterScreen(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    const begin = Offset(0.0, 1.0);
                    const end = Offset.zero;
                    const curve = Curves.ease;

                    final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                    final offsetAnimation = animation.drive(tween);

                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
                ),
              );
            },
          ),
          const SizedBox(width: 8),
          Text(
            markersAsyncValue.when(
              data: (markers) => selectedShopType.shopType != null
                  ? '${humanizeNumberWithDotSeparator(markers.length)} ${selectedShopType.shopType!.toLowerCase()} places in the area'
                  : '${humanizeNumberWithDotSeparator(markers.length)} places in the area',
              loading: () => 'Loading...',
              error: (error, stackTrace) => 'Error: $error',
            ),
            style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onPrimary),
          ),
          const Spacer(),
          VisualisationType(
            onChanged: (selected) => {onChanged(selected)},
            initialIndex: 0,
          )
        ],
      ),
    );
  }
}
