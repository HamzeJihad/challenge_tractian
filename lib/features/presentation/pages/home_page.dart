import 'package:flutter/material.dart' ;
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tractian/core/enums/service_status.dart';
import 'package:flutter_tractian/features/presentation/controllers/home_controller.dart';
import 'package:flutter_tractian/features/presentation/widgets/card_company_widget.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController _menuController = GetIt.I<HomeController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _menuController.fetchAllCompanies();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/images/logo_tractian.svg'),
          ],
        ),
      ),
      body: AnimatedBuilder(
        animation: _menuController,
        builder: (context, _) {
          if (_menuController.loadingStatus == ServiceStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (_menuController.loadingStatus == ServiceStatus.error) {
            return const Center(child: Text('Erro ao consultar menu'));
          }
          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 22),
            itemCount: _menuController.companies.length,
            itemBuilder: (context, index) {
              return CardCompanyWidget(
                companyEntity: _menuController.companies[index],
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 40);
            },
          );
        },
      ),
    );
  }
}
