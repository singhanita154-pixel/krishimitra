import 'package:flutter/material.dart';
import 'package:krishimitra/screens/home_screen.dart';


class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final languages = ["English", "हिन्दी"];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Language"),
        backgroundColor: Colors.blue, // system/backend color
      ),
      body: ListView.builder(
        itemCount: languages.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ListTile(
              title: Text(
                languages[index],
                style: const TextStyle(fontSize: 18),
              ),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                String langCode = (languages[index] == "हिन्दी") ? "hi" : "en";

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(languageCode: langCode),
                  ),
                );
              },

            ),
          );
        },
      ),
    );
  }
}
