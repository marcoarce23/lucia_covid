import 'package:flutter/material.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/Generic.dart';
import 'package:lucia_covid/src/Model/PreferenceUser.dart';
import 'package:lucia_covid/src/Util/Resource.dart' as resource;
import 'package:lucia_covid/src/module/Settings/RoutesModule.dart';

class ListCitizenModule extends StatelessWidget {
  final generic = new Generic();
  final prefs = new PreferensUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(resource.titleApp),
      ),
      body: _showData(),
    );
  }

  Widget _showData() {
    return FutureBuilder(
      future: generic.getAll(new RegistroAmigo(),urlGetDevuelveAyuda, primaryKeyGetAyudaAmigo),
      builder: (BuildContext context, AsyncSnapshot<List<Entity>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, i) => _createItem(context, snapshot.data[i]));
        } else
          return Center(child: CircularProgressIndicator());
      },
      
    );
  }

  Widget _createItem(BuildContext context, RegistroAmigo entity) {

    prefs.correoElectronico = 'marcoarce23@gmail.com';

    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (value) 
      {
         //generic.delete(value);
      
          Scaffold.of(context).showSnackBar(
            new SnackBar(content:new Text('Registro eliminado'))
          );
      },

      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('nombre: ${entity.regPersona} - Tipo ayuda: ${entity.regTipoAPoyo} - Prioridad: ${entity.regPrioridad}'),
              subtitle: Text('Telef. contacto: ${entity.regTelefono} - Ubicación: ${entity.regUbicacion}'),
              onTap: () =>
                //  Navigator.pushNamed(context, 'citizen', arguments: entity),
                 Navigator.pushNamed(context, 'citizen'),
            ),
          ],
        ),
      ),
    );
  }
}
