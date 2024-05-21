public class OpportunityHandler {
    public static void handleOpportunities(List<Opportunity> newOpportunities) {
        OpportunityHelper.updateOpportunityAutoNumbers(newOpportunities);
    }
}