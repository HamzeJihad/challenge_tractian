
import 'package:dio/dio.dart';
import 'package:flutter_tractian/core/apis_url/tractian_api_url.dart';
import 'package:flutter_tractian/core/exceptions/server_exception.dart';
import 'package:flutter_tractian/features/data/dtos/company_dto.dart';

class AssetsTreeDataSource {
  final Dio dio;
  AssetsTreeDataSource(this.dio);

  Future<List<CompanyDto>> fetchAllCompanies() async {
    try {
      final response = await dio.get('${TractianApiUrl.API_TRACTRIAN}/companies');

      List<CompanyDto> listCompanyDto = [];
      response.data.forEach((company) {
        listCompanyDto.add(CompanyDto.fromJson(company));
      });

      return listCompanyDto;
    } catch (e) {
      throw ServerException(message: 'Failed to fetch companies: $e');
    }
  }

  
}