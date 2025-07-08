
import 'package:flutter/material.dart';
import 'package:flutter_tractian/core/enums/service_status.dart';
import 'package:flutter_tractian/features/domain/entities/asset_entity.dart';
import 'package:flutter_tractian/features/domain/entities/location_entity.dart';
import 'package:flutter_tractian/features/domain/usecases/fetch_all_companies_assets_use_case.dart';
import 'package:flutter_tractian/features/domain/usecases/fetch_all_companies_locations_use_case.dart';
import 'package:collection/collection.dart';

class AssetsTreeController extends ChangeNotifier {
  final FetchAllCompaniesAssetsUseCase fetchAssetsUseCase;
  final FetchAllCompaniesLocationsUseCase fetchLocationsUseCase;

  AssetsTreeController(this.fetchAssetsUseCase, this.fetchLocationsUseCase);

  ServiceStatus _loadingStatus = ServiceStatus.loading;
  ServiceStatus get loadingStatus => _loadingStatus;

  final TextEditingController searchController = TextEditingController();
  final ValueNotifier<bool> isEnergySensorSelected = ValueNotifier(false);
  final ValueNotifier<bool> isCriticalSelected = ValueNotifier(false);

  List<LocationEntity> _locations = [];
  List<AssetEntity> _assets = [];

  List<LocationEntity> _filteredLocations = [];
  List<AssetEntity> _filteredAssets = [];

  List<LocationEntity> get locations => _filteredLocations;
  List<AssetEntity> get assets => _filteredAssets;

  final Set<String> expandedNodeIds = {};

  Future<void> loadData(String companyId) async {
    _loadingStatus = ServiceStatus.loading;
    notifyListeners();

    try {
      final locationsFuture = fetchLocationsUseCase(companyId);
      final assetsFuture = fetchAssetsUseCase(companyId);

      final results = await Future.wait([locationsFuture, assetsFuture]);

      _locations = results[0] as List<LocationEntity>;
      _assets = results[1] as List<AssetEntity>;

      _filteredLocations = List.from(_locations);
      _filteredAssets = List.from(_assets);

      _loadingStatus = ServiceStatus.done;
      notifyListeners();
    } catch (e) {
      _loadingStatus = ServiceStatus.error;
      notifyListeners();
    }
  }

  void filterTree() {
    final query = searchController.text.toLowerCase();
    final filterEnergy = isEnergySensorSelected.value;
    final filterCritical = isCriticalSelected.value;

    final matchingAssets = _assets.where((a) {
      final matchesText = query.isEmpty || a.name.toLowerCase().contains(query);
      final matchesEnergy = !filterEnergy || a.sensorType == 'energy';
      final matchesCritical = !filterCritical || a.status == 'alert';
      return matchesText && matchesEnergy && matchesCritical;
    }).toList();

    if (query.isEmpty && !filterEnergy && !filterCritical) {
      _filteredAssets = List.from(_assets);
      _filteredLocations = List.from(_locations);
      expandedNodeIds.clear();
      notifyListeners();
      return;
    }

    final matchingAssetIds = matchingAssets.map((a) => a.id).toSet();
    final parentsToInclude = <String>{};
    final locationsToInclude = <String>{};

    void collectLocationParents(String? locationId) {
      if (locationId == null) return;
      final parentLoc = _locations.firstWhereOrNull((l) => l.id == locationId);
      if (parentLoc != null) {
        locationsToInclude.add(parentLoc.id);
        collectLocationParents(parentLoc.parentId);
      }
    }

    void collectParents(String? parentId) {
      if (parentId == null) return;

      final parentAsset = _assets.firstWhereOrNull((a) => a.id == parentId);
      if (parentAsset != null) {
        parentsToInclude.add(parentAsset.id);
        collectParents(parentAsset.parentId);
        if (parentAsset.locationId != null) {
          locationsToInclude.add(parentAsset.locationId!);
          collectLocationParents(parentAsset.locationId);
        }
        return;
      }

      locationsToInclude.add(parentId);
      collectLocationParents(parentId);
    }

    for (final asset in matchingAssets) {
      collectParents(asset.parentId);
      if (asset.locationId != null) {
        locationsToInclude.add(asset.locationId!);
        collectLocationParents(asset.locationId);
      }
    }

    _filteredAssets = _assets.where((a) {
      return matchingAssetIds.contains(a.id) || parentsToInclude.contains(a.id);
    }).toList();

    _filteredLocations = _locations.where((l) {
      final matchesQuery = l.name.toLowerCase().contains(query);
      return locationsToInclude.contains(l.id) || (query.isNotEmpty && matchesQuery);
    }).toList();

    expandedNodeIds
      ..clear()
      ..addAll(parentsToInclude)
      ..addAll(locationsToInclude);

    notifyListeners();
  }

  void resetFilters() {
  searchController.clear();
  isEnergySensorSelected.value = false;
  isCriticalSelected.value = false;
  expandedNodeIds.clear();
  _filteredAssets = List.from(_assets);
  _filteredLocations = List.from(_locations);
  notifyListeners();
}
}
