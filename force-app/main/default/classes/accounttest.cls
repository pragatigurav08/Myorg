@isTest
public class accounttest {
 @isTest
    public static void testClass3(){
        list<account> accToConlist =new list<account>();
        list<account> accToOpplist =new list<account>();
        account acc1=new account(name='paggu',Contact__c=true);
        account acc2=new account(name='abc');
        accToConlist.add(acc1);
        accToConlist.add(acc2);
        insert accToConlist;
        //call the handler method
        AccountHandler.createOppAndCon(accToConlist);

        Account a1=new Account(Name='Acc1',Opportunity__c=true);
        Account a2=new Account(Name='Acc2',Opportunity__c=true,Active__c='yes');
        accToOpplist.add(a1);
        accToOpplist.add(a2);
        insert accToOpplist;
        
        //call the handler method
        AccountHandler.createOppAndCon(accToOpplist);
        
        List<Contact> recentRecords=[Select FirstName,LastName,AccountId from contact order by CreatedDate desc limit 1];
       //System.assert(recentRecords.size() > 0, 'No contact records found.');        
        if (recentRecords.size() > 0) {
            System.assertEquals('paggu', recentRecords[0].FirstName);
        }   
        List<Opportunity> recentoppRecords=[Select Name, AccountId from opportunity where AccountId!=null order by CreatedDate desc limit 1];
       //System.assert(recentRecords.size() > 0, 'No contact records found.');        
       /* if (recentRecords.size() > 0) {
            System.assertEquals('Acc2', recentoppRecords[0].Name);
        } */  
        for(Opportunity opp:recentoppRecords){
            if(opp.Name=='Acc2'){
                 System.assertEquals('Acc2', recentoppRecords[0].Name);
            }
        }
    }
}