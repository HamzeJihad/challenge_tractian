
import 'package:flutter_tractian/core/exceptions/server_exception.dart';

class UnauthorizedException extends ServerException {
  UnauthorizedException() : super(message: 'Unauthorized');
}