import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// Shared Preferences
class PreferencesService {
  Future<void> saveUserInfo(String fullName, String username, String email,
      String phoneNumber, String passWord, String country) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('fullName', fullName);
    await prefs.setString('username', username);
    await prefs.setString('email', email);
    await prefs.setString('phoneNumber', phoneNumber);
    await prefs.setString('passWord', passWord);
    await prefs.setString('country', country);
  }

  Future<Map<String, String?>> getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'fullName': prefs.getString('fullName'),
      'username': prefs.getString('username'),
      'email': prefs.getString('email'),
      'phoneNumber': prefs.getString('phoneNumber'),
      'passWord': prefs.getString('passWord'),
      'country': prefs.getString('country'),
    };
  }

  Future<bool> isFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    bool? isFirstLaunch = prefs.getBool('isFirstLaunch');
    if (isFirstLaunch == null || isFirstLaunch) {
      await prefs.setBool('isFirstLaunch', false);
      return true;
    }
    return false;
  }
}

// SQLite
class DatabaseService {
  Future<Database> _openDb() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'app_data.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE posts(id INTEGER PRIMARY KEY, content TEXT, content IMAGE, content VIDEO)",
        );
      },
      version: 1,
    );
  }

  Future<void> savePost(String content) async {
    final db = await _openDb();
    await db.insert(
      'posts',
      {'content': content},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getPosts() async {
    final db = await _openDb();
    return await db.query('posts');
  }
}

// Combine services
class DataService {
  final FileService fileService = FileService();
  final PreferencesService preferencesService = PreferencesService();
  final DatabaseService databaseService = DatabaseService();
}

// file_service.dart

class FileService {
  Future<void> pickAndSaveImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final imageBytes = await pickedFile.readAsBytes();
      await DatabaseHelper().saveProfilePicture(imageBytes);
    }
  }
}
// database_helper.dart

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'app_data.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE user(id INTEGER PRIMARY KEY, profile_picture BLOB)",
        );
      },
      version: 1,
    );
  }

  Future<void> saveProfilePicture(Uint8List imageBytes) async {
    final db = await database;
    await db.insert(
      'user',
      {'profile_picture': imageBytes},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Uint8List?> getProfilePicture() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('user');
    if (maps.isNotEmpty) {
      return maps.first['profile_picture'] as Uint8List;
    }
    return null;
  } // database_helper.dart

  Future<void> deleteAllData() async {
    final db = await database;
    await db.delete('user');
  }

  Future<void> insertPost(String text, Uint8List? imageBytes, String? videoPath,
      Uint8List? voiceBytes) async {
    final db = await database;
    await db.insert(
      'posts',
      {
        'text': text,
        'image': imageBytes,
        'video': videoPath,
        'voice': voiceBytes
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getPosts() async {
    final db = await database;
    return await db.query('posts', orderBy: 'timestamp DESC');
  }

  Future<void> deleteAllPosts() async {
    final db = await database;
    await db.delete('posts');
  }
}

// profile_picture_provider.dart

class ProfilePictureProvider with ChangeNotifier {
  Uint8List? _profilePicture;

  ProfilePictureProvider() {
    _loadProfilePicture();
  }

  Uint8List? get profilePicture => _profilePicture;

  Future<void> _loadProfilePicture() async {
    _profilePicture = await DatabaseHelper().getProfilePicture();
    notifyListeners();
  }

  Future<void> updateProfilePicture() async {
    await FileService().pickAndSaveImage();
    _loadProfilePicture();
  }

// profile_picture_provider.dart

  Future<void> deleteProfilePicture() async {
    await DatabaseHelper().deleteAllData();
    await _clearSharedPreferences();
    _profilePicture = null;
    notifyListeners();
  }

  Future<void> _clearSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}

class PostService {
  Future<void> savePost(String text, Uint8List? imageBytes, String? videoPath,
      Uint8List? voiceBytes) async {
    await DatabaseHelper().insertPost(text, imageBytes, videoPath, voiceBytes);
  }
}

// post
// post_provider.dart

class PostProvider with ChangeNotifier {
  List<Map<String, dynamic>> _posts = [];

  List<Map<String, dynamic>> get posts => _posts;

  Future<void> loadPosts() async {
    _posts = await DatabaseHelper().getPosts();
    notifyListeners();
  }

  Future<void> addPost(String text, Uint8List? imageBytes, String? videoPath,
      Uint8List? voiceBytes) async {
    await DatabaseHelper().insertPost(text, imageBytes, videoPath, voiceBytes);
    await loadPosts(); // Reload posts after adding a new one
  }

  Future<void> clearAllPosts() async {
    await DatabaseHelper().deleteAllPosts();
    _posts.clear();
    notifyListeners();
  }
}
