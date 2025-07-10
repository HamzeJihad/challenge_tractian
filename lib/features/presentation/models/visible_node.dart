class VisibleNode {
  final String id;
  final String title;
  final String iconPath;
  final double indent;
  final bool isComponent;
  final String? status;
  final String? sensorType;
  final bool expanded;

  VisibleNode({
    required this.id,
    required this.title,
    required this.iconPath,
    required this.indent,
    required this.isComponent,
    required this.status,
    required this.sensorType,
    required this.expanded,
  });
}
