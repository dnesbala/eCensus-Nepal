import 'package:ecensus_nepal/models/ganak_model.dart';
import 'package:ecensus_nepal/models/options_model.dart';
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

  var ownHouse = "other";
  var baseHouseMade = "";
  var drinkingWaterSource = "";
  var foodHeatSource = "";
  var lightSource = "";

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
                      Text("परिचयात्मक खण्ड", style: TextStyle(fontSize: 18)),
                  content: Column(
                    children: [
                      SingleTextField(
                        title: 'प्रदेश',
                        fieldName: 'province',
                        textController: provinceTextController,
                        formKey: provinceFormKey,
                      ),
                      SingleTextField(
                        title: 'जिल्ला',
                        fieldName: 'district',
                        textController: districtTextController,
                        formKey: districtFormKey,
                      ),
                      SingleTextField(
                        title: 'गाउपालिका / नगरपालिका',
                        fieldName: 'municiaplity',
                        textController: municipalityTextController,
                        formKey: municipalityFormKey,
                      ),
                      SingleTextField(
                        title: 'वडा नं',
                        fieldName: 'wardNo',
                        textController: wardNoTextController,
                        formKey: wardNoFormKey,
                      ),
                      SingleTextField(
                        title: 'टोल',
                        fieldName: 'tole',
                        textController: toleTextController,
                        formKey: toleFormKey,
                      ),
                      SingleTextField(
                        title: 'घरमूलीको नाम',
                        fieldName: 'familyHeadName',
                        textController: familyHeadNameTextController,
                        formKey: familyHeadNameFormKey,
                      ),
                      SingleTextField(
                        title: 'घरमूलीको सम्पर्क नम्बर',
                        fieldName: 'familyHeadContact',
                        textController: familyHeadContactTextController,
                        formKey: familyHeadContactFormKey,
                      ),
                    ],
                  ),
                ),
                Step(
                  isActive: _currentStep == 1,
                  title: Text("पारिवारिक खण्ड", style: TextStyle(fontSize: 18)),
                  content: Column(
                    children: [
                      CustomRadio(
                        question:
                            'तपाईंको परिवारले प्रयोग गरेको घरको स्वामित्व कस्तो हो ?',
                        options: [
                          OptionsModel(name: 'आफ्नै', value: 'own'),
                          OptionsModel(name: 'भाडामा', value: 'rent'),
                          OptionsModel(
                              name: 'संस्थागत', value: 'organizational'),
                          OptionsModel(name: 'अन्य', value: 'other'),
                        ],
                        onSelectItem: (String val) => ownHouse = val,
                      ),
                      Divider(),
                      CustomRadio(
                        question:
                            'तपाईंको परिवारले प्रयोग गरेको घरको जग कस्तो छ?',
                        options: [
                          OptionsModel(name: 'माटोको जोडाई भएको', value: 'mud'),
                          OptionsModel(
                              name: 'ईटा/ढुङ्गा, सिमेन्टको जोडाई भएको',
                              value: 'concretePillar'),
                          OptionsModel(
                              name: 'जस्ता पाताको', value: 'metalFrame'),
                          OptionsModel(
                              name: 'काठको खम्बा गाडेको', value: 'wood'),
                          OptionsModel(name: 'अन्य', value: 'other'),
                        ],
                        onSelectItem: (String val) => baseHouseMade = val,
                      ),
                      Divider(),
                      CustomRadio(
                        question:
                            'तपाईंको परिवारले खानेपानीको मुख्य स्रोत कुन हो?',
                        options: [
                          OptionsModel(
                              name: 'धारा/पाइप(घर परिसर भित्र)', value: 'tap'),
                          OptionsModel(
                              name: 'खुला इनार/कुवा, मुल धारा', value: 'well'),
                          OptionsModel(name: 'नदी/खोला', value: 'river'),
                          OptionsModel(name: ' जार/बोत्तल', value: 'jar'),
                          OptionsModel(name: 'अन्य', value: 'other'),
                        ],
                        onSelectItem: (String val) => ownHouse = val,
                      ),
                      Divider(),
                      CustomRadio(
                        question:
                            ' तपाईको परिवारमा खाना पकाउन अक्सर(मुख्यरुपमा) कुन इन्धन प्रयोग गर्नुहुन्छ?',
                        options: [
                          OptionsModel(name: 'काठ/दाउरा', value: 'wood'),
                          OptionsModel(name: 'एल.पी ग्याँस', value: 'gas'),
                          OptionsModel(
                              name: 'बिजुली', value: 'electricAppliances'),
                          OptionsModel(name: 'अन्य', value: 'other'),
                        ],
                        onSelectItem: (String val) => ownHouse = val,
                      ),
                      Divider(),
                      CustomRadio(
                        question:
                            ' तपाईको परिवारमा बत्ती बाल्न अक्सर (मुख्य रुपमा) के प्रयोग गर्नुहुन्छ?',
                        options: [
                          OptionsModel(name: 'बिजुली', value: 'electricity'),
                          OptionsModel(
                              name: 'सोलार/सौर्ययर्जा', value: 'solar'),
                          OptionsModel(name: 'बायोग्याँस', value: 'biogas'),
                          OptionsModel(name: 'मट्टीतेल', value: 'kerosene'),
                          OptionsModel(name: 'अन्य', value: 'other'),
                        ],
                        onSelectItem: (String val) => ownHouse = val,
                      ),
                    ],
                  ),
                ),
                Step(
                  isActive: _currentStep == 2,
                  title: Text("मृत्यु विवरण", style: TextStyle(fontSize: 18)),
                  content: Column(
                    children: [
                      Text(
                          'गत १२ महिनामा तपाईंको परिवारमा कसैको मृत्यु भएको थियो?',
                          style: TextStyle(fontSize: 20)),
                      RadioListTile<bool>(
                        groupValue: isDeathWithinPast12Months,
                        title: Text('थियो'),
                        value: true,
                        onChanged: (bool? val) {
                          setState(() {
                            isDeathWithinPast12Months = val!;
                          });
                        },
                      ),
                      RadioListTile<bool>(
                        groupValue: isDeathWithinPast12Months,
                        title: Text('थिएन'),
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
                                hintText: 'कति जनाको मृत्यु भएको थियो?',
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
                                        hintText: 'मृतक नाम ${i + 1}',
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
                      Text('व्यक्तिगत विवरण', style: TextStyle(fontSize: 18)),
                  content: Column(
                    children: [
                      DataTable(
                        columnSpacing:
                            (MediaQuery.of(context).size.width / 10) * 0.5,
                        dataRowHeight: 80,
                        columns: [
                          DataColumn(
                            label: Text('पुरा नाम'),
                          ),
                          DataColumn(
                            label: Text('नाता'),
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
    print(provinceTextController.text);
    print(districtTextController.text);
    print(baseHouseMade);
    print(noOfDeaths);
    print(deathPersons);
  }
}
