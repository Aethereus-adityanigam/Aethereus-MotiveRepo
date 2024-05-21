public with sharing class OpportunityTriggerHandler {
    public static void Updateuniquenames(List<Opportunity>oppRecords)
    {
        Map<Id,Integer>Accountcount=new Map<Id,Integer>();
            Map<Id,String>Accountwname=new Map<Id,String>();
            Integer oppCount=0;
            List<Opportunity>oppnames=new List<Opportunity>();
            for(Opportunity opp:oppRecords)
            {
                if(opp.AccountId!=null)
                {
                    Accountwname.put(opp.AccountId,opp.Account.Name);
                }
            }
            List<Account> oppcounts=[select id,(select id from Opportunities) from Account where id in:Accountwname.keyset()];
            if(!oppcounts.isEmpty())
            {
                for(Account o:oppcounts)
                {
                    oppCount=o.Opportunities.size();
                    Accountcount.put(o.id,oppCount);
                }
            }
            for(Opportunity opp1:oppRecords)
            {
                Account accountname=[select Name from Account where Id=:opp1.AccountId];
                if(opp1.AccountId!=null && Accountcount.containsKey(opp1.AccountId))
                {
                    oppCount=Accountcount.get(opp1.AccountId)+1;
                    opp1.uniquename__c=accountname.Name+'Opp00'+String.valueOf(oppCount);
                }
                else
                {
                    oppCount+=1;
                    Accountcount.put(opp1.AccountId,oppCount);
                    opp1.uniquename__c=accountname.Name+'Opp00'+String.valueOf(oppCount);
                }
            }
    }
    public static void updatewhenaccountwaschanged(List<Opportunity>oppRecords,Map<Id,Opportunity>oldRecords)
    {
        List<Opportunity>oppotunityrecords=new List<Opportunity>();
        for(Opportunity opp:oppRecords)
        {
            if(opp.AccountId!=null && oldRecords.get(opp.Id).accountId!=opp.AccountId)
            {
                oppotunityrecords.add(opp);
            }
        }
        Updateuniquenames(oppotunityrecords);
    }

}