/*********************************************************************************
Class Name      : AsyncJobFactory
Description     : Factory class for implementing the Async Jobs
Created By      : Sebastian Torres
Created Date    : 2021-04-14 
Modification Log: 
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-04-14              Initial version
*********************************************************************************/
public class AsyncJobFactory {
    
    public static AsyncJob getInstance(String jobName) 
    {
        AsyncJob job = null;
        
        if(jobName == 'Exchange Call') job = new AsyncExchangeJob();
        //implement rest of async processes
        
        return job;
    }

}