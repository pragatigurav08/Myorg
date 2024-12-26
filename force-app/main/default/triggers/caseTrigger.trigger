trigger caseTrigger on Case (before insert,after insert) {
    if(trigger.isAfter){
        if(trigger.isInsert){
           // CaseHandler.casenumber(trigger.new);
        }
    }
}