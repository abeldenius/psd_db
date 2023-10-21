import 'package:flutter/material.dart';

class DataOverviewPage extends StatelessWidget {
  const DataOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dataoversigt'),
      ),
      body: const Center(
        child: Text('This is the Dataoversigt page'),
      ),
    );
  }
}
