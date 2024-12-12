import 'package:mobile_challenge_traction/src/data/models/asset.dart';
import 'package:mobile_challenge_traction/src/data/models/location.dart';
import 'package:mobile_challenge_traction/src/utils/tree_node.dart';

class AssetState {
  final bool isLoading;
  final List<Location>? locations;
  final List<Asset>? assets;
  final TreeNode? root;
  final String? error;

  AssetState({
    this.isLoading = false,
    this.locations = const [],
    this.assets = const [],
    this.root,
    this.error,
  });

  AssetState copyWith({
    bool? isLoading,
    List<Location>? locations,
    List<Asset>? assets,
    TreeNode? root,
    String? error,
  }) {
    return AssetState(
      isLoading: isLoading ?? this.isLoading,
      locations: locations ?? this.locations,
      assets: assets ?? this.assets,
      root: root ?? this.root,
      error: error ?? this.error,
    );
  }
}
