import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_challenge_traction/src/data/models/asset.dart';
import 'package:mobile_challenge_traction/src/data/models/company.dart';
import 'package:mobile_challenge_traction/src/data/models/location.dart';
import 'package:mobile_challenge_traction/src/domain/usecases/read_assets_use_case.dart';
import 'package:mobile_challenge_traction/src/domain/usecases/read_locations_use_case.dart';
import 'package:mobile_challenge_traction/src/providers/asset/asset_state.dart';
import 'package:mobile_challenge_traction/src/utils/tree_node.dart';

class AssetNotifier extends StateNotifier<AssetState> {
  final ReadLocationsUseCase readLocationsUseCase;
  final ReadAssetsUseCase readAssetsUseCase;
  AssetNotifier({
    required this.readLocationsUseCase,
    required this.readAssetsUseCase,
  }) : super(AssetState());

  Future<void> readData(Company company) async {
    state = AssetState(isLoading: true);
    await readLocations(company.id);
    await readAssets(company.id);
    createTree(company);
    state = state.copyWith(isLoading: false, company: company);
  }

  Future<void> readLocations(String companyId) async {
    try {
      final List<Location> locations = await readLocationsUseCase(companyId);
      state = state.copyWith(locations: locations);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> readAssets(String companyId) async {
    try {
      final List<Asset> assets = await readAssetsUseCase(companyId);
      state = state.copyWith(assets: assets);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  void createTree(Company company) async {
    TreeNode root = TreeNode(company);
    List<Location> rootLocations = state.locations!
        .where((location) => location.parentId == null)
        .toList();
    for (Location location in rootLocations) {
      TreeNode node = TreeNode(location);
      root.addChild(node);
      findLocations(node);
    }
    List<Asset> rootAssets = state.assets!
        .where((asset) => asset.parentId == null && asset.locationId == null)
        .toList();
    for (Asset asset in rootAssets) {
      TreeNode node = TreeNode(asset);
      root.addChild(node);
      findAssets(node);
    }
    state = state.copyWith(root: root);
  }

  void findLocations(TreeNode parentNode) {
    List<Location> childLocations = state.locations!
        .where((location) => location.parentId == parentNode.value.id)
        .toList();

    if (childLocations.isEmpty) {
      findAssets(parentNode);
      return;
    }
    for (Location childLocation in childLocations) {
      TreeNode childNode = TreeNode(childLocation);
      parentNode.addChild(childNode);
      findLocations(childNode);
    }
  }

  void findAssets(TreeNode parentNode) {
    List<Asset> childFromLocations = state.assets!
        .where((asset) => asset.locationId == parentNode.value.id)
        .toList();
    List<Asset> childFromAssets = state.assets!
        .where((asset) => asset.parentId == parentNode.value.id)
        .toList();
    if (childFromLocations.isNotEmpty) {
      for (Asset asset in childFromLocations) {
        TreeNode childNode = TreeNode(asset);
        parentNode.addChild(childNode);
        findAssets(childNode);
      }
    }

    for (Asset asset in childFromAssets) {
      TreeNode childNode = TreeNode(asset);
      parentNode.addChild(childNode);
      findAssets(childNode);
    }
  }

  void filterTreeInput(String search) {
    if (search.isEmpty) {
      if (state.searchTree != null) {
        createTree(state.company!);
      }
    }
    if (search.length >= 6) {
      state = state.copyWith(isLoading: true);
      TreeNode? path = TreeNode.dfsFindPath(state.root!, search);
      if (path != null) {
        state = state.copyWith(isLoading: false, searchTree: path);
      } else {
        state = state.copyWith(isLoading: false, error: 'Nó não encontrado!');
      }
    }
  }

  void filterTreeSensorEnergy(bool filter) {
    if (filter) {
      state = state.copyWith(isLoading: true);
      TreeNode? path = TreeNode.dfsFindPathSensorEnergy(state.root!);
      if (path != null) {
        state = state.copyWith(isLoading: false, searchTree: path);
      } else {
        state = state.copyWith(
            isLoading: false, error: 'Sensores de energia não encontrados!');
      }
    } else {
      createTree(state.company!);
    }
  }

  void filterTreeCritical(bool filter) {
    if (filter) {
      state = state.copyWith(isLoading: true);
      TreeNode? path = TreeNode.dfsFindPathCritical(state.root!);
      if (path != null) {
        state = state.copyWith(isLoading: false, searchTree: path);
      } else {
        state = state.copyWith(
            isLoading: false, error: 'Status críticos não encontrados!');
      }
    } else {
      createTree(state.company!);
    }
  }

  List<TreeSliverNode<dynamic>> convertTree(TreeNode node) {
    return node.children.map((child) {
      return TreeSliverNode<dynamic>(
        child.value,
        expanded: true,
        children: convertTree(child),
      );
    }).toList();
  }
}
