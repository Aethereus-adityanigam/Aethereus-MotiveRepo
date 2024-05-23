import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import amount from '@salesforce/schema/Opportunity.Amount';
import name from '@salesforce/schema/Opportunity.Name';
import closeDate from '@salesforce/schema/Opportunity.CloseDate';
import stage from '@salesforce/schema/Opportunity.StageName';
import type1 from '@salesforce/schema/Opportunity.Type';

export default class RecordForm extends LightningElement {
    @api recordId;
    fields = [amount, name, closeDate, stage, type1];

    handleSuccess(event) {
        const toastEvent = new ShowToastEvent({
            title: 'Successfully created opportunity',
            message: 'Opportunity created successfully',
            variant: 'success'
        });
        this.dispatchEvent(toastEvent);
    }
    /*    
    handleError(event) {
        const toastEvent = new ShowToastEvent({
            title: 'Error',
            message: event.detail.message,
            variant: 'error',
        });
        this.dispatchEvent(toastEvent);
    }
*/
    handleSubmit(event) {
        event.preventDefault(); 
        const fields = event.detail.fields;
        fields.AccountId = this.recordId; 
        this.template.querySelector('lightning-record-form').submit(fields);
    }
}