
import 'package:flutter/material.dart';
import 'package:todolist_app/util/diaglog_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback  onSave;
  VoidCallback OnCancel;



   DialogBox({super.key,
  required this.controller,
  required this.onSave,
  required this.OnCancel
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.green[200],
      content: Container(
        height: 130,
        child: Column(
          children: [
            // input task
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Add anew task'),
            ),
            SizedBox(height: 12,),
            //buttons
            Row(
              children: [
                //Save button
                DiaglogButton(text: 'Save', onPressed: onSave),
                SizedBox(width: 8,),
                //Cancel button
                DiaglogButton(text: 'cancel', onPressed: OnCancel)
              ],
              
            )

          ],
        ),
      ),
    );
  }
}
