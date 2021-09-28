
import 'package:noa/services/serverDataJson.dart';

class JsonHandler{

  ServerDataJson dataServer;
  JsonHandler._();
  static final instance = JsonHandler._();

  setData(ServerDataJson dataServer)=>
      this.dataServer=dataServer;
}