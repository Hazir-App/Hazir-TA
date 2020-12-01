import 'package:sqflite/sqflite.dart';

class QueryHelper {
  static Future<void> executeRawQueries(String queries,Database database) async {
    List<String> splittedQueries = queries.split(';');
    splittedQueries.remove('');
    for(int i=0;i<splittedQueries.length;i++){
      try{
        await database.execute(splittedQueries[i]);
      }catch(e){
        print(e);
      }

    }
  }
  static String stringArgument(String argument){
    return "'${argument}'";
  }
}