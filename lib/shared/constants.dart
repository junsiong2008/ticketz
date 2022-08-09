import 'package:flutter/material.dart';

const Color kPrimaryColor = Color(0XFF315FBA);
const Color kSecondaryColor = Color(0xFFEAF0FF);
const Color kFormFieldColor = Color(0xFFE8E8E8);
const Color kLightGreyColor = Color(0XFFFCFCFC);
const Color kBackgroundGrey = Color(0XFFEAEAEA);

const TextStyle kChartNumberTextStyle = TextStyle(
  height: 0.5,
  fontWeight: FontWeight.bold,
  fontFamily: 'Poppins',
  fontSize: 48.0,
);

const TextStyle kFormFieldLabelTextStyle = TextStyle(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w500,
  fontSize: 16,
);

const TextStyle kReadOnlyLabelTextStyle = TextStyle(
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w500,
  fontSize: 14,
);

const TextStyle kErrorTextStyle = TextStyle(
  color: Colors.red,
  fontSize: 14,
);

const BoxDecoration kPrimaryButtonBoxDecoration = BoxDecoration(
  color: kPrimaryColor,
  borderRadius: BorderRadius.all(Radius.circular(4.0)),
);

const TextStyle kPrimaryButtonTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 16,
  fontWeight: FontWeight.w500,
);

const TextStyle kAppBarTitleTextStyle = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.w500,
);

const TextStyle kNameTextStyle = TextStyle(
  fontSize: 20.0,
);

const ShapeBorder kPrimaryButtonBorder = RoundedRectangleBorder(
  borderRadius: BorderRadius.all(
    Radius.circular(4.0),
  ),
);
