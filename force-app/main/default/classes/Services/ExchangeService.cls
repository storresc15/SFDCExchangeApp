/*********************************************************************************
Class Name      : ExchangeService
Description     : Main Exchange Service class, agnostic service layer to be called
Created By      : Sebastian Torres
Created Date    : 2021-07-13  
Modification Log: 
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-07-13               Initial version
*********************************************************************************/
public with sharing class ExchangeService {
    
    private static IExchangeService service() 
    {
		return (IExchangeService) Application.Service.newInstance(IExchangeService.class);
	}
    
    public static void applyExchangeRatesinOpps(Set<Id> oppIds)
    {
        service().applyExchangeRatesinOpps(oppIds);
    }
    public static Map<String, Double> getExchangeRates(Double amount)
    {
        return service().getExchangeRates(amount); 
    }
    
    public static Map<Double, ExchangeService.ProvisionalResult> getExchangeRates(List<Double> amountList)
    {
        return service().getExchangeRates(amountList);
    }
    
    public static void asyncApplyExchangeRatesinOpps(Set<id> oppIds)
    {
        service().asyncApplyExchangeRatesinOpps(oppIds);
    }

	public class ExchangeServiceException extends Exception {} 	

	public class ProvisionalResult {
		public Double exchangedAmount {get; set;}
		public Map<String, Double> mapExchange {get; set;}	
	}
    
    public class ExchangeWrapper {
        @AuraEnabled
        public String EUR {get;set;}
        @AuraEnabled    
        public String USD {get;set;}
        @AuraEnabled    
        public String CAD {get;set;}
        @AuraEnabled    
        public String MXN {get;set;}
    }

}