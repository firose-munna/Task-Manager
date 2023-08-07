import 'package:flutter/material.dart';
import 'package:taskmanager/data/model/authUtilty.dart';
import 'package:taskmanager/ui/screens/auth/loginScreen.dart';
import 'package:taskmanager/ui/screens/updateProfileScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UserProfileBanner extends StatefulWidget {
  final bool? isUpdateScreen;
  const UserProfileBanner({
    super.key, this.isUpdateScreen,
  });

  @override
  State<UserProfileBanner> createState() => _UserProfileBannerState();
}

class _UserProfileBannerState extends State<UserProfileBanner> {

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,

      backgroundColor: Colors.teal,
      title: GestureDetector(
        onTap: () {
          if ((widget.isUpdateScreen ?? false) == false) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const UpdateProfileScreen()));
          }
        },
        child: Row(
          children: [
            Visibility(
              visible: (widget.isUpdateScreen ?? false) == false,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    child: CachedNetworkImage(
                      placeholder: (_, __) => const Icon(Icons.account_circle),
                      imageUrl: AuthUtility.userInfo.data?.photo ?? '',
                      errorWidget: (_, __, ___) => const Icon(Icons.account_circle),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${AuthUtility.userInfo.data?.firstName ?? ''} ${AuthUtility.userInfo.data?.lastName ?? ''}',
                  style: const TextStyle(fontSize: 15, color: Colors.white),
                ),
                Text(
                  AuthUtility.userInfo.data?.email ?? 'Unknown',
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
            if (mounted) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                      (route) => false);
            }
          },
          icon: const Icon(Icons.logout),
        ),
      ],
    );
  }



  // @override
  // Widget build(BuildContext context) {
  //   return GestureDetector(
  //     onTap: (){
  //       if((widget.isUpdateScreen ?? false) == false){
  //         Navigator.push(context, MaterialPageRoute(builder: (context)=> const UpdateProfileScreen()));
  //       }
  //
  //     },
  //     child: ListTile(
  //       contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
  //       tileColor: Colors.teal,
  //       leading: CircleAvatar(
  //         backgroundImage: NetworkImage(
  //           AuthUtility.userInfo.data?.photo ?? '',
  //         ),
  //         onBackgroundImageError: (_, __) {
  //           const Icon(Icons.image);
  //         },
  //         radius: 20,
  //       ),
  //       title: Text(
  //         '${AuthUtility.userInfo.data?.firstName ?? ''} ${AuthUtility.userInfo.data?.lastName ?? ''}',
  //         style: const TextStyle(fontSize: 15, color: Colors.white),
  //       ),
  //       subtitle: Text(
  //         AuthUtility.userInfo.data?.email ?? 'Unknown',
  //         style: const TextStyle(
  //           color: Colors.white,
  //           fontSize: 12,
  //         ),
  //       ),
  //       trailing: IconButton(
  //         onPressed: () async {
  //           await AuthUtility.clearUserInfo();
  //           if (mounted) {
  //             Navigator.pushAndRemoveUntil(
  //                 context,
  //                 MaterialPageRoute(builder: (context) => const LoginScreen()), (
  //                 route) => false);
  //           }
  //         },
  //         icon: const Icon(Icons.logout, color: Colors.white,),
  //       ),
  //     ),
  //   );
  // }
}