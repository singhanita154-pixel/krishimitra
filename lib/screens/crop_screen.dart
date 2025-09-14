import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:krishimitra/screens/recommendation_screen.dart';
import '../l10n/lang.dart';

class CropScreen extends StatefulWidget {
  final String languageCode;

  const CropScreen({super.key, required this.languageCode});

  @override
  State<CropScreen> createState() => _CropScreenState();
}

class _CropScreenState extends State<CropScreen> {
  bool isDataFetched = false;
  String gpsLocation = "Fetching GPS...";
  String selectedLocation = "Not selected";
  String soilData = "—";
  String weatherData = "—";
  String marketData = "—";

  final List<String> locationOptions = [
    "Select Location",
    "Delhi",
    "Punjab",
    "Maharashtra",
    "West Bengal",
    "Tamil Nadu"
  ];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        gpsLocation = "Enable GPS service";
      });
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        gpsLocation = "Lat: ${position.latitude}, Lon: ${position.longitude}";
      });
    } else {
      setState(() {
        gpsLocation = "Permission Denied";
      });
    }
  }

  void fetchSoilWeatherData() {
    setState(() {
      soilData = "pH: 6.5, Moisture: 25%";
      weatherData = "Sunny, 32°C";
      marketData = "Wheat: ₹2000/quintal";
      isDataFetched = true;
    });
  }

  void navigateToRecommendedCrops() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecommendationScreen(
          languageCode: widget.languageCode,
          recommendedCrops: [
            {
              'name': 'Soybean 🌱',
              'description': 'High suitability (soil pH 6.5, good rain forecast), profit ₹22,000/acre'
            },
            {
              'name': 'Maize 🌽',
              'description': 'Good market demand, medium water use, profit ₹18,000/acre'
            },
            {
              'name': 'Pigeon Pea (Arhar) 🌾',
              'description': 'Improves soil fertility, medium profitability ₹15,000/acre'
            },
          ],
        ),
      ),
    );
  }

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
            Text(localizedValues[widget.languageCode]?['welcome'] ?? 'Crop Recommender'),
          ],
        ),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${localizedValues[widget.languageCode]?['location'] ?? 'Location'}: $gpsLocation",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  "${localizedValues[widget.languageCode]?['select_manual_location'] ?? 'Select Location'}:",
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  value: selectedLocation == "Not selected" ? null : selectedLocation,
                  hint: Text(localizedValues[widget.languageCode]?['select_manual_location'] ?? 'Select manually'),
                  items: locationOptions.map((String loc) {
                    return DropdownMenuItem<String>(
                      value: loc,
                      child: Text(loc),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedLocation = value!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: fetchSoilWeatherData,
              child: Text(localizedValues[widget.languageCode]?['fetch_data'] ?? 'Fetch Data'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              onPressed: isDataFetched ? navigateToRecommendedCrops : null,
              child: Text(localizedValues[widget.languageCode]?['see_recommended_crops'] ?? 'See Recommended Crops'),
            ),
            const SizedBox(height: 20),
            Text(
              "${localizedValues[widget.languageCode]?['soil_data'] ?? 'Soil Data'}: $soilData",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              "${localizedValues[widget.languageCode]?['weather_data'] ?? 'Weather Data'}: $weatherData",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              "${localizedValues[widget.languageCode]?['market_data'] ?? 'Market Data'}: $marketData",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
