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
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  final TextEditingController _controller4 = TextEditingController();
  final TextEditingController _controller5 = TextEditingController();
  final TextEditingController _controller6 = TextEditingController();
  final TextEditingController _controller7 = TextEditingController();
  final TextEditingController _controller8 = TextEditingController();
  final TextEditingController _controller9 = TextEditingController();
  final TextEditingController _controller10 = TextEditingController();
  final TextEditingController _controller11 = TextEditingController();
  final TextEditingController _controller12 = TextEditingController();
  String? _selectedValue;

  void dispose() {
    _controller.dispose();
    _controller2.dispose();
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
            FormField<String>(
              // Initialize FormField value.
              initialValue: '',
              // Provide a builder function to create your custom widget.
              builder: (FormFieldState<String> state) {
                return Container(
                  width: 400,
                  height: 60,
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Sagsnummer',
                      errorText: state.hasError ? state.errorText : null,
                    ),
                  ),
                );
              },
            ),
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
            FormField<String>(
              // Initialize FormField value.
              initialValue: '',
              // Provide a builder function to create your custom widget.
              builder: (FormFieldState<String> state) {
                return Container(
                  width: 400,
                  height: 60,
                  child: TextField(
                    controller: _controller2,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Mærke',
                      errorText: state.hasError ? state.errorText : null,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                  print(_controller.text);
                  print(_selectedValue);
                }
              },
              child: const Text('Gem'),
            ),
          ],
        ),
      )),
    );
  }
}
