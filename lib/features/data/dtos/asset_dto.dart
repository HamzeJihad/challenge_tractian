import 'package:flutter_tractian/features/domain/entities/asset_entity.dart';

class AssetDto {
  final String id;
  final String name;
  final String? parentId;
  final String? locationId;
  final String? sensorId;
  final String? sensorType;
  final String? status;
  final String? gatewayId;

  AssetDto({
    required this.id,
    required this.name,
    this.parentId,
    this.locationId,
    this.sensorId,
    this.sensorType,
    this.status,
    this.gatewayId,
  });

  factory AssetDto.fromJson(Map<String, dynamic> json) {
    return AssetDto(
      id: json['id'] as String,
      name: json['name'] as String,
      parentId: json['parentId'] as String?,
      locationId: json['locationId'] as String?,
      sensorId: json['sensorId'] as String?,
      sensorType: json['sensorType'] as String?,
      status: json['status'] as String?,
      gatewayId: json['gatewayId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'parentId': parentId,
      'locationId': locationId,
      'sensorId': sensorId,
      'sensorType': sensorType,
      'status': status,
      'gatewayId': gatewayId,
    };
  }

  AssetEntity toEntity() {
    return AssetEntity(
      id: id,
      name: name,
      parentId: parentId,
      locationId: locationId,
      sensorId: sensorId,
      sensorType: sensorType,
      status: status,
      gatewayId: gatewayId,
    );
  }
}
