import 'package:ecensus_nepal/models/options_model.dart';
import 'package:ecensus_nepal/widgets/custom_radio.dart';
import 'package:flutter/material.dart';

import 'package:ecensus_nepal/widgets/single_textfield.dart';

class AddNewDataScreen extends StatefulWidget {
  const AddNewDataScreen({Key? key}) : super(key: key);

  @override
  _AddNewDataScreenState createState() => _AddNewDataScreenState();
}

class _AddNewDataScreenState extends State<AddNewDataScreen> {
  PageController _pageController = PageController();
  int pageIndex = 0;

  var options = [OptionsModel(name: 'name', value: 'value')];

  static const pages = [
    SingleTextField(title: 'प्रदेश', fieldName: 'province'),
    SingleTextField(title: 'जिल्ला', fieldName: 'district'),
    SingleTextField(title: 'गाउपालिका/नगरपालिका', fieldName: 'municipality'),
    SingleTextField(title: 'वडा नं', fieldName: 'wardNo'),
    SingleTextField(title: 'टोल', fieldName: 'tole'),
    SingleTextField(
        title: 'परिवारमूलीको नाम र थर', fieldName: 'familyHeadName'),
    SingleTextField(
        title: 'सम्पर्क टेलिफोन/मोबाईल फोन नं', fieldName: 'familyHeadContact'),
    CustomRadio(
      question: 'तपाईंको परिवारले प्रयोग गरेको घरको स्वामित्व कस्तो हो ?',
      options: [
        OptionsModel(name: 'आफ्नै', value: 'own'),
        OptionsModel(name: 'भाडामा', value: 'rent'),
        OptionsModel(name: 'संस्थागत', value: 'organizational'),
        OptionsModel(name: 'अन्य', value: 'other'),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Data"),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              children: pages,
              onPageChanged: (int index) {
                setState(() {
                  pageIndex = index;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                if (pageIndex != 0)
                  ElevatedButton(
                    child: Text("अगाडि"),
                    onPressed: () {
                      setState(() {
                        pageIndex--;
                      });
                      _pageController.jumpToPage(pageIndex);
                    },
                  ),
                Spacer(),
                if (pageIndex <= pages.length)
                  ElevatedButton(
                    child: Text("पछाडि"),
                    onPressed: () {
                      setState(() {
                        pageIndex++;
                      });
                      _pageController.jumpToPage(pageIndex);
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
