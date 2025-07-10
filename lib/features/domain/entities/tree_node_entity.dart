import 'package:flutter_tractian/core/enums/tree_node_type.dart';

class TreeNodeEntity {
  final String id;
  final String name;
  final TreeNodeType type;
  final String? sensorType;
  final String? status;
  final List<TreeNodeEntity> children;

  TreeNodeEntity({
    required this.id,
    required this.name,
    required this.type,
    this.sensorType,
    this.status,
    this.children = const [],
  });
}