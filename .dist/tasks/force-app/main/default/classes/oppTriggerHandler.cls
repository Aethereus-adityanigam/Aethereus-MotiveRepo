public with sharing class oppTriggerHandler {
    public static void updatemethod(List<Opportunity>OppNewRec,Map<Id,Opportunity>OppOldRec)
    {
        //custom label
        List<String>fieldnames=System.Label.OpportunityFieldNames.split(',');
        String changedValuesString='';
        Set<Id>opportunityOwnerIds=new Set<id>();
        Map<Id,Id>opportunityAndOwner=new Map<Id,Id>();
        for(Opportunity opp:OppNewRec)
        {
            opportunityOwnerIds.add(opp.OwnerId);
        }
        Map<Id,String>UserDetails=new Map<Id,String>();
        List<User>username=[select id,FirstName from user where id in:opportunityOwnerIds];
        for(User u:username)
        {
            UserDetails.put(u.Id,u.FirstName);
        }
        for(Opportunity opp:OppNewRec)
        {            
            Opportunity oppold=OppOldRec.get(opp.Id);
            changedValuesString+=Stringgeneration(opp,OppOldRec,fieldnames);
            if (changedValuesString.length()>0) {
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setSubject('Opportunity updated');
                email.setToAddresses(new String[]{opp.OwnerId});
                email.setPlainTextBody('Hi '+UserDetails.get(opp.OwnerId) +',\n\n'+changedValuesString);
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