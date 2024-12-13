import 'package:mobile_challenge_traction/src/data/models/asset.dart';
import 'package:mobile_challenge_traction/src/data/models/company.dart';
import 'package:mobile_challenge_traction/src/data/models/location.dart';
import 'package:mobile_challenge_traction/src/utils/tree_node.dart';

class AssetState {
  final bool isLoading;
  final List<Location>? locations;
  final List<Asset>? assets;
  final TreeNode? root;
  final TreeNode? searchTree;
  final String? error;
  final Company? company;

  AssetState({
    this.isLoading = false,
    this.locations = const [],
    this.assets = const [],
    this.root,
    this.error,
    this.searchTree,
    this.company,
  });

  AssetState copyWith({
    bool? isLoading,
    List<Location>? locations,
    List<Asset>? assets,
    TreeNode? root,
    TreeNode? searchTree,
    String? error,
    Company? company,
  }) {
    return AssetState(
      isLoading: isLoading ?? this.isLoading,
      locations: locations ?? this.locations,
      assets: assets ?? this.assets,
      root: root ?? this.root,
      searchTree: searchTree ?? this.searchTree,
      error: error ?? this.error,
      company: company ?? this.company,
    );
  }
}
