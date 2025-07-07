import 'package:flutter_tractian/features/domain/entities/asset_entity.dart';
import 'package:flutter_tractian/features/domain/entities/company_entity.dart';
import 'package:flutter_tractian/features/domain/entities/location_entity.dart';

abstract class AssetsTreeRepository {
  Future<List<CompanyEntity>> fetchAllCompanies();
  Future<List<LocationEntity>> fetchAllLocations(String companyId);
  Future<List<AssetEntity>> fetchAllAssets(String companyId);
}
