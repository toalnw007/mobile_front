import 'package:flutter/material.dart';

class Loan extends StatelessWidget {
  const Loan({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        height: 300,
        padding: const EdgeInsets.all(65),
        color: Colors.red,
        child: const Center(
          child: Text(
            'This is Loan Page',
            style: TextStyle(fontSize: 28),
          ),
        ),
      ),
    );
  }
}