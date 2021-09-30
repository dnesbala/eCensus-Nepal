import 'package:ecensus_nepal/models/ganak_model.dart';
import 'package:ecensus_nepal/screens/add_new_data_screen.dart';
import 'package:ecensus_nepal/screens/collected_data_screen.dart';
import 'package:ecensus_nepal/widgets/dashboard_card.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  final Ganak? ganak;
  const DashboardScreen({Key? key, this.ganak}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<DashboardCard> dashboardActions = [
      DashboardCard(
        icon: Icons.add,
        text: 'Add New Data',
        screenName: AddNewDataScreen(ganak: ganak),
      ),
      DashboardCard(
        icon: Icons.folder_outlined,
        iconColor: Colors.blue,
        text: 'Collected Data',
        screenName: CollectedDataScreen(),
      ),
      DashboardCard(
        icon: Icons.save_outlined,
        iconColor: Colors.teal,
        text: 'Drafts',
        screenName: CollectedDataScreen(),
      ),
      DashboardCard(
        icon: Icons.amp_stories_sharp,
        iconColor: Colors.orange,
        text: 'About App',
        screenName: CollectedDataScreen(),
      ),
      DashboardCard(
        icon: Icons.apps_outlined,
        iconColor: Colors.purple.shade400,
        text: 'App Guide',
        screenName: CollectedDataScreen(),
      ),
      DashboardCard(
        icon: Icons.exit_to_app_outlined,
        iconColor: Colors.black87,
        text: 'Exit App',
        screenName: CollectedDataScreen(),
      ),
      DashboardCard(
        icon: Icons.logout_outlined,
        iconColor: Colors.red.shade400,
        text: 'Log Out',
        screenName: CollectedDataScreen(),
      ),
    ];

    return Scaffold(
      backgroundColor: Color(0xFF373A5B),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 20),
              child: Text(
                'Welcome, Mr ${ganak?.data?.name ?? 'Ganak'}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Divider(color: Colors.white12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1.6,
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 8,
                  ),
                  children: dashboardActions,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
