import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticketz/providers/registration_form_provider.dart';
import 'package:ticketz/shared/constants.dart';

enum HalalOption { halal, nonHalal }

class HalalRadioGroup extends StatefulWidget {
  const HalalRadioGroup({Key? key}) : super(key: key);

  @override
  State<HalalRadioGroup> createState() => _HalalRadioGroupState();
}

class _HalalRadioGroupState extends State<HalalRadioGroup> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<RegistrationFormProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          width: double.infinity,
          child: Text(
            'Halal or Non-Halal',
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
                Radio<HalalOption>(
                  value: HalalOption.halal,
                  groupValue: provider.halalOption,
                  onChanged: (HalalOption? value) {
                    provider.updateHalalOption(value);
                  },
                ),
                const SizedBox(
                  width: 8.0,
                ),
                const Text(
                  'Halal',
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio<HalalOption>(
                  value: HalalOption.nonHalal,
                  groupValue: provider.halalOption,
                  onChanged: (HalalOption? value) {
                    provider.updateHalalOption(value);
                  },
                ),
                const SizedBox(
                  width: 8.0,
                ),
                const Text(
                  'Non-Halal',
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

enum VegetarianOption { vegetarian, nonVegetarian }

class VegetarianRadioGroup extends StatefulWidget {
  const VegetarianRadioGroup({Key? key}) : super(key: key);

  @override
  State<VegetarianRadioGroup> createState() => _VegetarianRadioGroupState();
}

class _VegetarianRadioGroupState extends State<VegetarianRadioGroup> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<RegistrationFormProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          width: double.infinity,
          child: Text(
            'Vegetarian or Non-Vegetarian',
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
                Radio<VegetarianOption>(
                  value: VegetarianOption.vegetarian,
                  groupValue: provider.vegetarianOption,
                  onChanged: (VegetarianOption? value) {
                    Provider.of<RegistrationFormProvider>(
                      context,
                      listen: false,
                    ).updateVegetatianOption(value);
                  },
                ),
                const SizedBox(
                  width: 8.0,
                ),
                const Text(
                  'Vegetarian',
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio<VegetarianOption>(
                  value: VegetarianOption.nonVegetarian,
                  groupValue: provider.vegetarianOption,
                  onChanged: (VegetarianOption? value) {
                    Provider.of<RegistrationFormProvider>(
                      context,
                      listen: false,
                    ).updateVegetatianOption(value);
                  },
                ),
                const SizedBox(
                  width: 8.0,
                ),
                const Text(
                  'Non-Vegetarian',
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
