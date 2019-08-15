import 'package:apnea/models/minute_second.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/training_table_provider.dart';
import '../models/training_table.dart';

class TrainingTableDetailScreen extends StatefulWidget {
  static const routeName = '/training-table-detail';
  static const durationSelections = [
    '1:00',
    '1:30',
    '2:00',
    '2:30',
    '3:00',
    '3:30',
    '4:00',
    '4:30',
    '5:00',
  ];

  @override
  _TrainingTableDetailScreenState createState() =>
      _TrainingTableDetailScreenState();
}

class _TrainingTableDetailScreenState extends State<TrainingTableDetailScreen> {
  static const _trainingTableRange = [3, 4, 5, 6];
  final _form = GlobalKey<FormState>();
  int _totalTableRows = 4;
  TrainingTable _editedForm;
  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final tableKey = ModalRoute.of(context).settings.arguments as String;
      if (tableKey != null) {
        _editedForm = Provider.of<TrainingTableProvider>(context, listen: false)
            .getTable(tableKey);
      } else {
        _editedForm = TrainingTable(
          key: UniqueKey().toString(),
          name: '',
          description: '',
          table: [
            TrainingTableEntry(
              index: 0,
              holdTime: MinuteSecond.fromString('1:00'),
              breatheTime: MinuteSecond.fromString('1:00'),
            ),
            TrainingTableEntry(
              index: 1,
              holdTime: MinuteSecond.fromString('1:00'),
              breatheTime: MinuteSecond.fromString('1:00'),
            ),
            TrainingTableEntry(
              index: 2,
              holdTime: MinuteSecond.fromString('1:00'),
              breatheTime: MinuteSecond.fromString('1:00'),
            )
          ],
        );
      }
      _totalTableRows = _editedForm.table.length;
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) return;
    _form.currentState.save();
    // if (_editedForm.key != null) {
    //   Provider.of<TrainingTableProvider>(context, listen: false)
    //       .updateTable(_editedForm.key, _editedForm);
    // } else {
    //   Provider.of<TrainingTableProvider>(context, listen: false)
    //       .addTable(_editedForm);
    // }
    Provider.of<TrainingTableProvider>(context, listen: false)
        .addTable(_editedForm)
        .then((val) => Navigator.of(context).pop());
  }

  void _tableChanged(List<List<String>> tableContent) {
    List<TrainingTableEntry> newTable = [];
    for (int i = 0; i < _totalTableRows; i++) {
      newTable.add(
        TrainingTableEntry(
          index: i,
          holdTime: MinuteSecond.fromString(tableContent[i][0]),
          breatheTime: MinuteSecond.fromString(tableContent[i][1]),
        ),
      );
    }
    _editedForm.table = newTable;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        leading: IconButton(
          icon: Image.asset(
            'assets/icons/back.png',
            color: Theme.of(context).iconTheme.color,
          ),
          color: Theme.of(context).errorColor,
          onPressed: () {
            showDialog(
              context: context,
              builder: (ctx) {
                return AlertDialog(
                  title: const Text(
                    'Alert',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  content: const Text('Exit without saving?'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text(
                        'Continue Editing',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.button.color,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    FlatButton(
                      child: Text(
                        'Sure',
                        style: TextStyle(
                          color: Theme.of(context).errorColor,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Image.asset(
              'assets/icons/check.png',
              color: Theme.of(context).iconTheme.color,
            ),
            onPressed: _saveForm,
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: Form(
        key: _form,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 50.0,
                ),
                child: TextFormField(
                    initialValue: _editedForm.name,
                    maxLength: 30,
                    maxLengthEnforced: true,
                    decoration: InputDecoration(
                      labelText: 'Training Session Name',
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a name.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _editedForm.name = value;
                    }),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 50.0,
                ),
                child: TextFormField(
                  initialValue: _editedForm.description,
                  decoration: InputDecoration(
                    labelText: 'Description',
                  ),
                  maxLines: 3,
                  maxLength: 75,
                  maxLengthEnforced: true,
                  onSaved: (value) {
                    _editedForm.description = value;
                  },
                ),
              ),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Total Rounds: '),
                  DropdownButton(
                    value: _totalTableRows,
                    items: _trainingTableRange.map((i) {
                      return DropdownMenuItem(value: i, child: Text('$i'));
                    }).toList(),
                    onChanged: (val) {
                      setState(() => _totalTableRows = val);
                    },
                    underline: DropdownButtonUnderline(),
                  ),
                ],
              ),
              SizedBox(height: 25),
              TrainingTableInputWidget(
                  _totalTableRows, _tableChanged, _editedForm.table),
            ],
          ),
        ),
      ),
    );
  }
}

class TrainingTableInputWidget extends StatefulWidget {
  final int _totalTableRows;
  final Function _dropdownChanged;
  final List<TrainingTableEntry> _existingTableRows;

  TrainingTableInputWidget(
      this._totalTableRows, this._dropdownChanged, this._existingTableRows);

  @override
  _TrainingTableInputWidgetState createState() =>
      _TrainingTableInputWidgetState();
}

class _TrainingTableInputWidgetState extends State<TrainingTableInputWidget> {
  List<List<String>> _tableContents = [
    ['1:00', '1:00'],
    ['1:00', '1:00'],
    ['1:00', '1:00'],
    ['1:00', '1:00'],
    ['1:00', '1:00'],
    ['1:00', '1:00'],
  ];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget._existingTableRows.length; i++) {
      _tableContents[i][0] = widget._existingTableRows[i].holdTime.toString();
      _tableContents[i][1] =
          widget._existingTableRows[i].breatheTime.toString();
    }
  }

  void _onSelectionChanged(int index, int col, String value) {
    setState(() => _tableContents[index][col] = value);
    widget._dropdownChanged(_tableContents);
  }

  TableRow _buildTableRow(int index) {
    return TableRow(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Text(
            '${index + 1}',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        ),
        DurationDropDownMenu(
          index,
          0,
          _tableContents[index][0],
          _onSelectionChanged,
        ),
        DurationDropDownMenu(
          index,
          1,
          _tableContents[index][1],
          _onSelectionChanged,
        ),
      ],
    );
  }

  Widget _buildTableText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.top,
        columnWidths: {0: FractionColumnWidth(0.1)},
        children: <TableRow>[
          TableRow(
            decoration:
                BoxDecoration(border: Border(bottom: BorderSide(width: 1))),
            children: <Widget>[
              _buildTableText('#'),
              _buildTableText('Hold'),
              _buildTableText('Breathe'),
            ],
          ),
          ...List<TableRow>.generate(
            widget._totalTableRows,
            (i) {
              return _buildTableRow(i);
            },
          ),
        ],
      ),
    );
  }
}

class DurationDropDownMenu extends StatelessWidget {
  final int _index;
  final int _col;
  final String _selected;
  final Function _onSelectionChanged;

  DurationDropDownMenu(
    this._index,
    this._col,
    this._selected,
    this._onSelectionChanged,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: DropdownButton(
        value: _selected,
        items: TrainingTableDetailScreen.durationSelections.map((val) {
          return DropdownMenuItem(child: Text(val), value: val);
        }).toList(),
        onChanged: (val) => _onSelectionChanged(_index, _col, val),
        underline: DropdownButtonUnderline(),
      ),
    );
  }
}

class DropdownButtonUnderline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.0,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).textTheme.title.color,
            width: 1.0,
          ),
        ),
      ),
    );
  }
}
