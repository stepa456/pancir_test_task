sealed class APIException implements Exception {
  APIException(this.message);
  final String message;
}

class NoInternetConnectionException extends APIException {
  NoInternetConnectionException()
      : super(
            'Похоже, у вас отсутствует подключение к сети. Давайте попробуем еще раз?');
}

class PageNotFoundException extends APIException {
  PageNotFoundException()
      : super('Кажется, страница не найдена. Давайте вернемся назад?');
}

class NothingFoundException extends APIException {
  NothingFoundException()
      : super('По всем вашим фильтрам не найдено продуктов');
}

class UnknownServerException extends APIException {
  UnknownServerException()
      : super('Похоже, произошла ошибка сервера. Давайте вернемся назад?');
}

class TimeOutException extends APIException {
  TimeOutException()
      : super(
            'Превышено время ожидания ответа от сервера. Давайте вернемся назад и попробуем еще раз?');
}
