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
        
    }
    
    public override void onAfterUpdate(Map<Id,SObject> existingRecords)
    {
        
    }
}