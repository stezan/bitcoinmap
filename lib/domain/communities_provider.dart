import 'package:bitcoin_map/domain/repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'model/community_model.dart';

final communitiesProvider = FutureProvider<List<CommunityModel>>((ref) async {
  final repository = ref.read(bitcoinRepositoryProvider);
  final communities = await repository.fetchCommunities();
  return communities;
});
