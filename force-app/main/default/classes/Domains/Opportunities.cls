/*********************************************************************************
Class Name      : Opportunities
Description     : Main Domain class implemented for Opportunity domain layer
Created By      : Sebastian Torres
Created Date    : 2021-07-13  
Modification Log: 
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-07-13               Initial version
*********************************************************************************/
public inherited sharing class Opportunities extends ApplicationDomain {
    
    public Opportunities(List<Opportunity> opps) {
		super(opps);
	}

	public class Constructor implements fflib_SObjectDomain.IConstructable {
		public fflib_SObjectDomain construct(List<SObject> sObjectList) {
			return new Opportunities(sObjectList);
		}
	}	
    
    public override void onAfterInsert()
    {    
        ExchangeService.asyncApplyExchangeRatesinOpps(getApplicableExchangeOpps());     
    }
    
    public override void onAfterUpdate(Map<Id,SObject> existingRecords)
    {
        ExchangeService.asyncApplyExchangeRatesinOpps(getApplicableExchangeOpps(existingRecords));
    }
    
     public void updateAmounts(fflib_ISObjectUnitOfWork uow, Map<Double, ExchangeService.ProvisionalResult> rates) 
    {
        for(Opportunity opp : (List<Opportunity>) this.records)
		{
            system.debug('This opp is being changed on domain update amounts: ' + opp);
			opp.USDAmount__c = rates.get(opp.Amount).mapExchange.get('USD');
            opp.MXNAmount__c = rates.get(opp.Amount).mapExchange.get('MXN');
            opp.CADAmount__c = rates.get(opp.Amount).mapExchange.get('CAD');
			uow.registerDirty(opp);
		}
        
    }
    
    public set<id> getApplicableExchangeOpps(Map<Id,SObject> existingRecords)
    {
        Map<Id, Opportunity> oppsOldMap = new Map<ID, Opportunity>((List<Opportunity>)existingRecords.values());
        set<id> ids = new set<id>();
        for(Opportunity opp : (List<Opportunity>) this.records) {
            if(opp.Amount != null && oppsOldMap.get(opp.id).amount != opp.Amount){
              ids.add(opp.id);  
            } 
        }
        system.debug('these are applicable Exchange opps: ' + ids);
        return ids;
    }
    
    public set<id> getApplicableExchangeOpps()
    {
        set<id> ids = new set<id>();
        for(Opportunity opp : (List<Opportunity>) this.records) {
            if(opp.Amount != null) ids.add(opp.id);
        }
        system.debug('these are applicable Exchange opps: ' + ids);
        return ids;
    }
}