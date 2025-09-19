package ro.platformaStudiu.serviceClass.Exceptii;

public class InvalidDayException extends RuntimeException {
  public InvalidDayException(String message) {
    super(message);
  }
}
