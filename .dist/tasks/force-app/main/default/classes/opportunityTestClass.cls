@isTest
public class oppTestClass {
    @testSetup
    public static void createTestData() {
        Account acc1 = new Account(Name = 'TestAccount1');
        Account acc2 = new Account(Name = 'TestAccount2');
        insert new List<Account>{acc1, acc2};

        List<Opportunity> oppRecords = new List<Opportunity>();
        for (Integer i = 0; i < 2; i++) {
            Opportunity opp = new Opportunity(
                Name = 'TestOpp' + i,
                StageName = 'Prospecting',
                CloseDate = Date.Today().addDays(7),
                AccountId = acc1.Id
            );
            oppRecords.add(opp);
        }
        insert oppRecords;
    }

    @isTest
    public static void autonumber() {
        List<Opportunity> oppRecords = [SELECT Id, Name, uniquename__c FROM Opportunity ORDER BY CreatedDate];

        Test.startTest();
        for (Opportunity opp : oppRecords) {
            System.assert(opp.uniquename__c.contains('TestAccount1Opp00'), 'uniquename__c should contain "TestAccount1Opp00"');
        }
        Test.stopTest();
    }

    @isTest
    public static void accountUpdate() {
        Account newAccount = [SELECT Id FROM Account WHERE Name = 'TestAccount2' LIMIT 1];
        Opportunity oppToUpdate = [SELECT Id, AccountId, uniquename__c FROM Opportunity LIMIT 1];
        String oldUniqueName = oppToUpdate.uniquename__c;
        
        oppToUpdate.AccountId = newAccount.Id;

        Test.startTest();
        update oppToUpdate;
        Test.stopTest();

        Opportunity updatedOpp = [SELECT Id, AccountId, uniquename__c, Account.Name FROM Opportunity WHERE Id = :oppToUpdate.Id];

        System.assertNotEquals(oldUniqueName, updatedOpp.uniquename__c, 'uniquename__c should have changed.');
        System.assert(updatedOpp.uniquename__c.contains('TestAccount2Opp00'),'its correct');
    }

    @isTest
    public static void testUniqueNameForNewAccount() {
        Account newAccount = new Account(Name = 'NewTestAccount');
        insert newAccount;

        Opportunity newOpp = new Opportunity(
            Name = 'New Opportunity',
            AccountId = newAccount.Id,
            StageName = 'Prospecting',
            CloseDate = Date.today()
        );

        Test.startTest();
        insert newOpp;
        Test.stopTest();

        Opportunity insertedOpp = [SELECT Id, Name, uniquename__c, Account.Name FROM Opportunity WHERE Id = :newOpp.Id];
        String expectedUniqueName = 'NewTestAccountOpp001';

        System.assertEquals(expectedUniqueName, insertedOpp.uniquename__c);
    }

    
}
