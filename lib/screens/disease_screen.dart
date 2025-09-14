import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../l10n/lang.dart';

class DiseaseScreen extends StatefulWidget {
  final String languageCode;

  const DiseaseScreen({super.key, required this.languageCode});

  @override
  State<DiseaseScreen> createState() => _DiseaseScreenState();
}

class _DiseaseScreenState extends State<DiseaseScreen> {
  File? _selectedImage;
  String _diseaseResult = "—";

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);

        // Dummy result shown for now
        _diseaseResult = "Powdery Mildew 🌱 (Confidence: 87%)";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/images/logo.jpg', height: 40),
            const SizedBox(width: 10),
            Text(localizedValues[widget.languageCode]?['disease_detector'] ?? 'Disease Detector'),
          ],
        ),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: pickImage,
              child: Text(localizedValues[widget.languageCode]?['pick_image'] ?? 'Pick Crop Image'),
            ),
            const SizedBox(height: 20),
            _selectedImage != null
                ? Image.file(_selectedImage!, height: 200)
                : Text(localizedValues[widget.languageCode]?['no_image_selected'] ?? 'No image selected yet'),
            const SizedBox(height: 20),
            Text(
              "${localizedValues[widget.languageCode]?['predicted_disease'] ?? 'Predicted Disease'}: $_diseaseResult",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
