import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class OpportunityConsole extends NavigationMixin(LightningElement) {
    handleCreateOpportunity() {
        this[NavigationMixin.Navigate]({
            type: 'standard__navItemPage',
            attributes: {
                apiName: 'Create_Opportunity'
            }
        });
    }

    handleDeleteOpportunity() {
        this[NavigationMixin.Navigate]({
            type: 'standard__navItemPage',
            attributes: {
                apiName: 'Delete_Opportunity'
            }
        });
    }



    handleExit() {
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Account',
                actionName: 'list'
            }
        });
    
}}
