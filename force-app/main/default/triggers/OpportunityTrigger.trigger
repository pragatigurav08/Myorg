trigger OpportunityTrigger on Opportunity (after insert, after update, after delete,before delete) {
 /* if (Trigger.isInsert && trigger.isAfter) {
        OpportunityHandlerClass.handleAfterInsert(Trigger.new);
    }
    if (Trigger.isUpdate && trigger.isAfter) {
        OpportunityHandlerClass.handleAfterUpdate(Trigger.new, Trigger.oldMap);
    }
    if (Trigger.isDelete && trigger.isAfter) {
        OpportunityHandlerClass.handleAfterDelete(Trigger.old);
    }
    if (Trigger.isafter && trigger.isinsert) {
        OpportunityHandler.updateaccountamount(Trigger.new);
    }
    if (Trigger.isbefore && trigger.isdelete) {
        OpportunityHandler.preventDeletionOfOpp(Trigger.old);
    }*/
    if (Trigger.isAfter && trigger.isdelete) {
        OpportunityHandler.preventDelRelatedAcc(Trigger.old);
    }
    
}