public class OpportunityHandler {
    
    
    public static void preventDelRelatedAcc(List<opportunity> opplist){
        set<id> accIds=new set<id>();
        for(opportunity opp:opplist){
            if(opp.AccountId!=null){
               opp.addError('You Cannot delete accout related to opportunity');
            }
        }
            
        
    }
    
    /*public static void preventDeletionOfOpp(List<opportunity> oppList)
    {
        Id userId=[SELECT Id FROM Profile WHERE Name = 'System Administrator' limit 1].Id;
        for(opportunity opp:oppList){
            if(opp.stageName=='Closed won' ||opp.stageName=='Closed lost'){
                if(!  UserInfo.getProfileId().equals(userId)){
                    opp.addError('Only System Administrator can delete the opportunity');
                }
            }
        }
    }
    public static void updateDescription(List<opportunity>opplist){
        for(Opportunity opp:opplist){
            if(opp.Amount!=null && opp.Amount>100000)
                opp.Description='Hot Account';
            }
        }
    }
    public static void oppStageDesc(List<opportunity> oppList,Map<Id,opportunity> oldMap)
    {
        for(Opportunity opp:oppList)
        {
            if(oldMap==null || oldMap.get(opp.Id).StageName!=opp.StageName){
                
                if(opp.StageName =='Closed won'){
                    opp.closeDate=System.Today();
                    opp.type='New Customer';
            }
            }
        }
    }
   /*public static void createtask(List<opportunity>opplist,Map<id,opportunity>oldMAP){
        //set<id> oppids=new set<id>;
        list<task> addtask= new list<task>();
        for(opportunity opp:opplist){
            if(opp.StageName!=oldMap.get(opp.Id).StageName)
            {
              Task newtask=new Task();
                newtask.WhatId=opp.id;
                newtask.OwnerId=opp.OwnerId;
                newtask.Status='In Progress';
                newtask.Subject='related opportunity';
                addtask.add(newtask);
                
            }
            
        }
        if(!addtask.isEmpty()){
            insert addtask;
        }
    }*/
    public static void updateaccountamount(list<opportunity> opplist){
        list<account> acclist=new list<account>();
        for(opportunity opp:opplist){
            if(opp.AccountId!=null && opp.amount!=null){
                account acc=new account();
                acc.id=opp.AccountId;
                acc.Recent_Opportunity_Amount__c=opp.Amount;
                acclist.add(acc);
            }
        }
        if(!acclist.isempty()){
            update acclist;
        }
    }
    
   /*public static void updateoppdesc(List<opportunity> opplist,map<id,opportunity> oldMap){
        for(opportunity opp:opplist){
            if(opp.StageName!=oldMap.get(opp.Id).stageName){
                if(opp.StageName=='closed won'){
                    opp.Description=' desc changed to Closed won';
                }else if(opp.StageName=='Closed lost'){
                    opp.Description='opportunity changed to closed lost';
                }else {
                    opp.Description='opportunity is open';
                }
            }
                
        }
    }
    public static void opportunityprevent(list<Opportunity> opplist){
        for(opportunity opp:opplist){
            if(opp.amount==null){
                opp.addError('Amount Cannot be null');
            }
        }
    }
    
    public static void populateclosedlostReason(list<opportunity> opplist,map<id,opportunity> oldMap){
        for(opportunity opp:opplist){
            if(opp.stageName=='closed Lost' && opp.stageName!=oldMap.get(opp.id).StageName && opp.Closed_lost_Reason__c==null){
                opp.addError('Please Mention the Reason for Closed last');
            }
        }
    }*/
}