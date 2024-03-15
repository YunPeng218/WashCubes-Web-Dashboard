import 'package:flutter/material.dart';
import 'package:washcubes_admindashboard/src/features/admin/screens/lockers/locker_details.dart';
import 'package:washcubes_admindashboard/src/utilities/theme/widget_themes/text_theme.dart';

class LockerTable extends StatefulWidget {
  const LockerTable({super.key});

  @override
  State<LockerTable> createState() => _LockerTableState();
}

class _LockerTableState extends State<LockerTable> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    //TODO: Replace with actual Rider data
    final List<LockerDataRow> lockers = [
      LockerDataRow(
        location: "Taylor's University", 
        area: 'Subang Jaya, Selangor', 
        status: 'Available'
      ),
      LockerDataRow(
        location: "Sunway Geo Residences", 
        area: 'Subang Jaya, Selangor', 
        status: 'Occupied'
      ),
      LockerDataRow(
        location: "Tropicana City Office Tower", 
        area: 'Petaling Jaya, Selangor', 
        status: 'Available'
      ),
    ];

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
              'AREA',
              style: CTextTheme.greyTextTheme.headlineMedium,
            )),
            DataColumn(
                label: Text(
              'STATUS',
              style: CTextTheme.greyTextTheme.headlineMedium,
            )),
            const DataColumn(label: Text('')),
          ],
          rows: lockers
              .map(
                (locker) => DataRow(cells: [
                  DataCell(Text(
                    locker.location,
                    style: CTextTheme.blackTextTheme.headlineMedium,
                  )),
                  DataCell(Text(
                    locker.area,
                    style: CTextTheme.blackTextTheme.headlineMedium,
                  )),
                  DataCell(Text(
                    locker.status,
                    style: locker.status == 'Available' ? CTextTheme.blueTextTheme.headlineMedium : CTextTheme.redTextTheme.headlineMedium,
                  )),
                  DataCell(
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context, 
                          builder: (BuildContext context) {
                            return const LockerDetails();
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
      ],
    );
  }
}

class LockerDataRow {
  final String location;
  final String area;
  final String status;

  LockerDataRow({
    required this.location,
    required this.area,
    required this.status,
  });
}