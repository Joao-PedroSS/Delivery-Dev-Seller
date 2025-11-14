import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard DEV',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.white,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFF212121),
        cardColor: const Color(0xFF2D2D2D),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white70),
          headlineSmall:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          titleMedium:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
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
          _Sidebar(),
          Expanded(
            child: _MainContent(),
          ),
        ],
      ),
    );
  }
}

class _Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: const Color(0xFF1A1A1A),
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Entregas DEV',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            'Menu principal',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 16),
          _MenuItem(
            icon: Icons.dashboard_outlined,
            text: 'DASHBOARD',
            isSelected: true,
          ),
          _MenuItem(
            icon: Icons.people_alt_outlined,
            text: 'ENTREGADORES',
          ),
          _MenuItem(
            icon: Icons.description_outlined,
            text: 'Solicitações',
          ),
          const Spacer(),
          _MenuItem(
            icon: Icons.exit_to_app,
            text: 'SAIR',
          ),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isSelected;

  const _MenuItem({
    required this.icon,
    required this.text,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: isSelected ? Colors.grey.withOpacity(0.2) : Colors.transparent,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.white : Colors.grey[400],
            size: 20,
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey[400],
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 14,
            ),
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
          _buildHeader(),
          const SizedBox(height: 24),
          _buildStatsCards(),
          const SizedBox(height: 24),
          _buildOrdersSection(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'DASHBOARD',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
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

  Widget _buildOrdersSection() {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        children: [
          const Text(
            'PEDIDOS EM ANDAMENTO',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 16.0,
            runSpacing: 16.0,
            children: [
              _OrderCard(
                location: 'Local de entrega - Germânia',
                status: 'João esta no processo de coleta',
                distance: '12 km para o entregador chegar na loja',
                address: 'Rua Professor Prudente, 518',
              ),
              _OrderCard(
                location: 'Local de entrega - Avenida',
                status: 'Pedro esta no processo de entrega',
                distance: '12 km para o entregador chegar ao cliente',
                address: 'Avenida, 120, apto. 2',
              ),
              _OrderCard(
                location: 'Local de entrega - Germânia',
                status: 'João esta no processo de coleta',
                distance: '12 km para o entregador chegar na loja',
                address: 'Rua Professor Prudente, 518',
              ),
              _OrderCard(
                location: 'Local de entrega - Germânia',
                status: 'João esta no processo de coleta',
                distance: '12 km para o entregador chegar na loja',
                address: 'Rua Professor Prudente, 518',
              ),
              _OrderCard(
                location: 'Local de entrega - Avenida',
                status: 'Pedro esta no processo de entrega',
                distance: '12 km para o entregador chegar ao cliente',
                address: 'Avenida, 120, apto. 2',
              ),
              _OrderCard(
                location: 'Local de entrega - Germânia',
                status: 'João esta no processo de coleta',
                distance: '12 km para o entregador chegar na loja',
                address: 'Rua Professor Prudente, 518',
              ),
              _OrderCard(
                location: 'Local de entrega - Germânia',
                status: 'João esta no processo de coleta',
                distance: '12 km para o entregador chegar na loja',
                address: 'Rua Professor Prudente, 518',
              ),
              _OrderCard(
                location: 'Local de entrega - Avenida',
                status: 'Pedro esta no processo de entrega',
                distance: '12 km para o entregador chegar ao cliente',
                address: 'Avenida, 120, apto. 2',
              ),
            ],
          )
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
                    style: TextStyle(color: Colors.grey[300], fontSize: 14),
                  ),
                  if (showDot)
                    Padding(
                      padding: const EdgeInsets.only(left: 6.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 4,
                      ),
                    ),
                ],
              ),
              if (icon != null)
                Icon(icon, color: Colors.grey[400], size: 20),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            count,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
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
        color: const Color(0xFF3B3B3B),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            location,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            status,
            style: TextStyle(color: Colors.grey[300], fontSize: 13),
          ),
          const SizedBox(height: 4),
          Text(
            distance,
            style: TextStyle(color: Colors.grey[300], fontSize: 13),
          ),
          const SizedBox(height: 4),
          Text(
            address,
            style: TextStyle(color: Colors.grey[300], fontSize: 13),
          ),
        ],
      ),
    );
  }
}