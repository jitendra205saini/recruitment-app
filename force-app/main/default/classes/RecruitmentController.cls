public with sharing class RecruitmentController {

    @AuraEnabled(cacheable=true)
    public static List<Candidate__c> getCandidates() {
        return [SELECT Id, Name, Email__c, Phone__c, Skills__c, Experience__c, Status__c FROM Candidate__c];
    }

    @AuraEnabled
    public static void addCandidate(String name, String email, String phone, String skills, Integer exp) {
        Candidate__c c = new Candidate__c(
            Name = name,
            Email__c = email,
            Phone__c = phone,
            Skills__c = skills,
            Experience__c = exp,
            Status__c = 'Pending'
        );
        insert c;
    }

    @AuraEnabled
    public static void updateStatus(Id recordId, String status) {
        Candidate__c c = [SELECT Id FROM Candidate__c WHERE Id=:recordId LIMIT 1];
        c.Status__c = status;
        update c;
    }
}
