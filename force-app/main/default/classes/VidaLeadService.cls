/**
 * @description       : Prueba
 * @author            : Ana Maria Murillo
 * @group             : 
 * @last modified on  : 29-10-2024
 * @last modified by  : Ana Maria Murillo
 * @description 	  : uses https://github.com/callawaycloud/apex-rest-route
**/
@RestResource(urlMapping='/v1/mobility/autos/lead/*')
global class VidaLeadService {
    private static void handleRequest() {
		VidaLeadRoute router = new VidaLeadRoute();
		router.execute();
	}
	@HttpGet
	global static void handleGet() {
		handleRequest();
	}

	@HttpPost
	global static void handlePost() {
		handleRequest();
	}

	@HttpPut
	global static void handlePut() {
		handleRequest();
	}

	@HttpDelete
	global static void handleDelete() {
		handleRequest();
	}
}