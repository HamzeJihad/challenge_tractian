import 'package:flutter/material.dart' hide MenuController;
import 'package:flutter_tractian/core/enums/service_status.dart';
import 'package:flutter_tractian/features/presentation/controllers/assets_tree_controller.dart';
import 'package:flutter_tractian/features/presentation/widgets/assets_filter_widget.dart';
import 'package:flutter_tractian/features/presentation/widgets/assets_tree_widget.dart';
import 'package:get_it/get_it.dart';

class AssetsTreePage extends StatefulWidget {
  final String companyId;
  const AssetsTreePage({super.key, required this.companyId});

  @override
  State<AssetsTreePage> createState() => _AssetsTreePageState();
}

class _AssetsTreePageState extends State<AssetsTreePage> {
  final AssetsTreeController _controller = GetIt.I<AssetsTreeController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.loadData(widget.companyId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Assets')),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          if (_controller.loadingStatus == ServiceStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (_controller.loadingStatus == ServiceStatus.error) {
            return const Center(child: Text('Erro ao carregar dados.'));
          }
          return Column(
            children: [
              AssetsFilterWidget(controller: _controller),
              Expanded(
                child: AssetsTreeWidget(locations: _controller.locations, assets: _controller.assets),
              ),
            ],
          );
        },
      ),
    );
  }
}
