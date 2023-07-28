import 'package:flutter/material.dart';
import 'package:taskmanager/data/model/authUtilty.dart';
import 'package:taskmanager/ui/screens/auth/loginScreen.dart';
import 'package:taskmanager/ui/screens/updateProfileScreen.dart';

class UserProfileBanner extends StatefulWidget {
  const UserProfileBanner({
    super.key,
  });

  @override
  State<UserProfileBanner> createState() => _UserProfileBannerState();
}

class _UserProfileBannerState extends State<UserProfileBanner> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateProfileScreen()));
      },
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        tileColor: Colors.teal,
        leading: CircleAvatar(
          backgroundImage: NetworkImage(
            AuthUtility.userInfo.data?.photo ?? '',
          ),
          onBackgroundImageError: (_, __) {
            const Icon(Icons.image);
          },
          radius: 20,
        ),
        title: Text(
          '${AuthUtility.userInfo.data?.firstName ?? ''} ${AuthUtility.userInfo.data?.lastName ?? ''}',
          style: const TextStyle(fontSize: 15, color: Colors.white),
        ),
        subtitle: Text(
          AuthUtility.userInfo.data?.email ?? 'Unknown',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
        trailing: IconButton(
          onPressed: () async {
            await AuthUtility.clearUserInfo();
            if (mounted) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()), (
                  route) => false);
            }
          },
          icon: const Icon(Icons.logout, color: Colors.white,),
        ),
      ),
    );
  }
}