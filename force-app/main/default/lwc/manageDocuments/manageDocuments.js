import { LightningElement,api } from 'lwc';
//import updatePropertyDocs from '@salesforce/apex/managePropertyCls.updatePropertyDocs';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
export default class ManageDocuments extends LightningElement {

    @api getidfromparent;
     getPropDocs ={};
    get acceptedFormats(){
    return['.pdf', '.png', '.jpg'];
    }

    handleChange(event){

        if(event.target.name === 'passport'){
            this.getPropDocs.CD_Passport_Number__c = event.detail.value;
            console.log('purchase Date', this.getPropDocs.CD_Passport_Number__c);
           }
        if(event.target.name === 'BankBook'){
            this.getPropDocs.CD_Bank_Account_Number__c = event.detail.value;
            console.log('Mode Of Payment', this.getPropDocs.CD_Bank_Account_Number__c);
        }

    }

    handleSave(){
        updatePropertyDocs({PropId:this.getidfromparent, prop:this.getPropDocs})
        .then(result=>{     
            console.log('CheckId 2', this.getidfromparent); 
            console.log('chenk prop', this.getPropDocs);
            this.getPropDocs= {};       
            console('result', result);
            const toastEvent = new ShowToastEvent({
                title:'Success!',
                message: 'You have document uploaded successfully',
                variant:'success'
                });
                this.dispatchEvent(toastEvent);       
            }
        )
        .catch(error=>{
            console.log('checkError', error);
    
        })
        this.closeChild()
    }

    handleUploadFinished(event) {
        // Get the list of uploaded files
        const uploadedFiles = event.detail.files;
        alert('No. of files uploaded : ' + uploadedFiles.length);
    }
    closeChild(){
        console.log('check', this.getidfromparent)
        this.showManageProperties= false;
        
    
        const selectedevent= new CustomEvent("managedocument", {
         
            detail: this.showManageProperties
        
        });
        this.dispatchEvent(selectedevent);   
    }
}