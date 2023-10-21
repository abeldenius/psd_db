import 'package:flutter/material.dart';

class DataOverviewPage extends StatelessWidget {
  const DataOverviewPage({super.key});

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
            child: DataTable(
              columnSpacing: 15,
              columns: const <DataColumn>[
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
              rows: <DataRow>[
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('001')),
                    DataCell(Text('Computer')),
                    DataCell(Text('Apple')),
                    DataCell(Text('MacBook Air')),
                    DataCell(Text('SN123456')),
                    DataCell(Text('ID001')),
                    DataCell(Text('Alice')),
                    DataCell(Text('Bob')),
                    DataCell(Text('No issues')),
                    DataCell(Text('12:00')),
                    DataCell(Text('alice@email.com')),
                    DataCell(Text('****')),
                    DataCell(Text('Medium')),
                    DataCell(Text('Shelf 1')),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('002')),
                    DataCell(Text('Phone')),
                    DataCell(Text('Samsung')),
                    DataCell(Text('Galaxy S10')),
                    DataCell(Text('SN789012')),
                    DataCell(Text('ID002')),
                    DataCell(Text('Charlie')),
                    DataCell(Text('David')),
                    DataCell(Text('Needs repair')),
                    DataCell(Text('1:00')),
                    DataCell(Text('charlie@email.com')),
                    DataCell(Text('****')),
                    DataCell(Text('Small')),
                    const DataCell(Text('Shelf 2')),
                  ],
                ),
                // Add more rows here
              ],
            ),
          ),
        ),
      ),
    );
  }
}
