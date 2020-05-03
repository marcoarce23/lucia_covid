import 'package:flutter/material.dart';

class CitizenEventsDetailModule extends StatefulWidget {
  const CitizenEventsDetailModule({Key key}) : super(key: key);

  @override
  _CitizenEventsDetailModuleState createState() =>
      _CitizenEventsDetailModuleState();
}

class _CitizenEventsDetailModuleState extends State<CitizenEventsDetailModule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detalle de noticias"),) ,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
              child: Column(
          children: <Widget>[
            Image.network(
              "https://static.eldeber.com.bo//Files/Sizes/2020/4/13/1896836954_1140x520.jpg",
              width: MediaQuery.of(context).size.width,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Después de 45 días, la paciente de San Carlos sigue dando positivo a Covid-19",
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
                "La paciente cero de Santa Cruz, una mujer de 65 años que llegó de Italia, no presenta síntomas clínicos pero no puede ser dada da alta por el riesgo de que siga contagiando",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15)),
            SizedBox(
              height: 10,
            ),
            Text(
                "La mujer de San Carlos (65), que sin saberlo llegó con el Covid-19 incubando en su organismo desde Italia, es quizá la persona que se ha llevado lo peor de la pandemia. El 10 de marzo se convirtió en el primer caso positivo de la enfermedad en Santa Cruz, fue presa de la incomprensión ciudadana que impedía su internación en un centro hospitalario y pareciera que el virus se ha  ensañado con ella. Hoy, después de 45 días sigue dando positivo en las pruebas de laboratorio, por lo que continuará en aislamiento hospitalario. Los resultados de las últimas pruebas se conocieron este viernes y volvieron a dar positivo a Covid-19, lo que la coloca como uno de los pocos casos que se conocen en los que la carga viral se prolonga después de los 39 días. El jefe nacional de Epidiomología, Virgilio Prieto, refirió que la afectada se encuentra estable, pero sigue dando positivo. Su caso está siendo  investigado a profundad, en el entendido de que al ser el coronavirus una enfermedad nueva en el mundo,  todos, incluso los expertos en epidemiología, están aprendiendo cada día sobre su comportamiento y los países actúan según la experiencia de las regiones que  han logrado su contención, dijo Prieto.",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15)),
                  SizedBox(
              height: 10,
            ),
            Row( children: <Widget>[
Text("Fuente"), SizedBox(width: 10,),Text("El deber")

            ],)
          
          ],
        ),
      ),
    );
  }
}
