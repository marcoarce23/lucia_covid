

import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:io';
import 'dart:async';

import 'package:lucia_covid/src/Model/PreferenceUser.dart';

class PushNotificationProvider {

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _mensajesStreamController = StreamController<String>.broadcast();
  Stream<String> get mensajes => _mensajesStreamController.stream;
  final prefs = new PreferensUser();

  initNotifications() 
  {
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.getToken().then( (token) {
     print('===== FCM Token =====');
     prefs.token = token;
     print('tokennnn: ${prefs.token}');
   }
  );


   _firebaseMessaging.configure(
      onMessage: ( info ) {

        print('======= On Message ========');
        print( info );

        String argumento = 'no-data';
        if ( Platform.isAndroid  ) {  
          argumento = info['data']['comida'] ?? 'no-data';
        } else {
          argumento = info['comida'] ?? 'no-data-ios';
        }

        _mensajesStreamController.sink.add(argumento);

      },
      onLaunch: ( info ) {

        print('======= On Launch ========');
        print( info );
      },

      onResume: ( info ) {
        print('======= On Resume ========');
        print( info );

        String argumento = 'no-data';

        if ( Platform.isAndroid  ) {  
          argumento = info['data']['comida'] ?? 'no-data';
        } else {
          argumento = info['comida'] ?? 'no-data-ios';
        }
       _mensajesStreamController.sink.add(argumento);

      }


    );


  }


  dispose() {
    _mensajesStreamController?.close();
  }
}