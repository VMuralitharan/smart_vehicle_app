import 'package:flutter/material.dart';
import 'package:smart_vehicle_app/utils/colors.dart';
import 'package:intl/intl.dart';

class AlertsHistoryScreen extends StatefulWidget {
  const AlertsHistoryScreen({super.key});

  @override
  State<AlertsHistoryScreen> createState() => _AlertsHistoryScreenState();
}

class _AlertsHistoryScreenState extends State<AlertsHistoryScreen> {
  String _selectedFilter = 'Today';
  final List<String> _filters = [
    'Today',
    'Yesterday',
    'This Week',
    'This Month',
  ];

  final List<Map<String, dynamic>> _alerts = [
    {
      'type': 'drowsy',
      'vehicle': 'NL-5678',
      'driver': 'Kamal Perera',
      'time': DateTime.now().subtract(const Duration(minutes: 30)),
      'location': 'Kandy Road',
      'resolved': true,
    },
    {
      'type': 'accident',
      'vehicle': 'NL-1234',
      'driver': 'John Silva',
      'time': DateTime.now().subtract(const Duration(hours: 2)),
      'location': 'Colombo Highway',
      'resolved': false,
    },
    {
      'type': 'drowsy',
      'vehicle': 'NL-9012',
      'driver': 'Sunil Fernando',
      'time': DateTime.now().subtract(const Duration(hours: 5)),
      'location': 'Galle Road',
      'resolved': true,
    },
    {
      'type': 'emergency',
      'vehicle': 'NL-3456',
      'driver': 'Nimal Rathnayake',
      'time': DateTime.now().subtract(const Duration(days: 1)),
      'location': 'Kurunegala',
      'resolved': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alert History')),
      body: Column(
        children: [
          // Filter Chips
          Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _filters.map((filter) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(filter),
                      selected: _selectedFilter == filter,
                      onSelected: (selected) {
                        setState(() => _selectedFilter = filter);
                      },
                      selectedColor: AppColors.primary,
                      checkmarkColor: Colors.white,
                      labelStyle: TextStyle(
                        color: _selectedFilter == filter
                            ? Colors.white
                            : AppColors.textPrimary,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          // Stats Summary
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildStatCard('12', 'Total Alerts', AppColors.primary),
                const SizedBox(width: 12),
                _buildStatCard('3', 'Accidents', AppColors.danger),
                const SizedBox(width: 12),
                _buildStatCard('8', 'Drowsy', AppColors.warning),
                const SizedBox(width: 12),
                _buildStatCard('1', 'Emergency', AppColors.secondary),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Alerts List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _alerts.length,
              itemBuilder: (context, index) {
                return _buildAlertCard(_alerts[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertCard(Map<String, dynamic> alert) {
    Color alertColor;
    IconData alertIcon;
    String alertTypeText;

    switch (alert['type']) {
      case 'accident':
        alertColor = AppColors.danger;
        alertIcon = Icons.car_crash;
        alertTypeText = 'ACCIDENT';
        break;
      case 'drowsy':
        alertColor = AppColors.warning;
        alertIcon = Icons.bedtime;
        alertTypeText = 'DROWSY';
        break;
      case 'emergency':
        alertColor = AppColors.secondary;
        alertIcon = Icons.emergency;
        alertTypeText = 'EMERGENCY';
        break;
      default:
        alertColor = AppColors.normal;
        alertIcon = Icons.notifications;
        alertTypeText = 'ALERT';
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Alert Icon
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: alertColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(alertIcon, color: alertColor),
            ),
            const SizedBox(width: 16),
            // Alert Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        alertTypeText,
                        style: TextStyle(
                          color: alertColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: alert['resolved']
                              ? AppColors.success.withOpacity(0.1)
                              : AppColors.danger.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          alert['resolved'] ? 'RESOLVED' : 'ACTIVE',
                          style: TextStyle(
                            color: alert['resolved']
                                ? AppColors.success
                                : AppColors.danger,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Vehicle: ${alert['vehicle']}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Driver: ${alert['driver']}',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 12,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          alert['location'],
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('MMM dd, yyyy - hh:mm a').format(alert['time']),
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            // Action Button
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios, size: 16),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
