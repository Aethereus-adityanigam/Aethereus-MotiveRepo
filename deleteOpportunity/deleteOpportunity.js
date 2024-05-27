import { LightningElement, track } from 'lwc';
import deleteOpportunity from '@salesforce/apex/OpportunityController.deleteOpportunity';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';


export default class DeleteOpportunity extends LightningElement {
    @track opportunityId;

    handleChange(event) {
        const recordId = event.detail.value;
        if (Array.isArray(recordId)) {
            this.opportunityId = recordId[0];
        } else {
            this.opportunityId = recordId;
        }
        console.log('Extracted Opportunity ID:', this.opportunityId);
    }
    
    handleDelete() {
        deleteOpportunity({ opportunityId: this.opportunityId })
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Opportunity deleted successfully',
                        variant: 'success',
                    }),
                );
                this.handleSuccess();
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error deleting opportunity',
                        message: error.body.message,
                        variant: 'error',
                    }),
                );
            });
    }
    handleSuccess() {
        this.opportunityId = null;
        const inputField = this.template.querySelector('lightning-input-field');
        if (inputField) {
            inputField.value = null;
        }
    }
    
    
}
