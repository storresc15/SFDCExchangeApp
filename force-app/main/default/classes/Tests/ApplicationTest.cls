@isTest
public class ApplicationTest {

    @testSetup
    public static void makeData() {
        Opportunity[] testOpps = new List<Opportunity>();
        
        for(integer i = 0; i < 10; i++) {
            Opportunity opp = new Opportunity(Name = 'TestOpp' + 1, Amount = 25.5, StageName = 'Prospecting', CloseDate = system.today());
            testOpps.add(opp);
        }
        insert testOpps;
    }
    
    @isTest
    public static void testOppUpdate() {
        Opportunity opp = [Select id, amount FROM Opportunity LIMIT 1];
        opp.Amount = 25.3;
        update opp;
    }
    
    @isTest
    public static void testContinuation() {
        Object obj = ExchangeContinuationController.startRequest('55');
    }
    
    @isTest
    public static void testWebService() {
        // Invoke the continuation by calling the action method
        Continuation conti = (Continuation)ExchangeContinuationController.startRequest('55');
        
        // Verify that the continuation has the proper requests
        Map<String, HttpRequest> requests = conti.getRequests();
        system.assert(requests.size() == 1);
        //system.assert(requests.get(controller.requestLabel) != null);
        
        // Perform mock callout 
        // (i.e. skip the callout and call the callback method)
        HttpResponse response = new HttpResponse();
        response.setBody('Mock response body');   
        // Set the fake response for the continuation     
        Test.setContinuationResponse('55', response);
        // Invoke callback method
        List<Exception> ex = new List<Exception>();
        try{
          Object result = Test.invokeContinuationMethod(ExchangeContinuationController.processResponse(null), conti);  
        } catch(exception e) {
            ex.add(e);
        }
        // result is the return value of the callback
        //System.assertEquals(null, result);
        // Verify that the controller's result variable
        //   is set to the mock response.
       // System.assertEquals('Mock response body', controller.result);
    }
}