import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:ticketz/components/dash_line.dart';
import 'package:ticketz/components/small_text_button.dart';
import 'package:ticketz/components/verified_ticket_detail.dart';
import 'package:ticketz/models/participant.dart';
import 'package:ticketz/providers/qr_state_provider.dart';
import 'package:ticketz/shared/constants.dart';

class VerificationSuccess extends StatelessWidget {
  final String code;

  const VerificationSuccess({
    super.key,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 24.0,
            horizontal: 24.0,
          ),
          child: Column(
            children: [
              Lottie.asset(
                'assets/animations/success.json',
                repeat: false,
                height: 64,
              ),
              const SizedBox(
                height: 8.0,
              ),
              const Text(
                'Verification Success',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SmallTextButton(
                  label: 'Back to Scanner',
                  onPressed: () {
                    Provider.of<QRStateProvider>(context, listen: false)
                        .resetState();
                  }),
              const SizedBox(
                height: 16.0,
              ),
              const DashLine(),
              const SizedBox(
                height: 16.0,
              ),
              Consumer<List<Participant>>(builder: (context, value, child) {
                final participant =
                    value.firstWhere(((element) => element.id == code));
                return Column(
                  children: [
                    VerifiedTicketDetail(
                      label: 'TICKET NO',
                      text: participant.id!,
                    ),
                    VerifiedTicketDetail(
                      label: 'NAME',
                      text:
                          '${participant.englishName} ${participant.chineseName}',
                    ),
                    VerifiedTicketDetail(
                      label: 'NRIC',
                      text: participant.icNumber,
                    ),
                    VerifiedTicketDetail(
                      label: 'PHONE NUMBER',
                      text: participant.phoneNumber,
                    ),
                    VerifiedTicketDetail(
                      label: 'EMAIL ADDRESS',
                      text: participant.emailAddress,
                    ),
                    VerifiedTicketDetail(
                      label: 'SECONDARY SCHOOL',
                      text: participant.secondarySchool ?? 'N/A',
                    ),
                    VerifiedTicketDetail(
                      label: 'UNIT',
                      text: participant.unit ?? 'N/A',
                    ),
                    VerifiedTicketDetail(
                      label: 'HALAL OPTION',
                      text: participant.isHalal ? 'Halal' : 'Non-Halal',
                    ),
                    VerifiedTicketDetail(
                      label: 'VEGETARIAN OPTION',
                      text: participant.isVegetarian
                          ? 'Vegetarian'
                          : 'Non-Vegetarian',
                    ),
                    VerifiedTicketDetail(
                      label: 'ALLERGIC',
                      text: participant.allergic ?? 'N/A',
                    ),
                    VerifiedTicketDetail(
                      label: 'ATTENDED',
                      text:
                          participant.isAttended ? 'Attended' : 'Not Attended',
                    )
                  ],
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
