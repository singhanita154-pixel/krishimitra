import 'package:flutter/material.dart';
import '../l10n/lang.dart';
import 'crop_screen.dart';
import 'disease_screen.dart';
import 'chatbot_screen.dart';

class HomeScreen extends StatefulWidget {
  final String languageCode;  // ✅ Add this property

  const HomeScreen({super.key, required this.languageCode});  // Pass languageCode

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            ClipOval(
              child: Image.asset(
                'assets/images/logo.jpg',
                height: 40,
                width: 40,              // Ensure width = height for perfect circle
                fit: BoxFit.cover,      // Ensures the image covers the circle without distortion
              ),
            ),
            const SizedBox(width: 10),
            Text(localizedValues[widget.languageCode]!['welcome']!),

          ],
        ),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildFeatureCard(
              title: "Crop Recommender",
              color: Colors.green,
              icon: Icons.agriculture,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CropScreen(languageCode: widget.languageCode),
                  ),
                );
              },
            ),
            _buildFeatureCard(
              title: "Disease Detector",
              color: Colors.yellow[700]!,
              icon: Icons.bug_report,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DiseaseScreen()),
                );
              },
            ),
            _buildFeatureCard(
              title: "AI Voice Chatbot",
              color: Colors.blue,
              icon: Icons.mic,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatbotScreen()),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard({
    required String title,
    required Color color,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: color.withOpacity(0.9),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 48, color: Colors.white),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
