import 'app_exception.dart';

class Failure {
  final String userMessage;  // ما يراه المستخدم

  const Failure(this.userMessage);

  // تحويل من AppException إلى Failure
  factory Failure.fromException(AppException e) {
    switch (e.type) {
      case ExceptionType.network:
        return const Failure('تحقق من اتصالك بالإنترنت');
      case ExceptionType.auth:
        return const Failure('انتهت جلستك، سجل دخول مجدداً');
      case ExceptionType.notFound:
        return const Failure('البيانات غير موجودة');
      case ExceptionType.server:
        return const Failure('خطأ في الخادم، حاول لاحقاً');
      default:
        return const Failure('حدث خطأ غير متوقع');
    }
  }
}
