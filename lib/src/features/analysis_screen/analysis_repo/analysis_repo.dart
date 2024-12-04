import 'package:formulator/src/entities/models/entry.dart';
import 'package:formulator/src/entities/models/formula.dart';
import 'package:formulator/src/entities/models/section.dart';
import 'package:formulator/src/entities/models/sub_section.dart';
import 'package:formulator/src/features/analysis_screen/models/entry_with_details.dart';

class AnalysisRepo {
  /// Returns the 100% formula and the cost of achieving it
  static (Formula, double) analyzeTo100Percent(
    Formula initialFormula,
  ) {
    double totalCost = 0;
    final newFormula = Formula(name: initialFormula.name, sections: []);

    for (Section section in initialFormula.sections) {
      final Section newSection =
          Section(name: section.name, weight: section.weight, subsections: []);

      for (SubSection subSection in section.subsections) {
        final SubSection newSubsection = SubSection(
          name: subSection.name,
          weight: subSection.weight,
          entries: [],
        );

        for (Entry entry in subSection.entries) {
          late final Entry newEntry;
          if (entry.value >= entry.referenceValue) {
            newEntry = entry.copyWith();
          } else {
            final int units = entry.referenceValue - entry.value;
            final double cost = units * entry.costPerUnit;
            totalCost += cost;

            newEntry = entry.copyWith(
              value: entry.value < entry.referenceValue
                  ? entry.referenceValue
                  : entry.value,
            );
          }

          newSubsection.entries.add(newEntry);
        }

        newSection.subsections.add(newSubsection);
      }

      newFormula.sections.add(newSection);
    }

    return (newFormula, totalCost);
  }

  static (Formula, double) analyzeWithAmount(
    Formula initialFormula,
    double availableAmount,
  ) {
    double amountSpent = 0;

    final List<DetailedEntry> allDetailedEntries =
        _getDetailedEntries(initialFormula);

    while (true) {
      late final double lowestAnswer;
      late final double secondLowestAnswer;

      late final List<DetailedEntry> entriesWithLowestAnswer;

      if (allDetailedEntries.length > 1) {
        (lowestAnswer, secondLowestAnswer) =
            _getLowestAndSecondLowestAnswers(allDetailedEntries);
        entriesWithLowestAnswer = allDetailedEntries
            .where((DetailedEntry entry) => entry.answer == lowestAnswer)
            .toList();
        entriesWithLowestAnswer
            .sort((a, b) => a.impactOnFormula.compareTo(b.impactOnFormula));
      } else if (allDetailedEntries.length == 1) {
        lowestAnswer = allDetailedEntries[0].answer;
        secondLowestAnswer = 1;
        entriesWithLowestAnswer = [allDetailedEntries[0]];
      } else {
        throw Exception('There are no entries in the formula!');
      }

      for (DetailedEntry entry in entriesWithLowestAnswer) {
        int unitsToReach2ndLowest =
            ((secondLowestAnswer * entry.referenceValue) -
                    (lowestAnswer * entry.referenceValue))
                .toInt();

        while (unitsToReach2ndLowest > 0) {
          if (availableAmount >= entry.costPerUnit) {
            final int indexOfEntry = allDetailedEntries
                .indexWhere((DetailedEntry e) => e.name == entry.name);
            allDetailedEntries.replaceRange(
              indexOfEntry,
              indexOfEntry + 1,
              [
                entry.copyWith(
                    newValue: allDetailedEntries[indexOfEntry].value + 1)
              ],
            );
            unitsToReach2ndLowest--;
            availableAmount -= entry.costPerUnit;
            amountSpent += entry.costPerUnit;
          } else {
            final Formula newFormula = _getNewFormulaObjectFromDetailedEntries(
              initialFormula: initialFormula,
              detailedEntries: allDetailedEntries,
            );

            return (newFormula, amountSpent);
          }
        }
      }
    }
  }

  static List<DetailedEntry> _getDetailedEntries(Formula initialFormula) {
    final List<DetailedEntry> detailedEntries = [];
    for (Section section in initialFormula.sections) {
      for (SubSection subSection in section.subsections) {
        for (Entry entry in subSection.entries) {
          detailedEntries.add(
            DetailedEntry(
              name: entry.name,
              value: entry.value,
              referenceValue: entry.referenceValue,
              weight: entry.weight,
              costPerUnit: entry.costPerUnit,
              answer: entry.value / entry.referenceValue,
              subSectionName: subSection.name,
              sectionName: section.name,
              impactOnFormula: ((entry.weight / subSection.totalEntriesWeight) /
                      section.totalSubSectionWeight) /
                  initialFormula.totalSectionWeight,
            ),
          );
        }
      }
    }
    return detailedEntries;
  }

  static (double lowest, double secondLowest) _getLowestAndSecondLowestAnswers(
    List<DetailedEntry> detailedEntries,
  ) {
    double lowest = double.infinity;
    double secondLowest = double.infinity;

    for (DetailedEntry entry in detailedEntries) {
      if (entry.answer < lowest) {
        secondLowest = lowest;
        lowest = entry.answer;
      } else if (entry.answer < secondLowest && entry.answer != lowest) {
        secondLowest = entry.answer;
      }
    }
    if (secondLowest == double.infinity || lowest == double.infinity) {
      throw Exception(
          '======= There are less than 2 entries in the formula! =======');
    }
    return (lowest, secondLowest);
  }

  static Formula _getNewFormulaObjectFromDetailedEntries({
    required Formula initialFormula,
    required List<DetailedEntry> detailedEntries,
  }) {
    final Formula newFormula = Formula(
      name: initialFormula.name,
      sections: initialFormula.sections
          .map(
            (Section section) => Section(
              name: section.name,
              weight: section.weight,
              subsections: section.subsections
                  .map(
                    (SubSection subSection) => SubSection(
                      name: subSection.name,
                      weight: subSection.weight,
                      entries: [],
                    ),
                  )
                  .toList(),
            ),
          )
          .toList(),
    );

    for (DetailedEntry detailedEntry in detailedEntries) {
      newFormula.sections
          .firstWhere(
              (Section section) => section.name == detailedEntry.sectionName)
          .subsections
          .firstWhere((SubSection subSection) =>
              subSection.name == detailedEntry.subSectionName)
          .entries
          .add(
            Entry(
              name: detailedEntry.name,
              value: detailedEntry.value,
              referenceValue: detailedEntry.referenceValue,
              weight: detailedEntry.weight,
              costPerUnit: detailedEntry.costPerUnit,
            ),
          );
    }
    return newFormula;
  }
}