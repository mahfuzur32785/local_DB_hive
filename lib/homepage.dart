import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Box myBox = Hive.box('testBox');

  Box anotherBox = Hive.box('anotherBox');

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  TextEditingController u_nameController = TextEditingController();
  TextEditingController u_phoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hive DataBase'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Enter Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: phoneController,
              decoration: InputDecoration(
                hintText: 'Enter Phone',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(MediaQuery.of(context).size.width * 1, 55),
              ),
              onPressed: () async{
                var name = nameController.text;
                var phone = phoneController.text;

                await myBox.add(name);
                await anotherBox.add(phone);
                nameController.text='';
                phoneController.text='';
                FocusScope.of(context).unfocus();
              },
              child: Text(
                'ADD DATA',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: Hive.box('testBox').listenable(),
                builder: (context, box, widget) {
                  return ListView.builder(
                    itemCount: myBox.keys.toList().length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 5,
                        child: ListTile(
                          title: Text(myBox.getAt(index)),
                          subtitle: Text(anotherBox.getAt(index)),
                          trailing: Container(
                            width: 80,
                            child: Row(
                              children: [
                                IconButton(onPressed: (){
                                  showDialog(context: context, builder: (context) {
                                    return AlertDialog(
                                      title: Text('Edit Your Given Data'),
                                      content: Container(
                                        padding: EdgeInsets.only(top: 20),
                                        height: 250,
                                        width: 300,
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              controller: u_nameController,
                                              decoration: InputDecoration(
                                                hintText: myBox.getAt(index),
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                focusedErrorBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            TextFormField(
                                              controller: u_phoneController,
                                              decoration: InputDecoration(
                                                hintText: anotherBox.getAt(index),
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                focusedErrorBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                fixedSize: Size(MediaQuery.of(context).size.width * 1, 55),
                                              ),
                                              onPressed: () async{
                                                var u_name = u_nameController.text;
                                                var u_phone = u_phoneController.text;

                                                await myBox.putAt(index, u_name);
                                                await anotherBox.putAt(index, u_phone);
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                'UPDATE DATA',
                                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },);
                                  },
                                  icon: Icon(Icons.edit),
                                ),
                                IconButton(onPressed: (){
                                  myBox.deleteAt(index);
                                  anotherBox.deleteAt(index);
                                },
                                  icon: Icon(Icons.delete),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
