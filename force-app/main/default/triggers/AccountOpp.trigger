trigger AccountOpp on Account (before delete,after delete) {
    
    if((Trigger.isbefore|| trigger.isAfter)&& trigger.isDelete){
        AccountOPPHandler.deleteOrders(Trigger.old);
    }
    

}