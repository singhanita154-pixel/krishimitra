import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../l10n/lang.dart';

class ChatbotScreen extends StatefulWidget {
  final String languageCode;

  const ChatbotScreen({super.key, required this.languageCode});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _userVoiceInput = "";
  List<String> _chatMessages = [];

  void startListening() async {
    bool available = await _speech.initialize();
    if (available) {
      setState(() => _isListening = true);
      _speech.listen(
        onResult: (result) {
          setState(() {
            _userVoiceInput = result.recognizedWords;
          });
        },
      );
    }
  }

  void stopListeningAndSend() {
    _speech.stop();
    setState(() {
      _isListening = false;
      if (_userVoiceInput.trim().isNotEmpty) {
        _chatMessages.add("Farmer: $_userVoiceInput");
        _chatMessages.add("Bot: This is a sample response.");  // Dummy reply
      }
      _userVoiceInput = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/images/logo.jpg', height: 40),
            const SizedBox(width: 10),
            Text(localizedValues[widget.languageCode]?['chatbot'] ?? 'AI Voice Chatbot'),
          ],
        ),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _chatMessages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_chatMessages[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  _isListening
                      ? (localizedValues[widget.languageCode]?['listening'] ?? "Listening...")
                      : (localizedValues[widget.languageCode]?['tap_mic'] ?? "Tap mic to speak"),
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    FloatingActionButton(
                      backgroundColor: Colors.green,
                      onPressed: _isListening ? stopListeningAndSend : startListening,
                      child: Icon(_isListening ? Icons.mic_off : Icons.mic),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Text(
                        _userVoiceInput,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
