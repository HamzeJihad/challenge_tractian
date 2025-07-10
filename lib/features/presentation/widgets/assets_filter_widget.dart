import 'package:flutter/material.dart';
import 'package:flutter_tractian/features/presentation/controllers/assets_tree_controller.dart';
import 'package:flutter_tractian/features/presentation/widgets/chip_filter_widget.dart';

class AssetsFilterWidget extends StatelessWidget {
  final AssetsTreeController controller;

  const AssetsFilterWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: TextField(
                onChanged: controller.updateSearch,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, size: 18, color: Color(0xff8E98A3)),
                  fillColor: const Color(0xffEAEFF3),
                  filled: true,
                  hintText: 'Buscar Ativo ou Local',
                  hintStyle: const TextStyle(
                    color: Color(0xff8E98A3),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  ChipFilterWidget(
                    isSelected: controller.filterEnergy,
                    textLabel: 'Sensor de Energia',
                    icon: Icons.bolt,
                    onChanged: (value) {
                      controller.updateFilterEnergy(value!);
                    },
                  ),
                  const SizedBox(width: 16),
                  ChipFilterWidget(
                    isSelected: controller.filterCritical,
                    textLabel: 'Crítico',
                    icon: Icons.circle_notifications,
                    onChanged: (value) {
                      controller.updateFilterCritical(value!);
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
