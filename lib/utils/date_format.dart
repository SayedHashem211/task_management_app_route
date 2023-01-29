import 'package:intl/intl.dart';

class MyDateUtils{
  static formatTaskDate(DateTime dateTime){
    DateFormat formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(dateTime);
  }

  static DateTime extractDateOnly(DateTime dateTime){
    // to ignore time and make it 00:00:00
    return DateTime(dateTime.year ,
    dateTime.month,
      dateTime.day
    );
  }
}

// extension func (add func to class you didn't make it)
// DateTime class
// to use it , delete above extractDateOnly method
// extension DateTimeExtension on DateTime {
//   DateTime extractDateOnly(){
//    // inside DateTime class scope
//     return DateTime(this.year ,
//     this.month , this.day
//     );
//   }
// }