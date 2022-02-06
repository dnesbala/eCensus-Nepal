import 'package:flutter/material.dart';
import 'package:ecensus_nepal/models/census_data_model.dart';

class CollectedDataDetailScreen extends StatelessWidget {
  final CensusData? censusData;
  const CollectedDataDetailScreen({Key? key, this.censusData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(censusData?.familyHeadName ?? 'Family Head Name'),
        actions: [
          IconButton(
            icon: Icon(Icons.print),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: [
          ListTile(title: Text('प्रदेश : ${censusData?.province}')),
          Divider(),
          ListTile(title: Text('जिल्ला : ${censusData?.district}')),
          Divider(),
          ListTile(
              title: Text('गाउपालिका/नगरपालिका : ${censusData?.municipality}')),
          Divider(),
          ListTile(title: Text('वडा नं : ${censusData?.wardNo}')),
          Divider(),
          ListTile(title: Text('टोल : ${censusData?.tole}')),
          Divider(),
          ListTile(title: Text('घरमूलीको नाम : ${censusData?.familyHeadName}')),
          Divider(),
          ListTile(
              title: Text(
                  'घरमूलीको सम्पर्क नम्बर : ${censusData?.familyHeadContact}')),
          Divider(),
          ListTile(title: Text('घरको स्वामित्व : ${censusData?.ownHouse}')),
          Divider(),
          ListTile(title: Text('घरको जग : ${censusData?.baseHouseMade}')),
          Divider(),
          ListTile(
              title: Text(
                  'खानेपानीको स्रोत : ${censusData?.drinkingWaterSource}')),
          Divider(),
          ListTile(
              title: Text('खाना पकाउने स्रोत : ${censusData?.foodHeatSource}')),
          Divider(),
          ListTile(
              title: Text('बत्ती बाल्न स्रोत : ${censusData?.lightSource}')),
          Divider(),
          ListTile(
              title: Text(
                  'अघिल्लो १२ महिनामा मृत्यु : ${censusData?.isDeathWithinPast12Months}')),
          Divider(),
          ListTile(
              title: Text(
                  'अघिल्लो १२ महिनामा मृत्यु सङ्ख्या : ${censusData?.noOfDeaths}')),
          Divider(),
          ListTile(
              title: Text(
                  'अघिल्लो १२ महिनामा मृत्यु भएका व्यक्तिहरु : ${censusData?.deathPersons}')),
        ],
      ),
    );
  }
}
