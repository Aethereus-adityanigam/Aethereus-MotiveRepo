trigger OpportunityTrigger on Opportunity (before insert,before update) {
    if(Trigger.isBefore)
    {
        if(Trigger.isInsert)
        {
            opportunityTriggerHandler.Updateuniquenames(Trigger.new);
        }
        if(Trigger.isUpdate)
        {
            opportunityTriggerHandler.updatewhenaccountwaschanged(Trigger.new, Trigger.oldMap);
        }
    }

}