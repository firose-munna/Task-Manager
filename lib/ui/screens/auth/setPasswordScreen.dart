import 'package:flutter/material.dart';
import 'package:taskmanager/data/model/networkResponse.dart';
import 'package:taskmanager/data/services/networkCaller.dart';
import 'package:taskmanager/data/utils/urls.dart';
import 'package:taskmanager/ui/screens/auth/loginScreen.dart';
import 'package:taskmanager/ui/widgets/screenBackground.dart';

class SetPasswordScreen extends StatefulWidget {
  final String email, otp;
  const SetPasswordScreen({super.key, required this.email, required this.otp});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _setPasswordInProgress = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> resetPassword() async {
    _setPasswordInProgress = true;
    if (mounted) {
      setState(() {});
    }

    final Map<String, dynamic> requestBody = {
      "email": widget.email,
      "OTP": widget.otp,
      "password": _passwordController.text
    };

    final NetworkResponse response =
    await NetworkCaller().postRequest(Urls.resetPassword, requestBody);
    _setPasswordInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password reset successful!')));
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false);
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Reset password has been failed!')));
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Form(
              key: _formKey,
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  Text(
                    "Set Password",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 6,
                  ),

                  Text(
                    "Minimum length password 8 character with letter and number combination",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),

                  TextFormField(
                    controller: _passwordController,

                    obscureText: true,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return '*Enter your password';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    controller: _confirmPasswordController,

                    obscureText: true,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: 'Confirm Password',
                    ),
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return '*Enter your Confirm password';
                      }
                      else if (value! != _passwordController.text) {
                        return 'Confirm password does n\'t match';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(
                    height: 12,
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: Visibility(
                      visible: _setPasswordInProgress == false,
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          resetPassword();
                        },
                        child: const Text("Confirm", style: TextStyle(fontSize: 16),),
                      ),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Have account?",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      TextButton(onPressed: () {
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> const LoginScreen()), (route) => false);
                      }, child: const Text("Sign In"))
                    ],
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
