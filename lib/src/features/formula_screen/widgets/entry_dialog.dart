import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:formulator/src/utils/functions/validators.dart';
import 'package:formulator/src/utils/widgets/primary_button.dart';

class EntryDialog extends StatefulWidget {
  const EntryDialog({super.key});

  @override
  State<EntryDialog> createState() => _EntryDialogState();
}

class _EntryDialogState extends State<EntryDialog> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController valueController = TextEditingController();
  final TextEditingController refValueController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController costPerUnitController = TextEditingController();

  final FocusNode firstFocusNode = FocusNode();
  final FocusNode secondFocusNode = FocusNode();
  final FocusNode thirdFocusNode = FocusNode();
  final FocusNode fourthFocusNode = FocusNode();
  final FocusNode fifthFocusNode = FocusNode();
  final FocusNode sixthFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    valueController.dispose();
    refValueController.dispose();
    weightController.dispose();
    costPerUnitController.dispose();

    firstFocusNode.dispose();
    secondFocusNode.dispose();
    thirdFocusNode.dispose();
    fourthFocusNode.dispose();
    fifthFocusNode.dispose();
    sixthFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.lightBlue.shade50,
      insetPadding: EdgeInsets.symmetric(
        horizontal: MediaQuery.sizeOf(context).width / 3,
      ),
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.lightBlue, width: 2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Create New Entry',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 25),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Name',
                  style: TextStyle(fontSize: 17),
                ),
              ),
              const SizedBox(height: 4),
              TextFormField(
                autofocus: true,
                focusNode: firstFocusNode,
                controller: nameController,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                validator: (value) => Validators.simpleValidator(value),
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(secondFocusNode);
                },
              ),
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Value',
                  style: TextStyle(fontSize: 17),
                ),
              ),
              const SizedBox(height: 4),
              TextFormField(
                focusNode: secondFocusNode,
                controller: valueController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
                decoration: const InputDecoration(border: OutlineInputBorder()),
                validator: (value) => Validators.simpleValidator(value),
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(thirdFocusNode);
                },
              ),
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Reference Value',
                  style: TextStyle(fontSize: 17),
                ),
              ),
              const SizedBox(height: 4),
              TextFormField(
                focusNode: thirdFocusNode,
                controller: refValueController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
                decoration: const InputDecoration(border: OutlineInputBorder()),
                validator: (value) => Validators.simpleValidator(value),
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(fourthFocusNode);
                },
              ),
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Weight',
                  style: TextStyle(fontSize: 17),
                ),
              ),
              const SizedBox(height: 4),
              TextFormField(
                focusNode: fourthFocusNode,
                controller: weightController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
                decoration: const InputDecoration(border: OutlineInputBorder()),
                validator: (value) => Validators.simpleValidator(value),
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(fifthFocusNode);
                },
              ),
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Cost per Unit',
                  style: TextStyle(fontSize: 17),
                ),
              ),
              const SizedBox(height: 4),
              TextFormField(
                focusNode: fifthFocusNode,
                controller: costPerUnitController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
                decoration: const InputDecoration(border: OutlineInputBorder()),
                validator: (value) => Validators.simpleValidator(value),
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(sixthFocusNode);
                },
              ),
              const SizedBox(height: 25),
              PrimaryButton(
                focusNode: sixthFocusNode,
                shrink: true,
                color: Colors.blue,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.of(context).pop({
                      'name': nameController.text,
                      'value': valueController.text,
                      'refValue': refValueController.text,
                      'weight': weightController.text,
                      'costPerUnit': costPerUnitController.text,
                    });
                  }
                },
                borderRadius: BorderRadius.circular(35),
                borderSide: const BorderSide(color: Colors.blue, width: 2),
                padding:
                    const EdgeInsets.symmetric(vertical: 9, horizontal: 20),
                child: const Text(
                  'Create',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
