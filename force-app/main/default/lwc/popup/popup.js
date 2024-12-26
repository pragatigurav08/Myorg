import { LightningElement ,track} from 'lwc';
import saveContact from '@salesforce/apex/ObjectDetails.saveContact';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class Popup extends LightningElement {

    @track firstName = '';
    @track lastName = '';
    @track email = '';
    @track phone = '';
    @track city='';
    @track isModalOpen = false;

    handleChange(event) {
        const field = event.target.dataset.id;
        if (field) {
            this[field] = event.target.value;
        }
    }
    
    openModal() {
        this.isModalOpen = true;
    }
    closeModal() {
        this.isModalOpen = false;
    }
    handleSave() {
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

    clearForm() {
        this.firstName = '';
        this.lastName = '';
        this.email = '';
        this.phone = '';
        this.city='';
    }
}