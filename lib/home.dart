import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController controller;
  String name = '';
  bool isChecked = false;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  List<bool> checkedList = [];
  List<String> todoList = [];

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('To do'),
      ) ,
      body: Container(
        padding: EdgeInsets.all(32), 
        child: Column(
          children: [ 
            ListView.builder(
              shrinkWrap: true,
              itemCount: todoList.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Visibility(
                    visible: todoList.isEmpty,
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center, // Mengatur penempatan vertikal menjadi tengah
                        children: [
                          Text('Press + button to add'),
                        ],
                      ),
                    ),
                  );
                }

                final todoIndex = index - 1;
                return Row(
                  children: [
                    Checkbox(
                      value: checkedList[todoIndex],
                      onChanged: (value) {
                        setState(() {
                          checkedList[todoIndex] = value!;
                        });
                      },
                    ),
                    const SizedBox(width: 12),
                    Text(todoList[todoIndex]),
                  ],
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
                final name = await openDialog();
                if (name == null || name.isEmpty) return;

                setState(() {
                  todoList.add(name); 
                  checkedList.add(false);
                });
              },
        child: const Icon(Icons.add),
      ),
   );

  Future<String?> openDialog() => showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text('Add To Do'),
      content: TextField(
        autofocus: true,
        decoration: InputDecoration(hintText: 'Enter your name'),
        controller: controller,
        onSubmitted: (_) => submit(),
      ),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            print("Klik No");
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Submit'),
          onPressed: submit,
        ),
      ],
    ),
  );

  void submit() {
    Navigator.of(context as BuildContext).pop(controller.text);

    controller.clear();
  }
}