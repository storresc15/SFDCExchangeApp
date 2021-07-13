public inherited sharing class ExchangeServiceImp implements IExchangeService {
    
    public void applyExchangeRatesinOpps(Set<Id> oppIds)
    {
       //To be implemented with async processor 
    }
    public Map<String, Double> getExchangeRates(Double amount)
    {
        ExchangeHerokuAppService service = new ExchangeHerokuAppService();
        return service.callService(amount);
        
    }
    
    public List<ExchangeService.ProvisionalResult> getExchangeRates(List<Double> amountList)
    {
        List<ExchangeService.ProvisionalResult> results = new List<ExchangeService.ProvisionalResult>();
        for(double amount : amountList) 
        {
           ExchangeService.ProvisionalResult ex = new ExchangeService.ProvisionalResult();
            ex.exchangedAmount = amount;
            ex.mapExchange = getExchangeRates(amount);
            results.add(ex);
        }
        return results;
    }

}