import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

enum AppPages { dashboard, drivers, requests }

class Sidebar extends StatelessWidget {
  final AppPages currentPage;

  const Sidebar({super.key, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Theme.of(context).dialogBackgroundColor,
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
          Text(
            'Menu principal',
            style: Theme.of(context).textTheme.labelSmall,
          ),
          const SizedBox(height: 16),
          _MenuItem(
            icon: Icons.dashboard_outlined,
            text: 'DASHBOARD',
            route: '/dashboard/',
            isSelected: currentPage == AppPages.dashboard,
          ),
          _MenuItem(
            icon: Icons.people_alt_outlined,
            text: 'ENTREGADORES',
            route: '/dashboard/drivers',
            isSelected: currentPage == AppPages.drivers,
          ),
          _MenuItem(
            icon: Icons.description_outlined,
            text: 'Solicitações',
            route: '/dashboard/solitations',
            isSelected: currentPage == AppPages.requests,
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
  final String? route;
  final bool isSelected;

  const _MenuItem({
    required this.icon,
    required this.text,
    this.route,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final iconColor = Theme.of(context).iconTheme.color;

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
            color: isSelected ? Colors.white : iconColor,
            size: 20,
          ),
          const SizedBox(width: 12),
          InkWell(
            onTap: () {
              route != null ? Modular.to.navigate(route!) : {};
            },
            child: Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.white : iconColor,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 14,
              ),
            ),
          )
        ],
      ),
    );
  }
}