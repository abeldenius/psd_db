// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'data_overview.dart';

class Message {
  final String text;
  final String sender;

  Message({required this.text, required this.sender});
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Poul',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
          fontFamily: "IBM"),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'PSF Database'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget buildCustomFormField(
      String labelText, TextEditingController controller) {
    return FormField<String>(
      initialValue: '',
      builder: (FormFieldState<String> state) {
        return SizedBox(
          width: 400,
          height: 60,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: labelText,
              errorText: state.hasError ? state.errorText : null,
            ),
          ),
        );
      },
    );
  }

  final _formKey = GlobalKey<FormState>();
  bool showEmailFields = false;
  Map<String, TextEditingController> controllers = {
    'Sagsnummer': TextEditingController(),
    'Mærke': TextEditingController(),
    'Model': TextEditingController(),
    'Serienummer': TextEditingController(),
    'Afsender': TextEditingController(),
    'Modtager': TextEditingController(),
    'Eventuelle noter': TextEditingController(),
    'Lokation for opbevaring': TextEditingController(),
    'Størrelse': TextEditingController(),
  };

  String? _selectedValue = "Computer (C)";

  @override
  void initState() {
    super.initState();
    if (showEmailFields) {
      controllers['Email'] = TextEditingController();
      controllers['Password'] = TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> items = [
      "Computer (C)",
      "Bærbar (B)",
      "Android (A)",
      "iPhone (I)",
      "Tablet (T)",
      "iPad (iP)",
      "Stationær (S)",
      "USB (U)",
      "HDD (HDD)",
      "SSD (SSD)",
      "Email (EM)",
      "Server (SSH)"
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        // Add your drawer items here
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Text(
                'Oversigt',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              title: const Text(
                'Dataoversigt',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DataOverviewPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
          child: Form(
        key: _formKey,
        child: Column(
          children: [
            buildCustomFormField('Sagsnummer', controllers["Sagsnummer"]!),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 400,
              height: 60,
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enhed',
                ),
                value: _selectedValue,
                items: items.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedValue = newValue;
                    showEmailFields = (_selectedValue == "Email (EM)");
                    if (showEmailFields) {
                      controllers['Email'] = TextEditingController();
                      controllers['Password'] = TextEditingController();
                    } else {
                      controllers.remove('Email');
                      controllers.remove('Password');
                    }
                  });
                },
              ),
            ),
            if (showEmailFields) const SizedBox(height: 10),
            if (showEmailFields)
              buildCustomFormField('Email', controllers['Email']!),
            if (showEmailFields) const SizedBox(height: 10),
            if (showEmailFields)
              buildCustomFormField('Password', controllers['Password']!),
            const SizedBox(
              height: 10,
            ),
            if (!showEmailFields) ...[
              buildCustomFormField('Mærke', controllers["Mærke"]!),
              const SizedBox(
                height: 10,
              ),
            ],
            if (!showEmailFields) ...[
              buildCustomFormField('Model', controllers["Model"]!),
              const SizedBox(
                height: 10,
              )
            ],
            if (!showEmailFields) ...[
              buildCustomFormField('Serienummer', controllers["Serienummer"]!),
              const SizedBox(
                height: 10,
              )
            ],
            if (!showEmailFields) ...[
              buildCustomFormField('Afsender', controllers["Afsender"]!),
              const SizedBox(
                height: 10,
              )
            ],
            buildCustomFormField('Modtager', controllers["Modtager"]!),
            const SizedBox(
              height: 10,
            ),
            buildCustomFormField(
                'Eventuelle noter', controllers["Eventuelle noter"]!),
            const SizedBox(
              height: 10,
            ),
            buildCustomFormField('Størrelse/brugt', controllers["Størrelse"]!),
            const SizedBox(
              height: 10,
            ),
            buildCustomFormField('Lokation for opbevaring',
                controllers["Lokation for opbevaring"]!),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                  Map<String, String> data = {};

                  controllers.forEach((key, controller) {
                    data[key] = controller.text;
                    if (data[key]!.isEmpty) {
                      data[key] = 'N/A';
                    }
                  });

                  if (!controllers.containsKey("Email")) {
                    data['Email'] = 'N/A';
                  }
                  if (!controllers.containsKey("Password")) {
                    data['Password'] = 'N/A';
                  }
                  data['Enhed'] = _selectedValue!;

                  final response = await http.post(
                    Uri.parse('http://127.0.0.1:8000/receive_texts/'),
                    headers: {'Content-Type': 'application/json'},
                    body: jsonEncode(data),
                  );

                  if (response.statusCode == 200) {
                    print('Success');
                  } else {
                    print('Failed');
                  }
                }
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.hovered)) {
                      return Colors.greenAccent; // Hover color
                    }
                    return Colors.black
                        .withOpacity(0.8); // Default, not hovered.
                  }),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                      const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ))),
              child: const Text('Indsæt'),
            ),
          ],
        ),
      )),
    );
  }
}
