// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:washcubes_admindashboard/config.dart';
import 'package:washcubes_admindashboard/src/features/admin/screens/rider_list/rider_details.dart';
import 'package:washcubes_admindashboard/src/models/rider.dart';
import 'package:washcubes_admindashboard/src/utilities/theme/widget_themes/text_theme.dart';
import 'package:washcubes_admindashboard/src/constants/colors.dart';
import 'package:washcubes_admindashboard/src/features/admin/screens/rider_list/add_rider.dart';
import 'package:http/http.dart' as http;

class RiderTable extends StatefulWidget {
  const RiderTable({super.key});

  @override
  State<RiderTable> createState() => _RiderTableState();

  void refreshTable() {
    (key as _RiderTableState).fetchRidersDetails();
  }
}

class _RiderTableState extends State<RiderTable> {
  List<Rider> riders = [];
  List<Rider> allRiders = [];

  @override
  void initState() {
    super.initState();
    fetchRidersDetails();
  }

  Future<void> fetchRidersDetails() async {
    try {
      final response = await http.get(
        Uri.parse('${url}admin/fetchRiders'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data.containsKey('riders')) {
          final List<dynamic> riderData = data['riders'];
          final List<Rider> fetchedRiders =
              riderData.map((rider) => Rider.fromJson(rider)).toList();
          setState(() {
            riders = fetchedRiders;
            allRiders = fetchedRiders;
          });
        } else {
          print('Response data does not contain services.');
        }
      } else {
        print('Error: ${response.statusCode}');
        print('Error message: ${response.body}');
      }
    } catch (error) {
      print('Error Fetching Riders Details: $error');
    }
  }

  List<Rider> searchRider(List<Rider> riders, String? keyword) {
    if (keyword == null) {
      return riders;
    }
    return riders
        .where((riders) =>
            (riders.name.toLowerCase()).contains(keyword.toLowerCase()))
        .toList();
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
                    'Rider Data',
                    style: CTextTheme.blackTextTheme.displayLarge,
                  ),
                  IconButton(
                    onPressed: () async {
                      await fetchRidersDetails();
                    },
                    icon: const Icon(
                      Icons.refresh_rounded,
                      color: AppColors.cBlackColor,
                    ),
                  )
                ],
              ),
              //Add rider button
              ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AddRider(
                          refreshTable: fetchRidersDetails,
                        );
                      },
                    );
                  },
                  child: Text(
                    'Add New Rider',
                    style: CTextTheme.blackTextTheme.headlineMedium,
                  ))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SizedBox(
            height: 40.0,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search by Rider Name...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  riders = allRiders;
                  riders = searchRider(riders, value);
                });
              },
            ),
          ),
        ),
        Flexible(
          child: RiderList(riders: riders, refreshTable: fetchRidersDetails),
        ),
      ],
    );
  }
}

class RiderList extends StatelessWidget {
  List<Rider> riders = [];
  final VoidCallback refreshTable;

  RiderList({super.key, required this.riders, required this.refreshTable});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        DataTable(
          columnSpacing: screenWidth * 0.08,
          columns: [
            DataColumn(
                label: Text(
              'RIDER NAME',
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
          rows: riders
              .map(
                (rider) => DataRow(cells: [
                  DataCell(Text(
                    rider.name,
                    style: CTextTheme.blackTextTheme.headlineMedium,
                  )),
                  DataCell(Text(
                    rider.email,
                    style: CTextTheme.blackTextTheme.headlineMedium,
                  )),
                  DataCell(Text(
                    rider.phoneNumber.toString(),
                    style: CTextTheme.blackTextTheme.headlineMedium,
                  )),
                  DataCell(
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return RiderDetails(
                                rider: rider, refreshTable: refreshTable);
                          },
                        );
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
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // IconButton(
              //   onPressed: () {
              //     //TODO: Handle previous page button tap
              //   },
              //   icon: Container(
              //     decoration: const BoxDecoration(
              //       shape: BoxShape.circle,
              //       color: Color(0xFFD7ECF7),
              //     ),
              //     child: const Icon(Icons.arrow_back),
              //   ),
              // ),
              // const SizedBox(width: 16), // Adjust spacing as needed
              // Text(
              //   'Page 1 of 5', // Replace with actual page number
              //   style: CTextTheme.blackTextTheme.headlineMedium,
              // ),
              // const SizedBox(width: 16), // Adjust spacing as needed
              // IconButton(
              //   onPressed: () {
              //     //TODO: Handle next page button tap
              //   },
              //   icon: Container(
              //     decoration: const BoxDecoration(
              //       shape: BoxShape.circle,
              //       color: Color(0xFFD7ECF7),
              //     ),
              //     child: const Icon(Icons.arrow_forward),
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
