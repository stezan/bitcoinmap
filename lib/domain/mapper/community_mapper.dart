import 'package:bitcoin_map/data/model/community.dart';
import '../model/community_model.dart';

CommunityModel? mapCommunity(Community community) {
  if (community.tags['name'] == null) return null;

  return CommunityModel(
    id: community.id,
    name: community.tags['name'],
  );
}
