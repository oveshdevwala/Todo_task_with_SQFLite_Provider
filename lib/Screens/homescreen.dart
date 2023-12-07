// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:remainder_app/Database/colors.dart';
import 'package:remainder_app/Provider/notesProvider.dart';
import 'package:remainder_app/Screens/completedTask.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> BotttomNavigationscreens = [alltask(), completedtaskView()];
  @override
  void initState() {
    super.initState();
    getallNotes();
  }

  getallNotes() async {
    await context.read<TaskProvider>().facthData();
  }

  @override
  Widget build(BuildContext context) {
    print('build function Called!!');
    return Scaffold(
        bottomNavigationBar:
            Consumer<TaskProvider>(builder: (context, provider, child) {
      return NavigationBar(
          selectedIndex: provider.mSelectedIndex,
          onDestinationSelected: (index) {
            provider.mSelectedIndex = index;
            if (index == 0) {
              provider.facthData();
            } else {
              provider.facthCompleted();
            }
          },
          backgroundColor: uiColors.shade200,
          indicatorColor: uiColors.shade100,
          destinations: [
            NavigationDestination(
                icon: Icon(CupertinoIcons.home), label: 'All Task'),
            NavigationDestination(icon: Icon(Icons.done), label: 'Completed'),
          ]);
    }), body: Consumer<TaskProvider>(builder: (context, providers, child) {
      return BotttomNavigationscreens[providers.mSelectedIndex];
    }));
  }
}

class alltask extends StatelessWidget {
  alltask({super.key});

  @override
  Widget build(BuildContext context) {
    var providera = context.read<TaskProvider>();
    context.read<TaskProvider>().facthData();
    print("all task screen");
    return Scaffold(
        appBar: AppBar(
          backgroundColor: uiColors.shade100,
          title: Text('All Task'),
          // bottom: TabBar(
          //     dividerColor: Colors.transparent,
          //     labelColor: uiColors.black,
          //     onTap: (value) {},
          //     indicatorColor: Colors.green.shade400,
          //     tabs: [
          //       Text('All Task'),
          //       Text('Completed Task'),
          //     ]),
        ),
        backgroundColor: uiColors.shade100,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<TaskProvider>().isUpdate = false;
            providera.facthData();
            showmodel(0, context);
          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: BorderSide(color: uiColors.white)),
          backgroundColor: uiColors.shade200,
          child: Icon(
            Icons.add,
            size: 40,
            color: uiColors.white,
          ),
        ),
        body: Consumer<TaskProvider>(builder: (context, providers, child) {
          return providers.data.length != 0
              ? SingleChildScrollView(
                  child: Column(children: [
                    Consumer<TaskProvider>(builder: (context, provider, child) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: providers.data.length,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Container(
                                constraints: BoxConstraints(
                                    minHeight: 90, maxHeight: 2300),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                        shadowColor: uiColors.black,
                                        shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: uiColors.white),
                                            borderRadius:
                                                BorderRadius.circular(11)),
                                        backgroundColor: uiColors.shade200),
                                    child: Container(
                                      child: Row(
                                        children: [
                                          Checkbox.adaptive(
                                              value: provider.data[index]
                                                          .modelCompleted ==
                                                      0
                                                  ? false
                                                  : true,
                                              activeColor:
                                                  Colors.green.shade700,
                                              onChanged: (value) {
                                                provider
                                                    .completedChacker(index);
                                                provider.facthData();
                                              }),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                            child: Text(
                                              '${provider.data[index].modelTitle}',
                                              maxLines: 3,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: provider.data[index]
                                                              .modelCompleted ==
                                                          0
                                                      ? uiColors.black
                                                      : uiColors.black26),
                                            ),
                                          ),

                                          PopupMenuButton(
                                              color: uiColors.shade200,
                                              child: Icon(
                                                Icons.edit_square,
                                                color: uiColors.black,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      color: uiColors.white),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              itemBuilder: (context) {
                                                return [
                                                  PopupMenuItem(
                                                      onTap: () {
                                                        provider.delete(index);
                                                        provider.facthData();
                                                      },
                                                      child: Text('Delete')),
                                                  PopupMenuItem(
                                                      onTap: () {
                                                        provider.isUpdate =
                                                            true;
                                                        provider.facthData();
                                                        provider
                                                            .updatetextfield(
                                                                index);
                                                        showmodel(
                                                            index, context);
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
                )
              : Center(
                  child: SizedBox(
                    height: 300,
                    child: Lottie.asset('assets/maketask.json'),
                  ),
                );
        }));
  }
}

void showmodel(int mindex, context) {
  showModalBottomSheet(
      context: context,
      backgroundColor: uiColors.shade200,
      shape: RoundedRectangleBorder(
          side: BorderSide(color: uiColors.white),
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
                          hintText: 'Add Task',
                          hintStyle:
                              TextStyle(fontSize: 18, color: uiColors.black),
                          fillColor: uiColors.textFielGrey,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: uiColors.white)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: uiColors.white)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: uiColors.white))),
                    )),
                SizedBox(
                    width: 150,
                    child: ElevatedButton(
                        onPressed: () {
                          var providers = context.read<TaskProvider>();
                          if (providers.isUpdate == true) {
                            providers.updatetask(mindex);
                          } else {
                            providers.createTask(mindex);
                          }
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(10),
                            backgroundColor: uiColors.shade200,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(color: uiColors.white))),
                        child: Consumer<TaskProvider>(
                            builder: (context, provider, child) {
                          return Text(
                            provider.isUpdate != true ? 'Save' : 'Update',
                            style:
                                TextStyle(fontSize: 20, color: uiColors.white),
                          );
                        }))
                    // })
                    ),
                SizedBox(height: 10),
                // ElevatedButton(
                //     onPressed: () async {
                //       final TimeOfDay? remainderTime = await showTimePicker(
                //         context: context,
                //         initialTime:
                //             context.read<TaskProvider>().selectedTime,
                //         initialEntryMode: TimePickerEntryMode.dial,
                //       );
                //       if (remainderTime != null) {
                //         context.read<TaskProvider>().selectedTime =
                //             remainderTime.minute;
                //       }
                //     },
                //     child: Text('Select Time'))
              ],
            ),
          ));
}
