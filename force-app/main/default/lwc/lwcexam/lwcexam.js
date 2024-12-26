import { LightningElement, track} from 'lwc';
import saveContact from '@salesforce/apex/ObjectDetails.saveContact';
import deleteContact from '@salesforce/apex/ObjectDetails.deleteContact';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class ContactForm extends LightningElement {
    @track isModalOpen = false;
    @track firstName = '';
    @track lastName = '';
    @track email = '';
    @track phone = '';
    @track City='';
    @track contacts = [];
    contactId = 0;

    openModal() {
        this.isModalOpen = true;
    }

    closeModal() {
        this.isModalOpen = false;
    }

    handleChange(event) {
        const field = event.target.dataset.id;
        if (field === 'firstName') {
            this.firstName = event.target.value;
        } else if (field === 'lastName') {
            this.lastName = event.target.value;
        } else if (field === 'email') {
            this.email = event.target.value;
        } else if (field === 'phone') {
            this.phone = event.target.value;
        }
        else if (field === 'city') {
            this.city = event.target.value;
        }
    }

    handleSave() {
        this.contactId++;
        const newContact = {
            id: this.contactId,
            SNo: this.contacts.length + 1,
            Name: `${this.firstName} ${this.lastName}`,
            Email: this.email,
            Phone: this.phone,
            City:this.city
        };

        this.contacts = [...this.contacts, newContact];
        this.closeModal();
        this.resetForm();
    }

    handleDelete(event) {
        const contactId = parseInt(event.currentTarget.dataset.id);
        this.contacts = this.contacts.filter(contact => contact.id !== contactId);
    }

    resetForm() {
        this.firstName = '';
        this.lastName = '';
        this.email = '';
        this.phone = '';
        this.city='';
    }
    handleSubmit(saveContact){
        
            if (this.lastName.trim() === '') {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error',
                        message: 'Last Name is required',
                        variant: 'error'
                    })
                );
                return;
            }
    
            const contact = {
                FirstName: this.firstName,
                LastName: this.lastName,
                Email: this.email,
                Phone: this.phone,
                city:this.city
            };
    
            saveContact({ contact })
                .then(() => {
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Success',
                            message: 'Contact created successfully',
                            variant: 'success'
                        })
                    );
                    this.clearForm();
                })
                .catch(error => {
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Error creating contact',
                            message: error.body.message,
                            variant: 'error'
                        })
                    );
                });
        }
        handleDelete(event) {
            const recordId = event.target.dataset.id;
     
            deleteContact({ recordId })
                .then(() => {
                    // Refresh the contact list after deletion
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Success',
                            message: 'Record deleted successfully',
                            variant: 'success'
                        })
                    );
                    return refreshApex(this.contacts);
                })
                .catch(error => {
                    console.error('Error deleting record:', error);
                    // Handle error appropriately
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Error',
                            message: 'Error deleting record',
                            variant: 'error'
                        })
                    );
                });
            }
    }