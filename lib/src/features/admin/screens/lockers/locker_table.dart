import 'package:flutter/material.dart';
import 'package:washcubes_admindashboard/src/features/admin/screens/lockers/locker_details.dart';
import 'package:washcubes_admindashboard/src/utilities/theme/widget_themes/text_theme.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:washcubes_admindashboard/config.dart';
import 'package:washcubes_admindashboard/src/models/locker.dart';

class LockerTable extends StatefulWidget {
  const LockerTable({super.key});

  @override
  State<LockerTable> createState() => _LockerTableState();
}

class _LockerTableState extends State<LockerTable> {
  List<LockerSite> lockerSites = [];

  @override
  void initState() {
    super.initState();
    fetchLockerSites();
  }

  Future<void> fetchLockerSites() async {
    try {
      var reqUrl = '${url}lockers';
      final response = await http.get(Uri.parse(reqUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data.containsKey('lockers')) {
          final List<dynamic> lockerData = data['lockers'];
          final List<LockerSite> fetchedLockerSites =
              lockerData.map((site) => LockerSite.fromJson(site)).toList();
          setState(() {
            lockerSites = fetchedLockerSites;
          });
        } else {
          print('No lockers found.');
        }
      } else {
        // If the server did not return a 200 OK response, throw an exception.
        throw Exception('Failed to load locker sites');
      }
    } catch (error) {
      print('Error fetching locker sites: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        DataTable(
          columnSpacing: screenWidth * 0.1,
          columns: [
            DataColumn(
                label: Text(
              'LOCATIONS',
              style: CTextTheme.greyTextTheme.headlineMedium,
            )),
            DataColumn(
                label: Text(
              'ADDRESS',
              style: CTextTheme.greyTextTheme.headlineMedium,
            )),
            // DataColumn(
            //     label: Text(
            //   'STATUS',
            //   style: CTextTheme.greyTextTheme.headlineMedium,
            // )),
            const DataColumn(label: Text('')),
          ],
          rows: lockerSites
              .map(
                (locker) => DataRow(cells: [
                  DataCell(Text(
                    locker.name,
                    style: CTextTheme.blackTextTheme.headlineMedium,
                  )),
                  DataCell(Text(
                    locker.address,
                    style: CTextTheme.blackTextTheme.headlineMedium,
                  )),
                  // DataCell(Text(
                  //   locker.status,
                  //   style: locker.status == 'Available' ? CTextTheme.blueTextTheme.headlineMedium : CTextTheme.redTextTheme.headlineMedium,
                  // )),
                  DataCell(
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return LockerDetails(
                              lockerSite: locker,
                            );
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
      ],
    );
  }
}
