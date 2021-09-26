import 'package:ecensus_nepal/models/options_model.dart';
import 'package:flutter/material.dart';

class CustomRadio extends StatefulWidget {
  final String question;
  final List<OptionsModel> options;

  const CustomRadio({Key? key, required this.question, required this.options})
      : super(key: key);

  @override
  _CustomRadioState createState() => _CustomRadioState();
}

class _CustomRadioState extends State<CustomRadio> {
  String? _groupValue = '';

  @override
  void initState() {
    _groupValue = widget.options[0].value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Text(widget.question, style: TextStyle(fontSize: 20)),
          ...widget.options.map((op) => RadioListTile(
                groupValue: _groupValue,
                title: Text(op.name),
                value: op.value,
                onChanged: (String? val) {
                  setState(() {
                    _groupValue = val;
                  });
                },
              )),
        ],
      ),
    );
  }
}
