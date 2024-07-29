import 'package:date_time_picker_widget/src/date_time_picker_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:stacked/stacked.dart';

class TimePickerView extends ViewModelWidget<DateTimePickerViewModel> {
  final IconData? icon;
  final bool? isDeviderForTime;
  const TimePickerView(
      {Key? key,
      this.icon,
      this.isDeviderForTime = false})
      : super(key: key);

  @override
  Widget build(BuildContext context, DateTimePickerViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            if (icon != null)
              const SizedBox(
                width: 10,
              ),
            if (icon != null)
              Icon(
                icon!,
                color: Theme.of(context).hintColor,
              ),
              if(viewModel.isDeviderForTime != false)
              Padding(
              padding: const EdgeInsets.only(left: 16, top: 16,),
              child: Text(
                '${viewModel.timePickerTitle}',
                style: viewModel.timePickerTitleStyle ??
                    Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).hintColor,
                        ),
              ),
            ),
            if(viewModel.isDeviderForTime != true)
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
              child: Text(
                '${viewModel.timePickerTitle}',
                style: viewModel.timePickerTitleStyle ??
                    Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).hintColor,
                        ),
              ),
            ),
          ],
        ),
        if(viewModel.isDeviderForTime != false)
        const Padding(
          padding: EdgeInsets.only(left: 15, right: 20),
          child: Divider(),
        ),
        Container(
          height: 45,
          alignment: Alignment.center,
          child: viewModel.timeSlots == null
              ? Text(
                  viewModel.timeOutOfRangeError,
                  style: const TextStyle(color: Colors.black87),
                )
              : ScrollablePositionedList.builder(
                  itemScrollController: viewModel.timeScrollController,
                  itemPositionsListener: viewModel.timePositionsListener,
                  scrollDirection: Axis.horizontal,
                  itemCount: viewModel.timeSlots!.length,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  itemBuilder: (context, index) {
                    final date = viewModel.timeSlots![index];
                    return InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () => viewModel.selectedTimeIndex = index,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: index == viewModel.selectedTimeIndex
                                ? Theme.of(context).colorScheme.primary
                                : Colors.grey,
                          ),
                          color: index == viewModel.selectedTimeIndex
                              ? Theme.of(context).colorScheme.primary
                              : Colors.white,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          // ignore: lines_longer_than_80_chars
                          '${DateFormat(viewModel.is24h ? 'HH:mm' : 'hh:mm aa').format(date)}',
                          style: TextStyle(
                              fontSize: 14,
                              color: index == viewModel.selectedTimeIndex
                                  ? Colors.white
                                  : Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
