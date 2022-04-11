import 'package:flutter/material.dart';

class TitleSection extends StatelessWidget {
  final String title;
  final IconData? icon;
  final Function? onIconPressed;

  const TitleSection({required this.title, this.icon, this.onIconPressed});

  void onPressed() {
    onIconPressed?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(title, style: Theme.of(context).textTheme.headline2),
        if (icon != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0), //or 15.0
            child: Container(
              height: 50.0,
              width: 50.0,
              color: Colors.orange,
              child: IconButton(
                onPressed: onPressed,
                icon: Icon(icon),
              ),
            ),
          ),
      ]),
    );
  }
}