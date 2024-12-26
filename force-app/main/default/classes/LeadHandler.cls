public class LeadHandler {
	 /*public static void preventCreation(list<lead> leadList){
         String email;
        for(lead ld:leadList){
            email=ld.Email;
        }
         list<lead> emailList=[select id,email from lead where email=:email];
             for(lead l1:emailList){
                 if(l1.email==email){
                     l1.adderror('Lead Cannot be Created');
                 }
             }
    }*/
    
   
    public static void preventCreation(List<Lead> leadList) {
        // Collect all emails from leadList
        Set<String> emailSet = new Set<String>();
        for (Lead ld : leadList) {
            if (ld.Email != null) {
                emailSet.add(ld.Email);
            }
        }

        // Query for existing leads with the same email
        List<Lead> existingLeads = [SELECT Id, Email FROM Lead WHERE Email IN :emailSet];

        // Create a Set of emails that already exist
        Set<String> existingEmails = new Set<String>();
        for (Lead l : existingLeads) {
            existingEmails.add(l.Email);
        }

        // Check if the emails in leadList exist in the existingEmails Set
        for (Lead ld : leadList) {
            if (existingEmails.contains(ld.Email)) {
                ld.addError('Lead Cannot be Created');
            }
        }
    }

}