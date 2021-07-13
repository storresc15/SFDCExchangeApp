public with sharing class ExchangeService {
    
    private static IExchangeService service() 
    {
		//return (IExchangeService) Application.Service.newInstance(IExchangeService.class);
		return null;
	}
    
    public static void applyExchangeRatesinOpps(Set<Id> oppIds)
    {
        service().applyExchangeRatesinOpps(oppIds);
    }
    public static Map<String, Double> getExchangeRates(Double amount)
    {
        return service().getExchangeRates(amount); 
    }
    
    public static List<ExchangeService.ProvisionalResult> getExchangeRates(List<Double> amountList)
    {
        return service().getExchangeRates(amountList);
    }

	public class ExchangeServiceException extends Exception {} 	

	public class ProvisionalResult {
		public Double exchangedAmount {get; set;}
		public Map<String, Double> mapExchange {get; set;}	
	}

}