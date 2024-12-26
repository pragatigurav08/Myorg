import { LightningElement, wire } from 'lwc';
import getUsers from '@salesforce/apex/UserController.getUsers';
import getUserAccountCounts from '@salesforce/apex/UserController.getUserAccountCounts';
import getUserOpportunityCounts from '@salesforce/apex/UserController.getUserOpportunityCounts';

const columns = [
    { label: 'Name', fieldName: 'Name', type: 'button', typeAttributes: { label: { fieldName: 'Name' }, name: 'viewDetails', variant: 'base' } },
    { label: 'Email', fieldName: 'Email' },
    { label: 'Role', fieldName: 'UserRole.Name', type: 'text' },
    { label: 'Number of Accounts', fieldName: 'numAccounts', type: 'number' },
    { label: 'Number of Opportunities', fieldName: 'numOpportunities', type: 'number' }
];

export default class ViewUserWise extends LightningElement {
    columns = columns;
    userData = [];
    userDataError;
    userAccountCounts = {};
    userOpportunityCounts = {};

    @wire(getUsers)
    wiredUsers({ error, data }) {
        if (data) {
            this.userData = data;
            const userIds = data.map(user => user.Id);
            this.fetchUserDetails(userIds);
        } else if (error) {
            this.userDataError = error;
        }
    }

    fetchUserDetails(userIds) {
        getUserAccountCounts({ userIds: new list(userIds) })
            .then(result => {
                this.userAccountCounts = result;
                this.updateUserData();
            })
            .catch(error => {
                this.userDataError = error;
            });

        getUserOpportunityCounts({ userIds: new list(userIds) })
            .then(result => {
                this.userOpportunityCounts = result;
                this.updateUserData();
            })
            .catch(error => {
                this.userDataError = error;
            });
    }

    updateUserData() {
        this.userData = this.userData.map(user => {
            return {
                ...user,
                numAccounts: this.userAccountCounts[user.Id] || 0,
                numOpportunities: this.userOpportunityCounts[user.Id] || 0
            };
        });
    }

    handleRowAction(event) {
        const userId = event.detail.row.Id;
        // Additional logic can be implemented here if needed when a row is clicked
        // For now, we'll just log the userId
        console.log('User ID:', userId);
    }
}