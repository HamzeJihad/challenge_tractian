
import 'package:flutter_tractian/features/domain/entities/location_entity.dart';
import 'package:flutter_tractian/features/domain/repositories/assets_tree_repository.dart';

class FetchAllCompaniesLocationsUseCase {
  final AssetsTreeRepository _assetsTreeRepository;

  FetchAllCompaniesLocationsUseCase(this._assetsTreeRepository);

  Future<List<LocationEntity>> call(String companyId) {
    return _assetsTreeRepository.fetchAllLocations(companyId);
  }
}