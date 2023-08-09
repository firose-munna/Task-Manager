import 'package:flutter/material.dart';
import 'package:taskmanager/data/model/networ_response.dart';
import 'package:taskmanager/data/services/networkCaller.dart';
import 'package:taskmanager/data/utils/urls.dart';
import 'package:taskmanager/ui/screens/auth/pinVerificationScreen.dart';
import 'package:taskmanager/ui/widgets/screenBackground.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController _emailController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool _emailSendInProgress = false;


  Future<void> sendOTPToEmail() async {
    _emailSendInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response = await NetworkCaller()
        .getRequest(Urls.sendOtpToEmail(_emailController.text.trim()));
    _emailSendInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      if (mounted) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PinVerificationScreen(
                  email: _emailController.text.trim(),
                )));
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Email verification has been failed!')));
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ScreenBackground(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: _formkey,
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
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: "Email",
                      ),
                      validator: (String? value){
                        if(value?.isEmpty?? true){
                          return "*Enter your email";
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
                        visible: _emailSendInProgress == false,
                        replacement: const Center(child:  CircularProgressIndicator()),
                        child: ElevatedButton(
                            onPressed: () {
                              if(!_formkey.currentState!.validate()){
                                return;
                              }
                              //userSignup();
                              sendOTPToEmail();

                              //Navigator.push(context, MaterialPageRoute(builder: (context)=>PinVerificationScreen()));
                            },
                            child: const Text("Send", style: TextStyle(fontSize: 16),)),
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
                          Navigator.pop(context);
                        }, child: const Text("Sign In"))
                      ],
                    )

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
