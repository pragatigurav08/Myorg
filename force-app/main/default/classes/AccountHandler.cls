public class AccountHandler {
  
    public static void handleAfterInsert(List<Account> newList) {
        List<Contact> conList = new List<Contact>();
 
        // Iterate over each new Account record
        for (Account acc : newList) {
            // Check if Number_of_contacts__c is not null
            if (acc.NumberofLocations__c != null) {
                // Create the specified number of Contact records
                for (Integer i = 0; i < acc.NumberofLocations__c; i++) {
                    Contact con = new Contact();
                    con.LastName = acc.Name + ' ' + i;
                    con.AccountId = acc.Id;
                    conList.add(con);
                }
            }
        }
 
        // Insert Contact records in bulk
        if (!conList.isEmpty()) {
            try {
                insert conList;
            } catch (DmlException e) {
                // Handle DML exceptions (e.g., log the error or notify users)
                System.debug('Error inserting Contacts: ' + e.getMessage());
            }
        }
    }
    /*public static void createSalesRep(List<account> accList){
        set<Id> accIds=new set<Id>();
        for(Account acc:accList){
           accIds.add(acc.OwnerId);
        }
        list<user> ownerList=[select Id, name from user where id in:accIds];
        for(Account acc:accList){
          acc.Sales_Rep__c=ownerList[0].name;
        }
    }
    

    public static void createNumberOfContact(list<account> accList){
        list<contact> conList =new list<contact>();
        for(account acc:accList){
            if(acc.NumberofLocations__c!=null){
                Integer count=acc.NumberofLocations__c.intValue();
                for(integer i=0;i<count;i++){
                    contact con=new Contact();
                    con.LastName='Conlast'+i;
                    con.AccountId=acc.Id;
                    conList.add(con);
                }
            }  
        }
        if(!conList.isEmpty()){
            insert conList;
        }
    } 
      
    public static void changeOwner(list<account> accList){
        set<id> accIds=new set<Id>();
        list<contact> conlist=new list<contact>();  
        for(account acc:accList){
                accIds.add(acc.id);     
        }
        list<account> ownerList=[select id,ownerId,owner.name,(select id,ownerid from contacts)from account where id in:accIds];
        for(account a:ownerList){
            for(contact con:a.contacts){
                if(a.ownerId!=con.OwnerId){
                    con.OwnerId=a.ownerId;
                    conlist.add(con);
                }
          }
    }
        if(!conlist.isEmpty()){
            update conlist;
        }
    }

    /* public static void preventaccdel(list<account> acclist){
         set<id> accid=new set<id>();
             for(account acc:acclist){
             accid.add(acc.id);
         }
         for(opportunity opp:[SELECT id,AccountId from opportunity where AccountId IN:accid]){
             for(account acc1:acclist){
                 if(acc1.id==opp.AccountId){
                     acc1.adderror('you cannot delete this account.....!');
                 }
             }             
             
         }
    }
    
    
    public static void leftEmpCount(List<contact> oldEmpList){
		Set<Id> accIds=new Set<Id>();
		List<Account> accToBeUpdated=new List<Account>();
		Map<Id,Account> accIdToAccMap;
		List<contact> empList= new List<contact>();
		Map<Id,Decimal> accIdToTotalCount= new Map<Id,Decimal>();
		for(contact con:oldEmpList){
			if(con.AccountId!=null){
				accIds.add(con.AccountId);
				empList.add(con);
		}
}
			if(!accIds.isEmpty()){
			accIdToAccMap= new Map<Id,Account>([SELECT Id,Left_Employee_Count__c FROM Account WHERE Id IN:accIds]);
}
        if(!empList.isEmpty()){
			for(contact con:empList){
				if(accIdToAccMap.containsKey(con.AccountId)){
					if(accIdToTotalCount.containsKey(con.AccountId)){
						Decimal count =accIdToTotalCount.get(con.AccountId)+1;
                        accIdToTotalCount.put(con.AccountId,count);
					}else{
						accIdToTotalCount.put(con.AccountId,accIdToAccMap.get(con.AccountId).Left_Employee_Count__c+1);
				}
			}
		}
}

	for(Id accId:accIdToTotalCount.keySet()){
		Account acc= new Account();
		acc.Id=accId;
		acc.Left_Employee_Count__c=accIdToTotalCount.get(accId);
		accToBeUpdated.add(acc);
	}
	if(!accToBeUpdated.isEmpty()){
		update accToBeUpdated;
}
}
 

    public static void preventdel(list<account> acclist){
        for(account acc:acclist){
            if(acc.Active__c=='yes'){
                acc.addError(Label.Prevent_Account_Deletion);
            }
        }
    }
    
    public static void preventEdit(list<account> acclist){
        for(account acc:acclist) {
            if(acc.CreatedDate<System.today()-1){
                acc.adderror('Account Cannot be edited');
            }
        }       
    }
    

    public static void updaterelatedContactphone(List<account> acclist,map<id,account> oldMap){
        list<contact> conlist=new List<contact>();
        //set<Id> accid=new set<id>();
        map<id,account> accountsToContactMap =new Map<id,account>();
        for(account acc:acclist){
            if(acc.phone!=(oldMap.get(acc.id).phone)){
                accountsToContactMap.put(acc.id,acc);
                //accid.add(acc.id);
            }
        }
        
      //  for(Account acc : [SELECT Id, Phone, (SELECT HomePhone FROM Contacts) FROM Account WHERE Id IN: accIds])
        for(contact con:[select id,HomePhone,accountId from contact where AccountId IN:accountsToContactMap.keyset()])
        {
                if(accountsToContactMap.containsKey(con.AccountId)){
					con.HomePhone=accountsToContactMap.get(con.AccountId).Phone;
                    conlist.add(con);
                    /*if(acc.Contacts != null){
                  		  for(Contact con : acc.Contacts){
                         	 con.HomePhone=acc.Phone;

            }
            }
        if(!conlist.isEmpty()){
            update conlist;
        }
    }
}
}

    public static void copyBillingAddress(List<account>newlist){
        for(Account act:newlist){
            if(act.CopyBillingToShipping__c==true){
                act.ShippingStreet = act.BillingStreet;
            	act.ShippingCity = act.BillingCity;
            	act.ShippingState = act.BillingState;
            	act.ShippingPostalCode = act.BillingPostalCode;
            	act.ShippingCountry = act.BillingCountry;
            }
        }
    }

    public static void updatephonenum(list<account> acclist,map<id,account>oldMap){
        for(Account acc:acclist){
            if(acc.phone!=(oldmap.get(acc.id).phone)){
                acc.description='old phone number: '+oldmap.get(acc.id).phone+'new Phone number: '+acc.phone;
            }
        }
    }
    
    public static void updateIndustryRating(List<Account>accList,Map<Id,Account> oldMap){
	for(Account acc:accList){
		if(acc.Industry=='Media')
		{
			acc.Rating='Hot';
            }
    }
    }


    
    public static void updaterating(List<account>acclist){
        for(Account acc:acclist){
        if(acc.Industry!=null && acc.Industry=='Media')
        {
            acc.Rating='Hot';
        }
            
    }
    }
    public static void createContact(List<account>actlist)
    {
        List<Contact> newcon= new List<Contact>();
        for(account acc :actlist)
        {
            if(acc.Id!=null)
            {
                Contact con=new Contact();
                con.LastName=acc.Name;
                con.AccountId=acc.Id;  
                newcon.add(con);
            }   
        }
        if(!newcon.isEmpty()){
            insert newcon;
        }
}
public static void populaterating(List<account> acclist){
        for(account acc:acclist){
            if(acc.industry!=null && acc.Industry=='Media'){
                acc.rating='Hot';
            }
        }
    }
    
   public static void createOppAndCon(List<Account> accList)
   {
		List<Contact> conList= new List<Contact>();
		List<Opportunity> oppList= new List<Opportunity>();
		for(Account acc:accList){
			if(acc.Contact__c){
				Contact con = new Contact();
	 			con.FirstName = acc.Name;
				con.LastName = 'last'+acc.Name;
				con.AccountId = acc.Id;
				conList.add(con);
	  }
            if(acc.Opportunity__c && acc.Active__c == 'Yes')
            {
                Opportunity opp = new Opportunity();
				opp.AccountId = acc.Id;
				opp.StageName = 'Prospecting';
				opp.CloseDate = System.today();
				opp.Name = acc.Name;
				oppList.add(opp);
            }
   }
       if(!conList.isEmpty() && !oppList.isEmpty()){
           insert conList;
           insert oppList;
       }
   } 

    /*public static void updatePhoneNum(List<Account>acclist,Map<id,account>oldMap)
    {
        List<contact> conList=new List<contact>();
       // Map<Id,Account> accountstoContact=new Map<Id, Account>();
         set<Id> accids=new set<Id>();
        for(account acc:acclist)
        {
            if((acc.Phone!=null && acc.Phone!=(oldMap.get(acc.Id).Phone))&& oldMap!=null)
            {
                accids.add(acc.id);
            }
        }
        for(account act:[select id, Phone, (select HomePhone from contacts) from account where Id IN :accids])
            // [SELECT Id, Phone, (SELECT HomePhone FROM Contacts) FROM Account WHERE Id IN: accIds]
        {
            if(act.Contacts != null){
                for(Contact con : act.Contacts){
				con.HomePhone=act.Phone;
				conList.add(con);             }
        }
        if(!conList.isEmpty())
        {
			update conList;
		}
}
}*/
}