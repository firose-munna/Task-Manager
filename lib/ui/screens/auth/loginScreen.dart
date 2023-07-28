import 'package:flutter/material.dart';
import 'package:taskmanager/data/model/authUtilty.dart';
import 'package:taskmanager/data/model/loginModel.dart';
import 'package:taskmanager/data/model/networkResponse.dart';
import 'package:taskmanager/data/services/networkCaller.dart';
import 'package:taskmanager/data/utils/urls.dart';
import 'package:taskmanager/ui/screens/addNewTaskScreen.dart';
import 'package:taskmanager/ui/screens/auth/emailVerificationScreen.dart';
import 'package:taskmanager/ui/screens/auth/signUpScreen.dart';
import 'package:taskmanager/ui/screens/bottomNavBaseScreen.dart';
import 'package:taskmanager/ui/screens/updateProfileScreen.dart';
import 'package:taskmanager/ui/widgets/screenBackground.dart';




class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _loginInProgress = false;

  Future<void> login() async {
    _loginInProgress = true;
    if (mounted) {
      setState(() {});
    }
    Map<String, dynamic> requestBody = {
      "email": _emailController.text.trim(),
      "password": _passwordController.text
    };
    final NetworkResponse response =
    await NetworkCaller().postRequest(Urls.login, requestBody);
    _loginInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      LoginModel model = LoginModel.fromJson(response.body!);
      await AuthUtility.saveUserInfo(model);
      if (mounted) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => const BottomNavBaseScreen()),
                (route) => false);
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Incorrect email or password')));
      }
    }
  }




  @override
  Widget build(BuildContext context) {
    bool showPassword = true;

    return Scaffold(
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
                      "Get Started With",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 12,
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
                    TextFormField(
                      controller: _passwordController,
                      obscureText: showPassword,
                      decoration: const InputDecoration(
                        hintText: "Password",

                      ),
                      validator: (String? value){
                        if((value?.isEmpty?? true) || value!.length <= 5){
                          return "*Enter valid password";
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
                        visible: _loginInProgress == false,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),

                        child: ElevatedButton(
                            onPressed: () {
                              if(!_formkey.currentState!.validate()){
                                return;
                              }
                              login();
                            },
                            child: const Text("Login", style: TextStyle(fontSize: 16),)),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Center(
                        child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const EmailVerificationScreen()));
                            },
                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(color: Colors.grey),
                            ))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an Account?",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        TextButton(onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const SignUpScreen()));

                        }, child: const Text("Sign Up"))
                      ],
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}


