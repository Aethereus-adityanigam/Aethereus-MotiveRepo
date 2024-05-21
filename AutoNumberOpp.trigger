trigger AutoNumberOpp on Opportunity (before insert, before update) {
    OpportunityHandler.handleOpportunities(Trigger.new);
}