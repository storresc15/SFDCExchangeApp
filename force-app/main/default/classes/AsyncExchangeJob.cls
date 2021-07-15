/*********************************************************************************
Class Name      : AsyncExchangeJob
Description     : Async support class
Created By      : Sebastian Torres
Created Date    : 2021-04-14 
Modification Log: 
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-04-14              Initial version
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