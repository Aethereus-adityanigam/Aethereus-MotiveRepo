import { LightningElement, api } from 'lwc';
import createOpportunity from '@salesforce/apex/OpportunityController.createOpportunity';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';

export default class CreateOpportunity extends LightningElement {
    @api recordId;

    handleSubmit(event) {
        event.preventDefault();

        const fields = event.detail.fields; 
        createOpportunity({ 
            name: fields.Name, 
            accountId: fields.AccountId, 
            closeDate: fields.CloseDate, 
            stageName: fields.StageName,
            type: fields.Type 
        })
        .then(result => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: result,
                    variant: 'success',
                }),
            );
            this.clearFields();
        })
        .catch(error => {
            let errorMessage = 'Error creating opportunity';
            if (error && error.body && error.body.message) {
                errorMessage = error.body.message;
            }
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error',
                    message: errorMessage,
                    variant: 'error',
                }),
            );
            this.clearFields();
        });
    }

    clearFields() {
        const inputFields = this.template.querySelectorAll('lightning-input-field');
        if (inputFields) {
            inputFields.forEach(field => {
                field.reset();
            });
        }
    }
    handleExit() {
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Account',
                actionName: 'list'
            }
        });
    
}
}
