public class OpportunityHandlerClass {
    public static void handleAfterInsert(List<Opportunity> newOpportunities) {
        Set<Id> accountIds = new Set<Id>();
        for (Opportunity opp : newOpportunities) {
            if (opp.AccountId != null) {
                accountIds.add(opp.AccountId);
            }
        }
        addOpportunityOwnersToAccountTeams(accountIds);
    }
 
    public static void handleAfterUpdate(List<Opportunity> newOpportunities, Map<Id, Opportunity> oldOpportunities) {
        Set<Id> accountIds = new Set<Id>();
        for (Opportunity opp : newOpportunities) {
            if (opp.AccountId != null) {
                accountIds.add(opp.AccountId);
            }
            Opportunity oldOpp = oldOpportunities.get(opp.Id);
            if (oldOpp.AccountId != null && oldOpp.AccountId != opp.AccountId) {
                accountIds.add(oldOpp.AccountId);
            }
        }
        addOpportunityOwnersToAccountTeams(accountIds);
    }
 
    public static void handleAfterDelete(List<Opportunity> oldOpportunities) {
        Set<Id> accountIds = new Set<Id>();
        for (Opportunity opp : oldOpportunities) {
            if (opp.AccountId != null) {
                accountIds.add(opp.AccountId);
            }
        }
        addOpportunityOwnersToAccountTeams(accountIds);
    }
 
    private static void addOpportunityOwnersToAccountTeams(Set<Id> accountIds) {
        List<AccountTeamMember> accountTeamMembersToAdd = new List<AccountTeamMember>();
 
        for (Opportunity opp : [SELECT Id, AccountId, OwnerId FROM Opportunity WHERE AccountId IN :accountIds]) {
            if (opp.AccountId == null || opp.OwnerId == null) {
                continue;
            }
 
            List<AccountTeamMember> existingTeamMembers = [
                SELECT Id
                FROM AccountTeamMember
                WHERE AccountId = :opp.AccountId AND UserId = :opp.OwnerId
                LIMIT 1
            ];
            if (existingTeamMembers.isEmpty()) {
                AccountTeamMember teamMember = new AccountTeamMember();
                teamMember.AccountId = opp.AccountId;
                teamMember.UserId = opp.OwnerId;
                teamMember.TeamMemberRole = 'Opportunity Owner'; // Customize the role as needed
                accountTeamMembersToAdd.add(teamMember);
            }
        }
 
        if (!accountTeamMembersToAdd.isEmpty()) {
            insert accountTeamMembersToAdd;
        }
    }
}