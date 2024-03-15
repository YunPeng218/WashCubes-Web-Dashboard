import 'package:flutter/material.dart';
import 'package:washcubes_admindashboard/src/features/admin/screens/feedback/feedback_details.dart';
import 'package:washcubes_admindashboard/src/utilities/theme/widget_themes/text_theme.dart';

class FeedbackTable extends StatefulWidget {
  const FeedbackTable({super.key});

  @override
  State<FeedbackTable> createState() => _FeedbackTableState();
}

class _FeedbackTableState extends State<FeedbackTable> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    //TODO: Replace with actual feedback data
    final List<FeedbackRow> feedbacks = [
      FeedbackRow(
        userId: '#12345', 
        username: 'Trimity Wang', 
        feedback: 'The i3Cube smart locker is super convenient! Loved how...',
        dateReceived: 'Nov 23, 2023, 12:59', 
        rating: 'Satisfied'
      ),
      FeedbackRow(
        userId: '#12346', 
        username: 'Trimity Huang', 
        feedback: 'The i3Cube smart locker is super convenient! Loved how...',
        dateReceived: 'Nov 23, 2023, 13:00', 
        rating: 'Average'
      ),
      FeedbackRow(
        userId: '#12347', 
        username: 'Trimity Tan', 
        feedback: 'The i3Cube smart locker is super convenient! Loved how...',
        dateReceived: 'Nov 23, 2023, 13:01', 
        rating: 'Unsatisfactory'
      ),
    ];

    return Column(
      children: [
        DataTable(
          columnSpacing: screenWidth * 0.06,
          columns: [
            DataColumn(
                label: Text(
              'USER ID',
              style: CTextTheme.greyTextTheme.headlineMedium,
            )),
            DataColumn(
                label: Text(
              'USERNAME',
              style: CTextTheme.greyTextTheme.headlineMedium,
            )),
            DataColumn(
                label: Text(
              'FEEDBACK',
              style: CTextTheme.greyTextTheme.headlineMedium,
            )),
            DataColumn(
                label: Text(
              'DATE RECEIVED',
              style: CTextTheme.greyTextTheme.headlineMedium,
            )),
            DataColumn(
                label: Text(
              'RATING',
              style: CTextTheme.greyTextTheme.headlineMedium,
            )),
            const DataColumn(label: Text('')),
          ],
          rows: feedbacks
              .map(
                (feedback) => DataRow(cells: [
                  DataCell(Text(
                    feedback.userId,
                    style: CTextTheme.blackTextTheme.headlineMedium,
                  )),
                  DataCell(Text(
                    feedback.username,
                    style: CTextTheme.blackTextTheme.headlineMedium,
                  )),
                  DataCell(SizedBox(
                      width: 150,
                      child: Text(
                        feedback.feedback,
                        style: CTextTheme.blackTextTheme.headlineMedium,
                        overflow: TextOverflow.ellipsis, 
                        maxLines: 2,
                      ))),
                  DataCell(SizedBox(
                      width: 80,
                      child: Text(
                        feedback.dateReceived,
                        style: CTextTheme.blackTextTheme.headlineMedium,
                      ))),
                  DataCell(Text(
                    feedback.rating,
                    style: CTextTheme.blackTextTheme.headlineMedium?.copyWith(color: _getRatingColor(feedback.rating)),
                  )),
                  DataCell(
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context, 
                          builder: (BuildContext context) {
                            return const FeedbackDetails();
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

  // Function to determine rating color
  Color _getRatingColor(String ratingStatus) {
    switch (ratingStatus) {
      case 'Unsatisfactory':
        return Colors.red;
      case 'Average':
        return Colors.orange;
      case 'Satisfied':
        return Colors.blue;
      default:
        return Colors.red;
    }
  }
}

class FeedbackRow {
  final String userId;
  final String username;
  final String feedback;
  final String dateReceived;
  final String rating;

  FeedbackRow({
    required this.userId,
    required this.username,
    required this.feedback,
    required this.dateReceived,
    required this.rating,
  });
}