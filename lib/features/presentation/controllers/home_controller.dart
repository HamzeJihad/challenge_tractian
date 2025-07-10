import 'package:flutter/material.dart';
import 'package:flutter_tractian/core/enums/service_status.dart';
import 'package:flutter_tractian/features/domain/entities/company_entity.dart';
import 'package:flutter_tractian/features/domain/usecases/fetch_all_companies_use_case.dart';

class HomeController extends ChangeNotifier {
  HomeController(this.fetchAllCompaniesUseCase);
  final FetchAllCompaniesUseCase fetchAllCompaniesUseCase;

  List<CompanyEntity> _listAllCompanies = [];
  List<CompanyEntity> get companies => _listAllCompanies;

  ServiceStatus _loadingStatus = ServiceStatus.loading;
  ServiceStatus get loadingStatus => _loadingStatus;

  Future<void> fetchAllCompanies() async {
    _loadingStatus = ServiceStatus.loading;
    notifyListeners();

    try {
      final getAllCompaniesSnap = await fetchAllCompaniesUseCase();
      _listAllCompanies = getAllCompaniesSnap;
      _loadingStatus = ServiceStatus.done;
      notifyListeners();
    } catch (e) {
      _loadingStatus = ServiceStatus.error;
      notifyListeners();
    }
  }
}
