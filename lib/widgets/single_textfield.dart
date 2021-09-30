import 'package:ecensus_nepal/models/census_model.dart';
import 'package:ecensus_nepal/providers/census_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SingleTextField extends StatelessWidget {
  final String title;
  final String fieldName;
  final TextEditingController textController;
  final GlobalKey<FormState> formKey;

  const SingleTextField(
      {Key? key,
      required this.title,
      required this.fieldName,
      required this.textController,
      required this.formKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: textController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade100, width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: EdgeInsets.all(10),
              ),
              autofocus: true,
              validator: (String? val) {
                if (val == '') return "Required";
                return null;
              },
              onChanged: (String val) {
                if (fieldName == 'province')
                  context.read(censusDataProvider).state =
                      Census().copyWith(province: val);
                if (fieldName == 'district')
                  context.read(censusDataProvider).state =
                      Census().copyWith(district: val);
                if (fieldName == 'municipality')
                  context.read(censusDataProvider).state =
                      Census().copyWith(municipality: val);
                if (fieldName == 'wardNo')
                  context.read(censusDataProvider).state =
                      Census().copyWith(wardNo: int.parse(val));
                if (fieldName == 'tole')
                  context.read(censusDataProvider).state =
                      Census().copyWith(tole: val);
                if (fieldName == 'familyHeadName')
                  context.read(censusDataProvider).state =
                      Census().copyWith(familyHeadName: val);
                if (fieldName == 'familyHeadContact')
                  context.read(censusDataProvider).state =
                      Census().copyWith(familyHeadContact: int.parse(val));
              },
            ),
          ],
        ),
      ),
    );
  }
}
