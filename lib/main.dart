import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final Random random = Random();

  String getRandomRiskLevel() {
    List<String> riskLevels = ['Bajo', 'Medio', 'Alto'];
    int randomIndex = random.nextInt(riskLevels.length);
    return 'Nivel de Riesgo: ${riskLevels[randomIndex]}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Color(0xFF001A5F),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Hoy, ${_getFormattedDate()}'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemExtent: 120.0,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegistroScreen(),
                        ),
                      );
                    },
                    child: Card(
                      child: ListTile(
                        title: Text('SAVEWAT'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(getRandomRiskLevel()),
                            SizedBox(height: 8),
                            Text('Por favor, revise constantemente los registros para evitar desastres'),
                          ],
                        ),
                        trailing: Text('Hace ${index * 5} minutos'),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _getFormattedDate() {
    DateTime now = DateTime.now();
    String formattedDate = "${_getDayOfWeek(now.weekday)}  ${now.day} de ${_getMonthName(now.month)}";
    return formattedDate;
  }

  String _getDayOfWeek(int dayOfWeek) {
    List<String> daysOfWeek = ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'];
    return daysOfWeek[dayOfWeek - 1];
  }

  String _getMonth(int month) {
    return (month < 10) ? '0$month' : '$month';
  }

  String _getMonthName(int month) {
    List<String> monthNames = [
      'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'
    ];
    return monthNames[month - 1];
  }
}

class RegistroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registros'),
        backgroundColor: Color(0xFF001A5F),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Image.asset(
                  'assets/mapa_arequipa.jpg', // Reemplaza con el nombre de tu imagen
                  fit: BoxFit.cover,
                  height: 200.0,
                ),
                SizedBox(height: 16.0),
                DataTable(
                  columns: [
                    DataColumn(label: Text('Día')),
                    DataColumn(label: Text('Temperatura')),
                    DataColumn(label: Text('Precipitación (mm)')),
                    DataColumn(label: Text('ETc')),
                    DataColumn(label: Text('ETo')),
                    DataColumn(label: Text('Kc')),
                    DataColumn(label: Text('Humedad')),
                    DataColumn(label: Text('Agua Aplicada(L)')),
                    DataColumn(label: Text('Duración Riesgo(min)')),
                    DataColumn(label: Text('Etapa')),
                    DataColumn(label: Text('Riesgos')),
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(Text('Lunes')),
                      DataCell(Text('25°C')),
                      DataCell(Text('3.5 mm')),
                      DataCell(Text('0.8')),
                      DataCell(Text('1.0')),
                      DataCell(Text('0.85')),
                      DataCell(Text('75%')),
                      DataCell(Text('10 L')),
                      DataCell(Text('30 min')),
                      DataCell(Text('Etapa 1')),
                      DataCell(Text('Alto')),
                    ]),
                    // Agrega más filas según sea necesario
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Por favor, revise constantemente los registros para evitar desastres'),
          ),
        ],
      ),
    );
  }
}
