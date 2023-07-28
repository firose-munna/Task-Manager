import 'package:flutter/material.dart';
import 'package:taskmanager/ui/screens/auth/pinVerificationScreen.dart';
import 'package:taskmanager/ui/widgets/screenBackground.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key});

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
                  "Your Email Address",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 6,
                ),

                Text(
                  "A 6 digit verification PIN will send to your email address",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                const TextField(
                  keyboardType: TextInputType.emailAddress,

                  decoration: InputDecoration(
                    hintText: "Email",
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>PinVerificationScreen()));
                      },
                      child: const Text("Send", style: TextStyle(fontSize: 16),)),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Have account?",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    TextButton(onPressed: () {
                      Navigator.pop(context);
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
