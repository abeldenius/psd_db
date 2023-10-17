import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyForm(),
    );
  }
}

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _value = "";
  String _device = "";
  String _manufacturer = "";
  String _model = "";
  String _serialNumber = "";
  String _newDeviceId = "";
  DateTime _receivedDate = DateTime.now();
  String _responsible = "";
  String _notes = "";
  TimeOfDay _time = TimeOfDay.now();
  String _email = "";
  String _password = "";
  String _location = "";
  String _caseComment = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Form Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Value'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a value';
                  }
                  return null;
                },
                onSaved: (value) {
                  _value = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Device'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a device';
                  }
                  return null;
                },
                onSaved: (value) {
                  _device = value!;
                },
              ),
              // Repeat similar TextFormField widgets for other fields

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Now you can use the values entered in your form
                    // For example, you can print them to the console
                    print('Value: $_value');
                    print('Device: $_device');
                    // Print other fields as well
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
