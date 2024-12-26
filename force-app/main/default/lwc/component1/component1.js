import { LightningElement, track } from 'lwc';
import insertContacts from '@salesforce/apex/RecordCreation.createContacts';
import insertOpportunities from '@salesforce/apex/RecordCreation.createOpportunities';
import insertCases from '@salesforce/apex/RecordCreation.createCases';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class Component1 extends LightningElement {
    @track contacts = [{ id: 0, FirstName: '', LastName: '', Email: '' }];
    @track areContactsVisible = false;
    @track contactsIconName = 'utility:chevronright';

    @track opportunities = [{ id: 0, Name: '', CloseDate: '', StageName: '' }];
    @track areOpportunitiesVisible = false;
    @track opportunitiesIconName = 'utility:chevronright';

    @track cases = [{ id: 0, Subject: '', Origin: '', Status: '', Priority: '' }];
    @track areCasesVisible = false;
    @track casesIconName = 'utility:chevronright';

    toggleContactsVisibility() {
        this.areContactsVisible = !this.areContactsVisible;
        this.contactsIconName = this.areContactsVisible ? 'utility:chevrondown' : 'utility:chevronright';
    }

    toggleOpportunitiesVisibility() {
        this.areOpportunitiesVisible = !this.areOpportunitiesVisible;
        this.opportunitiesIconName = this.areOpportunitiesVisible ? 'utility:chevrondown' : 'utility:chevronright';
    }

    toggleCasesVisibility() {
        this.areCasesVisible = !this.areCasesVisible;
        this.casesIconName = this.areCasesVisible ? 'utility:chevrondown' : 'utility:chevronright';
    }

    handleInputChange(event) {
        const index = event.target.dataset.id;
        const field = event.target.dataset.field;
        const section = event.target.dataset.section;

        if (section === 'contact') {
            this.contacts[index][field] = event.target.value;
        } else if (section === 'opportunity') {
            this.opportunities[index][field] = event.target.value;
        } else if (section === 'case') {
            this.cases[index][field] = event.target.value;
        }
    }

    addContactRow() {
        this.contacts.push({ id: this.contacts.length, FirstName: '', LastName: '', Email: '' });
    }

    addOpportunityRow() {
        this.opportunities.push({ id: this.opportunities.length, Name: '', CloseDate: '', StageName: '' });
    }

    addCaseRow() {
        this.cases.push({ id: this.cases.length, Subject: '', Origin: '', Status: '', Priority: '' });
    }

    handleSaveAllContacts() {
        const formattedContacts = this.contacts.map(contact => ({
            FirstName: contact.FirstName,
            LastName: contact.LastName,
            Email: contact.Email
        }));

        insertContacts({ contacts: formattedContacts })
            .then(() => {
                this.showToast('Success', 'All contacts created successfully', 'success');
                this.contacts = [{ id: 0, FirstName: '', LastName: '', Email: '' }];
            })
            .catch(error => {
                this.showToast('Error', 'Error creating contacts: ' + error.body.message, 'error');
            });
    }

    handleSaveAllOpportunities() {
        const formattedOpportunities = this.opportunities.map(opportunity => ({
            Name: opportunity.Name,
            CloseDate: opportunity.CloseDate,
            StageName: opportunity.StageName
        }));

        insertOpportunities({ opportunities: formattedOpportunities })
            .then(() => {
                this.showToast('Success', 'All opportunities created successfully', 'success');
                this.opportunities = [{ id: 0, Name: '', CloseDate: '', StageName: '' }];
            })
            .catch(error => {
                this.showToast('Error', 'Error creating opportunities: ' + error.body.message, 'error');
            });
    }

    handleSaveAllCases() {
        const formattedCases = this.cases.map(cs => ({
            Subject: cs.Subject,
            Origin: cs.Origin,
            Status: cs.Status,
            Priority: cs.Priority
        }));

        insertCases({ cases: formattedCases })
            .then(() => {
                this.showToast('Success', 'All cases created successfully', 'success');
                this.cases = [{ id: 0, Subject: '', Origin: '', Status: '', Priority: '' }];
            })
            .catch(error => {
                this.showToast('Error', 'Error creating cases: ' + error.body.message, 'error');
            });
    }

    handleDiscardAllContacts() {
        this.contacts = [{ id: 0, FirstName: '', LastName: '', Email: '' }];
    }

    handleDiscardAllOpportunities() {
        this.opportunities = [{ id: 0, Name: '', CloseDate: '', StageName: '' }];
    }

    handleDiscardAllCases() {
        this.cases = [{ id: 0, Subject: '', Origin: '', Status: '', Priority: '' }];
    }

    showToast(title, message, variant) {
        const evt = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        });
        this.dispatchEvent(evt);
    }
}