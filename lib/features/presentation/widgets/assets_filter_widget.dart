import 'package:flutter/material.dart';
import 'package:flutter_tractian/features/presentation/controllers/assets_tree_controller.dart';
import 'package:flutter_tractian/features/presentation/widgets/chip_filter_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AssetsFilterWidget extends StatelessWidget {
  final AssetsTreeController controller;

  const AssetsFilterWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 54,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),

          child: TextField(
            controller: controller.searchController,
            onChanged: (_) => controller.filterTree(),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search, size: 18, color: Color(0xff8E98A3)),
              fillColor: const Color(0xffEAEFF3),
              filled: true,
              hintText: 'Buscar Ativo ou Local',
              hintStyle: const TextStyle(color: Color(0xff8E98A3), fontSize: 14, fontWeight: FontWeight.w400),
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
                isSelected: controller.isEnergySensorSelected,
                icon: Icons.bolt,
                textLabel: 'Sensor de Energia',
                onChanged: (value) {
                  controller.isEnergySensorSelected.value = value ?? false;
                  controller.filterTree();
                },
              ),
              const SizedBox(width: 8),
              ChipFilterWidget(
                isSelected: controller.isCriticalSelected,
                icon: FontAwesomeIcons.circleExclamation,
                textLabel: 'Crítico',
                onChanged: (value) {
                  controller.isCriticalSelected.value = value ?? false;
                  controller.filterTree();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
