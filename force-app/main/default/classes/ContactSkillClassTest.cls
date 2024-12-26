@isTest
public class ContactSkillClassTest {
    
    @testSetup
    static void setupTestData() {
        // Create test Skills
        Skill__c skill1 = new Skill__c(Name = 'Java');
        Skill__c skill2 = new Skill__c(Name = 'Apex');
        insert new List<Skill__c>{ skill1, skill2 };

        // Create test Contacts
        Contact contact1 = new Contact(
            LastName = 'Prag',
            Birth_City__c = 'New York',
            Branch__c = 'CS',
            Year_Of_Birth__c = 2001,
            year_of_pass_out__c = 2024,
            Skill_Set__c = 'Java,Apex'
        );
        
        Contact contact2 = new Contact(
            LastName = 'Kore',
            Birth_City__c = 'Belgavi',
            Branch__c = 'IT',
            Year_Of_Birth__c = 1990,
            year_of_pass_out__c = 2012,
            Skill_Set__c = 'Python'
        );
        
        insert new List<Contact>{ contact1, contact2};
    }
    @isTest
    static void testUIN() {
          List<Contact> contacts = [SELECT Id, Birth_City__c, Branch__c, Year_Of_Birth__c, year_of_pass_out__c FROM Contact];
        
        Test.startTest();
        ContactTriggerHandler.generateUID(contacts);
        Test.stopTest();

        // Verify UIN__c field for the first contact
        Contact contact1 = [SELECT UID__c FROM Contact WHERE LastName = 'Prag' LIMIT 1];
        System.assertEquals('24-CSNE-2001', contact1.UID__c, 'UIN for Contact 1 does not match');

        // Verify UIN__c field for the second contact
        Contact contact2 = [SELECT UID__c FROM Contact WHERE LastName = 'Kore' LIMIT 1];
        System.assertEquals('12-ITBE-1990', contact2.UID__c, 'UIN for Contact 2 does not match');    
        //check update 
        contact2.Birth_City__c='Dandeli';
        update contact2;
        Contact updatedcontact2= [SELECT UID__c FROM Contact WHERE LastName = 'Kore' LIMIT 1];
        System.assertEquals('12-ITDA-1990', updatedcontact2.UID__c, 'UIN for Contact 2 does not match');
        
    }
    @isTest
    static void testCheckSkill() {
        List<Contact> contacts = [SELECT Id, Skill_Set__c FROM Contact];

        Test.startTest();
        ContactTriggerHandler.checkSkill(contacts);
        Test.stopTest();

        // Verify ContactSkill__c records were created for the first contact
        List<ContactSkill__c> contactSkills1 = [SELECT Id, Contact__c, Skill__c FROM ContactSkill__c WHERE Contact__c = :contacts[0].Id];
        System.assertEquals(2, contactSkills1.size());

        // Verify ContactSkill__c records were created for the second contact
        List<ContactSkill__c> contactSkills2 = [SELECT Id, Contact__c, Skill__c FROM ContactSkill__c WHERE Contact__c = :contacts[1].Id];
        System.assertEquals(1, contactSkills2.size());

        // Verify the skills names
        Set<String> skillNames = new Set<String>();
        for (ContactSkill__c cs : contactSkills1) {
            Skill__c skill = [SELECT Name FROM Skill__c WHERE Id = :cs.Skill__c];
            skillNames.add(skill.Name);
        }
        System.assert(skillNames.contains('Java'));
        System.assert(skillNames.contains('Apex'));

        skillNames.clear();
        for (ContactSkill__c cs : contactSkills2) {
            Skill__c skill = [SELECT Name FROM Skill__c WHERE Id = :cs.Skill__c];
            skillNames.add(skill.Name);
        }
        System.assert(skillNames.contains('Python'));
    }
}