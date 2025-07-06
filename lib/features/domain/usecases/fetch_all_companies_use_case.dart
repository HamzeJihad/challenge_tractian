
import 'package:flutter_tractian/features/domain/entities/company_entity.dart';
import 'package:flutter_tractian/features/domain/repositories/assets_tree_repository.dart';

class FetchAllCompaniesUseCase {
  final AssetsTreeRepository _treeRepository;

  FetchAllCompaniesUseCase(this._treeRepository);

  Future<List<CompanyEntity>> call() {
    return _treeRepository.fetchAllCompanies();
  }
}