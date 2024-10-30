/**
 * @description       : Prueba
 * @author            : Ana Maria Murillo
 * @group             : 
 * @last modified on  : 29-10-2024
 * @last modified by  : Ana Maria Murillo
 * @description       : uses https://github.com/callawaycloud/apex-rest-route
**/
public with sharing class VidaLeadRoute extends RestRoute {

  protected override Object doPost() {
      if (!String.isEmpty(this.resourceId)) {
          throw new RestRouteError.RestException(
              'Operation not supported',
              'NOT_SUPPORTED',
              404
          );
      } else {
          Object body = JSON.deserializeUntyped(this.request.requestBody.toString());
          JSONParse root = new JSONParse(JSON.serialize(body));
          try {
              Boolean hasNotErrors = VidaValidacionLead.validateData(body,'Vida');
          } catch (VidaFieldNotFoundException e) {
              throw new VidaCustomException.CustomRestException(
                  e.getMessage(),
                  'Not_Acceptable',
                  406
              );
          }

          Map<String, Object> ipInput = new Map<String, Object>(); // Mapa para los datos de entrada
            ipInput.put('mobile_phone', root.get('mobile_phone').getStringValue());
            ipInput.put('email', root.get('email').getStringValue());
            ipInput.put('name', root.get('name').getStringValue());
            ipInput.put('status', root.get('status').getStringValue());
            //ipInput.put('swMockError', SURAMovilidadGetFlagErrorMock.getFlagErrorMock());
          // Llamada al Integration Procedure 
          
			Map<String, Object> response = (Map<String, Object>) vlocity_cmt.IntegrationProcedureService.runIntegrationService(
                'VidaPostLeadCreate',
                ipInput,
                new Map<String, Object>()
            );
        
          VidaLeadRoute.validarResponsePost(response);
          return response;
      }
  }

  public static Object validarResponsePost(Map<String, Object> response) {
    Map<String, Object> data = (Map<String, Object>) response.get('data');
    if (data.containsKey('error')) {
      String message = (String) data.get('message');
      String errorCode = (String) data.get('errorCode');
      Integer error = Integer.valueOf(data.get('error'));
      throw new VidaCustomException.CustomRestException(
        message,
        errorCode,
        error
      );
    }
     
    return response;
  }
}