import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticketz/components/registration_form_field.dart';
import 'package:ticketz/providers/registration_form_provider.dart';
import 'package:ticketz/shared/constants.dart';

enum StudentStatus { student, exStudent }

class StudentStatusGroup extends StatefulWidget {
  final TextEditingController otherSecondarySchoolController;
  final TextEditingController otherUnitController;

  const StudentStatusGroup({
    Key? key,
    required this.otherSecondarySchoolController,
    required this.otherUnitController,
  }) : super(key: key);

  @override
  State<StudentStatusGroup> createState() => _StudentStatusGroupState();
}

class _StudentStatusGroupState extends State<StudentStatusGroup> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<RegistrationFormProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          width: double.infinity,
          child: Text(
            'Are you a Student or Ex-Student?',
            style: kFormFieldLabelTextStyle,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Wrap(
          spacing: 16.0,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio<StudentStatus>(
                  value: StudentStatus.student,
                  groupValue: provider.studentStatus,
                  onChanged: (StudentStatus? value) {
                    Provider.of<RegistrationFormProvider>(
                      context,
                      listen: false,
                    ).updateStudentStatus(value);
                  },
                ),
                const SizedBox(
                  width: 8.0,
                ),
                const Text(
                  'Student',
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio<StudentStatus>(
                  value: StudentStatus.exStudent,
                  groupValue: provider.studentStatus,
                  onChanged: (StudentStatus? value) {
                    Provider.of<RegistrationFormProvider>(
                      context,
                      listen: false,
                    ).updateStudentStatus(value);
                  },
                ),
                const SizedBox(
                  width: 8.0,
                ),
                const Text(
                  'Ex-Student',
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 8.0,
        ),
        if (provider.studentStatus == StudentStatus.exStudent)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 8.0,
              ),
              const Text(
                'Previous Uniform Body (Badan Beruniform)',
                style: kFormFieldLabelTextStyle,
              ),
              DropdownButtonFormField(
                isExpanded: true,
                hint: const Text('Choose a Unit'),
                value: provider.unit,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                items:
                    kChanWaExUnit.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: provider.updateUnit,
              ),
            ],
          ),
        if (provider.studentStatus == StudentStatus.exStudent &&
            provider.unit == 'Other')
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: RegistrationFormField(
              label: 'Other (Please specify your previous unit):',
              textEditingController: widget.otherUnitController,
              onChanged: provider.updateOtherUnit,
            ),
          ),
        if (provider.studentStatus == StudentStatus.student)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Secondary School',
                style: kFormFieldLabelTextStyle,
              ),
              DropdownButtonFormField<String>(
                isExpanded: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                hint: const Text('Choose Secondary School'),
                value: provider.secondarySchool,
                items:
                    kSchoolList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: provider.updateSecondarySchool,
              ),
            ],
          ),
        if (provider.secondarySchool == 'Other')
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: RegistrationFormField(
              label: 'Other (Please specify secondary school):',
              textEditingController: widget.otherSecondarySchoolController,
              onChanged: provider.updateOtherSecondarySchool,
            ),
          ),
        if (provider.studentStatus == StudentStatus.student &&
            provider.secondarySchool == 'SMJK Chan Wa')
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 8.0,
              ),
              const Text(
                'Unit',
                style: kFormFieldLabelTextStyle,
              ),
              DropdownButtonFormField(
                isExpanded: true,
                hint: const Text('Choose a Unit'),
                value: provider.unit,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                items:
                    kChanWaUnit.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: provider.updateUnit,
              ),
            ],
          ),
        if (provider.studentStatus == StudentStatus.student &&
            provider.secondarySchool == 'SMJK Chan Wa' &&
            provider.unit == 'Other')
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: RegistrationFormField(
              label: 'Other (Please specify unit):',
              textEditingController: widget.otherUnitController,
              onChanged: provider.updateOtherUnit,
            ),
          ),
        const SizedBox(
          height: 8.0,
        ),
      ],
    );
  }
}
