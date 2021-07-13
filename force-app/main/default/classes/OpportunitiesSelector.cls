public inherited sharing class OpportunitiesSelector extends fflib_SObjectSelector {

    public List<Schema.SObjectField> getSObjectFieldList() {
		return new List<Schema.SObjectField> {
			Opportunity.Id,
			Opportunity.Name,
			Opportunity.AccountId,
            Opportunity.CADAmount__c,
            Opportunity.MXNAmount__c,
            Opportunity.USDAmount__c,
            Opportunity.Amount
		};
	}

	public Schema.SObjectType getSObjectType() {
		return Opportunity.sObjectType;
	
    }

    public List<Opportunity> selectById(Set<Id> oppIds) {
		return (List<Opportunity>) selectSObjectsById(oppIds);
	}
}
