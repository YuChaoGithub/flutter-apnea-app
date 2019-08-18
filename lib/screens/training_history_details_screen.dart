import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/training_table.dart';
import '../providers/training_history_provider.dart';

class TrainingHistoryDetailsScreen extends StatelessWidget {
  static const routeName = '/training-history-details';

  @override
  Widget build(BuildContext context) {
    final historyKey = ModalRoute.of(context).settings.arguments as String;
    final history = Provider.of<TrainingHistoryProvider>(context, listen: false)
        .getHistory(historyKey);
    final noDescription = (history.description == "");
    final noContractions = history.contractions.isEmpty;

    return Scaffold(
      appBar: AppBar(
        title: Text(history.name),
        leading: IconButton(
          icon: Image.asset(
            'assets/icons/back.png',
            color: Theme.of(context).primaryIconTheme.color,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(DateFormat('yyyy-MM-dd HH:mm')
                  .format(history.trainingDateTime)),
              SizedBox(height: 30),
              if (!noDescription)
                const Text(
                  'Training Description:',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
              if (!noDescription) SizedBox(height: 20),
              if (!noDescription) Text(history.description),
              if (!noDescription) SizedBox(height: 30),
              if (!noContractions)
                const Text(
                  'Diaphragm Contractions:',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
              if (!noContractions) SizedBox(height: 20),
              if (!noContractions)
                ...List<Column>.generate(history.contractions.length, (i) {
                  return Column(
                    children: <Widget>[
                      Text(
                        '${i + 1}. Starts at: ${history.contractions[i].toString()}',
                      ),
                      SizedBox(height: 10),
                    ],
                  );
                }).toList(),
              SizedBox(height: 30),
              TableWidget(table: history.table),
            ],
          ),
        ),
      ),
    );
  }
}

class TableWidget extends StatelessWidget {
  final List<TrainingTableEntry> table;

  TableWidget({this.table});

  TableRow _buildTableRow(String index, String holdTime, String breathTime,
      {bool isTitle = false, BuildContext context}) {
    return TableRow(
      decoration: isTitle
          ? BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 1,
                      color: Theme.of(context).textTheme.body1.color)))
          : BoxDecoration(),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3.0),
          child: Text(
            index,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3.0),
          child: Text(
            holdTime,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3.0),
          child: Text(
            breathTime,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.top,
        columnWidths: {
          0: FractionColumnWidth(0.15),
        },
        children: <TableRow>[
          _buildTableRow('#', 'Hold', 'Breathe',
              isTitle: true, context: context),
          ...List<TableRow>.generate(table.length, (i) {
            return _buildTableRow(
              '${i + 1}',
              table[i].holdTime.toString(),
              table[i].breatheTime.toString(),
              context: context,
            );
          }).toList(),
        ],
      ),
    );
  }
}
