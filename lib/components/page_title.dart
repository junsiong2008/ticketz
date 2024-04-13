import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  final String pageTitle;
  final List<Widget> actions;

  const PageTitle({
    super.key,
    required this.pageTitle,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 20.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            pageTitle,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: actions,
          )
        ],
      ),
    );
  }
}
