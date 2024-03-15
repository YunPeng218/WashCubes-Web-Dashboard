import 'package:flutter/material.dart';
import 'package:washcubes_admindashboard/src/constants/colors.dart';
import 'package:washcubes_admindashboard/src/features/admin/screens/riders/add_rider.dart';
import 'package:washcubes_admindashboard/src/features/admin/screens/riders/rider_table.dart';
import 'package:washcubes_admindashboard/src/utilities/theme/widget_themes/text_theme.dart';

class RiderData extends StatefulWidget {
  const RiderData({super.key});

  @override
  State<RiderData> createState() => _RiderDataState();
}

class _RiderDataState extends State<RiderData> {
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
                      // await fetchOrders();
                      // setState(() {});
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
                      return const AddRider();
                    },);
                }, 
                child: Text('Add New Rider', style: CTextTheme.blackTextTheme.headlineMedium,)
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
                hintText: 'Search by ID or Username..',
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
        const Expanded(child: RiderTable()),
      ],
    );
  }
}