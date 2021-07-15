public with sharing class ExchangeContinuationController {
    
    private static final String LONG_RUNNING_SERVICE_URL = 'https://whispering-cove-18050.herokuapp.com/rates/';
    
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
      req.setEndpoint(LONG_RUNNING_SERVICE_URL + value);
      // Add callout request to continuation
      con.addHttpRequest(req);
      // Return the continuation
      return con;
    }
    
    // Callback method
    @AuraEnabled(cacheable=true)
    public static Object processResponse(List<String> labels, Object state) {
      // Get the response by using the unique label
      HttpResponse response = Continuation.getResponse(labels[0]);
      // Set the result variable
      ExchangeService.ExchangeWrapper ex = new ExchangeService.ExchangeWrapper();
      ex = (ExchangeService.ExchangeWrapper) JSON.deserialize(response.getBody(),ExchangeService.ExchangeWrapper.class);
      system.debug('The list: ' + ex);
      return ex;
    }

}