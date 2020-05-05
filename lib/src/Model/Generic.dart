import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:mime_type/mime_type.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

enum SomeStatus {
  getHosptalAdd,
  element2,
  element3,
  element4,
}

const Map<SomeStatus, String> SomeStatusName = {
  SomeStatus.getHosptalAdd: "Element 1",
  SomeStatus.element2: "Element 2",
  SomeStatus.element3: "Element 3",
  SomeStatus.element4: "Element 4",
};

class Generic {

  final String url        =      'http://covid19.ruta88.net/COVID/Hospitales/srvHospital.svc/HOSPITALES/hola';
  final String urlAdd     =     'http://covid19.ruta88.net/COVID/Login/srvLogin.svc/login_signin';
  // 'http://covid19.ruta88.net/COVID/Hospitales/srvHospital.svc/CARGA_HOSPITALES1';
  final String urlUpdate  =      'http://covid19.ruta88.net/COVID/Hospitales/srvHospital.svc/CARGA_HOSPITALES1';
  final String primaryKey =      '_devuelveHospitalesResult';

  String getUrl() {
    return url;
  }

  String getUrlAdd() {
    return urlAdd;
  }

  String getUrlUpdate() {
    print(SomeStatusName[SomeStatus.element2]); // prints: "Element 2"

    return urlUpdate;
  }

  String getPrimaryKey() {
    return primaryKey;
  }

  Future<List<Entity>> getAll(Entity objeto) async 
  {
      final _url = getUrl();
      final _primaryKey = getPrimaryKey();

      final List<Entity> list = new List();
      Map<String, dynamic> decodeData;

      final response = await http.get(_url);

      if (response.statusCode == 200) {
          Map dataMap = json.decode(response.body);
          List<dynamic> listDynamic = dataMap[_primaryKey];

          for (int i = 0; i < listDynamic.length; i++) {
            decodeData = listDynamic[i];
            list.add(objeto.fromJson(decodeData));
          }
      }
      else {
        Exception('Error: Status 400');
      }
      return list;
  }

  Future<Map<String, dynamic>> add(Entity objeto) async {
      String _body = json.encode(objeto.toJson());
      final url = getUrlAdd();
      final response = await http.post(url, headers: {"Content-Type": "application/json"}, body: _body);

      return dataMap(response);
  }

  Future<Map<String, dynamic>> update(Entity objeto) async {
      String _body = json.encode(objeto.toJson());
      final url = getUrlUpdate();
      final response = await http.put(url, headers: {"Content-Type": "application/json"}, body: _body);

      return dataMap(response);
  }

  Future<Map<String, dynamic>> delete(dynamic idObjeto) async {
     // final url = 'productos/$idObjeto.json';
      // final response = await http.delete(url);
      //dataMap(response)
      return null;
  }

  Map dataMap(Response response) {
      Map dataMap;

      if (response.statusCode == 200)  dataMap = json.decode(response.body);
      else   dataMap.addAll(throw Exception('Error: Status 400'));

    return dataMap;
  }

  Future<String> subirImagen( File imagen ) async {

    final url = Uri.parse('https://api.cloudinary.com/v1_1/dc0tufkzf/image/upload?upload_preset=cwye3brj');
    final targetPath ='';
    final mimeType = mime(imagen.path).split('/'); //image/jpeg

    var result = await FlutterImageCompress.compressAndGetFile(imagen.absolute.path, targetPath, quality: 88, rotate: 180,);

    print(imagen.lengthSync());
    print(result.lengthSync());

    final imageUploadRequest = http.MultipartRequest(
      'POST',
      url
    );

    final file = await http.MultipartFile.fromPath(
      'file', 
      imagen.path,
      contentType: MediaType( mimeType[0], mimeType[1] )
    );

    imageUploadRequest.files.add(file);


    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if ( resp.statusCode != 200 && resp.statusCode != 201 ) {
      print('Algo salio mal');
      print( resp.body );
      return null;
    }

    final respData = json.decode(resp.body);
    print( respData);

    return respData['secure_url'];
  }  

  // Future<File> _compressAndGetFile(File file, String targetPath) async {
  //   var result = await FlutterImageCompress.compressAndGetFile(
  //       file.absolute.path, targetPath,
  //       quality: 88,
  //       rotate: 180,
  //     );

  //   print(file.lengthSync());
  //   print(result.lengthSync());

  //   return result;
  // }
}
