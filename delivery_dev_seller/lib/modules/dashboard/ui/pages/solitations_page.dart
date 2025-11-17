import 'package:delivery_dev_seller/modules/dashboard/ui/widgets/sidebar.dart';
import 'package:delivery_dev_seller/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SolitationsScreen extends StatelessWidget {
  const SolitationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const Sidebar(currentPage: AppPages.requests),
          Expanded(
            child: _MainContent(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.surface,
        shape: const CircleBorder(
          side: BorderSide(color: AppColors.borderColor, width: 2),
        ),
        child: const Icon(Icons.add, size: 32),
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
          _buildOrdersGrid(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'SOLICITAÇÕES',
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

  Widget _buildOrdersGrid(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: const Wrap(
        spacing: 16.0,
        runSpacing: 16.0,
        alignment: WrapAlignment.center,
        children: [
          _OrderCard(
            location: 'Local de entrega - Avenida',
            status: 'Pedro esta no processo de entrega',
            distance: '12 km para o entregador chegar ao cliente',
            address: 'Avenida, 120, apto. 2',
          ),
          _OrderCard(
            location: 'Local de entrega - Avenida',
            status: 'Nenhum entregador aceitou até o momento',
            distance: '...',
            address: 'Avenida, 120, apto. 2',
          ),
          _OrderCard(
            location: 'Local de entrega - Avenida',
            status: 'Pedro esta no processo de entrega',
            distance: '12 km para o entregador chegar ao cliente',
            address: 'Avenida, 120, apto. 2',
          ),
          _OrderCard(
            location: 'Local de entrega - Avenida',
            status: 'Pedro esta no processo de entrega',
            distance: '12 km para o entregador chegar ao cliente',
            address: 'Avenida, 120, apto. 2',
          ),
          _OrderCard(
            location: 'Local de entrega - Avenida',
            status: 'Pedro esta no processo de entrega',
            distance: '12 km para o entregador chegar ao cliente',
            address: 'Avenida, 120, apto. 2',
          ),
          _OrderCard(
            location: 'Local de entrega - Avenida',
            status: 'Pedro esta no processo de entrega',
            distance: '12 km para o entregador chegar ao cliente',
            address: 'Avenida, 120, apto. 2',
          ),
          _OrderCard(
            location: 'Local de entrega - Avenida',
            status: 'Pedro esta no processo de entrega',
            distance: '12 km para o entregador chegar ao cliente',
            address: 'Avenida, 120, apto. 2',
          ),
           _OrderCard(
            location: 'Local de entrega - Avenida',
            status: 'Pedro esta no processo de entrega',
            distance: '12 km para o entregador chegar ao cliente',
            address: 'Avenida, 120, apto. 2',
          ),
           _OrderCard(
            location: 'Local de entrega - Avenida',
            status: 'Pedro esta no processo de entrega',
            distance: '12 km para o entregador chegar ao cliente',
            address: 'Avenida, 120, apto. 2',
          ),
        ],
      ),
    );
  }
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