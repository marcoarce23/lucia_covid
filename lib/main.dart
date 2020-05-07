import 'package:flutter/material.dart';
import 'package:lucia_covid/src/Model/PreferenceUser.dart';
import 'package:lucia_covid/src/Widget/InputField/MaskEdit.dart';
import 'package:lucia_covid/src/module/CitizenPage/CitizenModule.dart';
import 'package:lucia_covid/src/module/Entity/EntityModule.dart';
import 'package:lucia_covid/src/module/Entity/EventEntityModule.dart';
import 'package:lucia_covid/src/module/InitialPages/SlideShowModule.dart';
import 'package:lucia_covid/src/module/Login/ForgetPasswordModule.dart';
import 'package:lucia_covid/src/module/Login/RegisterLoginModule.dart';
import 'package:lucia_covid/src/module/Login/SignUpModule.dart';
import 'package:lucia_covid/src/module/SplashScreen/SplashScreenModule.dart';
import 'package:lucia_covid/src/module/Voluntary/EventModule.dart';
import 'package:lucia_covid/src/module/Voluntary/VoluntaryModule.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferensUser();
  await prefs.initPrefs();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

//   Widget _cpf() {
//     String mask = '00000000000';
//     var controller = new MaskedTextController(mask: mask);

//     return new TextField(
//       controller: controller,
//       keyboardType: TextInputType.number,
//       decoration: new InputDecoration(
//         labelText: 'CPF',
//         hintText: mask
//       ),
//     );
//   }

//   Widget _onlyLetters() {
//     String mask = 'AAAAAAAAAAAAAAAA';
//     var controller = new MaskedTextController(mask: mask);

//     return new TextField(
//       controller: controller,
//       keyboardType: TextInputType.text,
//       decoration: new InputDecoration(
//         labelText: 'Only Letters',
//        // hintText: mask
//       ),
//     );
//   }

//   Widget _alphaNumeric() {
//     String mask = 'AAAAAAAA-00000000';
//     var controller = new MaskedTextController(mask: mask);

//     return new TextField(
//       controller: controller,
//       keyboardType: TextInputType.text,
//       decoration: new InputDecoration(
//           labelText: 'Alpha Numeric',
//           hintText: mask
//       ),
//     );
//   }

//   Widget _anyChar() {
//     String mask = '0A@*';
//     var controller = new MaskedTextController(mask: mask);

//     return new TextField(
//       controller: controller,
//       keyboardType: TextInputType.text,
//       decoration: new InputDecoration(
//           labelText: 'Any Char',
//           hintText: mask
//       ),
//     );
//   }

//   Widget _moneyDefault() {
//     var controller = new MoneyMaskedTextController();

//     return new TextField(
//       controller: controller,
//       keyboardType: TextInputType.number,
//       decoration: new InputDecoration(
//           labelText: 'Money (Default)',
//       ),
//     );
//   }

//   Widget _moneyCustomized() {
//     var controller = new MoneyMaskedTextController(
//       initialValue: 1000.0,
//       decimalSeparator: '.',
//       thousandSeparator: ',',
//       leftSymbol: 'US\$',
//       precision: 3
//     );

//     return new TextField(
//       controller: controller,
//       keyboardType: TextInputType.number,
//       decoration: new InputDecoration(
//         labelText: 'Money (Customized)',
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Masked Text',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Flutter Masked Text'),
//         ),
//         body: new Padding(
//           padding: EdgeInsets.all(10.0),
//           child: Column(
//             children: <Widget>[
//               _cpf(),
//               _onlyLetters(),
//               _alphaNumeric(),
//               _anyChar(),
//               _moneyDefault(),
//               _moneyCustomized()
//             ],
//           ),
//         )
//         ,
//       ),
//     );
//   }
// }
  final prefs = new PreferensUser();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'resource.titleApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.white,
      ),
      //home: new ListCitizenModule(),
      //initialRoute: SplashScreenModule(),

      home: new VoluntaryModule(),//(,//IntroScreen(),

      routes: <String, WidgetBuilder>{
        'Splash': (BuildContext context) => new SplashScreenModule(),
        'citizen': (BuildContext context) => new CitizenModule(),
        'login': (BuildContext context) => new SignUpModule(),
        'forgetPassword': (BuildContext context) => new ForgetPassword(),
        'registerLogin': (BuildContext context) => new RegisterLoginModule(),
        'sliderShowModule': (BuildContext context) => new SliderShowModule(),
      },
    );
  }
}
