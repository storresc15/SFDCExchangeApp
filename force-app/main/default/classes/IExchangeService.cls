public interface IExchangeService {

    void applyExchangeRatesinOpps(Set<Id> oppIds);
    Map<String, Double> getExchangeRates(Double amount);
    Map<Double, ExchangeService.ProvisionalResult> getExchangeRates(List<Double> amountList);
    void asyncApplyExchangeRatesinOpps(Set<id> oppIds);
}