import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class CreatingOppUsingLwc extends LightningElement {
    @api recordId;
    fields = ['Name', 'CloseDate', 'StageName', 'AccountId'];
    handleSuccess(event) {
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                message: 'Opportunity created successfully',
                variant: 'success'
            })
        );
    }
    handleError(event) {
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Error',
                message: 'An error occurred',
                variant: 'error'
            })
        );
    }


    handleFormLoad(event) {
        event.preventDefault(); 
        const fields = event.detail.fields;
        fields.AccountId = this.recordId; 
        this.template.querySelector('lightning-record-form').submit(fields);
    }
}
