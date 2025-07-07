import 'package:flutter/material.dart';
import 'package:flutter_tractian/features/presentation/controllers/assets_tree_controller.dart';
import 'package:flutter_tractian/features/presentation/widgets/chip_filter_widget.dart';

class AssetsFilterWidget extends StatelessWidget {
  final AssetsTreeController controller;

  const AssetsFilterWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Campo de busca
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: TextField(
            controller: controller.searchController,
            onChanged: (_) => controller.filterTree(),
            decoration: InputDecoration(
              hintText: 'Search assets, components or locations...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
            ),
          ),
        ),

        ChipFilterWidget(
          isSelected: controller.isEnergySensorSelected,
          icon: Icons.bolt,
          textLabel: 'Show only Energy Sensors',
          onChanged: (value) {
            controller.isEnergySensorSelected.value = value ?? false;
            controller.filterTree();
          },
        ),

        ChipFilterWidget(
          isSelected: controller.isCriticalSelected,
          icon: Icons.circle,
          textLabel: 'Show only Critical Status',
          onChanged: (value) {
            controller.isCriticalSelected.value = value ?? false;
            controller.filterTree();
          },
        ),
      ],
    );
  }
}
