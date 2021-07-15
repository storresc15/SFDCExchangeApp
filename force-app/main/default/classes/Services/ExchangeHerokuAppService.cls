/*********************************************************************************
Class Name      : ExchangeHerokuAppService
Description     : Callout service class to Heroku App 
Created By      : Sebastian Torres
Created Date    : 2021-07-07
Modification Log:
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-07-07              Initial version 

*********************************************************************************/
public class ExchangeHerokuAppService extends RestClient {
    
    private static final string DEFAULTNAMEDCREDENTIAL = 'ExchangeApp';
    
    public ExchangeHerokuAppService() {
        namedCredentialName = DEFAULTNAMEDCREDENTIAL;
    }
    
    public Map<String, Double> callService(double amount) {
        
        Http h = new Http();
        String requestUrl = '/rates/' + amount;
        HttpResponse res = get(requestUrl);
        
        string result=res.getBody();
    	system.debug('^^^^^^'+result);
        
        ResponseWrapper wrapper = (ResponseWrapper)JSON.deserialize(result, ResponseWrapper.class);
        system.debug('Wrapper values: ' + wrapper);

        Map<String, Double> returnedValues = New Map<String, Double>();
        returnedValues.put('EUR', Double.valueOf(wrapper.EUR));
        returnedValues.put('CAD', Double.valueOf(wrapper.CAD));
        returnedValues.put('USD', Double.valueOf(wrapper.USD));
        returnedValues.put('MXN', Double.valueOf(wrapper.MXN));
        return returnedValues;
    }
    
    public class ResponseWrapper {

	public String EUR;
	public String USD;
	public String CAD;
	public String MXN;

	}

}