import 'package:flutter/material.dart';
import 'package:ticketz/components/halal_radio_group.dart';
import 'package:ticketz/components/student_status_group.dart';

class RegistrationFormProvider extends ChangeNotifier {
  String? englishName;
  String? chineseName;
  String? icNumber;
  String? phoneNumber;
  String? emailAddress;
  String? allergic;
  String? secondarySchool = 'SMJK Chan Wa';
  String? classroom = '1A';
  String? unit = 'Bulan Sabit Merah Malaysia';
  String? otherSecondarySchool;
  String? otherUnit;

  HalalOption? halalOption = HalalOption.halal;
  VegetarianOption? vegetarianOption = VegetarianOption.vegetarian;
  StudentStatus? studentStatus = StudentStatus.student;

  void updateEnglishName(String? englishName) {
    this.englishName = englishName;
    notifyListeners();
  }

  void updateChineseName(String? chineseName) {
    this.chineseName = chineseName;
    notifyListeners();
  }

  void updateIcNumber(String? icNumber) {
    this.icNumber = icNumber;
    notifyListeners();
  }

  void updatePhoneNumber(String? phoneNumber) {
    this.phoneNumber = phoneNumber;
    notifyListeners();
  }

  void updateEmailAddress(String? emailAddress) {
    this.emailAddress = emailAddress;
    notifyListeners();
  }

  void updateAllergic(String? allergic) {
    this.allergic = allergic;
    notifyListeners();
  }

  void updateSecondarySchool(String? secondarySchool) {
    this.secondarySchool = secondarySchool;
    notifyListeners();
  }

  void updateClassroom(String? classroom) {
    this.classroom = classroom;
    notifyListeners();
  }

  void updateUnit(String? unit) {
    this.unit = unit;
    notifyListeners();
  }

  void updateOtherSecondarySchool(String? secondarySchool) {
    otherSecondarySchool = secondarySchool;
    notifyListeners();
  }

  void updateOtherUnit(String? unit) {
    otherUnit = unit;
    notifyListeners();
  }

  void updateHalalOption(HalalOption? halalOption) {
    this.halalOption = halalOption;
    notifyListeners();
  }

  void updateVegetatianOption(VegetarianOption? vegetarianOption) {
    this.vegetarianOption = vegetarianOption;
    notifyListeners();
  }

  void updateStudentStatus(StudentStatus? studentStatus) {
    this.studentStatus = studentStatus;
    notifyListeners();
  }

  void resetForm() {
    englishName = null;
    chineseName = null;
    icNumber = null;
    phoneNumber = null;
    emailAddress = null;
    allergic = null;
    secondarySchool = 'SMJK Chan Wa';
    classroom = '1A';
    unit = 'Bulan Sabit Merah Malaysia';
    otherSecondarySchool = null;
    otherUnit = null;
    halalOption = HalalOption.halal;
    vegetarianOption = VegetarianOption.vegetarian;
    studentStatus = StudentStatus.student;
    notifyListeners();
  }
}
