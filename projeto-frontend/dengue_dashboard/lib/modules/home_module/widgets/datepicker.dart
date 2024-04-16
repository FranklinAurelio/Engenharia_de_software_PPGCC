import 'package:flutter/material.dart';

class DatePickerFilter extends StatefulWidget {
  const DatePickerFilter({super.key, this.restorationId});
  final String? restorationId;
  @override
  State<DatePickerFilter> createState() => _DatePickerFilterState();
}

class _DatePickerFilterState extends State<DatePickerFilter>
    with RestorationMixin {
  @override
  String? get restorationId => widget.restorationId;
  String selectedDate = 'Selecione a data';
  final RestorableDateTime _selectedDate = RestorableDateTime(DateTime(2023));
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  @pragma('vm:entry-point')
  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          initialCalendarMode: DatePickerMode.year,
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(2023),
          lastDate: DateTime(2026),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        selectedDate =
            '${_selectedDate.value.month}/${_selectedDate.value.year}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            _restorableDatePickerRouteFuture.present();
          },
          child: Text(selectedDate),
        ),
      ),
    );
  }
}
