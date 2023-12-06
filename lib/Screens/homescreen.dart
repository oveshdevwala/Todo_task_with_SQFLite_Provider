import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remainder_app/Provider/notesProvider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget build(BuildContext context) {
    context.read<TaskProvider>().facthData();
    print('build function Called!!');
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<TaskProvider>().isUpdate = false;
          showmodel(0, context);
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: BorderSide(color: Colors.white)),
        backgroundColor: Colors.green.shade200,
        child: Icon(
          Icons.add,
          size: 40,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text('Remainder'),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Consumer<TaskProvider>(builder: (context, provider, child) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: provider.data.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                      constraints:
                          BoxConstraints(minHeight: 90, maxHeight: 2300),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              shadowColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(11)),
                              backgroundColor: Colors.green.shade200),
                          child: Container(
                            child: Row(
                              children: [
                                Text(
                                  '${index + 1}',
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.black),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Text(
                                    '${provider.data[index].modelTitle}',
                                    maxLines: 3,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),
                                // Consumer<TaskProvider>(
                                //     builder: (context, provider, child) {
                                //   return
                                PopupMenuButton(
                                    color: Colors.green.shade200,
                                    child: Icon(
                                      Icons.edit_square,
                                      color: Colors.black,
                                    ),
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    itemBuilder: (context) {
                                      return [
                                        PopupMenuItem(
                                            onTap: () {
                                              provider.delete(index);
                                            },
                                            child: Text('Delete')),
                                        PopupMenuItem(
                                            onTap: () {
                                              provider.isUpdate = true;
                                              provider.updatetextfield(index);
                                              showmodel(index, context);
                                            },
                                            child: Text('Update')),
                                      ];
                                    })
                                // })
                              ],
                            ),
                          )));
                });
          })
        ]),
      ),
    );
  }

  void showmodel(int mindex, context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.green.shade200,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (context) => Container(
              child: Column(
                children: [
                  SizedBox(height: 19),
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: context.read<TaskProvider>().taskController,
                        decoration: InputDecoration(
                            hintText: 'Add Task...',
                            hintStyle:
                                TextStyle(fontSize: 18, color: Colors.black),
                            fillColor: Colors.grey.withOpacity(0.2),
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.white)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.white)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.white))),
                      )),
                  SizedBox(
                      width: 150,
                      child:
                          //  Consumer<TaskProvider>(
                          //     builder: (context, provider, child) {
                          //   return
                          ElevatedButton(
                              onPressed: () {
                                context.read<TaskProvider>().createTask(mindex);
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(10),
                                  backgroundColor: Colors.green.shade200,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      side: BorderSide(color: Colors.white))),
                              child: Text(
                                context.watch<TaskProvider>().isUpdate != true
                                    ? 'Save'
                                    : 'Update',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ))
                      // })
                      )
                ],
              ),
            ));
  }
}
