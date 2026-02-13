public with sharing class RecruitmentController {

    /* =========================================
       CANDIDATE METHODS
    ========================================= */

    // Get All Candidates
    @AuraEnabled(cacheable=true)
    public static List<Candidate__c> getCandidates() {
        return [
            SELECT Id, Name, Email__c, Phone__c, 
                   Skills__c, Experience__c, Status__c
            FROM Candidate__c
            ORDER BY CreatedDate DESC
        ];
    }

    // Add Candidate
    @AuraEnabled
    public static void addCandidate(
        String name,
        String email,
        String phone,
        String skills,
        Integer exp
    ) {
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

    // Update Candidate Status
    @AuraEnabled
    public static void updateCandidateStatus(Id candidateId, String status) {

        Candidate__c c = [
            SELECT Id, Status__c 
            FROM Candidate__c 
            WHERE Id = :candidateId 
            LIMIT 1
        ];

        c.Status__c = status;
        update c;
    }

    // Delete Candidate
    @AuraEnabled
    public static void deleteCandidate(Id candidateId) {
        Candidate__c c = [
            SELECT Id 
            FROM Candidate__c 
            WHERE Id = :candidateId 
            LIMIT 1
        ];
        delete c;
    }


    /* =========================================
       JOB METHODS
    ========================================= */

    // Get All Jobs
    @AuraEnabled(cacheable=true)
    public static List<Job__c> getJobs() {
        return [
            SELECT Id, Name, Department__c, 
                   Skills__c, Experience_Required__c
            FROM Job__c
            ORDER BY CreatedDate DESC
        ];
    }

    // Add Job
    @AuraEnabled
    public static void addJob(
        String title,
        String department,
        String skills,
        Integer exp
    ) {
        Job__c j = new Job__c(
            Name = title,
            Department__c = department,
            Skills__c = skills,
            Experience_Required__c = exp
        );

        insert j;
    }

    // Delete Job
    @AuraEnabled
    public static void deleteJob(Id jobId) {

        Job__c j = [
            SELECT Id 
            FROM Job__c 
            WHERE Id = :jobId 
            LIMIT 1
        ];

        delete j;
    }
}
