
import 'package:dio/dio.dart';
import 'package:flutter_tractian/core/apis_url/tractian_api_url.dart';
import 'package:flutter_tractian/core/exceptions/server_exception.dart';
import 'package:flutter_tractian/features/data/dtos/asset_dto.dart';
import 'package:flutter_tractian/features/data/dtos/company_dto.dart';
import 'package:flutter_tractian/features/data/dtos/location_dto.dart';

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

  
  Future<List<LocationDto>> fetchAllLocations(String companyId) async {
    try {
      final response = await dio.get('${TractianApiUrl.API_TRACTRIAN}/companies/$companyId/locations');
      return (response.data as List).map((e) => LocationDto.fromJson(e)).toList();
    } catch (e) {
      throw ServerException(message: 'Failed to fetch locations: $e');
    }
  }

  Future<List<AssetDto>> fetchAllAssets(String companyId) async {
    try {
      final response = await dio.get('${TractianApiUrl.API_TRACTRIAN}/companies/$companyId/assets');
      return (response.data as List).map((e) => AssetDto.fromJson(e)).toList();
    } catch (e) {
      throw ServerException(message: 'Failed to fetch assets: $e');
    }
  }
  
}