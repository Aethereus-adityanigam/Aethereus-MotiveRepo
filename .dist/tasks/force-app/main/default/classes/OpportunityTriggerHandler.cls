public class oppTriggerHandler {
    public static void Updateuniquenames(List<Opportunity>oppRecords)
    {
        Map<Id,Integer>oppwIdAndCount=new Map<Id,Integer>();
        Map<Id,String>accountidwName=new Map<Id,String>();
        set<Id>accountIds=new set<Id>();
        Integer oppCount=0;
        List<Opportunity>oppNames=new List<Opportunity>();
        for(Opportunity opp:oppRecords)
        {
          if(opp.AccountId!=null)
          {
              AccountIds.add(opp.AccountId);
                    
          }
        }
            List<Account> oppcounts=[Select id,name,(Select id from Opportunities) from Account where id in:AccountIds];
            if(!oppcounts.isEmpty())
            {
                for(Account o:oppcounts)
                {
                    oppCount=o.Opportunities.size();
                    OppwIdandcount.put(o.id,oppCount);
                    Accountidwname.put(o.Id,o.Name);
                }
            }
            for(Opportunity opp1:oppRecords)
            {
                //Account accountname=[Select Name from Account where Id=:opp1.AccountId];
                if(opp1.AccountId!=null && OppwIdandcount.containsKey(opp1.AccountId))
                {
                    oppCount=OppwIdandcount.get(opp1.AccountId)+1;
                    opp1.uniquename__c=accountidwName.get(opp1.AccountId)+'Opp00'+String.valueOf(oppCount);
                }
                else
                {
                    oppCount+=1;
                    OppwIdandcount.put(opp1.AccountId,oppCount);
                    opp1.uniquename__c=accountidwName.get(opp1.AccountId)+'Opp00'+String.valueOf(oppCount);
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