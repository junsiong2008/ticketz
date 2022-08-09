import 'package:flutter/material.dart';
import 'package:ticketz/shared/constants.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    required this.title,
    required this.actions,
    this.backButton = false,
  }) : super(key: key);

  final String title;
  final List<IconButton> actions;
  final bool backButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).orientation == Orientation.portrait
          ? MediaQuery.of(context).size.height * 0.12
          : MediaQuery.of(context).size.height * 0.2,
      color: kSecondaryColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              backButton
                  ? Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.arrow_back),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                        const SizedBox(
                          width: 16.0,
                        ),
                        Text(
                          title,
                          style: kAppBarTitleTextStyle,
                        ),
                      ],
                    )
                  : Text(
                      title,
                      style: kAppBarTitleTextStyle,
                    ),
              Row(
                children: actions,
              )
            ],
          ),
        ),
      ),
    );
  }
}
