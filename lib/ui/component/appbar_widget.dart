import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/constants.dart';
import 'package:travel_app/themes.dart';

AppBar buildAppBar(BuildContext context, {bool showExit = false}) {
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;
  final icon = CupertinoIcons.moon_stars;

  return AppBar(
    leading: showExit
        ? IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(AUTH);
            },
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.red[600],
            ),
          )
        : null,
    automaticallyImplyLeading: false,
    // leading: BackButton(),
    backgroundColor: Colors.transparent,
    // isDarkMode ? Colors.transparent:Colors.teal ,
    elevation: 0,
    actions: [
      ThemeSwitcher(
        builder: (context) => IconButton(
          icon: Icon(icon),
          color: isDarkMode ? Colors.white : Colors.black,
          onPressed: () {
            final theme = isDarkMode ? MyThemes.lightTheme : MyThemes.darkTheme;

            final switcher = ThemeSwitcher.of(context)!;
            switcher.changeTheme(theme: theme);
          },
        ),
      ),
    ],
  );
}
