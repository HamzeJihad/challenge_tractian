
import 'package:flutter_tractian/features/domain/entities/company_entity.dart';
import 'package:flutter_tractian/features/domain/repositories/assets_tree_repository.dart';

class FetchAllCompaniesUseCase {
  final AssetsTreeRepository _assetsTreeRepository;

  FetchAllCompaniesUseCase(this._assetsTreeRepository);

  Future<List<CompanyEntity>> call() {
    return _assetsTreeRepository.fetchAllCompanies();
  }
}