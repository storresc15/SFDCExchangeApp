trigger OpportunityTrigger on Opportunity (before insert, before update, before delete, after insert, after update, after delete) {
  
    fflib_SObjectDomain.triggerHandler(Opportunities.class);
    //Credomatic_Application.handleTrigger(Account.SObjectType);
}