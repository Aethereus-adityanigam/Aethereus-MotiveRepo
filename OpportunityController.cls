public with sharing class OpportunityController {
    @AuraEnabled
    public static void deleteOpportunity(Id opportunityId) {
        try {
            Opportunity opp = [SELECT Id FROM Opportunity WHERE Id = :opportunityId LIMIT 1];
            delete opp;
        } catch (Exception e) {
            throw new AuraHandledException('Error deleting Opportunity: ' + e.getMessage());
        }}
 
        @AuraEnabled
        public static string createOpportunity(String name, String accountId, Date closeDate, String stageName,string type ,integer amount) {
            Opportunity opp = new Opportunity(
                Name = name,
                AccountId = accountId,
                CloseDate = closeDate,
                StageName = stageName,
                Amount = amount
            );
            
            try {
                insert opp;
                return 'Opportunity created successfully with Id: ' + opp.Id;
            } catch (Exception e) {
                throw new AuraHandledException('Error creating Opportunity: ' + e.getMessage());
            }
        }   }

