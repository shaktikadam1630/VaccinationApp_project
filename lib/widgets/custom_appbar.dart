import 'package:flutter/material.dart';
import 'package:vaccination/screen/login/welcome_page.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.purple,
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 40, left: 15, right: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WelcomeScreen(), // Navigate to WelcomeScreen
                  ),
                );
              },
              child: Icon(
                Icons.sort,
                color: Colors.white,
                size: 40,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WelcomeScreen(), // Navigate to WelcomeScreen
                  ),
                );
              },
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}