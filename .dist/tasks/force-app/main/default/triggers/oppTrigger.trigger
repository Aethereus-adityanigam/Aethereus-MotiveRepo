trigger oppTrigger on Opportunity (after update) {
    if(Trigger.isAfter)
    {
        if(Trigger.isUpdate)
        {
            OpportunityTriggerHandler.updatemethod(Trigger.new,Trigger.oldMap);
        }
    }

}