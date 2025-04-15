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
                && oldMap.get(updatedJobPost.Id).Application_Quantity__c == 0
            ) {
                jobPostingUtils.updateJobPostingStatus(updatedJobPost, ConstantUtility.IN_PROGRESS_STATUS);
            }

            if (updatedJobPost.Offer_Stage_Applications__c != oldMap.get(updatedJobPost.Id).Offer_Stage_Applications__c
                && updatedJobPost.Status__c ==  ConstantUtility.IN_PROGRESS_STATUS
                && oldMap.get(updatedJobPost.Id).Offer_Stage_Applications__c == 0
            ) {
                jobPostingUtils.updateJobPostingStatus(updatedJobPost, ConstantUtility.OFFER_STAGE_STATUS);
            }

            if (updatedJobPost.Offer_Accepted__c != oldMap.get(updatedJobPost.Id).Offer_Accepted__c
                && updatedJobPost.Status__c ==  ConstantUtility.OFFER_STAGE_STATUS
                && updatedJobPost.Offer_Accepted__c == updatedJobPost.Open_Positions__c
            ) {
                jobPostingUtils.updateJobPostingStatus(updatedJobPost, ConstantUtility.CLOSED_HIRED_STATUS);
            }
        
        
        }
    }
}