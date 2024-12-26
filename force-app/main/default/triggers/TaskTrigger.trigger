trigger TaskTrigger on Task (before insert,after insert,after Update,after delete) {
    if(trigger.isAfter && Trigger.isInsert || Trigger.isUpdate){
        TaskTriggerHandler.countOfTask(trigger.new,null);
    }
    if(trigger.isafter && trigger.isDelete){
        TaskTriggerHandler.countOfTask(null, Trigger.old);
    }
}