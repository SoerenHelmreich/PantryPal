import 'dart:convert';
import 'dart:io';

import 'package:cooking_companion/env/env.dart';
import 'package:cooking_companion/models/completion_model.dart';
import 'package:cooking_companion/models/models_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<ModelsModel>> getModels() async {
    try {
      var response = await http.get(Uri.parse("${Env.BASEURL}/models"),
          headers: {'Authorization': 'Bearer ${Env.OPENAI_KEY}'});

      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse['error'] != null) {
        print(
            "In API_Models Error from GetModels(): ${jsonResponse['error']['message']}");
        throw HttpException(jsonResponse['error']['message']);
      }

      List temp = [];
      for (var value in jsonResponse['data']) {
        temp.add(value);
        print("temp ${value['id']}");
      }

      return ModelsModel.modelsFromSnapshot(temp);
    } catch (e) {
      print("error $e");
      rethrow;
    }
  }

  static Future<CompletionModel> createCompletion({
    required String systemPrompt,
    required String userPrompt,
    required Object returnFormat,
    int max_completion_tokens = 5000,
  }) async {
    try {
      var response = await http.post(
        Uri.parse("${Env.BASEURL}/chat/completions"),
        headers: {
          'Authorization': 'Bearer ${Env.OPENAI_KEY}',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(
          {
            "model": "gpt-4o-mini",
            "max_completion_tokens": max_completion_tokens,
            "response_format": returnFormat,
            "messages": [
              {"role": "system", "content": systemPrompt},
              {"role": "user", "content": userPrompt}
            ]
          },
        ),
      );

      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse['error'] != null) {
        print(
            "In API_Models Error from createCompletion(): ${jsonResponse['error']['message']}");
        throw HttpException(jsonResponse['error']['message']);
      }

      //Model returned something useful
      if (jsonResponse['choices'].length > 0) {
        print(jsonResponse['choices'][0]['message']['content']);

        return CompletionModel.fromJson(
            jsonResponse['choices'][0]['message']['content']);
      } else {
        throw HttpException("No completion message from model");
      }
    } catch (e) {
      print("error $e");
      rethrow;
    }
  }
}
