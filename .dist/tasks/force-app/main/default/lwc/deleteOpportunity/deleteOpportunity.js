import { LightningElement ,track,api} from 'lwc';
import getAccounts from '@salesforce/apex/searchanddelete.getAccounts';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import deleteopp from '@salesforce/apex/searchanddelete.deleteopp';
export default class deleteOpportunity extends LightningElement{
    @track opportunities = [];
    @track selectedOpportunity;
    @track searchTerm='';
    @api isModalOpen=false;
    handleSearchChange(event) {
        this.searchTerm = event.target.value;
        getAccounts({ oppName:this.searchTerm })
            .then(result => {
                this.opportunities = result;
            })
            .catch(error => {
                console.error('Error fetching opportunities:', error);
            });
    }
    handleOpportunitySelection(event) {
        const selectedOpportunityId = event.currentTarget.dataset.id;
        this.selectedOpportunity = this.opportunities.find(opportunity => opportunity.Id === selectedOpportunityId);
        this.searchTerm=this.selectedOpportunity.Name;
        this.opportunities=[];
    }
    handleClick()
    {
        deleteopp({oppid: this.selectedOpportunity})
        .then(result => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Opportunity Deleted successfully',
                    variant: 'success'
                })
            );
        })
    }
    closebutton(event)
    {
        this.isModalOpen=false;
        
        console.log('button clicked');
    }
    closeModal() {
        this.dispatchEvent(new CustomEvent('closemodal'));
        // Optionally reset any state or variables related to the modal
    }
}