import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:taskmanager/data/model/networkResponse.dart';
import 'package:taskmanager/data/services/networkCaller.dart';
import 'package:taskmanager/data/utils/urls.dart';
import 'package:taskmanager/ui/screens/auth/loginScreen.dart';
import 'package:taskmanager/ui/screens/auth/setPasswordScreen.dart';
import 'package:taskmanager/ui/widgets/screenBackground.dart';

class PinVerificationScreen extends StatefulWidget {
  final String email;
  const PinVerificationScreen({super.key, required this.email});

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {

  final TextEditingController _otpController = TextEditingController();
  bool _otpVerificationInProgress = false;

  Future<void> verifyOTP() async {
    _otpVerificationInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response = await NetworkCaller()
        .getRequest(Urls.otpVerify(widget.email, _otpController.text));
    _otpVerificationInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      if (mounted) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SetPasswordScreen(
                  email: widget.email,
                  otp: _otpController.text,
                )));
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Otp verification has been failed!')));
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
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  Text(
                    "PIN Verification",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 6,
                  ),

                  Text(
                    "Enter 6 digit verification PIN here",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  PinCodeTextField(
                    controller: _otpController,
                    length: 6,
                    keyboardType: TextInputType.number,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.teal,
                      inactiveFillColor: Colors.white,
                      inactiveColor: Colors.white,
                      activeColor: Colors.white,
                      selectedFillColor: Colors.white,
                      selectedColor: Colors.teal
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    backgroundColor: Colors.transparent,
                    cursorColor: Colors.teal,

                    enableActiveFill: true,
                    enablePinAutofill: true,

                    onCompleted: (v) {
                    },
                    onChanged: (value) {
                    },
                    beforeTextPaste: (text) {
                      print("Allowing to paste $text");
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      return true;
                    },
                    appContext: context,
                  ),
                  const SizedBox(
                    height: 12,
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: Visibility(
                      visible: _otpVerificationInProgress == false,
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          verifyOTP();
                        },
                        child: const Text("Verify", style: TextStyle(fontSize: 16),)
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
