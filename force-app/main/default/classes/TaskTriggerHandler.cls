public class TaskTriggerHandler {
    public static void countOfTask(List<Task> taskList,list<task> old){
        Set<Id> accountIds = new Set<Id>();
        List<account> accToUpdate=new List<account>();
        for(task t:taskList){
          accountIds.add(t.whatid);  
        }
        
         if (old != null) {
            for (Task t : old) {
                if (t.WhatId != null) {
                    accountIds.add(t.WhatId);
                }
            }
        }
        list<AggregateResult> accountRecords=[SELECT count(Id)taskcount, WhatId from Task WHERE whatid in:accountIds Group by Whatid];
        for(AggregateResult ar:accountRecords){
            Account acc=new Account();
            acc.id=(Id)ar.get('WhatId');
            acc.Task_Count__c=String.valueOf((Integer)ar.get('taskCount'));
            accToUpdate.add(acc);
        }
        update accToUpdate;
    }
}