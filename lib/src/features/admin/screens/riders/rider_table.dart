import 'package:flutter/material.dart';
import 'package:washcubes_admindashboard/src/features/admin/screens/riders/rider_details.dart';
import 'package:washcubes_admindashboard/src/utilities/theme/widget_themes/text_theme.dart';

class RiderTable extends StatefulWidget {
  const RiderTable({super.key});

  @override
  State<RiderTable> createState() => _RiderTableState();
}

class _RiderTableState extends State<RiderTable> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    //TODO: Replace with actual Rider data
    final List<RiderDataRow> riders = [
      RiderDataRow(
        riderId: '#12345', 
        riderName: 'Darren Lee', 
        riderEmail: 'darren9612@gmail.com'
      ),
      RiderDataRow(
        riderId: '#12346', 
        riderName: 'Darren Tee', 
        riderEmail: 'darren9613@gmail.com'
      ),
      RiderDataRow(
        riderId: '#12345', 
        riderName: 'Darren Three', 
        riderEmail: 'darren9614@gmail.com'
      ),
    ];

    return Column(
      children: [
        DataTable(
          columnSpacing: screenWidth * 0.08,
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
            const DataColumn(label: Text('')),
          ],
          rows: riders
              .map(
                (rider) => DataRow(cells: [
                  DataCell(Text(
                    rider.riderId,
                    style: CTextTheme.blackTextTheme.headlineMedium,
                  )),
                  DataCell(Text(
                    rider.riderName,
                    style: CTextTheme.blackTextTheme.headlineMedium,
                  )),
                  DataCell(Text(
                    rider.riderEmail,
                    style: CTextTheme.blackTextTheme.headlineMedium,
                  )),
                  DataCell(
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context, 
                          builder: (BuildContext context) {
                            return const RiderDetails();
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

class RiderDataRow {
  final String riderId;
  final String riderName;
  final String riderEmail;

  RiderDataRow({
    required this.riderId,
    required this.riderName,
    required this.riderEmail,
  });
}