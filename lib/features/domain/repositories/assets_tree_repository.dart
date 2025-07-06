import 'package:flutter_tractian/features/domain/entities/company_entity.dart';

abstract class AssetsTreeRepository {
  Future<List<CompanyEntity>> fetchAllCompanies();
}
