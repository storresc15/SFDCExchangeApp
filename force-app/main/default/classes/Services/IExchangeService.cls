/*********************************************************************************
Class Name      : IExchangeService
Description     : Interface used to implement on the Exchange Service
Created By      : Sebastian Torres
Created Date    : 2021-07-13  
Modification Log: 
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-07-13               Initial version
*********************************************************************************/
public interface IExchangeService {

    void applyExchangeRatesinOpps(Set<Id> oppIds);
    Map<String, Double> getExchangeRates(Double amount);
    Map<Double, ExchangeService.ProvisionalResult> getExchangeRates(List<Double> amountList);
    void asyncApplyExchangeRatesinOpps(Set<id> oppIds);
}