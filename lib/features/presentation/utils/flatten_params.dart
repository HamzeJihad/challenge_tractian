// Parameters passed to isolate that flattens and filters the tree
class FlattenParams {
  final List<Map<String, dynamic>> locations;
  final List<Map<String, dynamic>> assets;
  final Set<String> expandedIds;
  final bool filterEnergy;
  final bool filterCritical;
  final String searchText;

  FlattenParams({
    required this.locations,
    required this.assets,
    required this.expandedIds,
    required this.filterEnergy,
    required this.filterCritical,
    required this.searchText,
  });

  factory FlattenParams.fromMap(Map<String, dynamic> map) => FlattenParams(
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
class Node {
  final Map<String, dynamic> data;
  final List<Node> children = [];
  Node(this.data);
}
