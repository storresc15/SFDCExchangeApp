/*********************************************************************************
Class Name      : ApplicationDomain
Description     : Support class to handle the configuration of the Domain layer in Application
Created By      : Sebastian Torres
Created Date    : 2021-07-12 
Modification Log: 
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-07-12              Initial version
*********************************************************************************/
public inherited sharing abstract class ApplicationDomain extends fflib_SObjectDomain {
    public ApplicationDomain(List<SObject> records) {
        super(records);
        // Disable the base class CRUD checking in preference to explicit checking elsewhere
        //Configuration.disableTriggerCRUDSecurity();
    }    
}