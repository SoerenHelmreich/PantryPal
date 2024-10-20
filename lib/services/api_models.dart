import 'dart:convert';
import 'dart:io';

import 'package:cooking_companion/models/completion_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ApiService {
  static Future<CompletionModel> createCompletion({
    required String systemPrompt,
    required String userPrompt,
    required Object returnFormat,
    int max_completion_tokens = 5000,
  }) async {
    try {
      final supabase = Supabase.instance.client;

      final res = await supabase.functions
          .invoke("openai", method: HttpMethod.post, body: {
        "systemPrompt": systemPrompt,
        "userPrompt": userPrompt,
        "returnFormat": returnFormat
      });
      final data = res.data;

      print(data);
      

      Map jsonResponse = jsonDecode(data);

      if (jsonResponse['error'] != null) {
        print(
            "In API_Models Error from createCompletion(): ${jsonResponse['error']['message']}");
        throw HttpException(jsonResponse['error']['message']);
      }

      //Model returned something useful
      if (jsonResponse['title'].length > 0) {
        print(data);

        return CompletionModel.fromJson(data);
      } else {
        throw const HttpException("No completion message from model");
      }
    } catch (e) {
      print("error $e");
      rethrow;
    }
  }
}
