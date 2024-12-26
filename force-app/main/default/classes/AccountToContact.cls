public class AccountToContact {
    public static void createAccount(list<Account> accList){
        List<contact> conList=new List<contact>();
        Map<String,Account> accMap=new Map<string,Account>();
        String Phone; 
        for(account acc:accList){
            if(acc.phone!=null){
                 Phone=acc.Phone;
                 accMap.put(acc.Phone,acc);
            }
        }
        Set<String> phoneNumbers = accMap.keySet();
        list<contact> conPhone=[select id,Phone from Contact where Phone=:phoneNumbers];
        if(conPhone.isEmpty()){
            for(account acc:accList){
                if(acc.phone!=null){
           		 contact con=new contact();
            	 con.lastName='Acc last';
            	 con.Phone=acc.Phone;
           		 con.AccountId=acc.Id;
                    conList.add(con);
                }
            }
            
            if(!conList.isEmpty()){
                insert conList;
            }
        }else{
            for(contact c:conPhone){
                 Account acc = accMap.get(c.Phone);
                if (acc != null) {
                    c.AccountId = acc.Id;
                    conList.add(c);
                }
            }
            
            if(!conList.isEmpty()){
                update conList;
            }
        
        }
    }
}