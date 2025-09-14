import 'package:flutter/material.dart';
import '../l10n/lang.dart';

class RecommendationScreen extends StatelessWidget {
  final String languageCode;
  final List<Map<String, String>> recommendedCrops;

  const RecommendationScreen({
    super.key,
    required this.languageCode,
    required this.recommendedCrops,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
    children: [
      ClipOval(
        child: Image.asset(
          'assets/images/logo.jpg', // your logo path
          height: 30, // small size
          width: 30,
          fit: BoxFit.cover,
        ),
      ),
      const SizedBox(width: 10), // space between logo and text
      const Text("Recommended Crops"),
    ],
  ),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Based on soil, weather & market data, we recommend:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: recommendedCrops.length,
                itemBuilder: (context, index) {
                  final crop = recommendedCrops[index];
                  return Card(
                    color: Colors.green[200],
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      leading: const Icon(Icons.agriculture, color: Colors.green, size: 36),
                      title: Text(
                        crop['name']!,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        crop['description']!,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
