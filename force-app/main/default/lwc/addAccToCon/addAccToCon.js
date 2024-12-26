import { LightningElement, wire, track, api } from 'lwc';
import searchContacts from '@salesforce/apex/AccountContactManagerController.searchContacts';
import getContactsByAccountId from '@salesforce/apex/AccountContactManagerController.getContactsByAccountId';
import saveContacts from '@salesforce/apex/AccountContactManagerController.saveContacts';
import deleteContact from '@salesforce/apex/AccountContactManagerController.deleteContact';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
 
const COLUMNS = [
    { label: 'Name', fieldName: 'Name' },
    { label: 'Email', fieldName: 'Email' },
    {
        type: 'button',
        typeAttributes: {
            label: 'Add',
            name: 'add',
            variant: 'brand'
        }
    }
];
 
const SELECTED_COLUMNS = [
    { label: 'Name', fieldName: 'Name' },
    { label: 'Email', fieldName: 'Email' },
    {
        type: 'button',
        typeAttributes: {
            label: 'Remove',
            name: 'remove',
            variant: 'destructive'
        }
    }
];
 
export default class AddAccToCon extends LightningElement {
    @api recordId;
    @track contacts = [];
    @track selectedContacts = [];
    @track columns = COLUMNS;
    @track selectedColumns = SELECTED_COLUMNS;
    @track isModalOpen = false;
 
    connectedCallback() {
        this.loadExistingContacts();
    }
 
    loadExistingContacts() {
        getContactsByAccountId({ accountId: this.recordId })
            .then(result => {
                this.selectedContacts = result;
            })
            .catch(error => {
                this.showToast('Error', error.body.message, 'error');
            });
    }
 
    openModal() {
        this.isModalOpen = true;
    }
 
    closeModal() {
        this.isModalOpen = false;
    }
 
    handleSearch(event) {
        const searchTerm = event.target.value;
        searchContacts({ searchTerm: searchTerm })
            .then(result => {
                this.contacts = result;
            })
            .catch(error => {
                this.contacts = [];
                this.showToast('Error', error.body.message, 'error');
            });
    }
 
    handleRowAction(event) {
        const contact = event.detail.row;
        this.selectedContacts = [...this.selectedContacts, contact];
    }
 
    handleRemove(event) {
        const contact = event.detail.row;
        deleteContact({ contactId: contact.Id })
            .then(() => {
                this.selectedContacts = this.selectedContacts.filter(
                    item => item.Id !== contact.Id
                );
                this.showToast('Success', 'Contact removed successfully', 'success');
            })
            .catch(error => {
                this.showToast('Error', error.body.message, 'error');
            });
    }
 
    handleSave() {
        saveContacts({ accountId: this.recordId, contacts: this.selectedContacts })
            .then(() => {
                this.showToast('Success', 'Contacts added successfully', 'success');
                this.selectedContacts = [];
                this.closeModal();
            })
            .catch(error => {
                this.showToast('Error', error.body.message, 'error');
            });
    }
 
    showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        });
        this.dispatchEvent(event);
    }
}