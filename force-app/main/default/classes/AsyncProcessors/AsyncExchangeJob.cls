/*********************************************************************************
Class Name      : AsyncExchangeJob
Description     : Async Job class used for the exchange app as instance used in factory and strategy pattern
Created By      : Sebastian Torres
Created Date    : 2021-07-13  
Modification Log: 
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-07-13               Initial version
*********************************************************************************/
public class AsyncExchangeJob extends AsyncJob {
    
    public override void executeAsyncProcess(AsyncRequest__c request) 
    {
        //Checking limits
        if(!limitsAvailable()) return;
        
        List<ID> idsAfterSplit = request.Params__c.split(',');
        Integer allowedCallouts = Limits.getLimitCallouts() - Limits.getCallouts();
        Set<Id> oppIds = new Set<Id>();
        for(Opportunity opp:new OpportunitiesSelector().selectByIdForCallouts(idsAfterSplit, allowedCallouts)) {
                  oppIds.add(opp.id);       
        } 
       ExchangeService.applyExchangeRatesinOpps(oppIds);
    } 
    
    

}