class DatabaseKey {
  DateTime dateTime = DateTime.now();

  int datetimetKeyFormatter(DateTime dateTime) {
    // datetime -> string like 20501210
    final String databaseKey = dateTime.year.toString() +
        dateTime.month.toString().padLeft(2, '0') +
        dateTime.day.toString().padLeft(2, '0');
    // String -> int
    final int databasePrimaryKey = int.parse(databaseKey);
    return databasePrimaryKey;
  }
}
