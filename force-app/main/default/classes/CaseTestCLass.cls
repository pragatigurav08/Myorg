@isTest
public class CaseTestCLass {
  @istest
    public static void caseMethod1(){
        account acc1=new account(name='caseacc1');
        account acc2=new account(name='caseacc2');
        set<id> accid=new set<id>();
        list<account>acclist=new list<account>{acc1,acc2};
        insert acclist;
        accid.add(acc1.id);
        accid.add(acc2.id);
        case cs1 =new case(accountId=acc1.Id);
        case cs2 =new case(accountId=acc2.Id);
        list<case> caselist=new list<case>{cs1,cs2};
        insert caselist;
        
       list<case> updatecase=[select id, caseNumber,AccountID from case];
       CaseHandler.casenumber(updatecase);
       
       list<account> updateaccount=[select id, Case_number__c, (select caseNumber from cases) from account where id in:accid];        
    }
}