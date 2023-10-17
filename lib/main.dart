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
  final TextEditingController _controller = TextEditingController();
  final List<Message> messages = [];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 600,
              height: 800,
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 600),
                      child: TextField(
                        style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 12,
                            color: Colors.black),
                        maxLines: null,
                        controller: TextEditingController()
                          ..text = messages[index].text,
                        enabled: false, // Makes it read-only
                        decoration: InputDecoration(
                          labelText: messages[index].sender,
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            isLoading
                ? const CircularProgressIndicator()
                : const SizedBox.shrink(),
            const Spacer(),
            Container(
              padding: const EdgeInsets.only(bottom: 50.0),
              width: 600,
              child: TextField(
                controller: _controller,
                onSubmitted: (text) async {
                  setState(() {
                    isLoading = true;
                  });
                  // var response = await onEnter(
                  //     text); // Assuming onEnter returns the bot's response // Replace with your own logic
                  setState(() {
                    isLoading = false;
                    messages.add(Message(text: text, sender: 'Bruger'));
                    messages.add(Message(text: text, sender: 'Poul'));
                  });
                  _controller.clear();
                },
                decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.send),
                  border: OutlineInputBorder(),
                  labelText: 'Hvad kan jeg hjælpe med?',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
