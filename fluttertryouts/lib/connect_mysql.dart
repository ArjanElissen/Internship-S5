// this was the first try to connect to MySQL. After this I learned to use XAMPP to connect to it.


// import 'package:mysql1/mysql1.dart';

// Future<void> connectBase() async {
//   print('Connecting to the database...');

//   var settings = ConnectionSettings(
//     host: '10.0.2.2',
//     port: 3306,
//     user: 'root',
//     password: 'Garnarprif6#',
//     db: 'chatbot',
//   );

//   try {
//     final conn = await MySqlConnection.connect(settings);
//     print('Connected to the database!');

//     try {
//       print('Is this working?');
//       Results result = await conn.query('SELECT * FROM betablokkers LIMIT 1');
//       print(result);

//     for (var row in result) {
//       print('Effects of Carvedilol: ${row['effects']}');
//     }


//     } finally {
//       await conn.close();
//       print('Connection closed.');
//     }
//   } catch (e) {
//     print('Error connecting to the database: $e');
//   }
// }
