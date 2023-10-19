// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

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
      List.generate(8, (index) => TextEditingController());
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
            buildCustomFormField('Sagsnummer', controllers[1]),
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
            buildCustomFormField('Mærke', controllers[2]),
            const SizedBox(
              height: 10,
            ),
            buildCustomFormField('Model', controllers[3]),
            const SizedBox(
              height: 10,
            ),
            buildCustomFormField('Serienummer', controllers[4]),
            const SizedBox(
              height: 10,
            ),
            buildCustomFormField('Afsender', controllers[5]),
            const SizedBox(
              height: 10,
            ),
            buildCustomFormField('Modtager', controllers[6]),
            const SizedBox(
              height: 10,
            ),
            buildCustomFormField('Eventuelle noter', controllers[7]),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                  for (var controller in controllers) {
                    print(controller.text);
                  }
                  print(_selectedValue);
                }
              },
              child: const Text('Indsæt'),
            ),
          ],
        ),
      )),
    );
  }
}
