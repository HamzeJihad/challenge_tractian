import 'flatten_params.dart';

// Function that will be executed in an isolate to generate the flat list of visible nodes
List<Map<String, dynamic>> flattenTree(Map<String, dynamic> args) {
  final params = FlattenParams.fromMap(args);

  // 1) builds a map ID → Node
  final nodes = <String, Node>{};
  for (var loc in params.locations)   nodes[loc['id'] as String] = Node(loc);
  for (var asset in params.assets)    nodes[asset['id'] as String] = Node(asset);

  // 2) connects children and roots
  final roots = <Node>[];
  for (var node in nodes.values) {
    final pid = (node.data['parentId'] as String?) ?? (node.data['locationId'] as String?);
    if (pid != null && nodes.containsKey(pid)) {
      nodes[pid]!.children.add(node);
    } else {
      roots.add(node);
    }
  }

  // 3) filter function
  bool matches(Node n) {
    final name = (n.data['name'] as String).toLowerCase();
    if (params.searchText.isNotEmpty && !name.contains(params.searchText.toLowerCase())) return false;
    if (params.filterEnergy && n.data['sensorType'] != 'energy') return false;
    if (params.filterCritical && n.data['status'] != 'alert') return false;
    return true;
  }

  // 4) recursive walk generating the List<Map>
  final result = <Map<String, dynamic>>[];
  void walk(Node n, double indent) {
    // includes if it matches the filter or has a descendant that matches
    bool include = matches(n);
    if (!include) {
      for (var c in n.children) {
        void checkDesc(Node nn) {
          if (matches(nn)) include = true;
          else for (var cc in nn.children) checkDesc(cc);
        }
        checkDesc(c);
        if (include) break;
      }
    }
    if (!include) return;

    final isComponent = n.data['sensorType'] != null;
    final iconType = isComponent
        ? 'component'
        : (n.data['parentId'] != null || n.data['locationId'] != null)
            ? 'asset'
            : 'location';

    result.add({
      'id': n.data['id'],
      'title': n.data['name'],
      'iconType': iconType,
      'indent': indent,
      'isComponent': isComponent,
      'status': n.data['status'],
      'sensorType': n.data['sensorType'],
      'expanded': params.expandedIds.contains(n.data['id']),
    });

    if (params.expandedIds.contains(n.data['id'])) {
      for (var c in n.children) walk(c, indent + 6);
    }
  }

  for (var root in roots) walk(root, 0);
  return result;
}
