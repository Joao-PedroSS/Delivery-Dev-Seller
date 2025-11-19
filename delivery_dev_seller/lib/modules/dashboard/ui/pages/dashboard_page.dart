import 'package:delivery_dev_seller/modules/dashboard/data/dtos/delivery_dto.dart';
import 'package:delivery_dev_seller/modules/dashboard/ui/viewmodels/dashboard_viewmodel.dart';
import 'package:delivery_dev_seller/modules/dashboard/ui/widgets/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<StatefulWidget> createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return _DashboardScreen();
  }
}

class _DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const Sidebar(currentPage: AppPages.dashboard),

          Expanded(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  width: double.infinity,
                  child: _MainContentHeader(),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: _MainContent(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MainContentHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            border: Border.all(color: Colors.green, width: 2),
          ),
          child: Icon(Icons.all_inclusive, color: Colors.green),
        ),
      ],
    );
  }
}

class _MainContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStatsCards(),
        const SizedBox(height: 24),
        _buildOrdersSection(context),
      ],
    );
  }

  Widget _buildStatsCards() {
    final DashboardViewmodel viewModel = Modular.get<DashboardViewmodel>();

    viewModel.initViewmodel();

    return AnimatedBuilder(
      animation: viewModel, 
      builder: (context, _) { 
        return Row(
          children: [
            SizedBox(
              width: 253,
              child: _StatCard(
                title: 'Entregadores online',
                count: viewModel.countDriversOnline.toString(),
                icon: Icons.open_in_new,
                route: '/dashboard/drivers'
              ),
            ),
            SizedBox(width: 20),
            SizedBox(
              width: 253,
              child: _StatCard(
                title: 'Meus pedidos',
                count: viewModel.countRestaurantSolitations.toString(),
                icon: Icons.open_in_new,
                route: '/dashboard/solitations'
              ),
            ),  
            Spacer()
          ],
        );
      }
    ); 
  }

  Widget _buildOrdersSection(BuildContext context) {
    final viewModel = Modular.get<DashboardViewmodel>();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'PEDIDOS EM ANDAMENTO',
              style: Theme.of(context).textTheme.titleMedium,
            ), 
          ),
          const SizedBox(height: 24),

          AnimatedBuilder(
            animation: viewModel,
            builder: (context, _) {
              final orders = viewModel.deliveries;

              if (orders.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              return Center(
                child: Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: orders
                      .map((o) => _buildOrderCard(o))
                      .toList(),
                ),
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
  final String route;

  const _StatCard({
    required this.title,
    required this.count,
    required this.route,
    this.icon,
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
                ],
              ),
              if (icon != null)
                IconButton(
                  onPressed: () => Modular.to.navigate(route),
                   icon: Icon(
                    icon,
                    color: Theme.of(context).iconTheme.color,
                    size: 20
                  ),
                ),
                
            ],
          ),
          const SizedBox(height: 12),
          Text(
            count,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.right,
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
    distance: '10 km',
    address: order.customerAddressStreet,
    name: 'joao'
  );
}

class _OrderCard extends StatelessWidget {
  final String location;
  final String status;
  final String distance;
  final String address;
  final String name;

  const _OrderCard({
    required this.name,
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
            'Local de entrega - $location',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 12),
          Text(
            '$name esta no processo de coleta',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 4),
          Text(
            '${distance} para o entregador chegar.',
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