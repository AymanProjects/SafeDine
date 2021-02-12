import 'package:SafeDine/Utilities/AppTheme.dart';
import 'package:SafeDine/Widgets/SafeDineField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddNoteField extends StatelessWidget {
  final Function onNoteChanged;
  final String savedValue;
  AddNoteField({this.onNoteChanged, this.savedValue});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Provider.of<AppTheme>(context, listen: false).grey,
        ),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: SizedBox(
        height: 90,
        child: SafeDineField(
          initialValue: savedValue,
          hintText: 'Add notes to the order...',
          enabled: true,
          maxLines: 3,
          onChanged: (note) {
            if (onNoteChanged != null) onNoteChanged(note);
          },
        ),
      ),
    );
  }
}
