import 'package:testkey/database/database_helper.dart';

void main() async {
  final dbHelper = DatabaseHelper();

  final db = await dbHelper.database;

  // Insert data
  await db.insert('users', {
    'name': 'John Doe',
    'email': '5fX8Y@example.com',
  });

  // Query data
  final users = await db.query('users');
  print(users);

  // Update data
  await db.update(
    'users',
    {
      'name': 'Jane Doe',
    },
    where: 'id = ?',
    whereArgs: [1],
  );

  // Delete data
  await db.delete('users', where: 'id = ?', whereArgs: [1]);
}
