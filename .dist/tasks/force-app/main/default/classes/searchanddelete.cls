public with sharing class searchanddelete {
    @AuraEnabled
    public static List<Opportunity> getAccounts(String oppName)
    {
        List<Opportunity>opportunityList=new List<Opportunity>();
        if(oppName!='')
        {
            String oppNames='%'+oppName+'%';
            opportunityList=[select Id,Name from Opportunity where Name like :oppNames];
        }
        return opportunityList;
    }
    @AuraEnabled
    public static Boolean deleteopp(Opportunity oppid){
        delete oppid;
        return true;
    }

}