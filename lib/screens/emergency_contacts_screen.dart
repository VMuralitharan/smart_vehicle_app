import 'package:flutter/material.dart';
import 'package:smart_vehicle_app/utils/colors.dart';

class EmergencyContactsScreen extends StatefulWidget {
  const EmergencyContactsScreen({super.key});

  @override
  State<EmergencyContactsScreen> createState() =>
      _EmergencyContactsScreenState();
}

class _EmergencyContactsScreenState extends State<EmergencyContactsScreen> {
  final List<Map<String, String>> _contacts = [
    {'name': 'Police Emergency', 'number': '119', 'type': 'Police'},
    {'name': 'Ambulance Service', 'number': '1990', 'type': 'Ambulance'},
    {'name': 'Fire Department', 'number': '110', 'type': 'Fire'},
    {'name': 'Vehicle Owner', 'number': '+94 77 123 4567', 'type': 'Owner'},
    {'name': 'Fleet Manager', 'number': '+94 71 987 6543', 'type': 'Manager'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Contacts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addContact,
          ),
        ],
      ),
      body: Column(
        children: [
          // Info Card
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.primary.withOpacity(0.2)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'These contacts will receive SMS alerts during emergencies',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Contacts List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _contacts.length,
              itemBuilder: (context, index) {
                return _buildContactCard(_contacts[index]);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addContact,
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildContactCard(Map<String, String> contact) {
    IconData contactIcon;
    Color contactColor;

    switch (contact['type']) {
      case 'Police':
        contactIcon = Icons.local_police;
        contactColor = Colors.blue;
        break;
      case 'Ambulance':
        contactIcon = Icons.medical_services;
        contactColor = Colors.red;
        break;
      case 'Fire':
        contactIcon = Icons.fire_truck;
        contactColor = Colors.orange;
        break;
      default:
        contactIcon = Icons.person;
        contactColor = AppColors.primary;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Contact Icon
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: contactColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(contactIcon, color: contactColor),
            ),
            const SizedBox(width: 16),
            // Contact Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contact['name']!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    contact['number']!,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: contactColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      contact['type']!,
                      style: TextStyle(
                        color: contactColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Action Buttons
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.call, size: 20),
                  onPressed: () => _callContact(contact['number']!),
                ),
                IconButton(
                  icon: const Icon(Icons.edit, size: 20),
                  onPressed: () => _editContact(contact),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _addContact() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Emergency Contact'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Contact Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Contact added successfully'),
                ),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _editContact(Map<String, String> contact) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Contact'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: TextEditingController(text: contact['name']),
              decoration: const InputDecoration(
                labelText: 'Contact Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: TextEditingController(text: contact['number']),
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Contact updated successfully'),
                ),
              );
            },
            child: const Text('Update'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${contact['name']} removed'),
                  backgroundColor: AppColors.danger,
                ),
              );
            },
            style: TextButton.styleFrom(
              foregroundColor: AppColors.danger,
            ),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }

  void _callContact(String number) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Call Emergency'),
        content: Text('Do you want to call $number?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Implement actual call functionality
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Calling $number...'),
                ),
              );
            },
            child: const Text('Call'),
          ),
        ],
      ),
    );
  }
}
