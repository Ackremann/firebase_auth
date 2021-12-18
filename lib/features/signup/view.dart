import 'package:firebase_auth/core/validator/validator.dart';
import 'package:firebase_auth/features/home/view.dart';
import 'package:firebase_auth/features/signup/controller.dart';
import 'package:firebase_auth/widgets/input_field.dart';
import 'package:firebase_auth/widgets/snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignupView extends StatefulWidget {
  SignupView({Key? key}) : super(key: key);

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  SignupController controller = SignupController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Singup'),
      ),
      body: Form(
        key: controller.formKey,
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            InputField(
              hint: 'Pls enter your Email',
              onSaved: (v) => controller.email = v!,
              validator: Validator.email,
            ),
            InputField(
              hint: 'Pls enter your Password',
              onSaved: (v) => controller.password = v!,
              validator: Validator.password,
            ),
            controller.loasding
                ? CupertinoActivityIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      setState(() => controller.loasding = true);
                      final message = await controller.SignUp();
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
                      setState(() => controller.loasding = false);
                    },
                    child: Text('Register Now'),
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Have an account ?'),
                TextButton(onPressed: () {}, child: Text('Login now!')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
