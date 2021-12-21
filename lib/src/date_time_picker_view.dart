import 'package:date_time_picker_widget/src/date/date_picker_view.dart';
import 'package:date_time_picker_widget/src/date_time_picker_type.dart';
import 'package:date_time_picker_widget/src/date_time_picker_view_model.dart';
import 'package:date_time_picker_widget/src/time/time_picker_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class DateTimePicker extends ViewModelBuilderWidget<DateTimePickerViewModel> {
  final DateTime initialSelectedDate;
  final Function(DateTime date, DateTimePickerViewModel v) onDateChanged;
  final Function(DateTime time) onTimeChanged;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime startTime;
  final DateTime endTime;
  final Duration timeInterval;
  final bool is24h;
  final DateTimePickerType type;
  final String timeOutOfRangeError;
  final String datePickerTitle;
  final String timePickerTitle;

  final IconData? timeIcon;
  final IconData? dateIcon;

  /// Constructs a DateTimePicker
  const DateTimePicker({
    Key? key,
    required this.initialSelectedDate,
    required this.onDateChanged,
    required this.onTimeChanged,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    this.timeIcon,
    this.dateIcon,
    this.timeInterval = const Duration(minutes: 1),
    this.is24h = false,
    this.type = DateTimePickerType.Both,
    this.timeOutOfRangeError = 'Out of Range',
    this.datePickerTitle = 'Pick a Date',
    this.timePickerTitle = 'Pick a Time',
  }) : super(key: key);

  @override
  Widget builder(
      BuildContext context, DateTimePickerViewModel viewModel, Widget? child) {
    if (!initialSelectedDate.isAfter(startDate)) {
      throw Exception('initialSelectedDate must be a date after startDate');
    }

    if (!initialSelectedDate.isBefore(endDate)) {
      throw Exception('initialSelectedDate must be a date before endDate');
    }

    if (!endDate.isAfter(startDate)) {
      throw Exception('endDate must be a date after startDate');
    }

    if (!endTime.isAfter(startTime)) {
      throw Exception('endTime must be a time after startTime');
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (type == DateTimePickerType.Both ||
                  type == DateTimePickerType.Date)
                DatePickerView(
                  constraints: constraints,
                  icon: dateIcon,
                ),
              if (type == DateTimePickerType.Both) const SizedBox(height: 5),
              if (type == DateTimePickerType.Both ||
                  type == DateTimePickerType.Time)
                TimePickerView(
                  icon: timeIcon,
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  DateTimePickerViewModel viewModelBuilder(BuildContext context) =>
      DateTimePickerViewModel(
        initialSelectedDate,
        onDateChanged,
        onTimeChanged,
        startDate,
        endDate,
        startTime,
        endTime,
        timeInterval,
        is24h,
        type,
        timeOutOfRangeError,
        datePickerTitle,
        timePickerTitle,
      );

  @override
  void onViewModelReady(DateTimePickerViewModel viewModel) => viewModel.init();
}
