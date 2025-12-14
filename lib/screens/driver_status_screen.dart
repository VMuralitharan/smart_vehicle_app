import 'package:flutter/material.dart';
import 'package:smart_vehicle_app/utils/colors.dart';

class DriverStatusScreen extends StatefulWidget {
  const DriverStatusScreen({super.key});

  @override
  State<DriverStatusScreen> createState() => _DriverStatusScreenState();
}

class _DriverStatusScreenState extends State<DriverStatusScreen> {
  final List<Map<String, dynamic>> _drivers = [
    {
      'name': 'Ainkaran',
      'vehicle': 'NL-1234',
      'status': 'normal',
      'lastAlert': '2 hours ago',
      'trip': 'Colombo → Kandy',
      'alertCount': 0,
    },
    {
      'name': 'AJ',
      'vehicle': 'NL-5678',
      'status': 'drowsy',
      'lastAlert': '15 mins ago',
      'trip': 'Kandy → COLOMBO',
      'alertCount': 2,
    },
    {
      'name': 'VM',
      'vehicle': 'NL-9012',
      'status': 'normal',
      'lastAlert': '5 hours ago',
      'trip': 'Jaffna → Colombo',
      'alertCount': 1,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Driver Status')),
      body: Column(
        children: [
          // Status Summary Card
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.purple.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('3', 'Total Drivers'),
                _buildStatItem('1', 'Drowsy'),
                _buildStatItem('2', 'Normal'),
                _buildStatItem('3', 'Alerts Today'),
              ],
            ),
          ),
          // Driver List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _drivers.length,
              itemBuilder: (context, index) {
                return _buildDriverCard(_drivers[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.9)),
        ),
      ],
    );
  }

  Widget _buildDriverCard(Map<String, dynamic> driver) {
    bool isDrowsy = driver['status'] == 'drowsy';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Avatar with Status
            Stack(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: isDrowsy
                      ? AppColors.warning.withOpacity(0.1)
                      : AppColors.normal.withOpacity(0.1),
                  child: Icon(
                    Icons.person,
                    size: 32,
                    color: isDrowsy ? AppColors.warning : AppColors.normal,
                  ),
                ),
                if (isDrowsy)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.danger,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Icon(
                        Icons.warning,
                        size: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 16),
            // Driver Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        driver['name'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: isDrowsy
                              ? AppColors.warning.withOpacity(0.1)
                              : AppColors.success.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          isDrowsy ? 'DROWSY' : 'NORMAL',
                          style: TextStyle(
                            color: isDrowsy
                                ? AppColors.warning
                                : AppColors.success,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.directions_bus,
                        size: 14,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        driver['vehicle'],
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        Icons.route,
                        size: 14,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          driver['trip'],
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Last alert: ${driver['lastAlert']}',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
