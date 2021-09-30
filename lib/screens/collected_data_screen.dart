import 'package:flutter/material.dart';

class CollectedDataScreen extends StatelessWidget {
  const CollectedDataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Collected Census Data'),
      ),
      body: Column(
        children: [
          ListTile(
            onTap: () {},
            leading:
                SizedBox(height: double.infinity, child: Icon(Icons.person)),
            title: Text('Ram Prasad Kharel'),
            subtitle: Text('Kathmandu'),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
          ListTile(
            onTap: () {},
            leading:
                SizedBox(height: double.infinity, child: Icon(Icons.person)),
            title: Text('Krishna Nagarkoti'),
            subtitle: Text('Bhaktapur'),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
          ListTile(
            onTap: () {},
            leading:
                SizedBox(height: double.infinity, child: Icon(Icons.person)),
            title: Text('Anuska Shrestha'),
            subtitle: Text('Kavre'),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
        ],
      ),
    );
  }
}
