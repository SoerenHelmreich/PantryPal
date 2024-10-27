import 'package:flutter/material.dart';
import 'package:pantry_pal/utils/constants.dart';
import 'package:pantry_pal/widgets/centerOnWeb.dart';
import 'package:simple_animated_button/elevated_layer_button.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key, required this.redirectPage});
  final Widget redirectPage;

  final TextEditingController emailInputController = TextEditingController();
  final TextEditingController passwordInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ConstrainedContainer(
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: ElevatedLayerButton(
              onClick: () => Navigator.of(context).pop(),
              buttonHeight: 50,
              buttonWidth: 50,
              animationDuration: const Duration(milliseconds: 200),
              animationCurve: Curves.ease,
              topDecoration: BoxDecoration(
                  color: Colors.amber,
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(60)),
              topLayerChild: const Icon(Icons.arrow_back),
              baseDecoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(60)),
            ),
          ),
          forceMaterialTransparency: true,
          scrolledUnderElevation: 0.0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text("Create an account", style: monoStyleTitle),
              SizedBox(height: 48),

              //Email
              TextField(
                controller: emailInputController,
                keyboardType: TextInputType.emailAddress,
                autocorrect: true,
                enableSuggestions: false,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: "Email",
                  hintText: "Provide your email",
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 4.0, color: Colors.black)),
                  hintStyle: TextStyle(
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              //Password
              TextField(
                controller: passwordInputController,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: "Password",
                  hintText: "Create a strong password",
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 4.0, color: Colors.black)),
                  hintStyle: TextStyle(
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
              SizedBox(height: 40),
              ElevatedLayerButton(
                onClick: () {
                  SignUp(emailInputController.text,
                      passwordInputController.text, context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => redirectPage));
                },
                buttonHeight: 60,
                buttonWidth: 270,
                animationDuration: const Duration(milliseconds: 200),
                animationCurve: Curves.ease,
                topDecoration: BoxDecoration(
                    color: Colors.amber,
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(20)),
                topLayerChild: Text(
                  "Sign in",
                  style: monoStyleButtonBig,
                ),
                baseDecoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<AuthResponse?> SignUp(
    String email, String password, dynamic context) async {
  try {
    AuthResponse response =
        await supabase.auth.signUp(email: email, password: password);
    print(response);
    return response;
  } on Exception catch (e) {
    if (e is AuthException && e.code == 'user_already_exists') {
      return SignIn(email, password, context);
    }
    if (e is AuthException && e.code == 'weak_password') {
      ShowSnackBar('Weak password. Use at least 6 characters.', 4, context);
      return null;
    } else {
      print('An error occurred: ${e.toString()}');
      return null;
    }
  }
}

Future<AuthResponse?> SignIn(
    String email, String password, dynamic context) async {
  try {
    AuthResponse response = await supabase.auth
        .signInWithPassword(email: email, password: password);
    return response;
  } on Exception catch (e) {
    if (e is AuthException && e.code == 'invalid_credentials') {
      ShowSnackBar('Wrong password. Please try again', 4, context);
      return e as Future<AuthResponse>;
    }
  }
}

void ShowSnackBar(String message, int duration, dynamic context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.none,
      content: Text(message),
      duration: Duration(seconds: duration),
    ),
  );
}
