public class AccountContactManagerController {
@AuraEnabled(cacheable=true)
    public static List<Contact> searchContacts(String searchTerm) {
        String query = '%' + searchTerm + '%';
        return [SELECT Id, Name, Email FROM Contact WHERE Name LIKE :query LIMIT 50];
    }
 
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactsByAccountId(Id accountId) {
        return [SELECT Id, Name, Email FROM Contact WHERE AccountId = :accountId];
    }
 
    @AuraEnabled
    public static void saveContacts(Id accountId, List<Contact> contacts) {
        for (Contact contact : contacts) {
            contact.AccountId = accountId;
        }
        upsert contacts;
    }
 
    @AuraEnabled
    public static void deleteContact(Id contactId) {
        Contact contactToDelete = [SELECT Id FROM Contact WHERE Id = :contactId LIMIT 1];
        delete contactToDelete;
    }
}