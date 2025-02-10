class Community {
  final String id;
  final Map<String, dynamic> tags;

  Community({
    required this.id,
    required this.tags,
  });

  factory Community.fromJson(Map<String, dynamic> json) {
    return Community(
      id: json['id'],
      tags: Map<String, dynamic>.from(json['tags']),
    );
  }
}
