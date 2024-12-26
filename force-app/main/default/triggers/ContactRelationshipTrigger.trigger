trigger ContactRelationshipTrigger on Contact_Relationship__c (before update) {
    if(Trigger.isBefore && Trigger.isUpdate){
        ContactRelationshipHandler.changeowner(Trigger.new);
    }
}