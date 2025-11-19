import 'package:delivery_dev_seller/modules/dashboard/ui/viewmodels/drivers_viewmodel.dart';
import 'package:delivery_dev_seller/modules/dashboard/ui/widgets/sidebar.dart';
import 'package:delivery_dev_seller/theme/app_colors.dart';
import 'package:delivery_dev_seller/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class _Driver {
  final String nome;
  final String localizacao;
  final String status;

  _Driver({
    required this.nome,
    required this.localizacao,
    required this.status,
  });
}

final List<_Driver> _mockDrivers = [
  _Driver(nome: 'João da Sila', localizacao: 'Rua Prudente', status: 'EM COLETA'),
  _Driver(nome: 'João da Sila', localizacao: 'Rua Prudente', status: 'DISPONÍVEL'),
  _Driver(nome: 'João da Sila', localizacao: 'Rua Prudente', status: 'ENTREGANDO'),
  _Driver(nome: 'João da Sila', localizacao: 'Rua Prudente', status: 'DISPONÍVEL'),
  _Driver(nome: 'João da Sila', localizacao: 'Rua Prudente', status: 'OFF'),
  _Driver(nome: 'João da Sila', localizacao: 'Rua Prudente', status: 'OFF'),
  _Driver(nome: 'João da Sila', localizacao: 'Rua Prudente', status: 'OFF'),
  _Driver(nome: 'João da Sila', localizacao: 'Rua Prudente', status: 'OFF'),
  _Driver(nome: 'João da Sila', localizacao: 'Rua Prudente', status: 'OFF'),
  _Driver(nome: 'João da Sila', localizacao: 'Rua Prudente', status: 'OFF'),
  _Driver(nome: 'João da Sila', localizacao: 'Rua Prudente', status: 'OFF'),
  _Driver(nome: 'João da Sila', localizacao: 'Rua Prudente', status: 'OFF'),
  _Driver(nome: 'João da Sila', localizacao: 'Rua Prudente', status: 'OFF'),
  _Driver(nome: 'Marina Souza', localizacao: 'Rua Prudente', status: 'OFF'),
  _Driver(nome: 'Elaine Ribeiro', localizacao: 'Rua Prudente', status: 'OFF'),
];

class DriversPage extends StatefulWidget {
  DriversPage({super.key});

  @override
  State<DriversPage> createState() => _DriversState();
}

class _DriversState extends State<DriversPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard DEV',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      home: _DriversScreen(),
    );
  }
}

class _DriversScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const Sidebar(currentPage: AppPages.drivers),
          Expanded(
            child: _MainContent(),
          ),
        ],
      ),
    );
  }
}

class _MainContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 24),
          _buildTable(context),
          const SizedBox(height: 24),
          _buildPagination(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'ENTREGADORES',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.green.shade300, width: 2),
          ),
          child: Icon(
            Icons.all_inclusive,
            color: Colors.green.shade300,
            size: 24,
          ),
        ),
      ],
    );
  }

  Widget _buildTable(BuildContext context) {
  final viewModel = Modular.get<DriversViewmodel>();
  
  viewModel.fetchDrivers();

  return AnimatedBuilder(
    animation: viewModel,
    builder: (context, _) {
      if (viewModel.isLoadingDrivers) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(40),
            child: CircularProgressIndicator(),
          ),
        );
      }

      if (viewModel.drivers == null || viewModel.drivers!.isEmpty) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(40),
            child: Text("Nenhum entregador encontrado."),
          ),
        );
      }

      final drivers = viewModel.drivers!;

      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: DataTable(
          headingRowHeight: 50,
          dataRowMaxHeight: 50,
          dataRowMinHeight: 50,
          horizontalMargin: 16,
          columnSpacing: 20,
          headingTextStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.text,
          ),
          columns: const [
            DataColumn(label: Text('Nome')),
            DataColumn(label: Text('Localização')),
            DataColumn(label: Text('Status')),
          ],
          rows: drivers.map((driver) { 
            return DataRow(
              cells: [
                DataCell(Text(driver.name)),
                DataCell(Text(driver.location)),
                DataCell(Text(driver.status)),
              ],
            );
          }).toList(),
        ),
      );
    },
  );
}

  Widget _buildPagination(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _PageButton(text: '1 ', isActive: true),
        _PageButton(text: '2'),
        _PageButton(text: '3'),
        _PageButton(text: '4'),
        _PageButton(text: '5'),
        _PageButton(text: '6'),
        _PageButton(text: '...'),
        _PageButton(text: '10'),
        _PageButton(icon: Icons.chevron_left),
        _PageButton(icon: Icons.chevron_right),
      ],
    );
  }
}

class _PageButton extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final bool isActive;

  const _PageButton({
    this.text,
    this.icon,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color bgColor = isActive ? AppColors.surface : AppColors.primary;
    final Color fgColor = isActive ? Colors.white : AppColors.surface;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Material(
        color: bgColor,
        borderRadius: BorderRadius.circular(6.0),
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(6.0),
          child: Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            child: text != null
                ? Text(
                    text!,
                    style: TextStyle(
                      color: fgColor,
                      fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                    ),
                  )
                : Icon(
                    icon,
                    color: fgColor,
                    size: 20,
                  ),
          ),
        ),
      ),
    );
  }
}