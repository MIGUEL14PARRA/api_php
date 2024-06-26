import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AnfibiosScreen extends StatefulWidget {
  @override
  _AnfibiosScreenState createState() => _AnfibiosScreenState();
}

class _AnfibiosScreenState extends State<AnfibiosScreen> {
  List anfibios = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAnfibios();
  }

  Future<void> fetchAnfibios() async {
    final response =
        await http.get(Uri.parse('http://localhost/consulta_anfibios.php'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        anfibios = data['registros'].map((anfibio) {
          return {
            'nombre': anfibio['nombre'] ?? '',
            'nombre_cientifico': anfibio['nombre_cientifico'] ?? '',
            'veneno': anfibio['veneno'] ?? '',
            'habitos': anfibio['habitos'] ?? '',
            'habitat': anfibio['habitat'] ?? '',
          };
        }).toList();
        isLoading = false;
      });
    } else {
      print('Error al cargar los datos');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de reptiles')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: anfibios.isEmpty
                  ? Center(child: Text('No se encontraron datos'))
                  : DataTable(
                      columns: [
                        DataColumn(label: Text('Nombre')),
                        DataColumn(label: Text('Nombre Científico')),
                        DataColumn(label: Text('Veneno')),
                        DataColumn(label: Text('Hábitos')),
                        DataColumn(label: Text('Hábitat')),
                      ],
                      rows: anfibios.map((anfibio) {
                        return DataRow(cells: [
                          DataCell(Text(anfibio['nombre'])),
                          DataCell(Text(anfibio['nombre_cientifico'])),
                          DataCell(Text(anfibio['veneno'])),
                          DataCell(Text(anfibio['habitos'])),
                          DataCell(Text(anfibio['habitat'])),
                        ]);
                      }).toList(),
                    ),
            ),
    );
  }
}
