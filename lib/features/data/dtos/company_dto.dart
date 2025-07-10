import 'package:flutter_tractian/features/domain/entities/company_entity.dart';

class CompanyDto {
  final String id;
  final String name;

  CompanyDto({
    required this.id,
    required this.name,
  });

  factory CompanyDto.fromJson(Map<String, dynamic> json) {
    return CompanyDto(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  CompanyEntity toEntity() {
    return CompanyEntity(
      id: id,
      name: name,
    );
  }
}
