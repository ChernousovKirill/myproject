trigger JobPostinTrigger on Job_Posting__c (before update) {
    new JobPostingTriggerHandler().run();
}