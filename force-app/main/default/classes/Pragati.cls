public class Pragati {
 
    
    public static void test()
    {
    	string str='Hello World';
        system.debug(str);
    }
    public static  void test2()
    {
        test();
        string str1='hey its me';
        System.debug(str1);
        
        account acc=new account(name='abc',phone='56278255');
        insert acc;
        system.debug(acc);
        
       // list<account> myList=new list<account>();
        //myList.add(name='satish');
       // insert myList;
       // system.debug(myList);
        
        
    }
    

}