public with sharing class UserController {
    @AuraEnabled(cacheable=true)
    public static List<User> getUsers() {
        return [SELECT Id, Name, Email, UserRole.Name FROM User LIMIT 100];
    }

    @AuraEnabled(cacheable=true)
    public static Map<String, Integer> getUserAccountCounts(List<Id> userIds) {
        Map<String, Integer> accountCounts = new Map<String, Integer>();
        for (AggregateResult ar : [SELECT OwnerId, COUNT(Id) FROM Account WHERE OwnerId IN :userIds GROUP BY OwnerId]) {
            accountCounts.put((String)ar.get('OwnerId'), (Integer)ar.get('count'));
        }
        return accountCounts;
    }

   @AuraEnabled(cacheable=true)
   public static Map<String, Integer> getUserOpportunityCounts(List<Id> userIds) {
        Map<String, Integer> opportunityCounts = new Map<String, Integer>();
        for (AggregateResult ar : [SELECT OwnerId, COUNT(Id)  FROM Opportunity WHERE OwnerId IN :userIds GROUP BY OwnerId]) {
            opportunityCounts.put((String)ar.get('OwnerId'), (Integer)ar.get('count'));
        }
        return opportunityCounts;
    }
}