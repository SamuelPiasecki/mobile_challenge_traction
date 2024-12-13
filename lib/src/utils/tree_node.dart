import 'package:mobile_challenge_traction/src/data/models/asset.dart';

class TreeNode {
  dynamic value;
  List<TreeNode> children;

  TreeNode(this.value, [List<TreeNode>? children]) : children = children ?? [];

  void addChild(TreeNode child) {
    children.add(child);
  }

  static TreeNode? dfsFindPath(TreeNode root, dynamic target) {
    if (root.value.name.contains(target)) {
      return root;
    }

    for (var child in root.children) {
      TreeNode? foundNode = dfsFindPath(child, target);

      if (foundNode != null) {
        root.children = [foundNode];
        return root;
      }
    }

    return null;
  }

  static TreeNode? dfsFindPathSensorEnergy(TreeNode root) {
    if (root.value is Asset &&
        root.value.sensorType != null &&
        root.value.sensorType == 'energy') {
      return root;
    }

    for (var child in root.children) {
      TreeNode? foundNode = dfsFindPathSensorEnergy(child);

      if (foundNode != null) {
        root.children = [foundNode];
        return root;
      }
    }

    return null;
  }

  static TreeNode? dfsFindPathCritical(TreeNode root) {
    if (root.value is Asset &&
        root.value.status != null &&
        root.value.status == 'alert') {
      return root;
    }

    for (var child in root.children) {
      TreeNode? foundNode = dfsFindPathCritical(child);

      if (foundNode != null) {
        root.children = [foundNode];
        return root;
      }
    }

    return null;
  }
}
