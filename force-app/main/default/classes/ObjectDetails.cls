public with sharing class ObjectDetails {
    @AuraEnabled(cacheable=true)
    public static List<Contact> showcontacts() {
	return [Select Email,Phone,Name from Contact];

}
    @AuraEnabled
    public static void deleteContact(Id contactId) {
        Contact contactToDelete = [SELECT Id FROM Contact WHERE Id = :contactId  LIMIT 1];
        delete contactToDelete;
    }
    @AuraEnabled
    public static void saveContact(Contact contact) {
        try {
            insert contact;
        } catch (Exception e) {
            throw new AuraHandledException('Error saving contact: ' + e.getMessage());
        }
    }
    
}