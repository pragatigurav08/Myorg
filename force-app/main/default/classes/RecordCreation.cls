/*@RestResource(urlMapping='/ContactsCreation/*')
global with sharing class ContactCreation {
@HttpPost
    global static String ContactsCreation()
    {
        RestRequest req = RestContext.request; 
		RestResponse res = RestContext.response; 
		String jsonString = req.requestBody.toString();
        system.debug(jsonString);
        //ResponseMessage response = new ResponseMessage();
        /*try {
            // Create Account
            Account newAccount = new Account(
                Name = req.accountName,
                Phone = req.accountPhone,
                Website = req.accountWebsite
            );
            insert newAccount;
            
            // Create related Contacts
            List<Contact> contactsToInsert = new List<Contact>();
            for (Contacts contact : req.contacts) {
                Contact newContact = new Contact(
                    FirstName = contact.firstName,
                    LastName = contact.lastName,
                    Email = contact.email,
                    Phone = contact.phone,
                    AccountId = newAccount.Id
                );
                contactsToInsert.add(newContact);
            }
            insert contactsToInsert;     
    }
        return jsonString;
    }
}*/


public with sharing class RecordCreation {

    @AuraEnabled
    public static void createContacts(List<Contact> contacts) {
        try {
            if (contacts != null && !contacts.isEmpty()) {
                insert contacts;
            }
        } catch (Exception e) {
            throw new AuraHandledException('Error inserting contacts: ' + e.getMessage());
        }
    }
    
     @AuraEnabled
    public static void createOpportunities(List<Opportunity> opportunities) {
        try {
            insert opportunities;
        } catch (DmlException e) {
            throw new AuraHandledException('Error inserting opportunities: ' + e.getMessage());
        }
    }

    @AuraEnabled
    public static void createCases(List<Case> cases) {
        try {
            insert cases;
        } catch (DmlException e) {
            throw new AuraHandledException('Error inserting cases: ' + e.getMessage());
        }
    }  
}