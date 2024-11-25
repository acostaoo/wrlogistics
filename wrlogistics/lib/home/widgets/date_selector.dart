import 'package:WrLogistics/assets/palette.dart';
import 'package:flutter/material.dart';

class DateAndTimeSelector extends StatefulWidget {
  const DateAndTimeSelector({super.key});

  @override
  DateAndTimeSelectorState createState() {
    return DateAndTimeSelectorState();
  }
}

class DateAndTimeSelectorState extends State<DateAndTimeSelector> {
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now().add(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectDate(context),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 80),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.secondary),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.calendar_today),
            const SizedBox(width: 8),
            Text(
              selectedDate != null
                  ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                  : "Seleccionar fecha",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class _TimePicker extends StatefulWidget {
  const _TimePicker({Key? key}) : super(key: key);

  @override
  __TimePickerState createState() => __TimePickerState();
}

class __TimePickerState extends State<_TimePicker> {
  TimeOfDay? selectedTime;

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectTime(context),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 80),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.secondary),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.access_time),
            const SizedBox(width: 8),
            Text(
              selectedTime != null
                  ? "${selectedTime!.hour}:${selectedTime!.minute}"
                  : "Seleccionar hora",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
