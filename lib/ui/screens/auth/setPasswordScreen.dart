import 'package:flutter/material.dart';
import 'package:taskmanager/ui/screens/auth/loginScreen.dart';
import 'package:taskmanager/ui/widgets/screenBackground.dart';

class SetPasswordScreen extends StatelessWidget {
  const SetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
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
                const TextField(
                  keyboardType: TextInputType.emailAddress,
                  obscureText: true,

                  decoration: InputDecoration(
                    hintText: "Password",
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                const TextField(
                  keyboardType: TextInputType.emailAddress,
                  obscureText: true,

                  decoration: InputDecoration(
                    hintText: "Confirm Password",
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> const LoginScreen()), (route) => false);
                      },
                      child: const Text("Confirm", style: TextStyle(fontSize: 16),)),
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
    );
  }
}
