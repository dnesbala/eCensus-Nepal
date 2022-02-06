import 'package:dio/dio.dart';
import 'package:ecensus_nepal/models/ganak_model.dart';
import 'package:ecensus_nepal/screens/add_new_data_screen.dart';
import 'package:ecensus_nepal/screens/collected_data_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:ecensus_nepal/models/census_data_model.dart';
import 'package:ecensus_nepal/widgets/boxes.dart';

class CollectedDataScreen extends StatefulWidget {
  final Ganak? ganak;
  const CollectedDataScreen({Key? key, this.ganak}) : super(key: key);

  @override
  _CollectedDataScreenState createState() => _CollectedDataScreenState();
}

class _CollectedDataScreenState extends State<CollectedDataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Collected Census Data'),
      ),
      body: ValueListenableBuilder<Box<CensusData>>(
        valueListenable: Boxes.getCensusData().listenable(),
        builder: (BuildContext context, box, _) {
          final List<CensusData> censusDatas =
              box.values.toList().cast<CensusData>();

          if (censusDatas.isEmpty)
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No data collected.',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    child: Text("Add New Data"),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => AddNewDataScreen(
                            ganak: widget.ganak,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          else
            return ListView.builder(
              itemCount: censusDatas.length,
              itemBuilder: (BuildContext context, int index) {
                var censusData = censusDatas[index];

                return ListTile(
                  leading: SizedBox(
                      height: double.infinity, child: Icon(Icons.person)),
                  title: Text(censusData.familyHeadName!),
                  subtitle: Text(censusData.district!),
                  trailing: IconButton(
                    icon: Icon(Icons.more_vert),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Wrap(
                              children: [
                                ListTile(
                                    leading: Icon(Icons.edit),
                                    title: Text(
                                      "Edit Detail",
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    minLeadingWidth: 10,
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    }),
                                ListTile(
                                  leading: Icon(Icons.delete),
                                  title: Text(
                                    "Delete Data",
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  minLeadingWidth: 10,
                                  onTap: () async {
                                    await censusData.delete().then((_) =>
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'Data deleted successfully.'),
                                            duration: Duration(seconds: 2),
                                          ),
                                        ));
                                    Navigator.of(context).pop();
                                  },
                                ),
                                ListTile(
                                  leading: Icon(Icons.upload),
                                  title: Text(
                                    "Save to Server",
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  minLeadingWidth: 10,
                                  onTap: () async {
                                    print("--------------------------");
                                    try {
                                      var response = await Dio().post(
                                          'http://ecensus.herokuapp.com/api/v1/census',
                                          data: {
                                            'province': censusData.province,
                                            'district': censusData.district,
                                            'municipality':
                                                censusData.municipality,
                                            'wardNo': censusData.wardNo,
                                            'tole': censusData.tole,
                                            'familyHeadName':
                                                censusData.familyHeadName,
                                            'familyHeadContact':
                                                censusData.familyHeadContact,
                                            'ownHouse': censusData.ownHouse,
                                            'baseHouseMade':
                                                censusData.baseHouseMade,
                                            'drinkingWaterSource':
                                                censusData.drinkingWaterSource,
                                            'foodHeatSource':
                                                censusData.foodHeatSource,
                                            'lightSource':
                                                censusData.lightSource,
                                            'isDeathWithinPast12Months':
                                                censusData
                                                    .isDeathWithinPast12Months,
                                            'noOfDeaths': censusData.noOfDeaths,
                                            'deathPersons':
                                                censusData.deathPersons,
                                            'individualDetail':
                                                censusData.individualDetail,
                                          },
                                          options: Options(headers: {
                                            "Authorization":
                                                "Bearer ${widget.ganak?.token}",
                                          }));
                                      print(response);
                                      if (response.statusCode == 201) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content:
                                              Text('Data saved to server.'),
                                        ));
                                        Navigator.of(context).pop();
                                      }
                                    } on DioError catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(e.error),
                                      ));
                                    }
                                  },
                                ),
                              ],
                            );
                          });
                    },
                  ),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          CollectedDataDetailScreen(censusData: censusData),
                    ),
                  ),
                );
              },
            );
        },
      ),
    );
  }
}
