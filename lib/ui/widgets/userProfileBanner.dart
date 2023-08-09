import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:taskmanager/data/model/authUtilty.dart';
import 'package:taskmanager/ui/screens/auth/login_screen.dart';
import 'package:taskmanager/ui/screens/updateProfileScreen.dart';

class UserProfileBanner extends StatelessWidget {
  final bool? isInProfileUpdateScreen;
  const UserProfileBanner({
    super.key,
    this.isInProfileUpdateScreen,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      backgroundColor: Colors.teal,
      title: GestureDetector(
        onTap: isInProfileUpdateScreen == true
            ? null
            : () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const UpdateProfileScreen(),
            ),
          );
        },
        child: Row(
          children: [
            Visibility(
              visible: isInProfileUpdateScreen == null,
              child: Row(
                children: [
                  Visibility(
                    visible: AuthUtility.userInfo.data!.photo!.isNotEmpty,
                    replacement: const Icon(Icons.account_circle, size: 40),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: MemoryImage(
                        base64Decode(AuthUtility.userInfo.data!.photo!),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${AuthUtility.userInfo.data?.firstName ?? ''} ${AuthUtility.userInfo.data?.lastName ?? ''}",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  AuthUtility.userInfo.data?.email ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () async {
            await AuthUtility.clearUserInfo();
            Future.delayed(Duration.zero).then((value) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const LoginScreen();
                  },
                ),
                    (route) => false,
              );
            });
          },
          icon: const Icon(Icons.logout),
        ),
      ],
    );
  }
}
