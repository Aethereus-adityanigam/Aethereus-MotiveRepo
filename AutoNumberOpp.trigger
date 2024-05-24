trigger AutoNumberOpp on Opportunity (before insert, before update) {
    if (Trigger.isInsert) {
        OpportunityHandler.handleOpportunities(Trigger.new);
    } else if (Trigger.isUpdate) {
        List<Opportunity> toprocess = new List<Opportunity>();
        for (Opportunity opp : Trigger.new) {
            Opportunity oldOpp = Trigger.oldMap.get(opp.Id);
            if (opp.AccountId != oldOpp.AccountId) {
                toprocess.add(opp); }}
        if (!toprocess.isEmpty()) {
            OpportunityHandler.handleOpportunities(toprocess);
        } }}