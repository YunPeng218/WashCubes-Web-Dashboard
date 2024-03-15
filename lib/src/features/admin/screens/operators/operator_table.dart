import 'package:flutter/material.dart';
import 'package:washcubes_admindashboard/src/features/admin/screens/operators/operator_details.dart';
import 'package:washcubes_admindashboard/src/utilities/theme/widget_themes/text_theme.dart';

class OperatorTable extends StatefulWidget {
  const OperatorTable({super.key});

  @override
  State<OperatorTable> createState() => _OperatorTableState();
}

class _OperatorTableState extends State<OperatorTable> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    //TODO: Replace with actual Operator data
    final List<OperatorDataRow> operators = [
      OperatorDataRow(
        operatorId: '#12345', 
        operatorName: 'Aarav Patel', 
        operatorEmail: 'optr3379@gmail.com', 
        mobileNumber: '+60 12-345 6789'
      ),
      OperatorDataRow(
        operatorId: '#12346', 
        operatorName: 'Aarav Shatel', 
        operatorEmail: 'optr3380@gmail.com', 
        mobileNumber: '+60 12-345 6790'
      ),
      OperatorDataRow(
        operatorId: '#12347', 
        operatorName: 'Aarav Cartel', 
        operatorEmail: 'optr3381@gmail.com', 
        mobileNumber: '+60 12-345 6791'
      ),
    ];

    return Column(
      children: [
        DataTable(
          columnSpacing: screenWidth * 0.06,
          columns: [
            DataColumn(
                label: Text(
              'OPERATOR ID',
              style: CTextTheme.greyTextTheme.headlineMedium,
            )),
            DataColumn(
                label: Text(
              'OPERATOR NAME',
              style: CTextTheme.greyTextTheme.headlineMedium,
            )),
            DataColumn(
                label: Text(
              'USERNAME',
              style: CTextTheme.greyTextTheme.headlineMedium,
            )),
            DataColumn(
                label: Text(
              'MOBILE NUMBER',
              style: CTextTheme.greyTextTheme.headlineMedium,
            )),
            const DataColumn(label: Text('')),
          ],
          rows: operators
              .map(
                (operator) => DataRow(cells: [
                  DataCell(Text(
                    operator.operatorId,
                    style: CTextTheme.blackTextTheme.headlineMedium,
                  )),
                  DataCell(Text(
                    operator.operatorName,
                    style: CTextTheme.blackTextTheme.headlineMedium,
                  )),
                  DataCell(Text(
                    operator.operatorEmail,
                    style: CTextTheme.blackTextTheme.headlineMedium,
                  )),
                  DataCell(Text(
                    operator.mobileNumber,
                    style: CTextTheme.blackTextTheme.headlineMedium,
                  )),
                  DataCell(
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context, 
                          builder: (BuildContext context) {
                            return const OperatorDetails();
                          },);
                      },
                      child: Text(
                        'Check',
                        style: CTextTheme.blackTextTheme.headlineMedium,
                      ),
                    ),
                  ),
                ]),
              )
              .toList(),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  //TODO: Handle previous page button tap
                },
                icon: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFD7ECF7),
                  ),
                  child: const Icon(Icons.arrow_back),
                ),
              ),
              const SizedBox(width: 16), // Adjust spacing as needed
              Text(
                'Page 1 of 5', // Replace with actual page number
                style: CTextTheme.blackTextTheme.headlineMedium,
              ),
              const SizedBox(width: 16), // Adjust spacing as needed
              IconButton(
                onPressed: () {
                  //TODO: Handle next page button tap
                },
                icon: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFD7ECF7),
                  ),
                  child: const Icon(Icons.arrow_forward),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class OperatorDataRow {
  final String operatorId;
  final String operatorName;
  final String operatorEmail;
  final String mobileNumber;

  OperatorDataRow({
    required this.operatorId,
    required this.operatorName,
    required this.operatorEmail,
    required this.mobileNumber,
  });
}