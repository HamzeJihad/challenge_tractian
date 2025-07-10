
import 'package:flutter_tractian/core/exceptions/server_exception.dart';

class TimeoutException extends ServerException {
  TimeoutException() : super(message: 'Request timed out');
}