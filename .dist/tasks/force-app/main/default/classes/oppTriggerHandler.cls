public with sharing class oppTriggerHandler {
    public static void updatemethod(List<Opportunity>OppNewRec,Map<Id,Opportunity>OppOldRec)
    {
        //custom label
        List<String>fieldnames=System.Label.OpportunityFieldNames.split(',');
        String changedValuesString='';
        for(Opportunity opp:OppNewRec)
        {
            //retriving the username
            user owner=[select FirstName from user where Id=:opp.OwnerId];
            Opportunity oppold=OppOldRec.get(opp.Id);
            changedValuesString+=Stringgeneration(opp,OppOldRec,fieldnames);
            if (changedValuesString.length()>0) {
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setSubject('Opportunity updated');
                email.setToAddresses(new String[]{opp.OwnerId});
                email.setPlainTextBody('Hi '+Owner.FirstName +',\n\n'+changedValuesString);
                Messaging.sendEmail(new Messaging.SingleEmailMessage[]{email});
            }
        }
        
    }
    public static String Stringgeneration(Opportunity oppRec,Map<Id,Opportunity>OppOldRec,List<String>fieldnames)
    {
        String generator='';
        for(String field:fieldnames)
        {
            if(OppOldRec.get(oppRec.Id).get(field)!=oppRec.get(field))
            {
                generator+='The Opportunity '+OppOldRec.get(oppRec.Id).get(field)+'changed to'+oppRec.get(field)+'\n';
            }
        }
        return generator;
        
    }
}