import 'package:flutter/foundation.dart';
import 'package:flutter_tractian/core/enums/service_status.dart';
import 'package:flutter_tractian/features/domain/entities/asset_entity.dart';
import 'package:flutter_tractian/features/domain/entities/location_entity.dart';
import 'package:flutter_tractian/features/domain/usecases/fetch_all_companies_assets_use_case.dart';
import 'package:flutter_tractian/features/domain/usecases/fetch_all_companies_locations_use_case.dart';
import 'package:flutter_tractian/features/presentation/utils/flatten_params.dart';
import 'package:flutter_tractian/features/presentation/models/visible_node.dart';
class AssetsTreeController extends ChangeNotifier {
    AssetsTreeController(this.fetchAssets,this.fetchLocations);

  final FetchAllCompaniesLocationsUseCase fetchLocations;
  final FetchAllCompaniesAssetsUseCase fetchAssets;

  ServiceStatus loadingStatus = ServiceStatus.loading;
  List<LocationEntity> locations = [];
  List<AssetEntity> assets = [];
  Set<String> expandedIds = {};
  bool filterEnergy = false;
  bool filterCritical = false;
  String searchText = '';

  List<VisibleNode> visibleNodes = [];


  Future<void> loadData(String companyId) async {
    loadingStatus = ServiceStatus.loading;
    notifyListeners();
    try {
      locations = await fetchLocations(companyId);
      assets = await fetchAssets(companyId);
      _computeVisible();
      loadingStatus = ServiceStatus.done;
    } catch (e) {
      loadingStatus = ServiceStatus.error;
      notifyListeners();
    }
  }

  void toggleExpand(String id) {
    if (!expandedIds.remove(id)) {
      expandedIds.add(id);
    }
    _computeVisible();
  }

  void updateSearch(String text) {
    searchText = text;
    _computeVisible();
  }

  void updateFilterEnergy(bool value) {
    filterEnergy = value;
    _computeVisible();
  }

  void updateFilterCritical(bool value) {
    filterCritical = value;
    _computeVisible();
  }

  void resetFilters() {
    filterEnergy = false;
    filterCritical = false;
    searchText = '';
    expandedIds.clear();
    visibleNodes.clear();
    notifyListeners();
  }

  Future<void> _computeVisible() async {
    final locJson = locations
        .map((l) => {'id': l.id, 'name': l.name, 'parentId': l.parentId, 'locationId': null})
        .toList();
    final assetJson = assets
        .map((a) => {
              'id': a.id,
              'name': a.name,
              'parentId': a.parentId,
              'locationId': a.locationId,
              'sensorType': a.sensorType,
              'status': a.status,
            })
        .toList();

    final params = {
      'locations': locJson,
      'assets': assetJson,
      'expandedIds': expandedIds.toList(),
      'filterEnergy': filterEnergy,
      'filterCritical': filterCritical,
      'searchText': searchText,
    };

    final flat = await compute(flattenTree, params);
    visibleNodes = flat.map((m) {
      final iconPath = m['iconType'] == 'location'
          ? 'assets/images/location_icon.svg'
          : m['iconType'] == 'asset'
              ? 'assets/images/asset_icon.svg'
              : 'assets/images/component_icon.svg';
      return VisibleNode(
        id: m['id'],
        title: m['title'],
        iconPath: iconPath,
        indent: m['indent'],
        isComponent: m['isComponent'],
        status: m['status'],
        sensorType: m['sensorType'],
      );
    }).toList();

    notifyListeners();
  }
}
