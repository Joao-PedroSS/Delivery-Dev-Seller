import 'package:delivery_dev_seller/modules/dashboard/data/dtos/delivery_dto.dart';
import 'package:delivery_dev_seller/modules/dashboard/ui/viewmodels/solitations_viewmodel.dart';
import 'package:delivery_dev_seller/modules/dashboard/ui/widgets/new_solitation_modal.dart';
import 'package:delivery_dev_seller/modules/dashboard/ui/widgets/sidebar.dart';
import 'package:delivery_dev_seller/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SolitationsPage extends StatefulWidget {
  const SolitationsPage({super.key});

  @override
  State<SolitationsPage> createState() => _SolitationsState();
}

class _SolitationsState extends State<SolitationsPage> {
  
  void _openNewOrderModal() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return const OrderFormModal();
      },
    );
  }
  
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
        onPressed: _openNewOrderModal,
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
    final viewModel = Modular.get<SolitationsViewmodel>();

    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: StreamBuilder<List<DeliveryDto>>(
        stream: viewModel.ordersStream,
        builder: (context, snapshot) {
          
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Erro ao carregar solicitações: ${snapshot.error}",
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: CircularProgressIndicator(),
              ),
            );
          }

          final orders = snapshot.data ?? [];

          if (orders.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  "Nenhuma solicitação encontrada.",
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            );
          }

          return Wrap(
            spacing: 16.0,
            runSpacing: 16.0,
            alignment: WrapAlignment.start, 
            children: orders.map((order) => _buildOrderCard(order)).toList(),
          );
        },
      ),
    );
  }
}

_OrderCard _buildOrderCard(DeliveryDto order) {
  final bool isPending = order.status == 'pending';

  String statusText;
  String distanceText;

  if (isPending) {
    statusText = "Nenhum entregador aceitou até o momento";
    distanceText = "..."; 
  } else {
    statusText = "${order.driverName ?? 'O entregador'} está no processo de entrega";
    distanceText = "${order.distanceKm?.toStringAsFixed(1) ?? '--'} km para o entregador chegar ao cliente";
  }

  return _OrderCard(
    location: order.customerAddressLabel.isNotEmpty ? order.customerAddressLabel : "Local de entrega",
    status: statusText,
    distance: distanceText,
    address: order.customerAddressStreet,
    isPending: isPending,
  );
}

class _OrderCard extends StatelessWidget {
  final String location;
  final String status;
  final String distance;
  final String address;
  final bool isPending;

  const _OrderCard({
    required this.location,
    required this.status,
    required this.distance,
    required this.address,
    this.isPending = false,
  });

  @override
  Widget build(BuildContext context) {
    final contentOpacity = isPending ? 0.5 : 1.0;
    
    final backgroundColor = isPending 
        ? Color.alphaBlend(Colors.black.withOpacity(0.3), Theme.of(context).canvasColor)
        : Theme.of(context).canvasColor;

    return Container(
      width: 280,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Opacity(
        opacity: contentOpacity,
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
      ),
    );
  }
}