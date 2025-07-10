import 'package:flutter/material.dart';
import 'package:flutter_tractian/features/presentation/controllers/assets_tree_controller.dart';

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
            // Campo de busca
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
                      color: Color(0xff8E98A3), fontSize: 14, fontWeight: FontWeight.w400),
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
            // Chips de filtro
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  FilterChip(
                    label: const Text('Sensor de Energia'),
                    avatar: const Icon(Icons.bolt, size: 18, color: Colors.white),
                    selected: controller.filterEnergy,
                    onSelected: (v) => controller.updateFilterEnergy(v),
                    selectedColor: const Color(0xff2188FF),
                  ),
                  const SizedBox(width: 8),
                  FilterChip(
                    label: const Text('Crítico'),
                    avatar: const Icon(Icons.circle_notifications, size: 18, color: Colors.white),
                    selected: controller.filterCritical,
                    onSelected: (v) => controller.updateFilterCritical(v),
                    selectedColor: const Color(0xffE53E3E),
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
