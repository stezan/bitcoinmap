class BitcoinShop {
  final String id;
  final OsmJson osmJson;
  final Map<String, dynamic> tags;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;

  BitcoinShop({
    required this.id,
    required this.osmJson,
    required this.tags,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory BitcoinShop.fromJson(Map<String?, dynamic> json) {
    return BitcoinShop(
      id: json['id'],
      osmJson: OsmJson.fromJson(json['osm_json']),
      tags: Map<String, dynamic>.from(json['tags']),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
    );
  }
}

class OsmJson {
  final int? id;
  final int? uid;
  final String? type;
  final double? lat;
  final double? lon;
  final String? timestamp;
  final int? version;
  final int? changeset;
  final String? user;
  final Map<String, dynamic>? tags;

  OsmJson({
    required this.type,
    required this.id,
    required this.lat,
    required this.lon,
    required this.timestamp,
    required this.version,
    required this.changeset,
    required this.user,
    required this.uid,
    required this.tags,
  });

  factory OsmJson.fromJson(Map<String?, dynamic> json) {
    return OsmJson(
      type: json['type'],
      id: json['id'],
      lat: json['lat'],
      lon: json['lon'],
      timestamp: json['timestamp'],
      version: json['version'],
      changeset: json['changeset'],
      user: json['user'],
      uid: json['uid'],
      tags: json['tags'] != null ? Map<String, dynamic>.from(json['tags']) : null,
    );
  }
}
