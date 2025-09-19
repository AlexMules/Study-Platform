package ro.platformaStudiu.serviceClass.Exceptii;

public class InvalidHourException extends RuntimeException {
    public InvalidHourException(String message) {
        super(message);
    }
}
