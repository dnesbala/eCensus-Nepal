import 'package:ecensus_nepal/models/census_data_model.dart';
import 'package:ecensus_nepal/models/ganak_model.dart';
import 'package:ecensus_nepal/models/options_model.dart';
import 'package:ecensus_nepal/screens/dashboard_screen.dart';
import 'package:ecensus_nepal/widgets/boxes.dart';
import 'package:ecensus_nepal/widgets/custom_radio.dart';
import 'package:ecensus_nepal/widgets/single_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddNewDataScreen extends StatefulWidget {
  final Ganak? ganak;
  const AddNewDataScreen({Key? key, this.ganak}) : super(key: key);

  @override
  _AddNewDataScreenState createState() => _AddNewDataScreenState();
}

class _AddNewDataScreenState extends State<AddNewDataScreen> {
  int _currentStep = 0;
  int _noOfIndividualPerson = 1;
  bool _isDataSaving = false;

  final provinceFormKey = GlobalKey<FormState>();
  final districtFormKey = GlobalKey<FormState>();
  final municipalityFormKey = GlobalKey<FormState>();
  final wardNoFormKey = GlobalKey<FormState>();
  final toleFormKey = GlobalKey<FormState>();
  final familyHeadNameFormKey = GlobalKey<FormState>();
  final familyHeadContactFormKey = GlobalKey<FormState>();
  final noOfDeathsFormKey = GlobalKey<FormState>();

  final provinceTextController = TextEditingController();
  final districtTextController = TextEditingController();
  final municipalityTextController = TextEditingController();
  final wardNoTextController = TextEditingController();
  final toleTextController = TextEditingController();
  final familyHeadNameTextController = TextEditingController();
  final familyHeadContactTextController = TextEditingController();
  final noOfDeathsTextController = TextEditingController();

  var ownHouse = "own";
  var baseHouseMade = "mud";
  var drinkingWaterSource = "tap";
  var foodHeatSource = "wood";
  var lightSource = "electricity";

  List<String> deathPersons = [];
  List individualDetails = [];

  var isDeathWithinPast12Months = false;
  var noOfDeaths = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Data"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {},
            tooltip: 'Save data',
          ),
        ],
      ),
      body: WillPopScope(
        onWillPop: () async {
          return await showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text("Are you sure you want to go back?"),
              content: Text("Filled data will be lost."),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text("NO"),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text("YES"),
                ),
              ],
            ),
          );
        },
        child: ListView(
          children: [
            Stepper(
              currentStep: _currentStep,
              onStepTapped: (step) => _tapStep(step),
              onStepContinue: _continueStep,
              onStepCancel: _backStep,
              physics: ClampingScrollPhysics(),
              controlsBuilder: (BuildContext context,
                  {VoidCallback? onStepContinue, VoidCallback? onStepCancel}) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (_currentStep > 0)
                      TextButton(
                        onPressed: () => _backStep(),
                        child: Text("Back"),
                      ),
                    SizedBox(width: 5),
                    if (_currentStep == 3)
                      _isDataSaving
                          ? Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                              onPressed: () => _saveData(),
                              child: Text("Save Data"),
                            )
                    else
                      ElevatedButton(
                        onPressed: () => _continueStep(),
                        child: Text("Next"),
                      ),
                  ],
                );
              },
              steps: [
                Step(
                  isActive: _currentStep == 0,
                  title:
                      Text("?????????????????????????????? ????????????", style: TextStyle(fontSize: 18)),
                  content: Column(
                    children: [
                      SingleTextField(
                        title: '??????????????????',
                        fieldName: 'province',
                        textController: provinceTextController,
                        formKey: provinceFormKey,
                      ),
                      SingleTextField(
                        title: '??????????????????',
                        fieldName: 'district',
                        textController: districtTextController,
                        formKey: districtFormKey,
                      ),
                      SingleTextField(
                        title: '??????????????????????????? / ???????????????????????????',
                        fieldName: 'municiaplity',
                        textController: municipalityTextController,
                        formKey: municipalityFormKey,
                      ),
                      SingleTextField(
                        title: '????????? ??????',
                        fieldName: 'wardNo',
                        textController: wardNoTextController,
                        formKey: wardNoFormKey,
                      ),
                      SingleTextField(
                        title: '?????????',
                        fieldName: 'tole',
                        textController: toleTextController,
                        formKey: toleFormKey,
                      ),
                      SingleTextField(
                        title: '???????????????????????? ?????????',
                        fieldName: 'familyHeadName',
                        textController: familyHeadNameTextController,
                        formKey: familyHeadNameFormKey,
                      ),
                      SingleTextField(
                        title: '???????????????????????? ????????????????????? ???????????????',
                        fieldName: 'familyHeadContact',
                        textController: familyHeadContactTextController,
                        formKey: familyHeadContactFormKey,
                      ),
                    ],
                  ),
                ),
                Step(
                  isActive: _currentStep == 1,
                  title: Text("??????????????????????????? ????????????", style: TextStyle(fontSize: 18)),
                  content: Column(
                    children: [
                      CustomRadio(
                        question:
                            '????????????????????? ???????????????????????? ?????????????????? ??????????????? ???????????? ??????????????????????????? ??????????????? ?????? ?',
                        options: [
                          OptionsModel(name: '???????????????', value: 'own'),
                          OptionsModel(name: '??????????????????', value: 'rent'),
                          OptionsModel(
                              name: '????????????????????????', value: 'organizational'),
                          OptionsModel(name: '????????????', value: 'other'),
                        ],
                        onSelectItem: (String val) => ownHouse = val,
                      ),
                      Divider(),
                      CustomRadio(
                        question:
                            '????????????????????? ???????????????????????? ?????????????????? ??????????????? ???????????? ?????? ??????????????? ????',
                        options: [
                          OptionsModel(name: '?????????????????? ??????????????? ????????????', value: 'mud'),
                          OptionsModel(
                              name: '?????????/??????????????????, ??????????????????????????? ??????????????? ????????????',
                              value: 'concretePillar'),
                          OptionsModel(
                              name: '??????????????? ??????????????????', value: 'metalFrame'),
                          OptionsModel(
                              name: '??????????????? ??????????????? ??????????????????', value: 'wood'),
                          OptionsModel(name: '????????????', value: 'other'),
                        ],
                        onSelectItem: (String val) => baseHouseMade = val,
                      ),
                      Divider(),
                      CustomRadio(
                        question:
                            '????????????????????? ???????????????????????? ?????????????????????????????? ??????????????? ??????????????? ????????? ???????',
                        options: [
                          OptionsModel(
                              name: '????????????/????????????(?????? ??????????????? ???????????????)', value: 'tap'),
                          OptionsModel(
                              name: '???????????? ????????????/????????????, ????????? ????????????', value: 'well'),
                          OptionsModel(name: '?????????/????????????', value: 'river'),
                          OptionsModel(name: ' ?????????/??????????????????', value: 'jar'),
                          OptionsModel(name: '????????????', value: 'other'),
                        ],
                        onSelectItem: (String val) => drinkingWaterSource = val,
                      ),
                      Divider(),
                      CustomRadio(
                        question:
                            ' ?????????????????? ???????????????????????? ???????????? ??????????????? ???????????????(??????????????????????????????) ????????? ??????????????? ?????????????????? ???????????????????????????????',
                        options: [
                          OptionsModel(name: '?????????/???????????????', value: 'wood'),
                          OptionsModel(name: '??????.?????? ??????????????????', value: 'gas'),
                          OptionsModel(
                              name: '??????????????????', value: 'electricAppliances'),
                          OptionsModel(name: '????????????', value: 'other'),
                        ],
                        onSelectItem: (String val) => foodHeatSource = val,
                      ),
                      Divider(),
                      CustomRadio(
                        question:
                            ' ?????????????????? ???????????????????????? ??????????????? ??????????????? ??????????????? (??????????????? ???????????????) ?????? ?????????????????? ???????????????????????????????',
                        options: [
                          OptionsModel(name: '??????????????????', value: 'electricity'),
                          OptionsModel(
                              name: '???????????????/??????????????????????????????', value: 'solar'),
                          OptionsModel(name: '??????????????????????????????', value: 'biogas'),
                          OptionsModel(name: '????????????????????????', value: 'kerosene'),
                          OptionsModel(name: '????????????', value: 'other'),
                        ],
                        onSelectItem: (String val) => lightSource = val,
                      ),
                    ],
                  ),
                ),
                Step(
                  isActive: _currentStep == 2,
                  title: Text("?????????????????? ???????????????", style: TextStyle(fontSize: 18)),
                  content: Column(
                    children: [
                      Text(
                          '?????? ?????? ????????????????????? ????????????????????? ???????????????????????? ??????????????? ?????????????????? ???????????? ?????????????',
                          style: TextStyle(fontSize: 20)),
                      RadioListTile<bool>(
                        groupValue: isDeathWithinPast12Months,
                        title: Text('????????????'),
                        value: true,
                        onChanged: (bool? val) {
                          setState(() {
                            isDeathWithinPast12Months = val!;
                          });
                        },
                      ),
                      RadioListTile<bool>(
                        groupValue: isDeathWithinPast12Months,
                        title: Text('????????????'),
                        value: false,
                        onChanged: (bool? val) {
                          setState(() {
                            isDeathWithinPast12Months = val!;
                            noOfDeaths = 0;
                            noOfDeathsTextController.text = '';
                          });
                        },
                      ),
                      if (isDeathWithinPast12Months)
                        Column(
                          children: [
                            TextField(
                              controller: noOfDeathsTextController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade100, width: 1),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                filled: true,
                                fillColor: Colors.grey.shade100,
                                contentPadding: EdgeInsets.all(10),
                                hintText: '????????? ??????????????? ?????????????????? ???????????? ?????????????',
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (String val) {
                                if (val != '') {
                                  int num = int.parse(val);
                                  if (num > 0)
                                    setState(() {
                                      noOfDeaths = num;
                                    });
                                }
                              },
                            ),
                            SizedBox(height: 10),
                            Column(
                              children: [
                                for (int i = 0; i < noOfDeaths; i++)
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade100,
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        filled: true,
                                        fillColor: Colors.grey.shade100,
                                        contentPadding: EdgeInsets.all(10),
                                        hintText: '???????????? ????????? ${i + 1}',
                                      ),
                                      onSubmitted: (String val) {
                                        deathPersons.add(val);
                                      },
                                      textInputAction: TextInputAction.next,
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
                Step(
                  isActive: _currentStep == 3,
                  title:
                      Text('??????????????????????????? ???????????????', style: TextStyle(fontSize: 18)),
                  content: Column(
                    children: [
                      DataTable(
                        columnSpacing:
                            (MediaQuery.of(context).size.width / 10) * 0.5,
                        dataRowHeight: 80,
                        columns: [
                          DataColumn(
                            label: Text('???????????? ?????????'),
                          ),
                          DataColumn(
                            label: Text('????????????'),
                          ),
                          DataColumn(
                            label: Text(''),
                          ),
                        ],
                        rows: [
                          for (int i = 0; i < _noOfIndividualPerson; i++)
                            DataRow(
                              cells: [
                                DataCell(
                                  Container(
                                    width: (MediaQuery.of(context).size.width /
                                            10) *
                                        3,
                                    child: TextField(),
                                  ),
                                ),
                                DataCell(
                                  Container(
                                    width: (MediaQuery.of(context).size.width /
                                            10) *
                                        1.5,
                                    child: TextField(),
                                  ),
                                ),
                                DataCell(
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.add),
                                        onPressed: () {
                                          setState(() {
                                            _noOfIndividualPerson++;
                                          });
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.remove),
                                        onPressed: () {
                                          setState(() {
                                            if (_noOfIndividualPerson > 1)
                                              _noOfIndividualPerson--;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _tapStep(int step) {
    setState(() => _currentStep = step);
  }

  _continueStep() {
    if (provinceFormKey.currentState!.validate()) {
      if (_currentStep < 3) setState(() => _currentStep += 1);
    }
  }

  _backStep() {
    setState(() => _currentStep -= 1);
  }

  _saveData() {
    final censusData = CensusData()
      ..province = provinceTextController.text
      ..district = districtTextController.text
      ..municipality = municipalityTextController.text
      ..wardNo = int.parse(wardNoTextController.text)
      ..tole = toleTextController.text
      ..familyHeadName = familyHeadNameTextController.text
      ..familyHeadContact = int.parse(familyHeadContactTextController.text)
      ..ownHouse = ownHouse
      ..baseHouseMade = baseHouseMade
      ..drinkingWaterSource = drinkingWaterSource
      ..foodHeatSource = foodHeatSource
      ..lightSource = lightSource
      ..isDeathWithinPast12Months = isDeathWithinPast12Months
      ..noOfDeaths = noOfDeaths
      ..deathPersons = deathPersons
      ..individualDetail = [];

    final box = Boxes.getCensusData();
    box.add(censusData);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Data Added.'),
      duration: Duration(seconds: 2),
    ));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => DashboardScreen(
          ganak: widget.ganak,
        ),
      ),
    );
  }
}
