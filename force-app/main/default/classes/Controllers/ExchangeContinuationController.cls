/*********************************************************************************
Class Name      : ExchangeContinuationController
Description     : Controller for Continuation Exchange component, implements continuation
Created By      : Sebastian Torres
Created Date    : 2021-07-13 
Modification Log: 
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-07-13              Initial version
*********************************************************************************/
public with sharing class ExchangeContinuationController {
    
    private static final String LONG_RUNNING_SERVICE_URL = 'https://whispering-cove-18050.herokuapp.com';
    
    // Action method
    @AuraEnabled(continuation=true cacheable=true)
    public static Object startRequest(String value) {
      // Create continuation. Argument is timeout in seconds.
      Continuation con = new Continuation(40);
      // Set callback method
      con.continuationMethod='processResponse';
      // Set state
      con.state='Hello, World!';
      // Create callout request
      HttpRequest req = new HttpRequest();
      req.setMethod('GET');
      req.setEndpoint(LONG_RUNNING_SERVICE_URL +'/rates/' + value);
      // Add callout request to continuation
      //con.addHttpRequest(req);
      con.state = con.addHttpRequest(req);
      // Return the continuation
      system.debug('Running continuation from controller');
      return con;
    }
    
    // Callback method
    @AuraEnabled(cacheable=true)
    public static Object processResponse(Object state) {
      // Get the response by using the unique label
      HttpResponse response = Continuation.getResponse((String)state);
      // Set the result variable
      //return response.getBody();
      ExchangeService.ExchangeWrapper ex = new ExchangeService.ExchangeWrapper();
      ex = (ExchangeService.ExchangeWrapper) JSON.deserialize(response.getBody(),ExchangeService.ExchangeWrapper.class);
      system.debug('The list: ' + ex);
      return ex;
    }

}