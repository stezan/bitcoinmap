import 'package:bitcoin_map/presentation/components/visualisation_type_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/filter_provider.dart';
import '../../utils/utils.dart';
import '../screen/filter_screen.dart';

class Header extends ConsumerWidget {
  final ValueChanged<int> onChanged;

  const Header({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final numberOfMarkers = ref.watch(displayedMarkersProvider);
    final filter = ref.watch(filterProvider);

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8),
      color: Theme.of(context).colorScheme.onPrimary,
      child: Row(
        children: [
          GestureDetector(
            child: Icon(
              Icons.filter_list,
              color: filter.shopType != null ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurface,
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
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: Text(
              getLabelText(numberOfMarkers, filter.shopType),
              key: ValueKey<String>(getLabelText(numberOfMarkers, filter.shopType)),
              style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface),
            ),
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

  String getLabelText(int? numberOfMarkers, String? shopType) {
    if (numberOfMarkers == null) {
      return 'Loading...';
    }
    if (shopType != null) {
      return '${humanizeNumberWithDotSeparator(numberOfMarkers)} $shopType places in the area';
    }
    return '${humanizeNumberWithDotSeparator(numberOfMarkers)} places in the area';
  }
}
