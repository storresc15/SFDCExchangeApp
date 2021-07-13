public interface IExchangeService {

    void applyExchangeRatesinOpps(Set<Id> oppIds);
    Map<String, Double> getExchangeRates(Double amount);
    List<ExchangeService.ProvisionalResult> getExchangeRates(List<Double> amountList);
}