import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Model/note_model.dart';

class NoteItem extends StatelessWidget {
  //1 first step
  final VoidCallback? onPressedEdit;
  final VoidCallback? onPressedDelete;
  final NoteModel noteModel;
  const NoteItem({super.key, required this.noteModel,required this.onPressedEdit,required this.onPressedDelete});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(noteModel.msg),
        Row(children: [
          //l5twa ltanya
          IconButton(onPressed: onPressedDelete, icon: Icon(Icons.delete)),
          IconButton(onPressed: onPressedEdit, icon: Icon(Icons.edit))
        ],
        ),
      ],
    );
  }
}