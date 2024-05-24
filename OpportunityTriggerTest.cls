@isTest
public class OpportunityTriggerTest {
    @testSetup
    static void setup() {
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        Account acc1 = [SELECT Id, Name FROM Account WHERE Name = 'Test Account' LIMIT 1];
        
        // this opportunity is added to ensure that one opportunity is already associated with account
        Opportunity o=new Opportunity(Name = 'Opportunity 0' ,StageName = 'Qualification',CloseDate = Date.today(),AccountId = acc1.Id);
        insert o;
        
        //100 opportunity with acc added
        List<Opportunity> bulkOpportunities = new List<Opportunity>();
        for (Integer i = 1; i <= 100; i++) {
            bulkOpportunities.add(new Opportunity(Name = 'Opportunity ' + i,StageName = 'Qualification',CloseDate = Date.today(),AccountId = acc1.Id));
        }
        insert bulkOpportunities;
        
        // 100 opportunity without acc added
        List<Opportunity> nullAccOpportunities = new List<Opportunity>();
        for (Integer i = 1; i <= 100; i++) {
            nullAccOpportunities.add(new Opportunity(Name = 'Null Account Opportunity ' + i,StageName = 'Qualification', CloseDate = Date.today()));
        }
        insert nullAccOpportunities;
    }
    @isTest
    static void testBulkOpportunityInsert() {
        List<Opportunity> insertedOpportunities = [SELECT Name,Id, AutoNumber__c, AccountId FROM Opportunity WHERE Name LIKE 'Opportunity %' ORDER BY Name];
        System.assertEquals(101, insertedOpportunities.size(), 'number of inserted opportunities is incorrect.');
        for (Opportunity opp : insertedOpportunities) {
            System.assert(opp.AutoNumber__c.startsWith('Test Account OPP'), 'AutoNumber__c value is incorrect ' + opp.AccountId);
        }
    } 
    @isTest
    static void testBulkOpportunityUpdate() {
        List<Opportunity> oppsToUpdate = [SELECT Id FROM Opportunity WHERE Name LIKE 'Opportunity %'];
        for (Opportunity opp : oppsToUpdate) {
            opp.AccountId = null;
        }
        update oppsToUpdate;

        List<Opportunity> updatedOpportunities = [SELECT Id, AutoNumber__c FROM Opportunity WHERE Id IN :oppsToUpdate];
        for (Opportunity opp : updatedOpportunities) {
            System.assert(opp.AutoNumber__c.startsWith('OPP'), 'AutoNumber__c value is incorrect ' + opp.Id);
        }
    }
    @isTest
    static void testBulkNullAccountOpportunities() {
        List<Opportunity> insertedOpportunities = [SELECT Id, AutoNumber__c FROM Opportunity WHERE Name LIKE 'Null Account Opportunity %' ORDER BY Name];
        System.assertEquals(100, insertedOpportunities.size(), 'The number of inserted opportunities is incorrect.');
        for (Opportunity opp : insertedOpportunities) {
            System.assert(opp.AutoNumber__c.startsWith('OPP'), 'AutoNumber__c value is incorrect');
        }
    }
}