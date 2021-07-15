trigger OnAsyncRequestInsert on AsyncRequest__c (before insert) {
    
    system.debug('The asyn trigger is being called'); 
    if(Limits.getLimitQueueableJobs() - Limits.getQueueableJobs() > 0)
    try
    {  
      Async_QueueableProcessor.enqueueGoingAsync(null);
    } catch(Exception ex)
    {
      // Ignore for now
    }

}