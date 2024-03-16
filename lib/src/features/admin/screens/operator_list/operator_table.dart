import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:washcubes_admindashboard/config.dart';
import 'package:washcubes_admindashboard/src/features/admin/screens/operator_list/operator_details.dart';
import 'package:washcubes_admindashboard/src/models/operator.dart';
import 'package:washcubes_admindashboard/src/utilities/theme/widget_themes/text_theme.dart';
import 'package:washcubes_admindashboard/src/constants/colors.dart';
import 'package:washcubes_admindashboard/src/features/admin/screens/operator_list/add_operator.dart';
import 'package:http/http.dart' as http;

class OperatorTable extends StatefulWidget {
  const OperatorTable({super.key});

  @override
  State<OperatorTable> createState() => _OperatorTableState();
}

class _OperatorTableState extends State<OperatorTable> {
  List<Operator> operators = [];

  @override
  void initState() {
    super.initState();
    fetchOperatorsDetails();
  }

  Future<void> fetchOperatorsDetails() async {
    try {
      final response = await http.get(
        Uri.parse('${url}admin/fetchOperators'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data.containsKey('operators')) {
          final List<dynamic> operatorData = data['operators'];
          final List<Operator> fetchedOperators =
              operatorData.map((operator) => Operator.fromJson(operator)).toList();
          setState(() {
            operators = fetchedOperators;
          });
        } else {
          print('Response data does not contain services.');
        }
      } else {
        print('Error: ${response.statusCode}');
        print('Error message: ${response.body}');
      }
    } catch (error) {
      print('Error Fetching Operators Details: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'Operator Data',
                    style: CTextTheme.blackTextTheme.displayLarge,
                  ),
                  IconButton(
                    onPressed: () async {
                      await fetchOperatorsDetails();
                    },
                    icon: const Icon(
                      Icons.refresh_rounded,
                      color: AppColors.cBlackColor,
                    ),
                  )
                ],
              ),
              //Add operator button
              ElevatedButton(
                onPressed: (){
                  showDialog(
                    context: context, 
                    builder: (BuildContext context) {
                      return const AddOperator();
                    },);
                }, 
                child: Text('Add New Operator', style: CTextTheme.blackTextTheme.headlineMedium,)
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SizedBox(
            height: 40.0,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search by Operator Name...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onChanged: (value) {
                //TODO: Handle search functionality
              },
            ),
          ),
        ),
        Flexible(
          child: OperatorList(
            operators: operators,
          ),
        ),
      ],
    );
  }
}

class OperatorList extends StatelessWidget {
  List<Operator> operators = [];

  OperatorList({super.key, required this.operators});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        DataTable(
          columnSpacing: screenWidth * 0.06,
          columns: [
            DataColumn(
                label: Text(
              'OPERATOR NAME',
              style: CTextTheme.greyTextTheme.headlineMedium,
            )),
            DataColumn(
                label: Text(
              'EMAIL',
              style: CTextTheme.greyTextTheme.headlineMedium,
            )),
            DataColumn(
                label: Text(
              'PHONE NUMBER',
              style: CTextTheme.greyTextTheme.headlineMedium,
            )),
            const DataColumn(label: Text('')),
          ],
          rows: operators
              .map(
                (operator) => DataRow(cells: [
                  DataCell(Text(
                    operator.name,
                    style: CTextTheme.blackTextTheme.headlineMedium,
                  )),
                  DataCell(Text(
                    operator.email,
                    style: CTextTheme.blackTextTheme.headlineMedium,
                  )),
                  DataCell(Text(
                    operator.phoneNumber.toString(),
                    style: CTextTheme.blackTextTheme.headlineMedium,
                  )),
                  DataCell(
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context, 
                          builder: (BuildContext context) {
                            return OperatorDetails(operator: operator);
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