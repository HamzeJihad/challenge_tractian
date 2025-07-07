
import 'package:flutter/material.dart';
import 'package:flutter_tractian/features/domain/entities/asset_entity.dart';
import 'package:flutter_tractian/features/domain/entities/location_entity.dart';
import 'package:flutter_tractian/features/presentation/widgets/tree_node_tile.dart';

class AssetsTreeWidget extends StatelessWidget {
  final List<LocationEntity> locations;
  final List<AssetEntity> assets;

  const AssetsTreeWidget({super.key, required this.locations, required this.assets});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
      children: [
        ...locations
            .where((l) => l.parentId == null)
            .map((location) => _buildLocationNode(location, indent: 0)),
        ...assets
            .where((a) => a.locationId == null && a.parentId == null)
            .map((asset) => _buildAssetOrComponentNode(asset, indent: 0)),
      ],
    );
  }

  Widget _buildLocationNode(LocationEntity location, {required double indent}) {
    return TreeNodeTile(
      title: location.name,
      iconPath: 'assets/images/location_icon.svg',
      indent: indent,
      buildChildren: () {
        final subLocations = locations
            .where((l) => l.parentId == location.id)
            .map((l) => _buildLocationNode(l, indent: indent + 6))
            .toList();

        final locationAssets = assets
            .where((a) => a.locationId == location.id && a.parentId == null && !a.isComponent)
            .map((a) => _buildAssetOrComponentNode(a, indent: indent + 6))
            .toList();

        return [...subLocations, ...locationAssets];
      },
    );
  }

  Widget _buildAssetOrComponentNode(AssetEntity asset, {required double indent}) {
    final isComponent = asset.sensorType != null;
    final isOperating = asset.status == 'operating';

    Widget? statusIcon;
    if (isComponent) {
      if (isOperating) {
        statusIcon = const Icon(Icons.bolt, size: 14, color: Colors.green);
      }
      
    else {
        statusIcon = Container(
          width: 8,
          height: 8,
          decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
        );
      }
    }

    if (isComponent) {
      return TreeNodeTile(
        title: asset.name,
        iconPath: 'assets/images/component_icon.svg',
        indent: indent,
        statusIcon: statusIcon,
      );
    }

    return TreeNodeTile(
      title: asset.name,
      iconPath: 'assets/images/asset_icon.svg',
      indent: indent,
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
}
