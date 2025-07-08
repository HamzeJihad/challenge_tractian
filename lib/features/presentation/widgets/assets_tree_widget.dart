import 'package:flutter/material.dart';
import 'package:flutter_tractian/features/domain/entities/asset_entity.dart';
import 'package:flutter_tractian/features/domain/entities/location_entity.dart';
import 'package:flutter_tractian/features/presentation/widgets/tree_node_tile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AssetsTreeWidget extends StatelessWidget {
  final List<LocationEntity> locations;
  final List<AssetEntity> assets;
  final Set<String> expandedNodeIds;

  const AssetsTreeWidget({
    super.key,
    required this.locations,
    required this.assets,
    required this.expandedNodeIds,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
      children: [
        // Locais principais
        ...locations
            .where((l) => l.parentId == null)
            .map((location) => _buildLocationNode(location, indent: 0)),

        // Ativos soltos (sem local nem parent)
        ...assets
            .where((a) => a.locationId == null && a.parentId == null)
            .map((a) => _buildAssetOrComponentNode(a, indent: 0)),

        // Componentes soltos com apenas location
        ...assets
            .where((a) =>
                a.locationId != null &&
                a.parentId == null &&
                a.isComponent &&
                !locations.any((l) => l.id == a.locationId))
            .map((a) => _buildAssetOrComponentNode(a, indent: 0)),
      ],
    );
  }

  Widget _buildLocationNode(LocationEntity location, {required double indent}) {
    return TreeNodeTile(
      title: location.name,
      iconPath: 'assets/images/location_icon.svg',
      indent: indent,
      initiallyExpanded: expandedNodeIds.contains(location.id),
      buildChildren: () {
        final subLocations = locations
            .where((l) => l.parentId == location.id)
            .map((l) => _buildLocationNode(l, indent: indent + 6))
            .toList();

        final locationAssets = assets
            .where((a) =>
                a.locationId == location.id &&
                a.parentId == null &&
                !a.isComponent)
            .map((a) => _buildAssetOrComponentNode(a, indent: indent + 6))
            .toList();

        final locationComponents = assets
            .where((a) =>
                a.locationId == location.id &&
                a.parentId == null &&
                a.isComponent)
            .map((a) => _buildAssetOrComponentNode(a, indent: indent + 6))
            .toList();

        return [
          ...subLocations,
          ...locationAssets,
          ...locationComponents,
        ];
      },
    );
  }

  Widget _buildAssetOrComponentNode(AssetEntity asset, {required double indent}) {
    final isComponent = asset.isComponent;

    Widget? statusIcon = isComponent
        ? buildStatusIcon(asset.status, asset.sensorType)
        : getAssetStatusIcon(asset.id);

    if (isComponent) {
      return TreeNodeTile(
        title: asset.name,
        iconPath: 'assets/images/component_icon.svg',
        indent: indent,
        statusIcon: statusIcon,
        initiallyExpanded: false,
      );
    }

    return TreeNodeTile(
      title: asset.name,
      iconPath: 'assets/images/asset_icon.svg',
      indent: indent,
      statusIcon: statusIcon,
      initiallyExpanded: expandedNodeIds.contains(asset.id),
      buildChildren: () {
        final subAssets = assets
            .where((a) => a.parentId == asset.id && !a.isComponent)
            .map((a) => _buildAssetOrComponentNode(a, indent: indent + 6))
            .toList();

        final components = assets
            .where((a) => a.parentId == asset.id && a.isComponent)
            .map((c) => _buildAssetOrComponentNode(c, indent: indent + 6))
            .toList();

        return [...subAssets, ...components];
      },
    );
  }

  Widget? getAssetStatusIcon(String assetId) {
    final children = assets.where((a) => a.parentId == assetId).toList();

    final hasAlert = children.any((a) => a.status == 'alert');
    if (hasAlert) {
      return const Icon(Icons.circle, size: 14, color: Colors.red);
    }

    final hasVibration = children.any((a) => a.sensorType == 'vibration');
    if (hasVibration) {
      return const Icon(FontAwesomeIcons.waveSquare, size: 12, color: Colors.blue);
    }

    final allOperating = children.isNotEmpty && children.every((a) => a.status == 'operating');
    if (allOperating) {
      return const Icon(Icons.bolt, size: 14, color: Colors.green);
    }

    return null;
  }

  Widget? buildStatusIcon(String? status, String? sensorType) {
    if (status == 'alert') {
      return const Icon(Icons.circle, size: 14, color: Colors.red);
    }

    if (sensorType == 'vibration') {
      return const Icon(FontAwesomeIcons.waveSquare, size: 12, color: Colors.blue);
    }

    if (status == 'operating') {
      return const Icon(Icons.bolt, size: 14, color: Colors.green);
    }

    return null;
  }
}

