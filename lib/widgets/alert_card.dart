import 'package:flutter/material.dart';
import '../models/alert_model.dart';

class AlertCard extends StatelessWidget {
  final AlertModel alert;

  const AlertCard({super.key, required this.alert});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(alert.title),
        subtitle: Text(alert.description),
        trailing: Text(alert.timestamp.toString()),
      ),
    );
  }
}
