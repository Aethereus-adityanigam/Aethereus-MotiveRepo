public class OpportunityHelper {
    public static void updateOpportunityAutoNumbers(list<Opportunity> opportunities) {
        set<Id> accountIds = new set<Id>();
        map<Id, List<Opportunity>> accountToOpps = new map<Id, List<Opportunity>>();
        map<Id, Integer> countOfOpps = new map<Id, Integer>();
        map<Id, String> accountNames = new map<Id, String>();
        for(Opportunity opp : opportunities) {
            if(opp.AccountId != null) {
                accountIds.add(opp.AccountId);
            }
        }
        for(Opportunity opp : [select Id, AccountId from Opportunity where AccountId in :accountIds]) {
            if(!accountToOpps.containsKey(opp.AccountId)) {
                accountToOpps.put(opp.AccountId, new List<Opportunity>());
            }
            accountToOpps.get(opp.AccountId).add(opp);
        }

        for(Id accId : accountIds) {
            countOfOpps.put(accId, accountToOpps.get(accId).size());
        }
        for(Account acc : [select Id, Name from Account where Id in :accountIds]) {
            accountNames.put(acc.Id, acc.Name);
        }
        Integer nullAccountCount = [SELECT COUNT() FROM Opportunity WHERE AccountId = null];

        for(Opportunity opp : opportunities) {
            Integer count = 1;
            String uniqueNumber = '';

            if(opp.AccountId != null) {
                if(countOfOpps.containsKey(opp.AccountId)) {
                    count = countOfOpps.get(opp.AccountId) + 1;
                    countOfOpps.put(opp.AccountId, count);
                }
                
                uniqueNumber = accountNames.get(opp.AccountId) + ' OPP' + count;
            } else {
                uniqueNumber = 'OPP' + nullAccountCount;
                nullAccountCount = nullAccountCount + 1;
            }
            
            opp.AutoNumber__c = uniqueNumber;
        }
    }
}