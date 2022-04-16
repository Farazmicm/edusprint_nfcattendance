import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nfcdemo/utilities/constants.dart';
import 'package:nfcdemo/widgets/widgets.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget(
      {Key? key,
      this.lstCalendarData,
      this.calendarController,
      this.isShowAgenda = false,
      this.appointmentDisplayMode = MonthAppointmentDisplayMode.appointment,
      this.calendarView = CalendarView.month})
      : super(key: key);

  final List<Meeting>? lstCalendarData;
  final CalendarController? calendarController;
  final bool isShowAgenda;
  final MonthAppointmentDisplayMode appointmentDisplayMode;
  final CalendarView calendarView;

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return SfCalendar(
      // appointmentBuilder:(context, calendarAppointmentDetails){
      //   return Text(calendarAppointmentDetails.bounds());
      // },
      scheduleViewMonthHeaderBuilder:
          (BuildContext buildContext, ScheduleViewMonthHeaderDetails details) {
        final String monthName =
            DateFormat('MMMM').format(DateTime(0, details.date.month));
        return Stack(
          children: [
            Image(
                image: ExactAssetImage('assets/calendar/' + monthName + '.png'),
                fit: BoxFit.cover,
                width: details.bounds.width,
                height: details.bounds.height),
            Positioned(
              left: 55,
              right: 0,
              top: 20,
              bottom: 0,
              child: CustomTextSingleLine(
                content: monthName + ' ' + details.date.year.toString(),
                style:
                    GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )
          ],
        );
      },
      maxDate: DateTime.parse(yearEndDate),
      minDate: DateTime.parse(yearStartDate),
      cellBorderColor: Colors.black12,
      viewHeaderHeight: 30,
      viewHeaderStyle: ViewHeaderStyle(
          backgroundColor: theme.colorScheme.primaryVariant,
          dayTextStyle: GoogleFonts.lato(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.secondary)),
      headerStyle: CalendarHeaderStyle(
          backgroundColor: theme.colorScheme.primary,
          textAlign: TextAlign.center,
          textStyle: GoogleFonts.lato(
              color: theme.colorScheme.background,
              fontWeight: FontWeight.bold,
              fontSize: 18)),
      headerHeight: 50,
      // onTap: (calendarTapDetails) {
      //     if(calendarTapDetails.appointments!.isNotEmpty)
      //       showCustomToast(context, calendarTapDetails.date.toString());
      // },
      viewNavigationMode: ViewNavigationMode.snap,
      initialSelectedDate: DateTime.now(),
      showDatePickerButton: true,
      showNavigationArrow: true,
      controller: widget.calendarController,
      view: widget.calendarView,
      dataSource: MeetingDataSource(widget.lstCalendarData ?? _getDataSource()),
      // by default the month appointment display mode set as Indicator, we can
      // change the display mode as appointment using the appointment display
      // mode property

      monthViewSettings: MonthViewSettings(
          agendaViewHeight: 350,
          agendaItemHeight: 40,
          showTrailingAndLeadingDates: true,
          showAgenda: widget.isShowAgenda,
          agendaStyle: AgendaStyle(
            dayTextStyle: GoogleFonts.lato(fontSize: 16),
          ),
          appointmentDisplayMode: widget.appointmentDisplayMode),
    );
  }
}

List<Meeting> _getDataSource() {
  final List<Meeting> meetings = <Meeting>[];
  final DateTime today = DateTime.now();
  final DateTime startTime =
      DateTime(today.year, today.month, today.day, 9, 0, 0);

  final DateTime endTime = startTime.add(const Duration(hours: 2));
  meetings.add(Meeting(
      'Conference', startTime, endTime, const Color(0xFF0F8644), false));

  return meetings;
}

/// An object to set the appointment collection data source to calendar, which
/// used to map the custom appointment data to the calendar appointment, and
/// allows to add, remove or reset the appointment collection.
class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the event data which will be rendered in calendar.
class Meeting {
  /// Creates a meeting class with required details.
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;
}
