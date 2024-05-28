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
            type: fields.Type ,
            amount:fields.Amount
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
                this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error',
                    message: error.body.message,
                    variant: 'error',
                }),
            );
            
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
  
}
