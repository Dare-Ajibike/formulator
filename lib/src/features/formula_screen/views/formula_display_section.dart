import 'package:flutter/material.dart';
import 'package:formulator/src/entities/db_manager/db_manager.dart';
import 'package:provider/provider.dart';

class FormulaDisplaySection extends StatelessWidget {
  final ScrollController controller;
  final String formulaName;

  const FormulaDisplaySection(
      {super.key, required this.controller, required this.formulaName});

  @override
  Widget build(BuildContext context) {
    return Consumer<DBManager>(
      builder: (context, manager, child) {
        return SizedBox(
          height: 70,
          child: Row(
            children: [
              Expanded(
                child: Scrollbar(
                  thumbVisibility: true,
                  controller: controller,
                  child: ListView(
                    controller: controller,
                    scrollDirection: Axis.horizontal,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    children: [
                      ...manager.formulasMap[formulaName]!.formulaDetails.map(
                        (InlineSpan span) => Center(
                          child: Text.rich(span),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 150,
                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
                margin: const EdgeInsets.only(right: 5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 4),
                ),
                child: Center(
                  child: FittedBox(
                    child: Text(
                      '=${(manager.formulasMap[formulaName]!.answer * 100).toStringAsFixed(4)}%',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
