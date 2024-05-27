@isTest
public with sharing class oppTests {
    @isTest
    public static void sendEmailTest()
    {
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        User owner = new User(
            FirstName = 'Test',
            LastName = 'User',
            Email = 'testuser2703@google.com',
            Username = 'testuser2703@google.com',
            Alias = 'tuser',
            ProfileId = p.Id, TimeZoneSidKey = 'Asia/Kolkata',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US'
        );
        insert owner;
        Opportunity opp=new Opportunity(Name='Test123',StageName='Prospecting',CloseDate=Date.Today().addDays(2),ownerId=owner.Id);
        insert opp;
        Map<Id,Opportunity>oldRec=new Map<Id,Opportunity>{opp.Id=>opp};
        opp.name='Test';
        opp.StageName='Qualification';
        opp.CloseDate=Date.Today();
        update opp;
        List<Opportunity>newRec=new List<Opportunity>{opp};
        test.StartTest();
        OpportunityTriggerHandler.updatemethod(newRec,oldRec);
        test.StopTest();
        Integer emailCount = Limits.getEmailInvocations();
        System.assertEquals(1,emailCount);
        
    }
}