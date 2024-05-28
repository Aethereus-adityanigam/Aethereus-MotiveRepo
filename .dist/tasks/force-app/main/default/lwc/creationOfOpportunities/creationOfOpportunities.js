import { LightningElement, api, track } from 'lwc';
import create from '@salesforce/apex/createOpportunity.create';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import NavigationMixin from 'lightning/navigation';
import GetAccountName from '@salesforce/apex/createOpportunity.GetAccountName'
export default class CreationOfOpportunities extends LightningElement{
    @api recordId;
    @api accountid;
    @api isModalOpen=false;
    //@track accountid=this.recordId;
    value;
    @track AccountId1=this.accountid;
    rec = {
        Name: '',
        StageName: '',
        CloseDate: '',
        AccountId:''
    };
    @track accountName='';
    get options() {
        return [
            { label: 'Prospecting', value: 'Prospecting' },
            { label: 'Qualification', value: 'Qualification' },
            {label: 'Needs Analysis', value: 'Needs Analysis' },
            {label: 'Value Proposition', value: 'Value Proposition' },
            {label: 'Id. Decision Makers', value: 'Id. Decision Makers' },
            {label: 'Perception Analysis', value: 'Perception Analysis' },
            {label: 'Proposal/Price Quote', value: 'Proposal/Price Quote' },
            {label: 'Negotiation/Review', value: 'Negotiation/Review' },
            { label: 'Closed Won', value: 'Closed Won' },
            {label: 'Closed Lost', value: 'Closed Lost' },
        ];
    }
    renderedCallback()
    {
        console.log('AccountIdof:',this.AccountId1);
        console.log('API Account',this.accountid);
    }
    handletext(event) {
        this.rec.Name = event.target.value;
    }

    handledate(event) {
        this.rec.CloseDate = event.target.value;
    }

    handleChange(event) {
        this.rec.StageName = event.detail.value;
    }
    connectedCallback() {
        console.log('Account:',this.rec.AccountId);
        console.log('Record Id:', this.recordId);
        this.rec.AccountId = this.accountid; 
        this.AccountName();
    }
    
    handleClick() {
        create({ opp: this.rec })
            .then(result => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Opportunity created successfully',
                        variant: 'success'
                    })
                );
                // Reset the fields after successful creation
                this.name = '';
                this.stage = '';
                this.close = '';
                this.AccountId=this.recordId
                
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating record',
                        message: error.body.message,
                        variant: 'error'
                    })
                );
            });
    }
    closebutton(event)
    {
        this.isModalOpen=false;
        console.log('button clicked');
        this.dispatchEvent(new CustomEvent('closemodal'));
    }
    AccountName()
    {
        GetAccountName({ accId: this.accountid })
        .then(result => {
            // Set the retrieved account name to the property
            this.accountName = result;
        })
        .catch(error => {
            // Handle errors here
            console.error(error);
        });
    }
}
