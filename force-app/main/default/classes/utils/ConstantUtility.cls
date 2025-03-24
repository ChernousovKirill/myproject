public with sharing class ConstantUtility {
    public static final String IN_PROGRESS_STATUS = 'In Progress';
    public static final Set<String> STATUS_BEFORE_PROGRESS = new Set<String>{
        'Approved',
        'Published'
    };
}