import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:misiontic_team_management/data/model/group.dart';
import 'package:misiontic_team_management/domain/controller/firestore_controller.dart';
import 'package:misiontic_team_management/ui/pages/add_group_page.dart';
import 'package:prompt_dialog/prompt_dialog.dart';

class GroupWidget extends StatefulWidget {
  const GroupWidget({Key? key}) : super(key: key);

  @override
  State<GroupWidget> createState() => _GroupWidgetState();
}

class _GroupWidgetState extends State<GroupWidget> {
  final FirestoreController firebaseController = Get.find();

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
        key: const ValueKey("groupsScaffold"),
        body: Center(
          // TODO
          child: Obx(
            () => ListView.builder(
                itemCount: firebaseController.sesions.length,
                itemBuilder: (BuildContext context, int index) {
                  return _buildItem(context, firebaseController.sesions[index]);
                }),
          ),
        ),
        // 'Aquí colocar la lista de grupos, recordar que se se debe escuchar el controlador (groups) con obx')

        floatingActionButton: FloatingActionButton(
          key: const ValueKey("addGroupAction"),
          child: const Icon(Icons.add),
          onPressed: () {
            // TODO
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddGroupPage()),
            ); //Aqui navegar a AddGroupPage
          },
        ));
  }

  Future<void> addGroup(id, student1, student2) async {
    firebaseController.addGroup(id, student1, student2);
  }

  Widget _buildItem(BuildContext context, Group group) {
    return Padding(
      key: ValueKey(group.groupId),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        key: const ValueKey("groupCard"),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Icon(
              Icons.group_outlined,
              color: Theme.of(context).colorScheme.secondary,
            ),
            title: Text(
              group.groupId,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [Text(group.student1), Text(group.student2)]),
          ),
        ),
      ),
    );
  }
}
