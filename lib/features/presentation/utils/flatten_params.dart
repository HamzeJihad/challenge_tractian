
// Parameters passed to isolate that flattens and filters the tree
class _FlattenParams {
  final List<Map<String, dynamic>> locations;
  final List<Map<String, dynamic>> assets;
  final Set<String> expandedIds;
  final bool filterEnergy;
  final bool filterCritical;
  final String searchText;

  _FlattenParams({
    required this.locations,
    required this.assets,
    required this.expandedIds,
    required this.filterEnergy,
    required this.filterCritical,
    required this.searchText,
  });

  factory _FlattenParams.fromMap(Map<String, dynamic> map) => _FlattenParams(
        locations: List<Map<String, dynamic>>.from(map['locations'] as List),
        assets: List<Map<String, dynamic>>.from(map['assets'] as List),
        expandedIds: Set<String>.from(map['expandedIds'] as List),
        filterEnergy: map['filterEnergy'] as bool,
        filterCritical: map['filterCritical'] as bool,
        searchText: map['searchText'] as String,
      );

  Map<String, dynamic> toMap() => {
        'locations': locations,
        'assets': assets,
        'expandedIds': expandedIds.toList(),
        'filterEnergy': filterEnergy,
        'filterCritical': filterCritical,
        'searchText': searchText,
      };
}

// Internal node used in tree construction
class _Node {
  final Map<String, dynamic> data;
  final List<_Node> children = [];

  _Node(this.data);
}

// Function that will be executed in an isolate to generate the flat list of visible nodes
List<Map<String, dynamic>> flattenTree(Map<String, dynamic> args) {
  final params = _FlattenParams.fromMap(args);

  // Maps us all locations + assets
  final nodes = <String, _Node>{};
  for (var loc in params.locations) {
    nodes[loc['id'] as String] = _Node(loc);
  }
  for (var asset in params.assets) {
    nodes[asset['id'] as String] = _Node(asset);
  }

  final roots = <_Node>[];
  for (var node in nodes.values) {
    final parentId = node.data['parentId'] as String?;
    final locationId = node.data['locationId'] as String?;
    final pid = parentId ?? locationId;
    if (pid != null && nodes.containsKey(pid)) {
      nodes[pid]!.children.add(node);
    } else {
      roots.add(node);
    }
  }

  bool matches(_Node n) {
    final name = (n.data['name'] as String).toLowerCase();
    if (params.searchText.isNotEmpty && !name.contains(params.searchText.toLowerCase())) {
      return false;
    }
    if (params.filterEnergy && n.data['sensorType'] != 'energy') return false;
    if (params.filterCritical && n.data['status'] != 'alert') return false;
    return true;
  }

  final result = <Map<String, dynamic>>[];

  void walk(_Node n, double indent) {
    bool include = matches(n);
    if (!include) {
      for (var c in n.children) {
        if (include) break;
        void checkDesc(_Node nn) {
          if (matches(nn)) include = true;
          else for (var cc in nn.children) checkDesc(cc);
        }
        checkDesc(c);
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

  for (var root in roots) {
    walk(root, 0);
  }

  return result;
}