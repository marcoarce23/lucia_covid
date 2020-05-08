import 'package:flutter/material.dart';
import 'package:lucia_covid/src/Provider/PushNotificationProvider.dart';


class BlankModule extends StatefulWidget {
  @override
  _BlankModuleState createState() => _BlankModuleState();
}

class _BlankModuleState extends State<BlankModule>
    with TickerProviderStateMixin {

        final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
  AnimationController animationController;

  AnimationController animationControllerPanel;

  

  Widget tabBody = Container(
  
  );

  @override
  void initState() {    
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = null;
    super.initState();

    final pushProvider = new PushNotificationProvider();
    pushProvider.initNotifications();

    // pushProvider.mensajes.listen( (data) {

    //   // Navigator.pushNamed(context, 'mensaje');
    //   print('Argumento del Push');
    //   print(data);

    //   navigatorKey.currentState.pushNamed('mensaje', arguments: data );

    // });
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        body: Center(
            child: SafeArea(
      child: Stack(
        children: <Widget>[

          SizedBox(
            height: 80,
          ),
          Container(
            height: 300,
            child: null,
          ),
          SizedBox(
            height: 80,
          ),
           
        ],
      ),
    )));
  }

  /*Center(
              child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 16,
                ),
                AnimatedButton(
                  text: 'Mensaje para mostrar informacion',
                  pressEvent: () {
                    AwesomeDialog(  
                      context: context,
                      headerAnimationLoop: false,
                      dialogType: DialogType.INFO,
                      animType: AnimType.BOTTOMSLIDE,
                      tittle: 'Información',
                      desc: 'Dialogo de despliegue de información',
                    ).show();
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                AnimatedButton(
                  text: 'Advertencia',
                  color: Colors.orange,
                  pressEvent: () {
                    AwesomeDialog(
                            context: context,
                            dialogType: DialogType.WARNING,
                            headerAnimationLoop: false,
                            animType: AnimType.TOPSLIDE,
                            tittle: 'Advertencia',
                            desc: 'Seguro de que desea eliminar el boton?',
                            btnOkOnPress: () {},
                            btnCancelOnPress: () {})
                        .show();
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                AnimatedButton(
                  text: 'Error Dialog',
                  color: Colors.red,
                  pressEvent: () {
                    AwesomeDialog(
                            context: context,
                            dialogType: DialogType.ERROR,
                            animType: AnimType.RIGHSLIDE,
                            headerAnimationLoop: false,
                            tittle: 'Error',
                            desc:
                                'Dialog description here..................................................',
                            btnOkOnPress: () {},
                            btnOkColor: Colors.red)
                        .show();
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                AnimatedButton(
                  text: 'Succes Dialog',
                  color: Colors.green,
                  pressEvent: () {
                    AwesomeDialog(
                        context: context,
                        animType: AnimType.SCALE,
                        headerAnimationLoop: false,
                        dialogType: DialogType.SUCCES,
                        tittle: 'Succes',
                        desc:
                            'Dialog description here..................................................',
                        btnOkOnPress: () {
                          debugPrint('OnClcik');
                        },
                        btnOkIcon: Icons.check_circle,
                        onDissmissCallback: () {
                          debugPrint('Dialog Dissmiss from callback');
                        }).show();
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                AnimatedButton(
                  text: 'Custom Body Dialog',
                  color: Colors.blueGrey,
                  pressEvent: () {
                    AwesomeDialog(
                      context: context,
                      animType: AnimType.SCALE,
                      dialogType: DialogType.INFO,
                      body: Center(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            'If the body is specified, then title and description will be ignored, this allows to further customize the dialogue.',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                      tittle: 'This is Ignored',
                      desc: 'This is also Ignored',
                    ).show();
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                AnimatedButton(
                  text: 'Custom Buttons Dialog',
                  color: Colors.brown,
                  pressEvent: () {
                    AwesomeDialog(
                      context: context,
                      animType: AnimType.SCALE,
                      customHeader: Icon(
                        Icons.face,
                        size: 50,
                      ),

                      tittle: 'This is Custom',
                      desc: 'This is custom button and header',
                      btnOk: FlatButton(
                        color: Colors.deepOrange,
                        child: Text(
                          'Custom Button',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      //this is ignored

                      btnOkOnPress: () {},
                    ).show();
                  },
                ),
              ],
            ),
          )),
        ),
      ),
      
    );
  }
*/


}
