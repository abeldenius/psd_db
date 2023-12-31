import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Map<String, dynamic>>> fetchData() async {
  final response = await http.get(
    Uri.parse('http://127.0.0.1:8000/fetch/'),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
    // Parse the response JSON into a List of Map<String, dynamic>
    final List<dynamic> responseData = jsonDecode(response.body);
    final List<Map<String, dynamic>> data =
        responseData.cast<Map<String, dynamic>>();
    return data;
  } else {
    throw Exception('Failed to load data');
  }
}

class DataOverviewPage extends StatelessWidget {
  late Future<List<Map<String, dynamic>>> futureData;

  DataOverviewPage() {
    futureData = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dataoversigt'),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black.withOpacity(0.5))),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: futureData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Text('No data available.');
                } else {
                  final data = snapshot.data!;

                  // Create rows based on the fetched data
                  final rows =
                      data.map<DataRow>((Map<String, dynamic> rowData) {
                    final cells = rowData.keys.map<DataCell>((String key) {
                      return DataCell(Text(rowData[key].toString()));
                    }).toList();
                    return DataRow(cells: cells);
                  }).toList();

                  return DataTable(
                    columnSpacing: 15,
                    columns: const [
                      DataColumn(label: Text('Sagsnummer')),
                      DataColumn(label: Text('Enhed')),
                      DataColumn(label: Text('Mærke')),
                      DataColumn(label: Text('Model')),
                      DataColumn(label: Text('Serienummer')),
                      DataColumn(label: Text('ID')),
                      DataColumn(label: Text('Afsender')),
                      DataColumn(label: Text('Modtager')),
                      DataColumn(label: Text('Noter')),
                      DataColumn(label: Text('Tid')),
                      DataColumn(label: Text('Mail')),
                      DataColumn(label: Text('Password')),
                      DataColumn(label: Text('Størrelse')),
                      DataColumn(label: Text('Lokation')),
                    ],
                    rows: rows,
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
