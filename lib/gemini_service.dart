import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:OpenBreath/data.dart'; // Assuming data.dart contains BreathingExercise

class GeminiService {
  // TODO: Replace with your actual Gemini API key.
  // It's recommended to use environment variables or a secure method for API keys in production.
  static final String _apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
  static const String _apiUrl = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent';

  Future<String?> recommendExercise(String userInput, List<BreathingExercise> exercises) async {
    if (_apiKey == 'YOUR_GEMINI_API_KEY' || _apiKey.isEmpty) {
      print('Gemini API Key is not set. Please set your API key in lib/gemini_service.dart');
      return null;
    }

    final exerciseList = exercises.map((e) => {
      'id': e.id,
      'title': e.title,
      'intro': e.intro,
      'pattern': e.pattern, // Include pattern for more context
    }).toList();

    final prompt = """
The user is looking for a breathing exercise. They described their current state or goal as: "$userInput".
Here is a list of available breathing exercises:
${jsonEncode(exerciseList)}

Please recommend the 'id' of the single most suitable breathing exercise from the list above based on the user's input.
Respond only with the 'id' of the recommended exercise, nothing else. If no exercise is suitable, respond with "none".
""";

    try {
      final response = await http.post(
        Uri.parse('$_apiUrl?key=$_apiKey'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'contents': [
            {
              'parts': [
                {'text': prompt}
              ]
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final String? recommendedId = jsonResponse['candidates']?[0]['content']?['parts']?[0]?['text'];
        return recommendedId?.trim();
      } else {
        print('Gemini API Error: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error calling Gemini API: $e');
      return null;
    }
  }
}
