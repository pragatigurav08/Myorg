public class ContactRelationshipHandler {
    public static void changeowner(list<Contact_Relationship__c>conRelList){
        set<id> ownerids=new set<Id>();
        for(Contact_Relationship__c conRel:conRelList){
            ownerids.add(conRel.Id);  
        }
        user u=[SELECT id, user.name from user where id in:ownerids];
        for(Contact_Relationship__c conRel:conRelList){
             conRel.Name=u.Name;
        }
    }
}