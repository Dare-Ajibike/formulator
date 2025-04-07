import 'package:flutter/material.dart';
import 'package:formulator/src/entities/models/entry.dart';
import 'package:formulator/src/features/analysis_screen/models/entry_with_amount.dart';
import 'package:formulator/src/utils/extensions/number_extension.dart';
import 'package:intl/intl.dart';

class EntryContainer2 extends StatelessWidget {
  final int entryNo;
  final Entry entry;

  const EntryContainer2({
    super.key,
    required this.entryNo,
    required this.entry,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    const double space1Width = 1;
    const double snWidth = 22;
    const double space1o2Width = 1;
    final double column1Width = screenWidth / 12;
    const double space2Width = 2;
    final double column2Width = screenWidth / 19;
    const double space3Width = 3;
    final double column3Width = screenWidth / 19;

    // if (entry is EntryWithAmount) {
    //   print((entry as EntryWithAmount).amountAdded);
    // }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 32,
          child: Row(
            children: [
              const SizedBox(width: space1Width),
              SizedBox(
                width: snWidth,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    '${entryNo.toString()}.',
                    style: const TextStyle(height: 1.1),
                  ),
                ),
              ),
              const SizedBox(width: space1o2Width),
              SizedBox(
                width: column1Width,
                child: Text(
                  entry.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(height: 1.1),
                ),
              ),
              const SizedBox(width: space2Width),
              SizedBox(
                width: column2Width,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    entry.weight.formatToString,
                  ),
                ),
              ),
              const SizedBox(width: space3Width),
              SizedBox(
                width: column2Width,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    entry.value.formatToString,
                  ),
                ),
              ),
              const SizedBox(width: space3Width),
              SizedBox(
                width: column2Width,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    entry.referenceValue.formatToString,
                  ),
                ),
              ),
              const SizedBox(width: space3Width),
              SizedBox(
                width: column3Width,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${(entry.answer * 100).toStringAsFixed(2)}%',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
              ),
              const SizedBox(width: space3Width),
              SizedBox(
                width: column2Width,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.center,
                  child: Text(
                    entry.costPerUnit.formatToString,
                  ),
                ),
              ),
              const SizedBox(width: space3Width),
              entry is EntryWithAmount
                  ? SizedBox(
                      width: column2Width,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.center,
                        child: Text(
                          '+${NumberFormat.decimalPattern().format((entry as EntryWithAmount).amountAdded ?? 0)}',
                          style: const TextStyle(
                            color: Color(0xFF3E9F33),
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ],
    );
  }
}

class EntryReference2 extends StatelessWidget {
  final bool showAmountAdded;

  const EntryReference2({super.key, this.showAmountAdded = false});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    const double space1Width = 1;
    const double snWidth = 22;
    const double space1o2Width = 1;
    final double column1Width = screenWidth / 12;
    const double space2Width = 2;
    final double column2Width = screenWidth / 19;
    const double space3Width = 3;
    final double column3Width = screenWidth / 19;

    return Row(
      children: [
        const SizedBox(width: space1Width + snWidth + space1o2Width),
        SizedBox(
          width: column1Width,
          child: const Text(
            'Entry Name',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(width: space2Width),
        SizedBox(
          width: column2Width,
          child: const Text(
            'Weight',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(width: space3Width),
        SizedBox(
          width: column2Width,
          child: const Text(
            'Value',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(width: space3Width),
        SizedBox(
          width: column2Width,
          child: const FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              'Reference',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ),
        const SizedBox(width: space3Width),
        SizedBox(
          width: column3Width,
          child: const FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              'Sub-total',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ),
        const SizedBox(width: space3Width),
        SizedBox(
          width: column2Width,
          child: const FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.center,
            child: Text(
              'Cost/Unit',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ),
        const SizedBox(width: space3Width),
        showAmountAdded
            ? SizedBox(
                width: column2Width,
                child: const FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.center,
                  child: Text(
                    '+Amount',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
