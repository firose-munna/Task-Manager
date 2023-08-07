import 'package:flutter/material.dart';
import 'package:taskmanager/data/model/authUtilty.dart';
import 'package:taskmanager/data/model/loginModel.dart';
import 'package:taskmanager/data/model/networkResponse.dart';
import 'package:taskmanager/data/services/networkCaller.dart';
import 'package:taskmanager/data/utils/urls.dart';
import 'package:taskmanager/ui/widgets/screenBackground.dart';

import 'package:taskmanager/ui/widgets/userProfileBanner.dart';
//import 'package:image_picker/image_picker.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  // XFile? imageFile;
  // ImagePicker picker = ImagePicker();
  bool _profileInProgress = false;

  final TextEditingController _imageNameController = TextEditingController();
  Data userData = AuthUtility.userInfo.data!;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController.text = userData.email ?? '';
    _firstNameController.text = userData.firstName ?? '';
    _lastNameController.text = userData.lastName ?? '';
    _mobileController.text = userData.mobile ?? '';
  }

  Future<void> updateProfile() async {
    _profileInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final Map<String, dynamic> requestBody = {
      "firstName": _firstNameController.text.trim(),
      "lastName": _lastNameController.text.trim(),
      "mobile": _mobileController.text.trim(),
      "photo": ""
    };
    if (_passwordController.text.isNotEmpty) {
      requestBody['password'] = _passwordController.text;
    }

    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.updateProfile, requestBody);
    _profileInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      userData.firstName = _firstNameController.text.trim();
      userData.lastName = _lastNameController.text.trim();
      userData.mobile = _mobileController.text.trim();
      AuthUtility.updateUserInfo(userData);
      _passwordController.clear();
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Profile updated!')));
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile update failed! Try again.')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ScreenBackground(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Material(
                      child: UserProfileBanner(
                    isUpdateScreen: true,
                  )),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 70,
                        ),
                        Text(
                          "Update Profile",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(color: Colors.white),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  //pickImageFromGallery();
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(14),
                                  color: Colors.teal,
                                  child: const Text(
                                    'Photos',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: _imageNameController,
                                  readOnly: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          readOnly: true,
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: "Email",
                          ),
                          validator: (String? value) {
                            if (value?.isEmpty ?? true) {
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
                          validator: (String? value) {
                            if (value?.isEmpty ?? true) {
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
                          validator: (String? value) {
                            if (value?.isEmpty ?? true) {
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
                          validator: (String? value) {
                            if ((value?.isEmpty ?? true) ||
                                value!.length < 11) {
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
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: "Password",
                          ),
                          validator: (String? value) {
                            if ((value?.isEmpty ?? true) ||
                                value!.length <= 5) {
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
                          child: _profileInProgress
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : ElevatedButton(
                                  onPressed: () {updateProfile();},
                                  child: const Text(
                                    "Update Profile",
                                    style: TextStyle(fontSize: 16),
                                  )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Future<ImageSource?> storageSelection() {
  //   return showDialog<ImageSource>(
  //     context: context,
  //     builder: (cntxt) {
  //       return AlertDialog(
  //           content: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: <Widget>[
  //           ListTile(
  //             onTap: () {
  //               if (mounted) {
  //                 Navigator.pop(context, ImageSource.camera);
  //               }
  //             },
  //             leading: const Icon(Icons.camera_alt_rounded),
  //             title: const Text('Camera'),
  //           ),
  //           // ListTile(
  //           //   onTap: () {
  //           //     if (mounted) {
  //           //       Navigator.pop(context, ImageSource.gallery);
  //           //     }
  //           //   },
  //           //   leading: const Icon(Icons.camera),
  //           //   title: const Text('Gallery'),
  //           // ),
  //         ],
  //       ));
  //     },
  //   );
  // }
  //
  // Future<void> pickImageFromGallery() async {
  //   ImageSource? imageSource = await storageSelection();
  //   if (imageSource == null) {
  //     return;
  //   }
  //   picker.pickImage(source: ImageSource.camera).then(
  //     (xFile) {
  //       if (xFile != null) {
  //         _imageNameController.text = xFile.name;
  //         if (mounted) {
  //           setState(() {});
  //         }
  //       }
  //     },
  //   );
  // }
}
