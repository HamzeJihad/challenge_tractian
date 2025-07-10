class LocationEntity {
  final String id;
  final String name;
  final String? parentId;

  const LocationEntity({required this.id, required this.name, this.parentId});

  factory LocationEntity.empty() => LocationEntity(id: '', name: '', parentId: null);
}
