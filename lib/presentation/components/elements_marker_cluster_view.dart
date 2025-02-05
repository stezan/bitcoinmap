import 'package:bitcoin_map/presentation/components/loading_overlay_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';
import '../../domain/elements_provider.dart';
import '../../domain/model/marker_with_data_model.dart';
import '../components/cluster_container_view.dart';
import '../components/element_details_view.dart';

const int maxClusterRadius = 100;
const double clusterSize = 40;

class ElementsMarkerCluster extends ConsumerStatefulWidget {
  final MapController mapController;

  const ElementsMarkerCluster({super.key, required this.mapController});

  @override
  ElementsMarkerClusterState createState() => ElementsMarkerClusterState();
}

class ElementsMarkerClusterState extends ConsumerState<ElementsMarkerCluster> {
  final ValueNotifier<List<MarkerWithData>> displayedMarkersNotifier = ValueNotifier([]);

  @override
  void initState() {
    super.initState();
    widget.mapController.mapEventStream.listen((event) {
      if (event is MapEventMove) {
        _loadNextBatch(ref.read(filteredMarkersProvider).value ?? []);
        final mapBounds = widget.mapController.camera.visibleBounds;
        //ref.read(filterProvider.notifier).setBounds(mapBounds);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final markersAsyncValue = ref.watch(filteredMarkersProvider);

    return markersAsyncValue.when(
      data: (markers) {
        _loadNextBatch(markers);

        return ValueListenableBuilder<List<MarkerWithData>>(
          valueListenable: displayedMarkersNotifier,
          builder: (context, displayedMarkers, child) {
            return MarkerClusterLayerWidget(
              options: MarkerClusterLayerOptions(
                maxClusterRadius: maxClusterRadius,
                size: const Size(clusterSize, clusterSize),
                alignment: Alignment.center,
                padding: const EdgeInsets.all(50),
                maxZoom: 15,
                showPolygon: false,
                onMarkerTap: (marker) {
                  final element = (marker as MarkerWithData).element;
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return ElementDetailsSheet(element: element);
                    },
                    showDragHandle: true,
                  );
                },
                markers: displayedMarkers,
                builder: (context, markers) {
                  return ClusterContainer(markerCount: markers.length);
                },
              ),
            );
          },
        );
      },
      loading: () => const Center(child: LoadingOverlayView()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }

  void _loadNextBatch(List<MarkerWithData> markers) {
    final mapBounds = widget.mapController.camera.visibleBounds;
    final markersInBounds = markers.where((marker) {
      return mapBounds.contains(marker.point);
    }).toList();

    displayedMarkersNotifier.value = [...markersInBounds];
  }
}
