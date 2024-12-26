trigger OrderTrigger on Order (before insert) {
if(trigger.isDelete && trigger.isAfter)
    {
        orderTriggerHandler.deleteRelOpp(trigger.old);
    }
}