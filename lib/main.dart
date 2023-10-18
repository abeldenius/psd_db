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
  String? _selectedValue;

  void dispose() {
    _controller.dispose();
    _controller2.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            Container(
              width: 400,
              height: 60,
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Enhed',
                ),
                value: _selectedValue,
                items: const [
                  DropdownMenuItem(
                    child: Text("Computer (C)"),
                    value: "Computer (C)",
                  ),
                  DropdownMenuItem(
                    child: Text("Bærbar (B)"),
                    value: "Bærbar (B)",
                  ),
                  DropdownMenuItem(
                    child: Text("Bærbar (B)"),
                    value: "Bærbar (B)",
                  ),
                  DropdownMenuItem(
                    child: Text("Android (A)"),
                    value: "Android (A)",
                  ),
                  DropdownMenuItem(
                    child: Text("iPhone (I)"),
                    value: "iPhone (I)",
                  ),
                  DropdownMenuItem(
                    child: Text("Bærbar (B)"),
                    value: "Bærbar (B)",
                  ),
                  DropdownMenuItem(
                    child: Text("Bærbar (B)"),
                    value: "Bærbar (B)",
                  ),
                  DropdownMenuItem(
                    child: Text("Bærbar (B)"),
                    value: "Bærbar (B)",
                  ),
                  DropdownMenuItem(
                    child: Text("Bærbar (B)"),
                    value: "Bærbar (B)",
                  ),
                  DropdownMenuItem(
                    child: Text("Bærbar (B)"),
                    value: "Bærbar (B)",
                  ),
                  DropdownMenuItem(
                    child: Text("Bærbar (B)"),
                    value: "Bærbar (B)",
                  ),
                  DropdownMenuItem(
                    child: Text("Bærbar (B)"),
                    value: "Bærbar (B)",
                  )

                  // Add more items here
                ],
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedValue = newValue;
                  });
                },
              ),
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
