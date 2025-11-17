import 'package:delivery_dev_seller/modules/dashboard/data/models/delivery_dto.dart';
import 'package:delivery_dev_seller/modules/dashboard/ui/viewmodels/dashboard_viewmodel.dart';
import 'package:delivery_dev_seller/modules/dashboard/ui/widgets/sidebar.dart';
import 'package:delivery_dev_seller/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<StatefulWidget> createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DashboardPage> {
  final _viewModel = Modular.get<DashboardViewmodel>();
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard DEV',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const Sidebar(currentPage: AppPages.dashboard),
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
          _buildStatsCards(),
          const SizedBox(height: 24),
          _buildOrdersSection(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'DASHBOARD',
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

  Widget _buildStatsCards() {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            title: 'Entregadores online',
            count: '10',
            showDot: true,
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: _StatCard(
            title: 'Meus pedidos',
            count: '9',
            icon: Icons.archive_outlined,
          ),
        ),
      ],
    );
  }

  Widget _buildOrdersSection(BuildContext context) {
  final _viewModel = Modular.get<DashboardViewmodel>();

  return Container(
    padding: const EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'PEDIDOS EM ANDAMENTO',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 24),

        AnimatedBuilder(
          animation: _viewModel,
          builder: (context, _) {
            final orders = _viewModel.deliveries;

            if (orders.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Wrap(
              spacing: 16,
              runSpacing: 16,
              children: orders
                  .map((o) => _buildOrderCard(o))
                  .toList(),
            );
          },
        ),
      ],
    ),
  );
}
}

class _StatCard extends StatelessWidget {
  final String title;
  final String count;
  final IconData? icon;
  final bool showDot;

  const _StatCard({
    required this.title,
    required this.count,
    this.icon,
    this.showDot = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  if (showDot)
                    const Padding(
                      padding: EdgeInsets.only(left: 6.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 4,
                      ),
                    ),
                ],
              ),
              if (icon != null)
                Icon(
                  icon,
                  color: Theme.of(context).iconTheme.color,
                  size: 20
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            count,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}

_OrderCard _buildOrderCard(DeliveryDto order) {
  return _OrderCard(
    location: order.customerAddressLabel,
    status: order.status,
    distance: '10',
    address: order.customerAddressStreet
  );
}

class _OrderCard extends StatelessWidget {
  final String location;
  final String status;
  final String distance;
  final String address;

  const _OrderCard({
    required this.location,
    required this.status,
    required this.distance,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            location,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 12),
          Text(
            status,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 4),
          Text(
            distance,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 4),
          Text(
            address,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}