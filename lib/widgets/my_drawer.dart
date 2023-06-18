import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_posting/theme/colors.dart';
import 'package:social_posting/widgets/drawer_list.dart';

// ignore: must_be_immutable
class MyDrawer extends StatelessWidget {
  MyDrawer({super.key, required this.onProfileTap, required this.onSignOut});
  void Function()? onSignOut;
  void Function()? onProfileTap;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: text2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //header
          Column(
            children: [
              const DrawerHeader(
                  child: Icon(
                CupertinoIcons.person,
                color: backgroundColor1,
                size: 65,
              )),
              DrawerList(
                icon: CupertinoIcons.home,
                text: 'H O M E',
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              //profile list tile
              DrawerList(
                icon: CupertinoIcons.person_alt,
                text: 'P R O F I L E',
                onTap: onProfileTap,
              ),
            ],
          ),
          //home list tile

          //logout
          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: DrawerList(
              icon: Icons.logout_outlined,
              text: 'LOGOUT',
              onTap: onSignOut,
            ),
          ),
        ],
      ),
    );
  }
}
