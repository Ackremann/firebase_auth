import 'package:firebase_auth/core/validator/validator.dart';
import 'package:firebase_auth/features/home/view.dart';
import 'package:firebase_auth/features/login/controller.dart';
import 'package:firebase_auth/features/signup/view.dart';
import 'package:firebase_auth/widgets/input_field.dart';
import 'package:firebase_auth/widgets/snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LogInController controller = LogInController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sing In'),
        centerTitle: true,
      ),
      body: Form(
        key: controller.formKey,
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            InputField(
              hint: 'Email',
              onSaved: (v) => controller.email = v!,
              validator: Validator.email,
              keyboardType: TextInputType.emailAddress,
            ),
            InputField(
              hint: 'Password',
              onSaved: (v) => controller.password = v!,
              validator: Validator.password,
              keyboardType: TextInputType.number,
            ),
            controller.loading
                ? CupertinoActivityIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        controller.loading = true;
                      });
                      final message = await controller.SignIn();
                      if (message == "ok") {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeView(),
                          ),
                        );
                      } else if (message != null && message.isEmpty) {
                        showSnackBar(context, message, isError: true);
                      } else {
                        showSnackBar(context, message!, isError: true);
                      }
                      setState(() {
                        controller.loading = false;
                      });
                    },
                    child: Text('LogIn'),
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(' dont Have an account ?'),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignupView(),
                        ),
                      );
                    },
                    child: Text('Sign Up now!')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
