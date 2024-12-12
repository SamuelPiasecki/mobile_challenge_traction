class Location {
  final String id;
  final String name;
  final String? parentId;

  Location({
    required this.id,
    required this.name,
    this.parentId,
  });

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      id: map['id'] as String,
      name: map['name'] as String,
      parentId: map['parentId'] != null ? map['parentId'] as String : null,
    );
  }
}
