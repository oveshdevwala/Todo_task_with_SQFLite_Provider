import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:remainder_app/Database/colors.dart';
import 'package:remainder_app/Provider/notesProvider.dart';
import 'package:remainder_app/Screens/homescreen.dart';

class completedtaskView extends StatelessWidget {
  const completedtaskView({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = context.read<TaskProvider>();
    provider.facthCompleted();
    print("completed task screen builded!!");
    return Scaffold(
        appBar: AppBar(
          backgroundColor: uiColors.shade100,
          title: Text(
            'Completed Task',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
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
        body: Consumer<TaskProvider>(builder: (context, providers, child) {
          return providers.data.length != 0
              ? SingleChildScrollView(
                  child: Column(children: [
                    Consumer<TaskProvider>(builder: (context, provider, child) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: provider.data.length,
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
                                            side: BorderSide(width: 2,
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
                                              activeColor: uiColors.shade700,
                                              onChanged: (value) {
                                                provider
                                                    .completedChacker(index);
                                                provider.facthCompleted();
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
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  decorationColor:
                                                      uiColors.shade700,
                                                  decorationThickness: 2.5,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: uiColors.black26),
                                            ),
                                          ),
                                          // Consumer<TaskProvider>(
                                          //     builder: (context, provider, child) {
                                          //   return
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
                                                        provider
                                                            .facthCompleted();
                                                      },
                                                      child: Text('Delete')),
                                                  PopupMenuItem(
                                                      onTap: () {
                                                        provider.isUpdate =
                                                            true;
                                                        showmodel(
                                                            index, context);
                                                        provider
                                                            .updatetextfield(
                                                                index);
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
                      height: 200,
                      child: Lottie.asset('assets/completedtask.json')),
                );
        }));
  }
}
