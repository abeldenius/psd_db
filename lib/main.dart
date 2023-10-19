// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
      home: MyHomePage(title: 'PSF Database'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});
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
  List<TextEditingController> controllers =
      List.generate(7, (index) => TextEditingController());
  String? _selectedValue;

  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }

    super.dispose();
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
      body: Center(
          child: Form(
        key: _formKey,
        child: Column(
          children: [
            buildCustomFormField('Sagsnummer', controllers[0]),
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
                  });
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            buildCustomFormField('Mærke', controllers[1]),
            const SizedBox(
              height: 10,
            ),
            buildCustomFormField('Model', controllers[2]),
            const SizedBox(
              height: 10,
            ),
            buildCustomFormField('Serienummer', controllers[3]),
            const SizedBox(
              height: 10,
            ),
            buildCustomFormField('Afsender', controllers[4]),
            const SizedBox(
              height: 10,
            ),
            buildCustomFormField('Modtager', controllers[5]),
            const SizedBox(
              height: 10,
            ),
            buildCustomFormField('Eventuelle noter', controllers[6]),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                  List<String> data = [];

                  for (var controller in controllers) {
                    data.add(controller.text);
                  }
                  data.add(_selectedValue!);

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
