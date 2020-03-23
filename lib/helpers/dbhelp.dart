import 'package:sqflite/sqflite.dart';

//class is made to help make db actions more manageble

class MicrosomesDB {
  //set all database tables
  MicrosomesDB() {
    openDatabase("microsomes6.db", version: 3,
        onUpgrade: (Database db, int oldVersion, int newVersion) async {
      //upgrade code goes here
      print("upgrading now");

      db.execute("ALTER TABLE timers ADD iconLink TEXT");
      //version 3 add iconLink
    }).then((db) {
      db.execute(
          'CREATE TABLE IF NOT EXISTS defaultColorScheme (id INTEGER PRIMARY KEY AUTOINCREMENT, schemeid INTEGER)');
    });
  }

  //sets up all the database tables and grabs the timers
  Future getAllTimers() async {
    Database db = await openDatabase("microsomes6.db", version: 3,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE IF NOT EXISTS  timers (id INTEGER PRIMARY KEY AUTOINCREMENT, totalWorkout TEXT, totalWorkTime TEXT, totalRestTime TEXT, label TEXT, playcolor TEXT, createdAt DATETIME DEFAULT CURRENT_TIMESTAMP)');
      //create timers
      await db.execute(
          'CREATE TABLE IF NOT EXISTS  activityhistory (id INTEGER PRIMARY KEY AUTOINCREMENT, intervalName TEXT, createdAt DATETIME DEFAULT CURRENT_TIMESTAMP, duration TEXT)');
      //create activity history

      await db.execute(
          'CREATE TABLE IF NOT EXISTS  activityhistoryInterval (id INTEGER PRIMARY KEY AUTOINCREMENT , activityhistoryid INTEGER , totalReps TEXT , feelings TEXT ,createdAt DATETIME DEFAULT CURRENT_TIMESTAMP, duration TEXT)');
    });

    List<Map> listAll =
        await db.rawQuery("SELECT * FROM timers ORDER BY id DESC");

    return listAll;
  }

  //adds history activity log
  Future addHistoryActivity(String intervalName) async {
    Database db = await openDatabase("microsomes6.db", version: 3);
    var idd = db.rawInsert(
        "INSERT INTO activityhistory (intervalName,duration) VALUES (?,?)",
        [intervalName, "0"]);

    return idd;
  }


  //get timer by name
  Future getTimerByName(String name) async {
    Database db = await openDatabase("microsomes6.db", version: 3);

   List<Map> allTimers= await db.query("timers",columns: ["*"],where: "label=?",whereArgs: [name],limit: 1);

    return allTimers;
  }

  //code to add a timer
  Future addTimer(String totalDuration, workoutDurtation, restDuration,
      labelText, playColor,iconLink) async {
    Database db = await openDatabase("microsomes6.db", version: 3);
    db.rawInsert(
        "INSERT INTO timers(totalWorkout,totalWorkTime,totalRestTime,label,playcolor,iconLink) VALUES (?,?,?,?,?,?)",
        [
          totalDuration,
          workoutDurtation,
          restDuration,
          labelText,
          playColor,
          iconLink
        ]).then((id) {
          return id;
        });
  }

  //set color scheme
  Future setColorScheme(int SchemeId) async {
    Database db = await openDatabase("microsomes6.db",
        version: 3, onCreate: (Database db, int version) async {});

    //just in case this table is not already created
    await db.execute(
        'CREATE TABLE IF NOT EXISTS defaultColorScheme (id INTEGER PRIMARY KEY AUTOINCREMENT, schemeid INTEGER)');

    var insertID = await db.rawInsert(
        "INSERT INTO defaultColorScheme(schemeid) VALUES (?)", [SchemeId]);
    return insertID;
  }


   Future getAllActivities() async {
    Database db = await openDatabase("microsomes6.db", version: 1);
    List<Map> listAll =
        await db.rawQuery("SELECT * FROM activityhistory ORDER BY id DESC");
    return listAll;
  }

  Future getTotalActicities() async {
    Database db = await openDatabase("microsomes6.db", version: 1);
    List<Map> total =
        await db.rawQuery("SELECT COUNT(id) as 'id' FROM activityhistory");
    return total[0]['id'];
  }

  Future getActivity(int index) async {
    print("activity requested $index");
    Database db = await openDatabase("microsomes6.db", version: 1);
    List<Map> listAll =
        await db.rawQuery("SELECT * FROM activityhistory ORDER BY id DESC");
    return listAll;
  }

  Future getActivtyPage(int page) async {
    double offset = page * 10.0;
    print("offset $offset");
    print("pages $page");
    Database db = await openDatabase("microsomes6.db", version: 1);
    List<Map> activityPages =
        await db.rawQuery("SELECT * FROM activityhistory ORDER BY id DESC  LIMIT ? OFFSET ?",[10,offset]);
    return activityPages;
  }
}
