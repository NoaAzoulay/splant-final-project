
class APIPath {
  //path to add plants by user
  static String plant(String uid, String plantID) =>
      'users/$uid/plants/$plantID';

  //path to access plants added by specific user
  static String plants(String uid) => 'users/$uid/plants';

// path to plants DB info
  static String plantsDb() => 'plants/';


}
