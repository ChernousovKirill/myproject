public with sharing class JobPostingTriggerHandler extends TriggerHandler {
    
    public JobPostingUtils jobPostingUtils {
        get {
            if (jobPostingUtils == null) {
                jobPostingUtils = new JobPostingUtils();
            }

            return jobPostingUtils;
        }
        set;
    }
    public override void beforeUpdate() {
        Map<Id, Job_Posting__c> oldMap = (Map<Id, Job_Posting__c>) Trigger.oldMap;
        Map<Id, Job_Posting__c> newMap = (Map<Id, Job_Posting__c>) Trigger.newMap;

        for (Job_Posting__c updatedJobPost : newMap.values()) {
            if (updatedJobPost.Application_Quantity__c != oldMap.get(updatedJobPost.Id).Application_Quantity__c 
                && ConstantUtility.STATUS_BEFORE_PROGRESS.contains(updatedJobPost.Status__c)
                && oldMap.get(updatedJobPost.Id).Application_Quantity__c == 0) {

                jobPostingUtils.updateJobPostingStatus(updatedJobPost, ConstantUtility.IN_PROGRESS_STATUS);

            }
        
        }
    }
}