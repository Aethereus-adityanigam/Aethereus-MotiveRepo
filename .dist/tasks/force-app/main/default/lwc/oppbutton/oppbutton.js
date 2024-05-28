import { LightningElement,track,api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
export default class oppbutton extends NavigationMixin(LightningElement) {
   @track activeTabValue;
    @track isCreateOpportunityVisible = false;
    @track isDeleteOpportunityVisible = false;
    @track tabsVisible = false
    @track accountid;
    @api recordId;
    isModalOpen=false;
    connectedCallback() {
        //console.log('Account:',this.AccountId);
        console.log('Record Id:', this.recordId); 
        //this.rec.AccountId = this.recordId; 
        this.accountid=this.recordId;
        console.log('Accountidparentcomp:',this.accountid);
        this.isModalOpen = false;
    }
    handleClick1() {
        // this.activeTabValue = 'create';
        this.isCreateOpportunityVisible = true;
        this.isDeleteOpportunityVisible = false;
        // this.tabsVisible=true;*/
        console.log('recordIdsecond2',this.recordId);
        this.isModalOpen = true;
    }

    handleClick2() {
        // this.activeTabValue = 'delete';
        this.isCreateOpportunityVisible = false;
        this.isDeleteOpportunityVisible = true;
        // this.tabsVisible=true;
        this.isModalOpen = true;
    }
    handleClick3()
    {
        this.isCreateOpportunityVisible=false;
        this.isDeleteOpportunityVisible=false;
        // this.tabsVisible=false;
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Account',
                actionName: 'list'
            }
        });
    }
}
