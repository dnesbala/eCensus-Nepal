import 'package:ecensus_nepal/widgets/dashboard_card.dart';
import 'package:flutter/material.dart';

List<DashboardCard> dashboardActions = [
  DashboardCard(
      icon: Icons.add, text: 'Add New Data', onTap: () => print('tapped')),
  DashboardCard(
      icon: Icons.folder_outlined,
      iconColor: Colors.blue,
      text: 'Collected Data',
      onTap: () {}),
  DashboardCard(
      icon: Icons.save_outlined,
      iconColor: Colors.teal,
      text: 'Drafts',
      onTap: () {}),
  DashboardCard(
      icon: Icons.amp_stories_sharp,
      iconColor: Colors.orange,
      text: 'About App',
      onTap: () {}),
  DashboardCard(
      icon: Icons.apps_outlined,
      iconColor: Colors.purple.shade400,
      text: 'App Guide',
      onTap: () {}),
  DashboardCard(
      icon: Icons.exit_to_app_outlined,
      iconColor: Colors.black87,
      text: 'Exit App',
      onTap: () {}),
  DashboardCard(
      icon: Icons.logout_outlined,
      iconColor: Colors.red.shade400,
      text: 'Log Out',
      onTap: () {}),
];

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF373A5B),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 20),
              child: Text(
                'Welcome, Mr Dinesh',
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