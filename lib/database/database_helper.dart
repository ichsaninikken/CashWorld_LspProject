import 'package:get_storage/get_storage.dart';
import 'package:cash_world/widgets/cashflow.dart';
import 'package:cash_world/utils/hash_password.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static const _databaseName = 'me_database.db';
  static const _databaseVersion = 1;
  final box = GetStorage();

  Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Menginisialisasi database
  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Create tabel pengguna
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY,
        username TEXT NOT NULL,
        password TEXT NOT NULL
      )
    ''');

    // Create tabel cashflow
    await db.execute('''
    CREATE TABLE cashflow (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      user_id INTEGER NOT NULL,
      date DATE NOT NULL,
      nominal INTEGER NOT NULL,
      description TEXT,
      status TEXT NOT NULL
    )
    ''');
  }

  Future<void> addUser(String username, String password) async {
    final db = await instance.database;
    await db.insert(
      'users',
      {
        'username': username,
        'password': password,
      },
    );
  }

  Future<bool> login(String username, String password) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> users = await db.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );

    if (users.isNotEmpty) {
      final storedPassword = users[0]['password'] as String;
      final hashedPassword = HashPassword(password);

      if (storedPassword == hashedPassword) {
        final id = users[0]['id'] as int; // Mengambil ID
        final box = GetStorage(); // Inisialisasi 

        // Menyimpan ID 
        box.write("user_id", id);
        box.write("username", username);

        return true; // Login berhasil
      }
    }

    return false;
  }

  // Menambah catatan cash flow
  Future<int?> insertCashflow(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert('cashflow', row);
  }

  // Mengambil catatan transaksi dari pengguna yang sedang login
  Future<List<CashFlow>> getCashflows() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'cashflow',
      where: 'user_id = ?',
      whereArgs: [box.read('user_id')],
    );

    return List.generate(maps.length, (i) {
      return CashFlow(
        id: maps[i]['id'],
        user_id: maps[i]['user_id'],
        date: maps[i]['date'],
        nominal: maps[i]['nominal'],
        description: maps[i]['description'],
        status: maps[i]['status'], 
      );
    });
  }

  // Mengambil catatan transaksi berdasarkan bulan dan tahun saat ini
  Future<List<CashFlow>> getCashflowsByMonth() async {
    final db = await instance.database;
    final now = DateTime.now();
    final currentMonth = now.month;
    final currentYear = now.year;

    final List<Map<String, dynamic>> maps = await db.query(
      'cashflow',
      where: 'user_id = ? AND date LIKE ?',
      whereArgs: [box.read('user_id'), "%-$currentMonth-$currentYear"],
    );
    return List.generate(maps.length, (i) {
      return CashFlow(
        id: maps[i]['id'],
        user_id: maps[i]['user_id'],
        date: maps[i]['date'],
        nominal: maps[i]['nominal'],
        description: maps[i]['description'],
        status: maps[i]['status'], 
      );
    });
  }
}
