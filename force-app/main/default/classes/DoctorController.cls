public with sharing class DoctorController {
    @AuraEnabled(cacheable=true)
    public static List<Doctor__c> getDoctors() {
        return [SELECT Id, Name, Specialty__c FROM Doctor__c];
    }
}