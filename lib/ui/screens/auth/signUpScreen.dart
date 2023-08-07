import 'package:flutter/material.dart';
import 'package:taskmanager/data/model/networkResponse.dart';
import 'package:taskmanager/data/services/networkCaller.dart';
import 'package:taskmanager/data/utils/urls.dart';
import 'package:taskmanager/ui/widgets/screenBackground.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool _signupInProgress = false;

  void userSignup()async{
    _signupInProgress = true;
    if(mounted){
      setState(() {});
    }
    final NetworkResponse response = await NetworkCaller().postRequest(Urls.registration, <String, dynamic>{
      "email": _emailController.text.trim(),
      "firstName": _firstNameController.text.trim(),
      "lastName": _lastNameController.text.trim(),
      "mobile": _mobileController.text.trim(),
      "password": _passwordController.text,
      "photo":""
    });
    _signupInProgress = false;
    if(mounted){
      setState(() {});
    }

    if(response.isSuccess){
      _emailController.clear();
      _passwordController.clear();
      _firstNameController.clear();
      _lastNameController.clear();
      _mobileController.clear();
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Registration Success!")));
      }

    }
    else{
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Registration Failed!")));
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
                      "Join With Us",
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
                      controller: _firstNameController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        hintText: "First Name",
                      ),
                      validator: (String? value){
                        if(value?.isEmpty?? true){
                          return "*Enter your first name";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      controller: _lastNameController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        hintText: "Last Name",
                      ),
                      validator: (String? value){
                        if(value?.isEmpty?? true){
                          return "*Enter your last name";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      controller: _mobileController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        hintText: "Mobile Number",
                      ),
                      validator: (String? value){
                        if((value?.isEmpty?? true) || value!.length < 11){
                          return "*Enter your valid mobile number";
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
                          return "*Enter a password more than 6 characters";
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
                        visible: _signupInProgress == false,
                        replacement: const Center(child:  CircularProgressIndicator()),
                        child: ElevatedButton(
                            onPressed: () {
                              if(!_formkey.currentState!.validate()){
                                return;
                              }
                              userSignup();
                            },
                            child: const Text("Sign Up", style: TextStyle(fontSize: 16),)),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Have an Account?",
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
          )),
    );
  }
}


