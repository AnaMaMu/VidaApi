public class VidaValidacionLead {
    public static Boolean validateData(Object body, String producto) {
        // Convertir el cuerpo deserializado a un mapa para acceder a los valores
        Map<String, Object> mockData = (Map<String, Object>) body;
        
        // Verificar si el mapa 'mockData' contiene el objeto 'data'
        if (!mockData.containsKey('data')) {
            throw new VidaFieldNotFoundException('No se encontró la clave "data" en el objeto JSON');
        }
        
        // Convertir el objeto 'data' a un mapa
        Map<String, Object> data = (Map<String, Object>) mockData.get('data');
        
        // Verificar si el mapa 'data' contiene el objeto 'lead'
        if (!data.containsKey('lead')) {
            throw new VidaFieldNotFoundException('No se encontró la clave "lead" en el objeto "data"');
        }
        
        // Convertir el objeto 'lead' a un mapa
        Map<String, Object> leadData = (Map<String, Object>) data.get('lead');
        
        // Validación de campos requeridos para 'Vida'producto
        if (producto == 'Vida') {
            // Verificar que los campos 'mobile_phone', 'email', 'name', y 'status' estén presentes
            if (!leadData.containsKey('mobile_phone') || !leadData.containsKey('email') ||
                !leadData.containsKey('name') || !leadData.containsKey('status')) {
                throw new VidaFieldNotFoundException('Falta uno o más campos requeridos en el lead');
            }
            
            // Validar que el campo 'mobile_phone' tenga al menos 10 dígitos
            String mobilePhone = (String) leadData.get('mobile_phone');
            if (mobilePhone.length() < 10) {
                throw new VidaFieldNotFoundException('El campo "mobile_phone" debe tener al menos 10 dígitos');
            }
            
            // Validar que el campo 'email' contenga un '@'
            String email = (String) leadData.get('email');
            if (!email.contains('@')) {
                throw new VidaFieldNotFoundException('El campo "email" debe contener un "@"');
            }
            
            // Validar que el 'status' sea un valor permitido (ej.: 'contacted', 'new', 'qualified')
            String status = (String) leadData.get('status');
            if (status != 'contacted' && status != 'new' && status != 'qualified') {
                throw new VidaFieldNotFoundException('El campo "status" tiene un valor no permitido');
            }
        }
        
        // Si todas las validaciones pasan, retornar true
        return true;
    }
}