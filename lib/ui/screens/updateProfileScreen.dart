import 'package:flutter/material.dart';
import 'package:taskmanager/ui/widgets/screenBackground.dart';

import 'package:taskmanager/ui/widgets/userProfileBanner.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: ScreenBackground(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Material(child: UserProfileBanner()),
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

                      TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.teal,
                              foregroundColor: Colors.white,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5.0),
                                  bottomLeft: Radius.circular(5.0),
                                ),
                              ),
                            ),
                            onPressed: () async {
                              await pickImageFromGallery();
                            },
                            child: const Text('Photos'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),


                      TextField(

                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: "Email",
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextField(
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: "First Name",
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextField(
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: "Last Name",
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: "Mobile Number",
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextField(
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: "Password",
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {

                            },
                            child: const Text("Update Profile", style: TextStyle(fontSize: 16),)),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }

  Future<ImageSource?> storageSelection() {
    return showDialog<ImageSource>(
      context: context,
      builder: (cntxt) {
        return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  onTap: () {
                    if (mounted) {
                      Navigator.pop(context, ImageSource.camera);
                    }
                  },
                  leading: const Icon(Icons.camera_alt_rounded),
                  title: const Text('Camera'),
                ),
                ListTile(
                  onTap: () {
                    if (mounted) {
                      Navigator.pop(context, ImageSource.gallery);
                    }
                  },
                  leading: const Icon(Icons.camera),
                  title: const Text('Gallery'),
                ),
              ],
            ));
      },
    );
  }

  Future<void> pickImageFromGallery() async {
    try {
      ImageSource? imageSource = await storageSelection();
      if (imageSource == null) {
        return;
      }
      final XFile? image = await ImagePicker().pickImage(source: imageSource);
      print(image?.path);
    } catch (e) {
      print(e.toString());
    }
  }
}
