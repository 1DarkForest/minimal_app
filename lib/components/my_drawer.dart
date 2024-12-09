import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/auth/auth_service.dart';
import '../pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 25),
                decoration:  BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    top: BorderSide.none,
                    left: BorderSide.none,
                    right: BorderSide.none,
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.forum_rounded,
                    color: Theme.of(context).colorScheme.primary,
                    size: 40,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: Text(
                    "H O M E",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  leading: Icon(
                    Icons.home,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: Text(
                    "S E T T I N G S",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  leading: Icon(
                    Icons.settings,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onTap: () {
                    Navigator.pop(context);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SettingsPage()));
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 25.0),
            child: ListTile(
              title: Text(
                "L O G O U T",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              leading: Icon(Icons.logout,
                  color: Theme.of(context).colorScheme.primary),
              onTap: logout,
            ),
          ),
        ],
      ),
    );
  }

  void logout() {
    final authService = AuthService();
    authService.signOut();
  }
}
