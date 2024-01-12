import { LightningElement,api,wire } from 'lwc';
import updateProperty from '@salesforce/apex/managePropertyCls.updateProperty';
// import submitForApproval from '@salesforce/apex/managePropertyCls.submitForApproval';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import { getRecord } from 'lightning/uiRecordApi';
import USER_ID from '@salesforce/user/Id';
import NAME_FIELD_USER from '@salesforce/schema/User.Name';
import TickerSymbol from '@salesforce/schema/Account.TickerSymbol';
import FORM_FACTOR from '@salesforce/client/formFactor';
// import Property_OBJECT from '@salesforce/schema/CD_Property__c';
// import PURCHASE_DATE from '@salesforce/schema/CD_Property__c.CD_Purchase_date__c'
//import BLOCK_DATE from '@salesforce/schema/CD_Property__c.CD_Block_Date__c';
// import MODE_OF_PAYMENT from '@salesforce/schema/CD_Property__c.CD_Mode_of_Payment__c';
// import PAYMENT_PERCENTAGE from '@salesforce/schema/CD_Property__c.CD_Payment_Percentage__c';
// import COMMENTS from '@salesforce/schema/CD_Property__c.CD_Block_Comments__c';
// import AGENT_NAME from '@salesforce/schema/CD_Property__c.CD_Agent_Name__c';



export default class ManageBlock extends LightningElement {
//    @api objectApiName = Property_OBJECT;
//    fields= [PURCHASE_DATE,MODE_OF_PAYMENT, PAYMENT_PERCENTAGE, COMMENTS, AGENT_NAME];
   @api getidfromparent;
   @api getdatafromparent;
    @api recordId;
   getProplist={};
   blockComments;
   currentDate;
   userName;
   date;
   date1;
    selectedRecordId;
   get options() {
    return [
        { label: 'Personal Cheque', value: 'Personal Cheque' },
        { label: 'Managers Cheque', value: 'Managers Cheque' },
        { label: 'Third Party Payment', value: 'Third Party Payment' },
        { label: 'Bank Transfer', value: 'Bank Transfer' },
    ];
}

get options2() {
    return [
        { label: 'Yes', value: 'Yes' },
        { label: 'No', value: 'No' },
    ];
}
// getBlockdate(){
//     this.getdatafromparent.CD_Block_Date__c = today();
// }
date;
/*connectedCallback(){
   let d = new Date();
    let newD = new Date(d.getTime() + d.getTimezoneOffset()*60000);
this.getProplist.CD_Block_Date__c = newD.toISOString().substring(0,10);
console.log('Block Date',this.getProplist.CD_Block_Date__c) 

} */
@wire(getRecord, {
    recordId: USER_ID,
    fields: [NAME_FIELD_USER]
}) 
wireuser({data}){
if(data){
this.userName= data.fields.Name.value;
console.log('user checkkkkkkkkkk',this.userName);
console.log("get passed data",JSON.stringify(this.getdatafromparent));
this.getProplist.CD_Sales_Agent_Name__c = this.userName;
console.log("why not binding",this.getProplist.CD_Sales_Agent_Name__c);
}

}
 /*
selectedAccount;

handleAccountSelection(event){
    this.selectedAccount = event.target.value;
    alert("The selected Accout id is"+this.selectedAccount);
}*/
requiredSplitAgent = false;
handleChange(event){
   
    //  if(event.target.label === 'Block Date'){
    //  this.getProplist.CD_Block_Date__c = event.detail.value;
    //  console.log('Block Date', this.getProplist.CD_Block_Date__c);
    // }
    // if(event.target.label === 'Client Name'){
    //     this.getProplist.CD_Client_Name__c = event.detail.value;
    //     console.log('Client Name', this.getProplist.CD_Client_Name__c);
    // }
    if(event.target.label === 'Split Deal'){
        this.getProplist.CD_Split_Deal__c = event.detail.value;
        console.log('Split Deal', this.getProplist.CD_Split_Deal__c);
        if(this.getProplist.CD_Split_Deal__c === 'Yes')
        {
            this.requiredSplitAgent = true;
        }
        if(this.getProplist.CD_Split_Deal__c === 'No')
        {
            this.requiredSplitAgent = false;
        }
    }
    if(event.target.label === 'Buyer Documents Received'){
        this.getProplist.CD_Buyer_Documents_Received__c = event.detail.value;
        console.log('Buyer Documents Received', this.getProplist.CD_Buyer_Documents_Received__c);
    }
    if(event.target.label === 'Block Date'){
        this.getProplist.CD_Block_Date__c = event.detail.value;
        console.log('Block Date', this.getProplist.CD_Block_Date__c);
    }
    if(event.target.label === 'Buyer Representing agent	'){
        this.getProplist.CD_Agent_Representing_Client__c	 = event.detail.value;
        console.log('Buyer Representing agent', this.getProplist.CD_Agent_Representing_Client__c	);
    }
    if(event.target.label === 'Date the reservation fees will be paid'){
        this.getProplist.CDDate_the_reservation_fees_will_be_paid__c = event.detail.value;
        console.log('Date the reservation fees will be paid ', this.getProplist.CDDate_the_reservation_fees_will_be_paid__c);
    }
    if(event.target.label === '% of Reservation Fees to be paid'){
        this.getProplist.CD_Reservation_Fees_be_Paid__c = event.detail.value;
        console.log('% of Reservation Fees to be paid', this.getProplist.CD_Reservation_Fees_be_Paid__c);
    }
     if(event.target.label === 'Brokerage Representing Client'){
        this.getProplist.CD_Brokerage_Representing_Client__c = event.detail.value;
        console.log('Brokerage Representing Client', this.getProplist.CD_Brokerage_Representing_Client__c);
    }
     if(event.target.label === 'Agent Representing Client'){
        this.getProplist.CD_Agent_Representing_Client__c = event.detail.value;
        console.log('Agent Representing Client', this.getProplist.CD_Agent_Representing_Client__c);
    }
    if(event.target.label === 'purchase Date'){
        this.getProplist.CD_Purchase_date__c = event.detail.value;
        console.log('purchase Date', this.getProplist.CD_Purchase_date__c);
       }
    if(event.target.label === 'Mode Of Payment'){
        this.getProplist.CD_Mode_of_Payment__c = event.detail.value;
        console.log('Mode Of Payment', this.getProplist.CD_Mode_of_Payment__c);
    }
     if(event.target.label === 'Payment Percentage'){
        this.getProplist.CD_Payment_Percentage__c= event.detail.value,'%';
        console.log('Payment Percentage', this.getProplist.CD_Payment_Percentage__c,'%');
    }
    if(event.target.label === 'Comments'){
        this.getProplist.CD_Block_Comments__c= event.detail.value;
        console.log('Comments', this.getProplist.CD_Block_Comments__c);
    }
    if(event.target.label === 'Unit Number'){
        this.getProplist.CD_Units__c= event.detail.value;
        console.log('Comments', this.getProplist.CD_Units__c);
    }
    
}
handleUserSelectedLookup(event){

this.getProplist.CD_Agent_Name_User__c = event.detail;
  console.log('Agent Name', this.getProplist.CD_Agent_Name_User__c);
 
  
}
handlesecondUserSelectedLookup(event){

    this.getProplist.CD_Second_Agent__c = event.detail;
      console.log('Agent Name', this.getProplist.CD_Second_Agent__c);
     
    }
    showAlert()
    {
        alert("split deal is 'Yes'.Select Second agent Name");
    }

handleContactSelectedLookup(event){
    
    this.getProplist.CD_Client_Name__c = event.detail;
  console.log('Client Name', this.getProplist.CD_Client_Name__c);
}

/*handleAgentRepresentingLookup(event){
    
    this.getProplist.CD_Agent_Representing_Client_contact__c = event.detail;
  console.log('Agent Name', this.getProplist.CD_Agent_Representing_Client_contact__c);
}
handleBrokeageRepresentingLookup(event){
    
    this.getProplist.CD_Brokerage_Representing_Client_Contact__c = event.detail;
  console.log('Brokeage Name', this.getProplist.CD_Brokerage_Representing_Client_Contact__c);
} 
*/

/*isInputValid() {
    let isValid = true;
    let fieldErrorMsg="Please Enter the";
    let inputFields = this.template.querySelectorAll('.validate');
    inputFields.forEach(item => {
   /*     if(!inputField.checkValidity()) {
            inputField.reportValidity();
            isValid = false;
        }
        this.getProplist[inputField.name] = inputField.value; 
        let fieldValue=item.value;
            let fieldLabel=item.label;            
            if(!fieldValue){
                item.setCustomValidity(fieldErrorMsg+' '+fieldLabel);
                isValid = false;
            }
			
            item.reportValidity();
        
    }); 
    return isValid;
} */

handleSubmit(){
 const isInputsCorrect = [...this.template.querySelectorAll("lightning-input")].reduce((validSoFar, inputField) => {
            inputField.reportValidity();
            return validSoFar && inputField.checkValidity();
        }, true);

        const isInputsCorrect2 = [...this.template.querySelectorAll("lightning-combobox")].reduce((validSoFar, inputField) => {
            inputField.reportValidity();
            return validSoFar && inputField.checkValidity();
        }, true);

        if (isInputsCorrect && isInputsCorrect2) {
            if (this.getProplist.CD_Split_Deal__c === 'Yes' && this.getProplist.CD_Second_Agent__c == null) {
                this.showAlert();
            } else {
                console.log('CheckId', this.getidfromparent);
                console.log('check comment', this.getProplist);
                updateProperty({ probId: this.getidfromparent, propsList: this.getProplist })
                    .then((result) => {
                        console.log('CheckId 2', this.getidfromparent);
                        console.log("returned result", result);
                        if (result == 'Please add approval in Project before submit for approval') {
                            this.dispatchEvent(new ShowToastEvent({
                                title: 'Warning',
                                message: 'Please add Project Approver in Project before submit for approval',
                                variant: 'Warning'
                            }));
                        } else {
                            // After updating the property, submit for approval
                            submitForApproval({ recordId: this.recordId })
                                .then(approvalResult => {
                                    console.log('Approval Result', approvalResult);
                                    this.dispatchEvent(new ShowToastEvent({
                                        title: 'Success!',
                                        message: 'You have blocked this property and submitted for approval',
                                        variant: 'success'
                                    }));
                                    this.closeChild();
                                    window.location.reload();
                                })
                                .catch(approvalError => {
                                    console.error('Approval Error', approvalError);
                                });
                        }
                    })
                    .catch((error) => {
                        console.log('CheckId 2', this.getidfromparent);
                        console.log('checkError', error);
                    });
            }
        }
   
    }


closeChild(){

   

    this.showManageProperties= false;
    

    const selectedevent= new CustomEvent("manageproperty", {
     
        detail: this.showManageProperties
    
    });
    this.dispatchEvent(selectedevent);   
}
//*************************Form Factor Starts Here**************************//

deviceType;
   ismobileRendered = false;
   displayFullData=false;
   desktopView=false;
   connectedCallback()
   {
    if(FORM_FACTOR === "Large")
    {
        this.deviceType ="Desktop/Laptop";
        this.desktopView = true;
        console.log("what is mobile view",this.deviceType);

    }
    if(FORM_FACTOR === "Medium")
    {
        this.deviceType ="Tablet";
    }
    if(FORM_FACTOR === "Small")
    {
        this.deviceType ="Mobile";
        this.ismobileRendered = true;
    }
    let d = new Date();
    let newD = new Date(d.getTime() + d.getTimezoneOffset()*60000);
this.getProplist.CD_Block_Date__c = newD.toISOString().substring(0,10);
console.log('Block Date',this.getProplist.CD_Block_Date__c) 
   }
    
}