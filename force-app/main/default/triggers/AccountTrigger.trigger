trigger AccountTrigger on Account (before insert,after insert,after update,before update,before delete) 
{
    if(trigger.isAfter && trigger.isInsert){
             AccountHandler.handleAfterInsert(trigger.new);
    }
   /* if(trigger.isBefore && trigger.isInsert){
             AccountHandler.createSalesRep(trigger.new);
    }
    
    if(trigger.isupdate && trigger.isAfter){
             AccountHandler.changeOwner(trigger.new);
    }
    
     if(trigger.isInsert && trigger.isAfter){
             AccountHandler.createNumberOfContact(trigger.new);
    }
    if(trigger.isInsert && trigger.isAfter){
        AccountToContact.createAccount(trigger.new);
    }
    
    if(trigger.isInsert && trigger.isbefore){
        AccountTriggerHandler.populaterating(trigger.new);
    }
    if(trigger.isInsert && trigger.isbefore){
        AccountHandler.createOppAndCon(trigger.new);
    }
     if(Trigger.isInsert){
        if(Trigger.isBefore){
            AccountHandler.copyBillingAddress(Trigger.New);
                }
    }
   if(trigger.isInsert || Trigger.isUpdate){
        if(Trigger.isBefore){
            AccountHandler.updatephonenum(Trigger.New,Trigger.oldMap);
                }
        }
    
    if(Trigger.isUpdate || trigger.isinsert){
        if(Trigger.isBefore){
            AccountHandler.updateIndustryRating(Trigger.New,trigger.oldMap);
 .isbefore && trigger.isUpdate){
        AccountHandler.preventEdit(trigger.new);
    }
    if(trigger.isBefore && trigger.isdelete){
        AccountHandler.preventaccdel(trigger.old);
    }*/
}