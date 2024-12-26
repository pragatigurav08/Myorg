trigger ContactTrigger on Contact (before insert,before update,after insert,after update)
{
    
    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            ContactTriggerHandler.contactRelationship(Trigger.new);
        }
    }
   /* if (Trigger.isBefore) {
        if (Trigger.isInsert || Trigger.isUpdate) {
            ContactTriggerHandler.generateUID(Trigger.new);
        }
    }
    if (Trigger.isAfter) {
        if (Trigger.isInsert || Trigger.isUpdate) {
            ContactTriggerHandler.checkskill(Trigger.new);
        }
    }
    }
    if (Trigger.isAfter) {
        if (Trigger.isInsert || Trigger.isUpdate) {
            ContactTriggerHandler.processSkills(Trigger.new);
        }
    }
   
    Set<Id> accountIds = new Set<Id>();
        for (Contact con : Trigger.new) {
            if (con.AccountId != null) {
                accountIds.add(con.AccountId);
            }
        }
    //get realted contact record and store it in map
        Map<Id, List<Contact>> accountToContactsMap = new Map<Id, List<Contact>>();
        List<Account> accounts = [SELECT Id, (SELECT Id, checkbox_isclicked__c FROM Contacts)
                                             FROM Account WHERE Id IN :accountIds];
        for (Account acc : accounts) {
            accountToContactsMap.put(acc.Id, acc.Contacts);
        }

        List<Contact> newContacts = new List<Contact>();
        List<Account> newAcc=new List<Account>();
    List<Contact> childContacts=new List<Contact>();
      //  Map<Id, Id> accountToNewParentAccountMap = new Map<Id, Id>();
 
        for (Id accountId : accountToContactsMap.keySet()) {
            Boolean allChecked = true;
            for (Contact con : accountToContactsMap.get(accountId)) {
                if (!con.checkbox_isclicked__c) {
                    allChecked = false;
                    break;
                }
            }
            if (allChecked) {
                // Create a new related contact
                newContacts.add(new Contact(
                    LastName = 'New Contact',
                    AccountId = accountId
                ));
                
               newAcc.add(new Account(
                    Name='NewParentAccount',ParentId=accountId
               ));
                Integer listsize= newAcc.size()-1;
                
               childContacts.add(new Contact(
                LastName='child contact record',
                  AccountId=newAcc.get(listsize).Id));
                
      }  
        }
    // Insert the new related contact record
        if (!newContacts.isEmpty()) {
            insert newContacts;        
}
    if(!newAcc.isEmpty()){
        insert newAcc;
    }
    if(!childContacts.isEmpty()){
        insert childContacts;
    }
    
    //Test Code Starts Here

    for (Contact con : Trigger.new) {
        // Check if all required fields are populated
        if (con.year_of_pass_out__c != null && con.Branch__c != null &&
            con.Birth_City__c != null && con.Year_Of_Birth__c != null) {
            
            // Extract the last two digits of the year of pass-out
            String yearOfPassOut = String.valueOf(con.year_of_pass_out__c).substring(2, 4);
            
            // Extract the engineering branch
            String branch = con.Branch__c;
            
            // Extract the first two characters of the birth city, uppercase them
            String cityInitials = con.Birth_City__c.length() >= 2 ? 
                                  con.Birth_City__c.substring(0, 2).toUpperCase() : 
                                  con.Birth_City__c.toUpperCase();
            
            // Extract the year of birth from DOB
            String yearOfBirth = String.valueOf(con.Year_Of_Birth__c);
            
            // Construct the UIN
            con.UID__c = yearOfPassOut + '-' + branch + cityInitials + '-' + yearOfBirth;
        } else {
            // Clear UIN if any required field is missing
            con.UID__c = null;
        }
    }*/
}