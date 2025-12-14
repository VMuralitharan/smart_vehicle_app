import 'package:flutter/material.dart';

class FloatingEmergencyButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const FloatingEmergencyButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed ?? () {},
      icon: const Icon(Icons.warning),
      label: const Text('Emergency'),
    );
  }
}
