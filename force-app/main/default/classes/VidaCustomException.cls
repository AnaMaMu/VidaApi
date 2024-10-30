public class VidaCustomException extends Exception {

    // Clase anidada para manejar excepciones REST personalizadas
    public class CustomRestException extends Exception {
        public String errorCode;
        public Integer httpStatusCode;

        // Constructor para la excepción personalizada
        public CustomRestException(String message, String errorCode, Integer httpStatusCode) {
            this.errorCode = errorCode;
            this.httpStatusCode = httpStatusCode;
            super.setMessage(message);  // Establece el mensaje usando el método disponible en la clase base
        }
    }
}