package ro.platformaStudiu.serviceClass.Exceptii;

public class InvalidParticipantNumberException extends RuntimeException {
        public InvalidParticipantNumberException(String message) {
        super(message);
    }
}