import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { loadStyle } from 'lightning/platformResourceLoader';
import fileSelectorStyle from '@salesforce/resourceUrl/fileSelectorStyle';

export default class FileUploadExample extends LightningElement {
    @api recordId;
    
    get acceptedFormats() {
        return ['.pdf', '.png'];
    }

    connectedCallback() {
        Promise.all([
            loadStyle(this, fileSelectorStyle)
        ]);
    }

    handleUploadPassport(event) {
        const uploadedFiles = event.detail.files.length;
        const evt = new ShowToastEvent({
            title: 'SUCCESS',
            message: uploadedFiles + ' Your File uploaded  successfully',
            variant: 'success',
        });
        this.dispatchEvent(evt);
    }
    /*
    handleUploadEID(event) {
        const uploadedFiles = event.detail.files.length;
        const evt = new ShowToastEvent({
            title: 'SUCCESS',
            message: uploadedFiles + ' Your EID uploaded  successfully',
            variant: 'success',
        });
        this.dispatchEvent(evt);
    }
    handleUploadKYC(event) {
        const uploadedFiles = event.detail.files.length;
        const evt = new ShowToastEvent({
            title: 'SUCCESS',
            message: uploadedFiles + ' Your KYC uploaded  successfully',
            variant: 'success',
        });
        this.dispatchEvent(evt);
    }
    */
}