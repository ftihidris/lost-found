import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;

    // If _database is null, initialize it
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    // Get the application documents directory
    final documentsDirectory = await getDatabasesPath();
    final path = join(documentsDirectory, 'createad_database.db');

    // Create or open the database at the specified path
    return await openDatabase(path, version: 1, onCreate: _createTable);
  }

  Future<void> _createTable(Database db, int version) async {
    // Create the 'createad' table with the desired columns
    await db.execute('''
      CREATE TABLE createad(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        category TEXT,
        title TEXT,
        description TEXT,
        location TEXT,
        imageUrls TEXT
      )
    ''');
  }

  Future<int> insert(Createad createad) async {
    // Get a reference to the database
    final db = await instance.database;

    // Insert the 'createad' into the correct table
    return await db.insert('createad', createad.toMap());
  }

  Future<List<Createad>> getAllCreateads() async {
    // Get a reference to the database
    final db = await instance.database;

    // Get all the 'createad' from the table
    final List<Map<String, dynamic>> maps = await db.query('createad');

    // Convert the List<Map> to List<Createad>
    return List.generate(maps.length, (i) {
      return Createad.fromMap(maps[i]);
    });
  }
}

class Createad {
  int? id;
  String? category;
  String? title;
  String? description;
  String? location;
  List<String>? imageUrls;

  Createad({
    this.id,
    this.category,
    this.title,
    this.description,
    this.location,
    this.imageUrls,
  });

  // Convert the 'createad' object to a map (key-value pairs)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'title': title,
      'description': description,
      'location': location,
      'imageUrls': imageUrls?.join(','),
    };
  }

  // Convert the map (key-value pairs) to a 'createad' object
  static Createad fromMap(Map<String, dynamic> map) {
    return Createad(
      id: map['id'],
      category: map['category'],
      title: map['title'],
      description: map['description'],
      location: map['location'],
      imageUrls: (map['imageUrls'] as String?)?.split(','),
    );
  }
}
