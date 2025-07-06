import 'package:flutter_tractian/features/domain/entities/location_entity.dart';

class LocationDto {
  final String id;
  final String name;
  final String? parentId;

  LocationDto({
    required this.id,
    required this.name,
    this.parentId,
  });

  factory LocationDto.fromJson(Map<String, dynamic> json) {
    return LocationDto(
      id: json['id'] as String,
      name: json['name'] as String,
      parentId: json['parentId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'parentId': parentId,
    };
  }

  LocationEntity toEntity() {
    return LocationEntity(
      id: id,
      name: name,
      parentId: parentId,
    );
  }
}
