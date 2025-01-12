import 'package:admin_app/models/child.dart';
// import 'package:admin_app/models/inventory.dart';
import 'package:admin_app/providers/children_provider.dart';
import 'package:admin_app/providers/inventory_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DashboardHeader(),
          const SizedBox(height: 24),
          const QuickStatsCards(),
          const SizedBox(height: 24),
          const UpcomingVaccinationsCard(),
          const SizedBox(height: 24),
          const LowInventoryAlert(),
        ],
      ),
    );
  }
}

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back, Health Worker',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Health Post: Central Community Clinic',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 4),
            Text(
              DateTime.now().toString().split(' ')[0],
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuickStatsCards extends StatelessWidget {
  const QuickStatsCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ChildrenProvider>(
      builder: (context, provider, child) {
        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          children: [
            _StatCard(
              title: 'Total Children',
              value: provider.children.length.toString(),
              icon: Icons.child_care,
              color: Colors.blue,
            ),
            _StatCard(
              title: 'Due for Vaccine',
              value: _calculateDueVaccines(provider.children),
              icon: Icons.vaccines,
              color: Colors.orange,
            ),
            _StatCard(
              title: 'Growth Checks Due',
              value: _calculateDueGrowthChecks(provider.children),
              icon: Icons.height,
              color: Colors.green,
            ),
            _StatCard(
              title: 'New Registrations',
              value: _calculateNewRegistrations(provider.children),
              icon: Icons.how_to_reg,
              color: Colors.purple,
            ),
          ],
        );
      },
    );
  }

  String _calculateDueVaccines(List<Child> children) {
    // Calculate children due for vaccines in next 7 days
    final now = DateTime.now();
    final nextWeek = now.add(const Duration(days: 7));
    
    int count = 0;
    for (var child in children) {
      for (var vaccine in child.vaccineRecords) {
        if (vaccine.administeredDate == null &&
            vaccine.dueDate.isAfter(now) &&
            vaccine.dueDate.isBefore(nextWeek)) {
          count++;
          break;
        }
      }
    }
    return count.toString();
  }

  String _calculateDueGrowthChecks(List<Child> children) {
    // Calculate children who haven't had a growth check in 3 months
    final threeMonthsAgo = DateTime.now().subtract(const Duration(days: 90));
    
    int count = 0;
    for (var child in children) {
      if (child.growthRecords.isEmpty ||
          child.growthRecords.last.date.isBefore(threeMonthsAgo)) {
        count++;
      }
    }
    return count.toString();
  }

  String _calculateNewRegistrations(List<Child> children) {
    // Calculate children registered in last 30 days
    final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));
    
    return children
        .where((child) => child.dateOfBirth.isAfter(thirtyDaysAgo))
        .length
        .toString();
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 32,
              color: color,
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class UpcomingVaccinationsCard extends StatelessWidget {
  const UpcomingVaccinationsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ChildrenProvider>(
      builder: (context, provider, child) {
        final upcomingVaccinations = _getUpcomingVaccinations(provider.children);

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Upcoming Vaccinations',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                if (upcomingVaccinations.isEmpty)
                  const Text('No upcoming vaccinations this week')
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: upcomingVaccinations.length,
                    itemBuilder: (context, index) {
                      final vaccination = upcomingVaccinations[index];
                      return ListTile(
                        title: Text(vaccination['childName']!),
                        subtitle: Text(vaccination['vaccineName']!),
                        trailing: Text(vaccination['dueDate']!),
                      );
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<Map<String, String>> _getUpcomingVaccinations(List<Child> children) {
    final now = DateTime.now();
    final nextWeek = now.add(const Duration(days: 7));
    final vaccinations = <Map<String, String>>[];

    for (var child in children) {
      for (var vaccine in child.vaccineRecords) {
        if (vaccine.administeredDate == null &&
            vaccine.dueDate.isAfter(now) &&
            vaccine.dueDate.isBefore(nextWeek)) {
          vaccinations.add({
            'childName': child.name,
            'vaccineName': vaccine.vaccineName,
            'dueDate': vaccine.dueDate.toString().split(' ')[0],
          });
        }
      }
    }

    return vaccinations;
  }
}

class LowInventoryAlert extends StatelessWidget {
  const LowInventoryAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InventoryProvider>(
      builder: (context, provider, child) {
        final lowInventory = _getLowInventoryItems(provider.inventory.cast<VaccineInventory>());

        if (lowInventory.isEmpty) {
          return const SizedBox.shrink();
        }

        return Card(
          color: Colors.red[50],
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.red[700],
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Low Inventory Alert',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.red[700],
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: lowInventory.length,
                  itemBuilder: (context, index) {
                    final vaccine = lowInventory[index];
                    return ListTile(
                      title: Text(vaccine.name),
                      subtitle: Text('Current stock: ${vaccine.quantity}'),
                      trailing: TextButton(
                        onPressed: () {
                          // TODO: Navigate to inventory management
                        },
                        child: const Text('Restock'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<VaccineInventory> _getLowInventoryItems(List<VaccineInventory> inventory) {
    const lowThreshold = 10; // Define low inventory threshold
    return inventory.where((vaccine) => vaccine.quantity < lowThreshold).toList();
  }
}
