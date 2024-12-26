trigger LeadTrigger on Lead (before insert) {
    if(trigger.isinsert && trigger.isbefore){
        LeadHandler.preventCreation(Trigger.new);
    }
}