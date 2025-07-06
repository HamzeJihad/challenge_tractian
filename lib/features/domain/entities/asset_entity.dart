class AssetEntity {
  final String id;
  final String name;
  final String? parentId;
  final String? locationId;
  final String? sensorId;
  final String? sensorType;
  final String? status;
  final String? gatewayId;

  const AssetEntity({
    required this.id,
    required this.name,
    this.parentId,
    this.locationId,
    this.sensorId,
    this.sensorType,
    this.status,
    this.gatewayId,
  });

  bool get isComponent => sensorType != null;
}
