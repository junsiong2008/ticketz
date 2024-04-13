import 'package:flutter/material.dart';

const Color kPrimaryColor = Color(0XFF315FBA);
const Color kSecondaryColor = Color(0xFFEAF0FF);
const Color kTertiaryColor = Color(0XFF63ADF2);
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
  fontSize: 14,
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

const TextStyle kRegistrationStatusTextStyle = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 24,
  color: kPrimaryColor,
);

const ShapeBorder kPrimaryButtonBorder = RoundedRectangleBorder(
  borderRadius: BorderRadius.all(
    Radius.circular(4.0),
  ),
);

const TextStyle kModalSheetTitleTextStyle = TextStyle(
  color: kPrimaryColor,
  fontSize: 20,
  fontWeight: FontWeight.w600,
);

const List<String> kSchoolList = [
  'SMK Bukit Mewah',
  'SMK Samtet, Ipoh',
  'SMK Mantin',
  'SMK Seri Keledang, Perak',
  'SMK Aminuddin Baki Chemor, Perak',
  'SMK Puteri',
  'SMK Tunku Ampuan Najihah',
  'SMK Tunku Durah',
  'SMJK Chan Wa',
  'SMJK Chan Wa (II)',
  'SMK KGV',
  'SMK DMS, Nilai',
  'SMK Gajah Berang, Melaka',
  'SMK Ketholik, Melaka',
  'SMK St. Paul',
  'SMK ACS',
  'SMK Chung Hua, Seremban',
  'SMK Chung Hua, KL',
  'SMJK Yu Hua, Kajang',
  'Other',
];

const List<String> kChanWaUnit = [
  'Bulan Sabit Merah Malaysia',
  'Gendang 24',
  'Goshin-Ryu Karate',
  'Kadet Angkatan Sekolah Pertahanan Awam',
  'Kadet Pengangkutan Jalan',
  'Kadet Polis',
  'Kadet Remaja Sekolah',
  'Kadet Tentera Barat-PKBM',
  'Pancaragam',
  'Pandu Puteri',
  'Pengakap',
  'Taekwando',
  'Wushu',
  'Persatuan Agama Buddha',
  'Persatuan Bahasa Cina',
  'Persatuan Bahasa Inggeris',
  'Persatuan Bahasa Malaysia',
  'Persatuan Kemahiran Hidup / ERT / Rekacipta',
  'Persatuan Pendidikan Seni Visual',
  'Persatuan Rukun Negara / Geografi dan Sejarah',
  'Persatuan Sains, Matematik dan Astronomi',
  'Kelab Drama',
  'Kelab Fotografi / Video',
  'Kelab Harmonika',
  'Kelab Interact',
  'Kelab Kerjaya',
  'Kelab Kesenian dan Kebudayaan (Tarian Naga / Singa)',
  'Kelab Koir',
  'Kelab Komputer',
  'Kelab Koperasi',
  'Kelab Pencipta Alam',
  'Kelab Robotik',
  'Kelab Setem / Filateli',
  'Kelab SPBT - Skim Pinjaman Buku Teks',
  'Kelab Tarian',
  'Other',
];

const List<String> kChanWaExUnit = [
  'Bulan Sabit Merah Malaysia',
  'Gendang 24',
  'Goshin-Ryu Karate',
  'Kadet Angkatan Sekolah Pertahanan Awam',
  'Kadet Pengangkutan Jalan',
  'Kadet Polis',
  'Kadet Remaja Sekolah',
  'Kadet Tentera Barat-PKBM',
  'Pancaragam',
  'Pandu Puteri',
  'Pengakap',
  'Taekwando',
  'Wushu',
  'Other',
];
