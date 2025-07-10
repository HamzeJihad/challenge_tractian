

import 'package:flutter_tractian/features/domain/entities/asset_entity.dart';
import 'package:flutter_tractian/features/domain/repositories/assets_tree_repository.dart';

class FetchAllCompaniesAssetsUseCase {
  final AssetsTreeRepository _assetsTreeRepository;

  FetchAllCompaniesAssetsUseCase(this._assetsTreeRepository);

  Future<List<AssetEntity>> call(String companyId) {
    return _assetsTreeRepository.fetchAllAssets(companyId);
  }
}