import 'dart:async';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE posts(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        content TEXT
      )
    ''');
  }

  Future<void> insertUser(String name) async {
    final db = await database;
    await db.insert('users', {'name': name});
  }

  Future<void> insertPost(String title, String content) async {
    final db = await database;
    await db.insert('posts', {'title': title, 'content': content});
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await database;
    return await db.query('users');
  }

  Future<List<Map<String, dynamic>>> getPosts() async {
    final db = await database;
    return await db.query('posts');
  }

  Future<void> savePostToFile(String title, String content) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File(join(directory.path, 'posts.txt'));
    await file.writeAsString('$title\n$content\n\n', mode: FileMode.append);
  }

  Future<String> readPostsFromFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File(join(directory.path, 'posts.txt'));

    if (await file.exists()) {
      return await file.readAsString();
    } else {
      return 'No posts available';
    }
  }

  Database? _database;

  // Future<Database> _initDatabase() async {
  //   String path = join(await getDatabasesPath(), 'user_data.db');
  //   return await openDatabase(
  //     path,
  //     version: 1,
  //     onCreate: (db, version) {
  //       return db.execute(
  //         "CREATE TABLE user(id INTEGER PRIMARY KEY, name TEXT, username TEXT, email TEXT, phoneNumber TEXT, imagePath TEXT)",
  //       );
  //     },
  //   );
  // }

  // Future<void> insertUser(Map<String, dynamic> user) async {
  //   final db = await database;
  //   await db.insert('user', user, conflictAlgorithm: ConflictAlgorithm.replace);
  // }

  Future<Map<String, dynamic>?> getUser() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('user');
    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }

  Future<void> close() async {
    final db = await database;
    db.close();
  }
}

// class DatabaseHelper2 {
//   static final DatabaseHelper2 instance = DatabaseHelper2._instance();
//   static Database? _db;

//   DatabaseHelper2._instance();

//   String postsTable = 'posts_table';
//   String colId = 'id';
//   String colText = 'text';
//   String colImagePath = 'imagePath';
//   String colVideoPath = 'videoPath';
//   String colIsLiked = 'isLiked';
//   String colLikeCount = 'likeCount';
//   String colComments = 'comments';

//   Future<Database?> get db async {
//     _db ??= await _initDb();
//     return _db;
//   }

//   Future<Database> _initDb() async {
//     Directory dir = await getApplicationDocumentsDirectory();
//     String path = join(dir.path, 'posts.db');
//     final postsDb = await openDatabase(
//       path,
//       version: 1,
//       onCreate: _createDb,
//     );
//     return postsDb;
//   }

//   void _createDb(Database db, int version) async {
//     await db.execute(
//       'CREATE TABLE $postsTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colText TEXT, $colImagePath TEXT, $colVideoPath TEXT, $colIsLiked INTEGER, $colLikeCount INTEGER, $colComments TEXT)',
//     );
//   }

//   Future<List<Map<String, dynamic>>> getPostMapList() async {
//     Database? db = await this.db;
//     final List<Map<String, dynamic>> result = await db!.query(postsTable);
//     return result;
//   }

//   Future<int> insertPost(Posts post) async {
//     Database? db = await this.db;
//     final int result = await db!.insert(postsTable, post.toMap());
//     return result;
//   }

//   Future<int> updatePost(Posts post) async {
//     Database? db = await this.db;
//     final int result = await db!.update(
//       postsTable,
//       post.toMap(),
//       where: '$colId = ?',
//       whereArgs: [post.id],
//     );
//     return result;
//   }

//   Future<int> deletePost(int id) async {
//     Database? db = await this.db;
//     final int result = await db!.delete(
//       postsTable,
//       where: '$colId = ?',
//       whereArgs: [id],
//     );
//     return result;
//   }

//   getApplicationDocumentsDirectory() {}
// }

// class Posts {
//   int? id;
//   String? text;
//   String? imagePath;
//   String? videoPath;
//   bool isLiked;
//   int likeCount;
//   List<String> comments;

//   Posts({
//     this.id,
//     this.text,
//     this.imagePath,
//     this.videoPath,
//     this.isLiked = false,
//     this.likeCount = 0,
//     this.comments = const [],
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'text': text,
//       'imagePath': imagePath,
//       'videoPath': videoPath,
//       'isLiked': isLiked ? 1 : 0,
//       'likeCount': likeCount,
//       'comments': comments.join('|'),
//     };
//   }

//   factory Posts.fromMap(Map<String, dynamic> map) {
//     return Posts(
//       id: map['id'],
//       text: map['text'],
//       imagePath: map['imagePath'],
//       videoPath: map['videoPath'],
//       isLiked: map['isLiked'] == 1,
//       likeCount: map['likeCount'],
//       comments: (map['comments'] as String).split('|'),
//     );
//   }
// }

class UserController extends GetxController {
  final GetStorage _storage = GetStorage();

  var userName = ''.obs;
  var email = ''.obs;
  var fullName = ''.obs;
  var profilePicture = ''.obs;
  var phoneNumber = ''.obs;
  var passWord = ''.obs;
  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  void saveUserData(String userName, String email, String fullName,
      String profilePicture, String phoneNumber, String passWord) {
    this.userName.value = userName;
    this.email.value = email;
    this.fullName.value = fullName;
    this.profilePicture.value = profilePicture;
    this.phoneNumber.value = phoneNumber;
    this.passWord.value = passWord;

    _storage.write('userName', userName);
    _storage.write('email', email);
    _storage.write('fullName', fullName);
    _storage.write('profilePicture', profilePicture);
    _storage.write('phoneNumber', phoneNumber);
    _storage.write('passWord', passWord);
  }

  void loadUserData() {
    userName.value = _storage.read('userName') ?? '';
    email.value = _storage.read('email') ?? '';
    fullName.value = _storage.read('fullName') ?? '';
    profilePicture.value = _storage.read('profilePicture') ?? '';
    phoneNumber.value = _storage.read('phoneNumber') ?? '';
    passWord.value = _storage.read('passWord') ?? '';
  }
}
