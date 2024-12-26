public class AccountOPPHandler {

    public static void deleteOrders(List<Account> accList) {
        // Get the Ids of Orders to be deleted
        Set<Id> accIds = new Set<Id>();
        for (Account acc : accList) {
            accIds.add(acc.Id);
        }
 
        // Query the related OrderProducts using the Order Ids
        List<Opportunity> oppToDelete = [
            SELECT Id
            FROM Opportunity
            WHERE AccountId IN :accIds
        ];
 
        // Delete the OrderProducts
        if (!oppToDelete.isEmpty()) {
            delete oppToDelete;
        }
 
        // Now delete the Orders
        delete accList;
    }
    
    
}