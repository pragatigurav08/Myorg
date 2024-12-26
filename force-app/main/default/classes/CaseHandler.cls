public class CaseHandler {
    /*public Static void casenumber(List<Case> cslist){
        list<account> acclist=new list<account>();
        for(case cs:cslist){
            if(cs.AccountId!=null){
                Account acc=new Account();
                acc.id=cs.AccountId;
                acc.Case_number__c=cs.CaseNumber;
                acclist.add(acc);
            }
        }
        if(!acclist.isempty()){
            update Acclist;
        }
    }*/
    
    public static void latestCreatedcase(list<case> caseList,list<case> oldCase){
        set<id> conIds=new Set<Id>();
        for(case cs:caseList){
            if(cs.ContactId!=null){
                conIds.add(cs.ContactId);
            }
        }
        Map<Id, Date> contactLastCaseDate = new Map<Id, Date>();
        for (AggregateResult ar : [
            SELECT ContactId, MAX(CreatedDate) lastDate 
            FROM Case 
            WHERE ContactId IN :conIds 
            GROUP BY ContactId
        ]) {
            contactLastCaseDate.put((Id)ar.get('ContactId'), (Date)ar.get('lastDate'));
        }
        List<Contact> contactsToUpdate = new List<Contact>();
        for(Id contactId : conIds){
            contactsToUpdate.add(new Contact(Id = contactId, LastCaseDate__c = contactLastCaseDate.get(contactId)));
        }
        update contactsToUpdate;
    }
}