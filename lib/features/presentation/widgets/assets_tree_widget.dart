import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../controllers/assets_tree_controller.dart';

class AssetsTreeWidget extends StatelessWidget {
  final AssetsTreeController controller;

  const AssetsTreeWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
          itemCount: controller.visibleNodes.length,
          itemBuilder: (_, idx) {
            final node = controller.visibleNodes[idx];
            final isExpanded = node.expanded;
            Widget? statusIcon;
            if (node.isComponent) {
              statusIcon = _buildStatusIcon(node.status, node.sensorType);
            }
            return Padding(
              padding: EdgeInsets.only(left: node.indent, top: 1, bottom: 1),
              child: InkWell(
                onTap: !node.isComponent ? () => controller.toggleExpand(node.id) : null,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 18,
                      child: node.isComponent
                          ? null
                          : Icon(
                              isExpanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right,
                              size: 14,
                              color: Colors.grey[700],
                            ),
                    ),
                    SvgPicture.asset(
                      node.iconPath,
                      height: 18,
                      colorFilter: const ColorFilter.mode(Color(0xFF1565C0), BlendMode.srcIn),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        node.title,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                    ),
                    if (statusIcon != null) ...[
                      const SizedBox(width: 4),
                      statusIcon,
                    ],
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget? _buildStatusIcon(String? status, String? sensorType) {
    if (status == 'alert') {
      return const Icon(Icons.circle, size: 14, color: Colors.red);
    }
    if (sensorType == 'vibration') {
      return const Icon(FontAwesomeIcons.waveSquare, size: 14, color: Colors.blue);
    }
    if (status == 'operating') {
      return const Icon(Icons.bolt, size: 14, color: Colors.green);
    }
    return null;
  }
}
