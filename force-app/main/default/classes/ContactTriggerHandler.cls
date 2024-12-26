public class ContactTriggerHandler {
    
    public static void contactRelationship(List<contact> conList){
        list<Contact_Relationship__c> cr=new list<Contact_Relationship__c>();
        for(contact con:conList){
            if(con.Contact_relatopnship__c){
                Contact_Relationship__c conRel=new Contact_Relationship__c();
                conRel.Name='test Relationship';
                conRel.Contact__c=con.Id;
                cr.add(conRel);
            }
        }
        insert cr;
    }
    
    //GENERATING UNIQUE ID AS PER REQUIREMENT 2
    
    /*public static void generateUID(List<Contact> contacts) {
        for (Contact con : contacts)
        {
            if (con.year_of_pass_out__c != null && con.Branch__c != null && con.Birth_City__c != null && con.Year_Of_Birth__c != null) 
            {
                String yearOfPassOut = String.valueOf(con.year_of_pass_out__c).substring(2, 4);
                String branch = con.Branch__c.toUpperCase();
                String cityInitials = con.Birth_City__c.length() >= 2 ? 
                                      con.Birth_City__c.substring(0, 2).toUpperCase() : 
                                      con.Birth_City__c.toUpperCase();
                String yearOfBirth = String.valueOf(con.Year_Of_Birth__c);
                
                con.UID__c = yearOfPassOut + '-' + branch + cityInitials + '-' + yearOfBirth;
            }
            
        }
    }
    
//REQUIREMENT 3
    /*public static void syncskills(List<contact>conlist){
        for (Contact con : conlist) {
        if (con.Skill_Set__c != null) {
            List<String> skillNames = con.Skill_Set__c.split(',');
            List<Skill__c> skillsToCreate = new List<Skill__c>();
            List<ContactSkill__c> contactSkillsToCreate = new List<ContactSkill__c>();

            for (String skillName : skillNames) {
                skillName = skillName.trim();
                Skill__c existingSkill = [SELECT Id FROM Skill__c WHERE Name = :skillName];

                if (existingSkill == null) {
                    Skill__c newSkill = new Skill__c(Name = skillName);
                    skillsToCreate.add(newSkill);
                } else {
                    ContactSkill__c contactSkill = new ContactSkill__c(Contact__c = con.Id, Skill__c = existingSkill.Id);
                    contactSkillsToCreate.add(contactSkill);
                }
            }

            if (!skillsToCreate.isEmpty()) {
                insert skillsToCreate;
                /*for (Skill__c skill : skillsToCreate) {
                 if()
                    ContactSkill__c contactSkill = new ContactSkill__c(Contact__c = con.Id, Skill__c = skill.Id);
                    contactSkillsToCreate.add(contactSkill);
                }
            }

            if (!contactSkillsToCreate.isEmpty()) {
                insert contactSkillsToCreate;
            }
        }
    }
    }
    public static void checkskill(List<Contact> c1) {
        List<ContactSkill__c> existingContactSkills = [SELECT Id, Contact__c, Skill__c FROM ContactSkill__c WHERE Contact__c IN :c1];
 
        Map<Id, Set<Id>> contactSkillMap = new Map<Id, Set<Id>>();
        for (ContactSkill__c existingContactSkill : existingContactSkills) {
            if (!contactSkillMap.containsKey(existingContactSkill.Contact__c)) {
                contactSkillMap.put(existingContactSkill.Contact__c, new Set<Id>());
            }
            contactSkillMap.get(existingContactSkill.Contact__c).add(existingContactSkill.Skill__c);
        }
 
        List<ContactSkill__c> contactSkillsToCreate = new List<ContactSkill__c>();
 
        for (Contact con : c1) {
            if (con.skill_set__c != null) {
                List<String> skillNames = con.skill_set__c.split(',');
 
                for (String skillName : skillNames) {
                    skillName = skillName.trim();
                    // Check if skill already exists
                    List<Skill__c> existingSkills = [SELECT Id FROM Skill__c WHERE Name = :skillName LIMIT 1];
                    Skill__c existingSkill = (existingSkills.isEmpty()) ? null : existingSkills[0];
 
                    if (existingSkill == null) {
                        // Create new skill record
                        Skill__c newSkill = new Skill__c(Name = skillName);
                        insert newSkill;
 
                        // Create contact skill record
                        ContactSkill__c contactSkill = new ContactSkill__c(Contact__c = con.Id, Skill__c = newSkill.Id);
                        contactSkillsToCreate.add(contactSkill);
                    } else {
                        // Check if contact already has this skill
                        if (!contactSkillMap.containsKey(con.Id) || !contactSkillMap.get(con.Id).contains(existingSkill.Id)) {
                            // Create contact skill record
                            ContactSkill__c contactSkill = new ContactSkill__c(Contact__c = con.Id, Skill__c = existingSkill.Id);
                            contactSkillsToCreate.add(contactSkill);
                        }
                    }
                }
            }
        }
 
        if (!contactSkillsToCreate.isEmpty()) {
            insert contactSkillsToCreate;
        }
    }*/
}