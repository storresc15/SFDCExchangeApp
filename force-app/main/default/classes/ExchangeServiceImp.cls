public inherited sharing class ExchangeServiceImp implements IExchangeService {
    
    public void applyExchangeRatesinOpps(Set<Id> oppIds)
    {
        fflib_ISObjectUnitOfWork uow = Application.UnitOfWork.newInstance();
        
        List<Double> amountList = new List<Double>();
        List<Opportunity> opps = new OpportunitiesSelector().selectById(oppIds);
        system.debug('These are the opps from selector in service: ' + opps);
        for(Opportunity opp : opps)
        {
            amountList.add(opp.amount);
        }
        system.debug('These are the amounts to be called: ' + amountList);
        try{    
        Map<Double, ExchangeService.ProvisionalResult> rates = getExchangeRates(amountList);
        new Opportunities(opps).updateAmounts(uow, rates);
        
        // Commit work
        
        uow.commitWork();
        } catch(Exception e) {
            system.debug('Exception Caught: ' + e.getMessage());
        }
    }
    
    public void asyncApplyExchangeRatesinOpps(Set<id> oppIds) 
    {
        //To be implemented with async processor 
         List<AsyncRequest__c> newAsyncRequests = new List<AsyncRequest__c>();
         List<String> textChangedIds = new List<ID>();
         List<Opportunity> opps = new OpportunitiesSelector().selectById(oppIds);
        for(Opportunity opp : opps)
        {
            textChangedIds.add(opp.id); 
            if(textChangedIds.size()>100)
          {
            newAsyncRequests.add(
              new AsyncRequest__c(AsyncType__c = 'Exchange Call',
                  Params__c = string.Join(textChangedIds,',')));
            textChangedIds.clear();
    
          }
        
        }
    
        if(textChangedIds.size()>0)
          newAsyncRequests.add(
            new AsyncRequest__c(AsyncType__c = 'Exchange Call',
                  Params__c = string.Join(textChangedIds,',')));
    	system.debug('Sending the following Async Requests: ' + newAsyncRequests);
        insert newAsyncRequests;
            }
    
    
    public Map<String, Double> getExchangeRates(Double amount)
    {
        ExchangeHerokuAppService service = new ExchangeHerokuAppService();
        return service.callService(amount);
        
    }
    
    public Map<Double, ExchangeService.ProvisionalResult> getExchangeRates(List<Double> amountList)
    {
        Map<Double, ExchangeService.ProvisionalResult> results = new Map<Double, ExchangeService.ProvisionalResult>();
        for(double amount : amountList) 
        {
           ExchangeService.ProvisionalResult ex = new ExchangeService.ProvisionalResult();
            ex.exchangedAmount = amount;
            ex.mapExchange = getExchangeRates(amount);
            results.put(amount, ex);
            //results.add(ex);
        }
        return results;
    }

}