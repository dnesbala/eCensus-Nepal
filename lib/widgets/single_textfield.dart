import 'package:flutter/material.dart';

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
              style: TextStyle(fontSize: 16),
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
              keyboardType:
                  fieldName == 'wardNo' || fieldName == 'familyHeadContact'
                      ? TextInputType.number
                      : TextInputType.text,
            ),
          ],
        ),
      ),
    );
  }
}
