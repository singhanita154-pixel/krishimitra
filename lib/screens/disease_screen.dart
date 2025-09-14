import 'package:flutter/material.dart';

class DiseaseScreen extends StatelessWidget {
  const DiseaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Disease Detector"), backgroundColor: Colors.yellow),
      body: const Center(child: Text("Disease Detection Page (Coming Soon)")),
    );
  }
}
