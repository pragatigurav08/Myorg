@isTest
public class AccountTriggerTest {
  /* @isTest
    public static void testclass(){
        Account a1=new Account(Name='Acctest1', industry='media');
        Account a2=new Account(Name='Acctest2',industry='Technology');
        List<Account> acclist = new List<Account>{a1, a2};
            
        AccountTriggerHandler.populaterating(acclist);
        
        system.AssertEquals('Hot',a1.rating);
        system.AssertEquals(null,a2.rating);
    }
    @isTest
    public static void testclass2(){
        List<Account> acc1=new list<Account>{new Account(name='Sid',CopyBillingToShipping__c=true,BillingStreet='abc',BillingCity='Dandeli')};
        insert acc1;
        AccountHandler.copyBillingAddress(acc1);
         
        Account updateacc=[select ShippingStreet, ShippingCity,BillingStreet,BillingCity from account where Id=:acc1[0].Id];
        system.AssertEquals('abc',updateacc.ShippingStreet);
        system.AssertEquals('Dandeli',updateacc.ShippingCity);
        
    }*/
    @isTest
    public static void testClass3(){
        list<account> accToConlist =new list<account>();
        list<account> accToOpplist =new list<account>();
        account acc1=new account(name='paggu',Contact__c=true);
        account acc2=new account(name='abc');
        accToConlist.add(acc1);
        accToConlist.add(acc2);
        insert accToConlist;
        AccountHandler.createOppAndCon(accToConlist);

        Account a1=new Account(Name='Acc1',Opportunity__c=true);
        Account a2=new Account(Name='Acc2',Opportunity__c=true,Active__c='yes');
        accToOpplist.add(a1);
        accToOpplist.add(a2);
        insert accToOpplist;
        AccountHandler.createOppAndCon(accToOpplist);
    }
}