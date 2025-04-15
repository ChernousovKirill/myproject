public inherited sharing class JobPostingUtils {
    
    public Job_Posting__c updateJobPostingStatus(Job_Posting__c itemOfJobPosting, String status) {
        itemOfJobPosting.Status__c = status;
        return itemOfJobPosting;
    }
}