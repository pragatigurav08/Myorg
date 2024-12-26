import { LightningElement, wire, track} from 'lwc';
import getContacts from '@salesforce/apex/ObjectDetails.showcontacts';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import deleteContact from '@salesforce/apex/ObjectDetails.deleteContact';
import { refreshApex } from '@salesforce/apex';
export default class Tabledesign extends LightningElement {
    @track contacts;
    @track error;
    //datalist=[];
    @wire(getContacts)
    
    wiredContacts({ error, data }) {
        if(data){
            this.contacts=data.map((con, index) => {
                return {
                    ...con,
                    SNo: index + 1
                };
            });
        } else if (error) {
            this.error = error;
            this.contacts = undefined;
        }
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