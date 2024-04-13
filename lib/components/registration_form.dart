import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticketz/components/formatter/ic_formatter.dart';
import 'package:ticketz/components/halal_radio_group.dart';
import 'package:ticketz/components/registration_form_field.dart';
import 'package:ticketz/components/student_status_group.dart';
import 'package:ticketz/models/participant.dart';
import 'package:ticketz/providers/registration_form_provider.dart';
import 'package:ticketz/providers/registration_state_provider.dart';
import 'package:ticketz/shared/constants.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  List<GlobalKey<FormState>> formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  int _index = 0;

  TextEditingController englishNameController = TextEditingController();
  TextEditingController chineseNameController = TextEditingController();
  TextEditingController icNumberController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController allergyController = TextEditingController();
  TextEditingController otherSecondarySchoolController =
      TextEditingController();
  TextEditingController otherUnitController = TextEditingController();

  Future<void> submitForm(
    RegistrationFormProvider registrationFormProvider,
    RegistrationStateProvider registrationStateProvider,
  ) async {
    bool validated = true;

    for (int i = 0; i < formKeys.length; i++) {
      if (!formKeys[i].currentState!.validate()) {
        validated = false;
        setState(() {
          _index = i;
        });
        break;
      }
    }

    if (validated) {
      Participant participant = Participant(
          englishName: registrationFormProvider.englishName!,
          chineseName: registrationFormProvider.chineseName,
          icNumber: registrationFormProvider.icNumber!,
          phoneNumber: registrationFormProvider.phoneNumber!,
          emailAddress: registrationFormProvider.emailAddress!,
          isHalal: registrationFormProvider.halalOption == HalalOption.halal
              ? true
              : false,
          isVegetarian: registrationFormProvider.vegetarianOption ==
                  VegetarianOption.vegetarian
              ? true
              : false,
          allergic: registrationFormProvider.allergic,
          studentStatus:
              registrationFormProvider.studentStatus == StudentStatus.student
                  ? 'Student'
                  : 'Ex-Student',
          secondarySchool: registrationFormProvider.secondarySchool != 'Other'
              ? registrationFormProvider.secondarySchool
              : registrationFormProvider.otherSecondarySchool,
          unit: registrationFormProvider.unit != 'Other'
              ? registrationFormProvider.unit
              : registrationFormProvider.otherUnit,
          datetimeCreated: DateTime.now());

      await registrationStateProvider.registerUser(participant);
    }
  }

  @override
  void dispose() {
    englishNameController.dispose();
    chineseNameController.dispose();
    icNumberController.dispose();
    phoneNumberController.dispose();
    emailAddressController.dispose();
    allergyController.dispose();
    otherSecondarySchoolController.dispose();
    otherUnitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final RegistrationFormProvider registrationFormProvider =
        Provider.of<RegistrationFormProvider>(context);

    final List<Step> steps = <Step>[
      Step(
        title: const Text(
          'Personal Info',
        ),
        content: Form(
          key: formKeys[0],
          child: Column(
            children: <Widget>[
              RegistrationFormField(
                label: 'Name (English)',
                textEditingController: englishNameController,
                onChanged: registrationFormProvider.updateEnglishName,
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Please enter your English name';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 8.0,
              ),
              RegistrationFormField(
                label: 'Name (Chinese) - Optional',
                textEditingController: chineseNameController,
                onChanged: registrationFormProvider.updateChineseName,
                validator: (value) {
                  if (value != null) {
                    RegExp regex = RegExp(
                        "[^\u4E00-\u9FFF\u3400-\u4DFF\uF900-\uFAFF]+",
                        unicode: true);

                    if (regex.hasMatch(value)) {
                      return 'Please enter Chinese character only';
                    }
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 8.0,
              ),
              RegistrationFormField(
                keyboardType: TextInputType.number,
                label: 'IC Number',
                textEditingController: icNumberController,
                onChanged: registrationFormProvider.updateIcNumber,
                validator: (value) {
                  RegExp regex = RegExp("^\\d{6}-\\d{2}\\-\\d{4}\$");
                  if (value == null ||
                      value.isEmpty ||
                      !regex.hasMatch(value)) {
                    return 'Please enter a valid IC: XXXXXX-XX-XXXX';
                  }
                  return null;
                },
                inputFormatters: [
                  ICFormatter(
                    sample: 'xxxxxx-xx-xxxx',
                    separator: '-',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      Step(
        title: const Text('Contact Info'),
        content: Form(
          key: formKeys[1],
          child: Column(
            children: <Widget>[
              RegistrationFormField(
                keyboardType: TextInputType.phone,
                label: 'Phone Number',
                textEditingController: phoneNumberController,
                onChanged: registrationFormProvider.updatePhoneNumber,
                validator: (value) {
                  RegExp regex = RegExp("^(\\+?6?01)[0-46-9]-*[0-9]{7,8}\$");
                  if (value == null ||
                      value.isEmpty ||
                      !regex.hasMatch(value)) {
                    return 'Please enter a valid Malaysian phone number: +60123456789';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 8.0,
              ),
              RegistrationFormField(
                keyboardType: TextInputType.emailAddress,
                label: 'Email Address',
                textEditingController: emailAddressController,
                onChanged: registrationFormProvider.updateEmailAddress,
                validator: (value) {
                  RegExp regex = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                  if (value == null ||
                      value.isEmpty ||
                      !regex.hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      Step(
        title: const Text('Dietary Restrictions'),
        content: Form(
          key: formKeys[2],
          child: Column(
            children: <Widget>[
              const HalalRadioGroup(),
              const SizedBox(
                height: 8.0,
              ),
              const VegetarianRadioGroup(),
              const SizedBox(
                height: 8.0,
              ),
              RegistrationFormField(
                label: 'Please specify if you\'re allergic to any food: ',
                textEditingController: allergyController,
                onChanged: registrationFormProvider.updateAllergic,
              ),
            ],
          ),
        ),
      ),
      Step(
        title: const Text('Student Status'),
        content: Form(
          key: formKeys[3],
          child: Column(
            children: <Widget>[
              StudentStatusGroup(
                otherSecondarySchoolController: otherSecondarySchoolController,
                otherUnitController: otherUnitController,
              ),
            ],
          ),
        ),
      ),
    ];

    return Stepper(
      controlsBuilder: ((context, details) {
        return _index == 0
            ? Padding(
                padding: const EdgeInsets.only(
                  top: 16.0,
                ),
                child: Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: details.onStepContinue,
                      child: const Text('Continue'),
                    ),
                  ],
                ),
              )
            : _index == 3
                ? Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kPrimaryColor,
                                foregroundColor: Colors.white,
                              ),
                              onPressed: () async {
                                // Experimental Code
                                var registrationStateProvider =
                                    Provider.of<RegistrationStateProvider>(
                                  context,
                                  listen: false,
                                );
                                await submitForm(
                                  registrationFormProvider,
                                  registrationStateProvider,
                                );
                              },
                              child: const Text('Submit'),
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            TextButton(
                              onPressed: details.onStepCancel,
                              child: const Text("Back"),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: details.onStepContinue,
                          child: const Text('Continue'),
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        TextButton(
                          onPressed: details.onStepCancel,
                          child: const Text('Back'),
                        ),
                      ],
                    ),
                  );
      }),
      currentStep: _index,
      onStepCancel: () {
        if (_index > 0) {
          setState(() {
            _index -= 1;
          });
        }
      },
      onStepContinue: () {
        setState(() {
          if (formKeys[_index].currentState!.validate()) {
            if (_index <= (steps.length - 1)) {
              _index += 1;
            }
          }
        });
      },
      onStepTapped: (int index) {
        setState(() {
          _index = index;
        });
      },
      steps: steps,
    );
  }
}
