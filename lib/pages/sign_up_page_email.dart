import 'package:flutter/material.dart';
import 'package:cooking_companion/utils/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});
  final TextEditingController emailInputController = TextEditingController();
  final TextEditingController passwordInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Account")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            //Email
            TextField(
              controller: emailInputController,
              autocorrect: true,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: "Provide your email",
                hintStyle: TextStyle(
                  color: Colors.grey.shade500,
                ),
              ),
            ),
            //Password
            TextField(
              controller: passwordInputController,
              autocorrect: true,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: "Password",
                hintStyle: TextStyle(
                  color: Colors.grey.shade500,
                ),
              ),
            ),
            SizedBox(height: 40),
            FloatingActionButton.extended(
              onPressed: () => SignUp(
                  emailInputController.text, passwordInputController.text),
              label: Text("Next"),
              icon: Icon(Icons.navigate_next),
            )
          ],
        ),
      ),
    );
  }
}

Future<AuthResponse?> SignUp(String email, String password) async {
  try {
    AuthResponse response =
        await supabase.auth.signUp(email: email, password: password);
    print(response);
    return response;
  } on Exception catch (e) {
    if (e is AuthException && e.code == 'user_already_exists') {
      return supabase.auth.signInWithPassword(email: email, password: password);
    } else {
      print('An error occurred: ${e.toString()}');
    }
  }
  return null;
}
