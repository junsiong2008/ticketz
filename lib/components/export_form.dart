import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticketz/components/primary_button.dart';
import 'package:ticketz/models/participant.dart';
import 'package:ticketz/providers/excel_provider.dart';

class ExportForm extends StatelessWidget {
  const ExportForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Export to Excel?',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        const Text(
          'This will export participant details, payment and attendance status to an Excel file.',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 16,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16.0,
          ),
          child: Consumer<List<Participant>>(
            builder: (context, value, child) {
              return PrimaryButton(
                  label: 'Export',
                  onTap: () async {
                    final excelProvider = Provider.of<ExcelProvider>(
                      context,
                      listen: false,
                    );
                    await excelProvider.exportToExcel(value);
                  });
            },
          ),
        ),
      ],
    );
  }
}
