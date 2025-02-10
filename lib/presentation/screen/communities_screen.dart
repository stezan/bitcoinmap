import 'package:bitcoin_map/domain/model/community_model.dart';
import 'package:bitcoin_map/presentation/components/list/list_ui_model.dart';
import 'package:bitcoin_map/presentation/components/list/shops_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bitcoin_map/domain/communities_provider.dart';
import '../components/section_header_view.dart';

class CommunitiesScreen extends ConsumerStatefulWidget {
  const CommunitiesScreen({super.key});

  @override
  CommunitiesScreenState createState() => CommunitiesScreenState();
}

class CommunitiesScreenState extends ConsumerState<CommunitiesScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final shopsAsyncValue = ref.watch(communitiesProvider);

    return shopsAsyncValue.when(
      data: (communities) {
        final filteredCommunities = communities.where((shop) {
          return shop.name.toLowerCase().contains(_searchQuery.toLowerCase());
        }).toList();

        return Column(
          children: [
            SectionHeaderView(
              count: filteredCommunities.length,
              searchDelegate: CommunitiesSearchDelegate(
                communities: communities,
                onSearch: (query) {
                  setState(() {
                    _searchQuery = query;
                  });
                },
              ),
            ),
            Expanded(
                child: ShopsListView(models: filteredCommunities.map((e) => ListUiModel(title: e.name, subtitle: e.id)).toList(), onTap: (index) {})),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}

class CommunitiesSearchDelegate extends SearchDelegate<String> {
  final List<CommunityModel> communities;
  final ValueChanged<String> onSearch;

  CommunitiesSearchDelegate({required this.communities, required this.onSearch});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          onSearch(query);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = communities.where((shop) {
      return shop.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      separatorBuilder: (context, index) => const Divider(),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final community = results[index];
        return ListTile(
          title: Text(community.name, style: TextStyle(fontSize: 16), maxLines: 1, overflow: TextOverflow.ellipsis),
          trailing: const Icon(Icons.arrow_forward_ios, size: 12),
          onTap: () {},
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = communities.where((shop) {
      return shop.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      separatorBuilder: (context, index) => const Divider(),
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final community = suggestions[index];
        return ListTile(
          title: Text(community.name, style: TextStyle(fontSize: 16), maxLines: 1, overflow: TextOverflow.ellipsis),
          trailing: const Icon(Icons.arrow_forward_ios, size: 12),
          onTap: () {},
        );
      },
    );
  }
}
