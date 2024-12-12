class TreeNode {
  dynamic value;
  List<TreeNode> children;

  TreeNode(this.value, [List<TreeNode>? children]) : children = children ?? [];

  void addChild(TreeNode child) {
    children.add(child);
  }
}
