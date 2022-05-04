import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'image_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DBHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

const IMAGE_URL =
     "https://4.imimg.com/data4/IU/GF/MY-985365/product-photography-500x500.jpg";
    //  "https://www.canon.co.nz/-/media/new-zealand/stories/rach-stewart/rach-stewart-1-mountains.ashx?la=en-nz";

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image'),
      ),
      body: FutureBuilder(
          future: getImage(),
          builder: (context, snapshot) => snapshot.hasData
              ? GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:   3 ,),
              itemCount: ((snapshot.data) as List<SampleImage>).length,
              itemBuilder: (context, i) =>Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                child: Image.memory(
                    dataFromBase64String(((snapshot.data)as List<SampleImage>)[i].image))),
              ) )
              : const Center(child: CircularProgressIndicator())),
    );
  }

  @override
  void initState() {
    super.initState();
    processImage();
  }

  processImage() async {
    Future<String> base64String = networkImageToBase64(IMAGE_URL);
    SampleImage? image;
    debugPrint("${(base64String.then((value) => value))}");
    base64String.then((String value) => {
          debugPrint("Future .:> ${(base64String.then((value) => value))}"),
          image = SampleImage(id: null, image: value),
          insertImage(image!)
        });
  }


  Future<List<SampleImage>> getImage() async =>
      await getSampleImages().then((value) => value);


  Future<void> insertImage(SampleImage image) async {

    final db = DBHelper._database;
 //  db?.execute("CREATE TABLE images(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, image TEXT)");
    await db?.insert(
      'images',
      image.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<SampleImage>> getSampleImages() async {
    final db = DBHelper._database;
    final List<Map<String, dynamic>>? maps = await db?.query('images');
    return List.generate(maps!.length, (i) {
      return SampleImage(
        id: maps[i]['id'],
        image: maps[i]['image'],
      );
    });
  }
}

class SampleImage {
  final int? id;
  final String image;

  const SampleImage({
    required this.id,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
    };
  }

  @override
  String toString() {
    return 'Image{id: $id, age: $image}';
  }
}

class DBHelper {
  static final DBHelper _dbHelper = DBHelper._internal();

  static Future<Database> get _instance async =>
      _database ??= await openDatabase(
        join(await getDatabasesPath(), 'sample.db'),
        onCreate: (db, version) =>
        "CREATE TABLE images(id INTEGER PRIMARY KEY, image TEXT)",
        version: 1,
      );

  static Database? _database;

  static Future<Database> init() async {
    _database = await _instance;
    return _database!;
  }

  factory DBHelper() {
    return _dbHelper;
  }

  DBHelper._internal();
}
