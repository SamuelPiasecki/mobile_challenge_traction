import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_challenge_traction/src/data/models/asset.dart';
import 'package:mobile_challenge_traction/src/data/models/company.dart';
import 'package:mobile_challenge_traction/src/providers/asset/asset_provider.dart';
import 'package:mobile_challenge_traction/src/providers/asset/asset_state.dart';
import 'package:mobile_challenge_traction/src/utils/helpers.dart';

class AssetPage extends ConsumerStatefulWidget {
  final Company company;

  static AssetPage builder(BuildContext context, GoRouterState state) {
    final company = state.extra as Company;
    return AssetPage(
      company: company,
    );
  }

  const AssetPage({
    super.key,
    required this.company,
  });

  @override
  ConsumerState<AssetPage> createState() => _AssetPageState();
}

class _AssetPageState extends ConsumerState<AssetPage> {
  List<TreeSliverNode<dynamic>> tree = [];
  bool sensorEnergy = false;
  bool critical = false;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(assetNotifierProvider.notifier).readData(widget.company);
      _controller.addListener(_filterSearchInput);
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_filterSearchInput);
    _controller.dispose();
    super.dispose();
  }

  void _filterSearchInput() {
    if (_controller.text.isEmpty) {
      ref.read(assetNotifierProvider.notifier).filterTreeInput('');
    } else {
      ref
          .read(assetNotifierProvider.notifier)
          .filterTreeInput(_controller.text);
    }
  }

  Widget _treeNodeBuilder(
    BuildContext context,
    TreeSliverNode<dynamic> node,
    AnimationStyle toggleAnimationStyle,
  ) {
    final bool isParentNode = node.children.isNotEmpty;
    const BorderSide border = BorderSide(
      width: 1,
      color: Colors.grey,
    );
    return TreeSliver.wrapChildToToggleNode(
      node: node,
      child: Row(
        children: <Widget>[
          SizedBox(width: 5.0 * node.depth! + 3.0),
          DecoratedBox(
            decoration: BoxDecoration(
              border: node.parent != null
                  ? const Border(left: border, bottom: border)
                  : null,
            ),
            child: const SizedBox(height: 40.0, width: 20.0),
          ),
          if (isParentNode)
            SizedBox.square(
              dimension: 15.0,
              child: Icon(
                node.isExpanded ? Icons.arrow_upward : Icons.arrow_downward,
                size: 14,
              ),
            ),
          const SizedBox(width: 8.0),
          Row(
            children: [
              Helpers.selectIcon(node).contains('svg')
                  ? SvgPicture.asset(Helpers.selectIcon(node))
                  : Image.asset(Helpers.selectIcon(node)),
              const SizedBox(width: 4),
              Text(
                node.content.name,
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(width: 4),
              if (node.content is Asset) ...[
                if (node.content.status == 'alert')
                  const Icon(
                    Icons.circle,
                    color: Colors.red,
                    size: 10,
                  ),
                if (node.content.sensorType == 'energy')
                  const Icon(
                    Icons.bolt,
                    color: Colors.green,
                    size: 15,
                  ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _getTree() {
    return TreeSliver(
      tree: tree,
      treeNodeBuilder: _treeNodeBuilder,
      treeRowExtentBuilder: (
        TreeSliverNode<dynamic> node,
        SliverLayoutDimensions layoutDimensions,
      ) {
        return 30.0;
      },
      indentation: TreeSliverIndentationType.none,
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(assetNotifierProvider);
    final notifier = ref.watch(assetNotifierProvider.notifier);

    ref.listen<AssetState>(assetNotifierProvider, (previous, next) {
      if (next.searchTree != null) {
        setState(() {
          tree = notifier.convertTree(next.searchTree!);
        });
      }

      if (previous?.searchTree != null && next.searchTree == null) {
        setState(() {
          tree = notifier.convertTree(next.root!);
        });
      }

      if (previous?.error != next.error) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(next.error ?? 'Erro desconhecido')),
          );
        });
      }
    });

    if (state.root != null) {
      setState(() {
        tree = notifier.convertTree(state.root!);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Assets',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF2188FF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                icon: Icon(Icons.search),
                hintText: 'Busque por Ativo ou Local',
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        sensorEnergy = !sensorEnergy;
                      });
                      notifier.filterTreeSensorEnergy(sensorEnergy);
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        sensorEnergy
                            ? const Color(0xFF2188FF)
                            : const Color(0xFFFFFFFF),
                      ),
                    ),
                    child: Text(
                      'Sensor de Energia',
                      style: TextStyle(
                        color: sensorEnergy ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        critical = !critical;
                      });
                      notifier.filterTreeCritical(critical);
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        critical
                            ? const Color(0xFF2188FF)
                            : const Color(0xFFFFFFFF),
                      ),
                    ),
                    child: Text(
                      'Crítico',
                      style: TextStyle(
                        color: critical ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(),
            if (state.isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
            if (!state.isLoading &&
                state.locations != null &&
                state.locations!.isNotEmpty)
              Expanded(
                child: CustomScrollView(
                  slivers: [_getTree()],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
