import 'package:flutter/material.dart';
import 'package:module_8_assignment/style.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<todo> ToDo=[];
  GlobalKey<FormState> todosFrom=GlobalKey<FormState>();

  final TextEditingController _titleEdController = TextEditingController();
  final TextEditingController _dsEditController = TextEditingController();
  final TextEditingController _dedlinlEdController = TextEditingController();

  myAlertDialog(context){
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: const Text('Add Task'),
            content: Form(
                child: Container(
                  width: double.infinity,
                  height: 230,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: TextFormStyle("Title"),
                        controller: _titleEdController,
                      ),
                      const SizedBox(height: 15),

                      TextFormField(
                        maxLines: 4,
                        decoration: TextFormStyle("Description"),
                        controller: _dsEditController,
                      ),
                      const SizedBox(height: 15),

                      TextFormField(
                        decoration: TextFormStyle("Dedline"),
                        controller: _dedlinlEdController,
                      ),
                    ],
                  ),
                )),

            actions: [
              TextButton(onPressed: (){
                Navigator.of(context).pop();
              }, child: const Text('Cancel')),

              TextButton(onPressed: (){
                ToDo.add(todo(_titleEdController.text.trim(),
                    _dsEditController.text.trim(),
                    _dedlinlEdController.text.trim()
                ));
                if(mounted){
                  setState(() {});
                }
                _titleEdController.clear();
                _dsEditController.clear();
                _dedlinlEdController.clear();
                Navigator.pop(context);
              }, child: const Text('Save'))
            ],
          );
        }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Task Management")),
      ),
      body: ListView.builder(
        itemCount: ToDo.length,
          itemBuilder: (context,index){
          return InkWell(
            onLongPress: (){
              showAddBottomSheet(index);
              if(mounted){
                setState(() {});
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(ToDo[index].title,style: const TextStyle(fontSize: 20,fontWeight:FontWeight.bold),),
                    Text("${ToDo[index].description} at ${ToDo[index].deadline}"),
                ],
              ),
            ),
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            myAlertDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
  void showAddBottomSheet(index){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context){
          return Container(
            height: 250,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Task Details",style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 10),

                  Text("Title :${ToDo[index].title}"),
                  Text("Description :${ToDo[index].description}"
                      " at :${ToDo[index].deadline}"),
                  const SizedBox(height: 15),

                  Row(
                    children: [
                      ElevatedButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel")),
                      const SizedBox(width: 15),

                      ElevatedButton(
                          onPressed: (){
                            ToDo.removeAt(index);
                            if(mounted){
                              setState(() {});
                            }
                            Navigator.pop(context);
                          },
                          child: const Text("Delete"),),
                  ],
                )
              ],
            ),
          ),
        );
      }
    );
  }
}

class todo{
  String title,description;
  String deadline;

  todo(this.title, this.description, this.deadline);
}
