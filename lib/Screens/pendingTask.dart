import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:remainder_app/Database/colors.dart';
import 'package:remainder_app/Provider/notesProvider.dart';
import 'package:remainder_app/Screens/homescreen.dart';

class PendingTask extends StatelessWidget {
  PendingTask({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<TaskProvider>().facthPending();
    print("pending task screen");
    return Scaffold(
        appBar: pendingtaskAppbar(),
        backgroundColor: uiColors.shade100,
        body: Consumer<TaskProvider>(builder: (context, providers, child) {
          return providers.data.length != 0
              ? todoListView(providers)
              : lottieAnimation();
        }));
  }

  AppBar pendingtaskAppbar() {
    return AppBar(
      backgroundColor: uiColors.shade100,
      title: Text('Pending Task'),
    );
  }

  Center lottieAnimation() {
    return Center(
      child: Container(
        height: 220,
        width: 160,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 4),
            borderRadius: BorderRadius.circular(20)),
        child: Lottie.asset('assets/pendingtask.json', fit: BoxFit.scaleDown),
      ),
    );
  }

  SingleChildScrollView todoListView(TaskProvider providers) {
    return SingleChildScrollView(
      child: Column(children: [
        Consumer<TaskProvider>(builder: (context, provider, child) {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: providers.data.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                    constraints: BoxConstraints(minHeight: 90, maxHeight: 2300),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            shadowColor: uiColors.black,
                            shape: RoundedRectangleBorder(
                                side:
                                    BorderSide(width: 2, color: uiColors.white),
                                borderRadius: BorderRadius.circular(11)),
                            backgroundColor: uiColors.shade200),
                        child: todoMainRow(provider, index)));
              });
        })
      ]),
    );
  }

  Container todoMainRow(TaskProvider provider, int index) {
    return Container(
      child: Row(
        children: [
          todoCheckbox(provider, index),
          SizedBox(width: 15),
          todoTitle(provider, index),
          popMenuForUpdateAndDelete(provider, index)
        ],
      ),
    );
  }

  Expanded todoTitle(TaskProvider provider, int index) {
    return Expanded(
      child: Text(
        '${provider.data[index].modelTitle}',
        maxLines: 3,
        textAlign: TextAlign.start,
        style: TextStyle(
            overflow: TextOverflow.ellipsis,
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: provider.data[index].modelCompleted == 0
                ? uiColors.black
                : uiColors.black26),
      ),
    );
  }

  SizedBox todoCheckbox(TaskProvider provider, int index) {
    return SizedBox(
      width: 20,
      child: Checkbox.adaptive(
          value: provider.data[index].modelCompleted == 0 ? false : true,
          activeColor: Colors.green.shade700,
          onChanged: (value) {
            provider.completedChacker(index);
            provider.facthPending();
          }),
    );
  }

  PopupMenuButton<dynamic> popMenuForUpdateAndDelete(
      TaskProvider provider, int index) {
    return PopupMenuButton(
        color: uiColors.shade200,
        child: Icon(
          Icons.edit_square,
          color: uiColors.black,
        ),
        shape: RoundedRectangleBorder(
            side: BorderSide(color: uiColors.white),
            borderRadius: BorderRadius.circular(12)),
        itemBuilder: (context) {
          return [
            PopupMenuItem(
                onTap: () {
                  provider.delete(index);
                  provider.facthPending();
                },
                child: Text('Delete')),
            PopupMenuItem(
                onTap: () {
                  provider.isUpdate = true;
                  provider.facthPending();
                  provider.updatetextfield(index);
                  showmodel(index, context);
                },
                child: Text('Update')),
          ];
        });
  }
}
