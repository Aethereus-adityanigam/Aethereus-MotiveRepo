public with sharing class createOpportunity {
    @AuraEnabled
    public static Opportunity create(Opportunity opp){
        Opportunity newopp=new Opportunity(name=opp.Name,stageName=opp.stageName,
        AccountId=opp.AccountId,CloseDate=opp.CloseDate);

            insert newopp;
            return newopp;
    }
    @AuraEnabled
    public static string GetAccountName(String accid){
        List<String> accountnames=new List<String>();
        List<Account> acc=[select Id,Name from Account Where id=:accid];
        return acc[0].name;
    }
}