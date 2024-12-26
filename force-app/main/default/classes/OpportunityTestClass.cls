@istest
public class OpportunityTestClass {
/*@istest
    public static void oppMethod1(){
        
        list<opportunity> oppList=new list<Opportunity>();
        account acc=new account(Name='newAcc');
        insert acc;
        opportunity opp=new opportunity(Name='newOPP',Amount=500,accountId=acc.id,Stagename='closed won',CloseDate=system.today());
        oppList.add(opp);
        insert oppList;
        OpportunityHandler.updateaccountamount(oppList);
        
        List<account> accRecords=[select Recent_Opportunity_Amount__c from account order by createddate limit 1];
        system.assertEquals(500,accRecords[0].Recent_Opportunity_Amount__c);
    }*/
    @isTest
    public static void updateAccountPhone(){
        list<opportunity> opplist=[select Name,Amount, AccountId from opportunity where amount!=null and AccountId!=null];
        OpportunityHandler.updateaccountamount(opplist);
                
    }
}