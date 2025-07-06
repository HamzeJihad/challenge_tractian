
import 'package:flutter_tractian/core/exceptions/server_exception.dart';
import 'package:flutter_tractian/features/data/data_source/assets_tree_data_source.dart';
import 'package:flutter_tractian/features/data/dtos/company_dto.dart';
import 'package:flutter_tractian/features/domain/entities/company_entity.dart';
import 'package:flutter_tractian/features/domain/repositories/assets_tree_repository.dart';

class AssetsTreeRepositoryImpl implements AssetsTreeRepository {
  final AssetsTreeDataSource dataSource;
  AssetsTreeRepositoryImpl(this.dataSource);

  @override
  Future<List<CompanyEntity>> fetchAllCompanies() async {
    try {
      List<CompanyDto> allCompanies = await dataSource.fetchAllCompanies();

      List<CompanyEntity> listAllCompanies = [];
      for (var company in allCompanies) {
        listAllCompanies.add(company.toEntity());
      }

      return listAllCompanies;
    } on ServerException catch (e) {
      throw Exception(e.message);
    }
  }

}