import { LightningElement, api, track, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import fetchRecordData from '@salesforce/apex/ConveyanceChecklist.fetchRecordData';
import FieldsEmpty from '@salesforce/label/c.Empty_Field_in_Checklist';
import NoAMLFound from '@salesforce/label/c.No_AML_in_Checklist';
import checklistcompleted from '@salesforce/label/c.Checklist_is_Completed';
import errorlisting from '@salesforce/label/c.Listing_Record_not_Exist';
import erroraml from '@salesforce/label/c.AML_Record_not_Exist';
import errorInquiry from '@salesforce/label/c.Inquiry_already_has_Conveyance';
import Amlstatusmsg from '@salesforce/label/c.AML_status_is_not_KYC_Pending';
import AmlStatusName from '@salesforce/label/c.AML_Status_1st_Value';
import AmlStatus2ndName from '@salesforce/label/c.AML_status_2nd_Value';
import AmlStatus3rdName from '@salesforce/label/c.AML_status_3rd_Value';
import AmlStatus4thName from '@salesforce/label/c.AML_status_4th_Value';
import AmlStatus5thName from '@salesforce/label/c.AML_status_5th_Value';
import Checkbox from '@salesforce/label/c.ConveyanceChecklist_Doc_Check';
import pagetwo from '@salesforce/label/c.X2nd_Page_Title';
import InquiryExclusiveProject from '@salesforce/label/c.Lwc_Inquiry_RecordTypeId_Exclusive_Project';
import ContactRecordId from '@salesforce/label/c.LWC_Contact_RecordId_SIR_Real_Eastate_LLC';
import TransactionTypePicklist from '@salesforce/label/c.LWC_Transaction_Type_Always_New_Developments_Exclusive_Project';
import ConveyanceExclusiveProject from '@salesforce/label/c.LWC_Conveyance_RecordTypeId_Exclusive_project';

import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import USER_ID from '@salesforce/user/Id';
import NAME_FIELD from '@salesforce/schema/User.Name';
import USER_ID_FIELD from '@salesforce/schema/User.Id';
export default class Conveyancechecklist extends NavigationMixin(LightningElement) {
    userName;
    @api recordId;
    @api isMobile = false;
    @api prop2;
    @api prop1;
    @api prop3;
    listId;
    Inquiryname;
    Listingtitle;
    InquiryId;
    EmptyMessage = FieldsEmpty;
    Aml = NoAMLFound;
    completed = checklistcompleted;
    ListingError = errorlisting;
    AmlError = erroraml;
    InquiryCon = errorInquiry;
    AmlNotPending = Amlstatusmsg;
    StatusOfAML = AmlStatusName;
    StatusOfAML2nd = AmlStatus2ndName;
    StatusOfAML3rd = AmlStatus3rdName;
    StatusOfAML4th = AmlStatus4thName;
    StatusOfAML5th = AmlStatus5thName;
    DocCheck = Checkbox;
    secondtitle = pagetwo;
    InquiryExclusiveProject1 = InquiryExclusiveProject; //new recordtypeid labels Inquiry
    ContactRecordId1 = ContactRecordId; // new Contact recordId 'SIR Real Estate LLC'
    TransactionTypePicklist1 = TransactionTypePicklist; //// new Conveyance Transaction Type piclist -'New Developments - Exclusive Projects'
    ConveyanceExclusiveProject1 = ConveyanceExclusiveProject; //new recordtypeid labels Conveyance
    ACCId;
    ACCtitle;
    profiletype;

    @wire(getRecord, {
        recordId: USER_ID,
        fields: [USER_ID_FIELD]
    })
    wiredUser({ error, data }) {
        if (data) {
            // Retrieve the user's name from the response
            this.userName = getFieldValue(data, USER_ID_FIELD);
            console.log(' USER  ID______----  '+JSON.stringify(this.userName));
        } else if (error) {
            console.error(error);
        }
    }
    @wire(fetchRecordData, { recordId: '$recordId' })
wiredRecordData(result) {
    // If the result is not empty, process it
    if (result.data) {
        this.UID = this.userName;
        console.log(' UID  ID______----  '+JSON.stringify(this.UID));
        console.log(' USER  ID______----  '+JSON.stringify(this.userName));
        this.owner = result.data.inquiryMap["Owner ID"];
        console.log(' OWNER ID______----  '+JSON.stringify(result.data.inquiryMap["Owner ID"]));
        
         this.Transactiontype = result.data.inquiryMap["Transaction Type"];
        console.log(' Transaction_Type__c----'+JSON.stringify(result.data.inquiryMap["Transaction Type"])+'---');

        this.contactEBN = result.data.inquiryMap["Contact name"];
        console.log(' COntact name----  '+JSON.stringify(result.data.inquiryMap["Contact name"]));

        this.InquiryTypecon = result.data.inquiryMap["Inquiry Type"];
        console.log(' INquiry Type----  '+JSON.stringify(result.data.inquiryMap["Inquiry Type"]));

        this.ListingPrefilled = result.data.inquiryMap["Initial Inquiry Listing"];
        console.log(' Listing  name----  '+JSON.stringify(result.data.inquiryMap["Initial Inquiry Listing"]));
        console.log(' -----custom label1 ----- '+JSON.stringify(this.InquiryExclusiveProject1));
        console.log(' -----custom label2 ----- '+JSON.stringify(this.ContactRecordId1));
        console.log(' -----custom label3 ----- '+JSON.stringify(this.TransactionTypePicklist1));
        console.log(' -----custom label4 ----- '+JSON.stringify(this.ConveyanceExclusiveProject1));

        this.contactNameEx = result.data.inquiryMap["Contact"];
        console.log(' Contact Id ----  '+JSON.stringify(result.data.inquiryMap["Contact"]));

        this.FirstBrokerEx = result.data.inquiryMap["Owner ID"];
        console.log(' Owner ID ----  '+JSON.stringify(result.data.inquiryMap["Owner ID"]));

        this.recordTypeinq = result.data.inquiryMap["Record Type ID"];
        console.log('## Record Type Id----  '+JSON.stringify(result.data.inquiryMap["Record Type ID"]));

        this.ListMaxPriceEx = result.data.inquiryMap["Price - max"];
        console.log(' Price Max----  '+JSON.stringify(result.data.inquiryMap["Price - max"]));
        console.log('LWC All Strted');
        console.log(' INQUIRY ____ ---- '+JSON.stringify(result.data.inquiryMap));
        console.log(' OWNER ID______----  '+JSON.stringify(result.data.inquiryMap["Owner ID"]));
        console.log(' Chechking The AML 0  - '+JSON.stringify(result.data.amlList));
        console.log(' msg on PROFILE TYPE  '+JSON.stringify(result.data.inquiryMap["Inquiry Profile"]));
        console.log(' msg on ACCOUNT OBJ '+JSON.stringify(result.data.AccountchildFieldExistsMap));
        console.log(' msg on ACCOUNT OBJ '+JSON.stringify(result.data.AccountchildFieldExistsMap["Agency Name"]));
        console.log(' msg INQUIRY MESS on IN '+JSON.stringify(result.data.ConvencList.length));
        console.log(' Result '+JSON.stringify(result));
        console.log('Result:', result);
        console.log(' msg on IN '+JSON.stringify(result.data.inquiryMap));
        console.log(' msg on AML '+JSON.stringify(result.data.amlList));
        console.log(' msg on AML length '+JSON.stringify(result.data.amlList.length));
        console.log(' msg on LL '+JSON.stringify(result.data.ListingchildFieldExistsMap));
        console.log(' msg on LL ID - '+JSON.stringify(result.data.ListingchildFieldExistsMap.Id));
        this.listId = '/' + result.data.ListingchildFieldExistsMap.Id;
        this.Inquiryname = result.data.inquiryMap['Inquiry Name'];
        this.Listingtitle = result.data.ListingchildFieldExistsMap["Listing Name"];
        this.InquiryId = '/' +result.data.inquiryMap['Inquiry Id']
        this.ACCId = '/' + result.data.AccountchildFieldExistsMap.Id;
        this.ACCtitle = result.data.AccountchildFieldExistsMap["Agency Name"];
        this.conn = result.data.ConvencList.length;
        this.InquiryType = result.data.inquiryMap["Inquiry Type"];
        this.profiletype = result.data.inquiryMap["Inquiry Profile"];
        const { inquiryMap, amlList, ListingchildFieldExistsMap, AccountchildFieldExistsMap } = result.data;
        this.fields = Object.entries(inquiryMap).filter(([fieldApiName]) => (
            fieldApiName !== 'null' && 
            fieldApiName !== 'Inquiry Name' &&
            fieldApiName !== 'Inquiry Id' &&
            fieldApiName !== 'Inquiry Type' &&
            fieldApiName !== 'Inquiry User' &&
            fieldApiName !== 'Owner ID' &&
            fieldApiName !== 'Transaction Type' &&
            fieldApiName !== 'Contact' &&
            fieldApiName !== 'Contact name' &&
            fieldApiName !== 'Price - max' &&
            fieldApiName !== 'Record Type ID'&&
            fieldApiName !== 'Inquiry Profile'
    
            
            )).map(([apiName, exists]) => {
            return { 
                label: apiName,
                apiName: apiName,
                isEmpty: exists, 
                colorclass: exists ? 'green-label' :'red-label'
            }
        });
    
        this.listingfields =
        Object.entries(ListingchildFieldExistsMap).filter(([fieldApiName]) => (
            fieldApiName !== 'null' &&
            fieldApiName !== "Listing Name" &&
            fieldApiName !== 'Id' 
    
        )).map(([apiName, exists]) => {
            return { 
                label: apiName,
                apiName: apiName,
                isEmpty: exists, 
                colorclass: exists ? 'green-label' :'red-label',
               
            }
        });
        this.amlfields = [];
        for (let i = 0; i < result.data.amlList.length; i++) { 
        const wrapper = result.data.amlList[i];
        console.log(' contact test '+JSON.stringify(wrapper.Contact));
        console.log('name:', wrapper.Name);
        //console.log(' contact test NAME - '+JSON.stringify(wrapper['Full Name']));
        this.amlfields.push({
        recordname: wrapper['AML record Name'],
        recordUrl: '/' + wrapper.Id, 
        recordcontacturl: '/' + wrapper.Contact,
        recordcontact: wrapper.Name,
        recordstatus: wrapper.Status,
        recordrole: wrapper.Role,
        
        recordFields: Object.entries(wrapper).filter(([fieldApiName]) => (
            fieldApiName !== 'Id' &&
            fieldApiName !== 'AML record Name' && 
            fieldApiName !== 'Contact' &&
            fieldApiName !== 'Full Name' &&
           // fieldApiName !== 'Status' &&
            fieldApiName !== 'Name'
        )).map(([fieldApiName, exists]) => {
            const field = {
                label: fieldApiName,
                apiName: fieldApiName,
                isEmpty: exists,
                colorclass: exists ? 'green-label' : 'red-label',
            };
            if (fieldApiName === 'Status') {
                field.hidden = true;
            }
            if (fieldApiName === 'Role') {
                field.hidden = true;
            }
            return field;
        })
        
        
        });
        }
        
        // If there is an error in fetching record data, log the error to the console
        } else if (result.error) {
            console.error(result.error);
        }
        } 
        
        get isButtonDisabled() {
            const fieldsEmpty = this.fields.some(field => !field.isEmpty);
          //  const amlFieldsEmpty = this.amlfields.length === 0 || this.amlfields.some(amlfield => amlfield.recordFields.some(field => !field.isEmpty));
            // The part for the button disable when the status is != KYC Pending
            const draftStatusLabel = this.StatusOfAML;
            const draftStatusLabel2 = this.StatusOfAML2nd;
            const draftStatusLabel3 = this.StatusOfAML3rd;
            const draftStatusLabel4 = this.StatusOfAML4th;
            const draftStatusLabel5 = this.StatusOfAML5th;
            let allDraft = false;
            if (this.InquiryType !== "Agency") {
            allDraft = this.amlfields.some(amlfield => {
            const statusField = amlfield.recordFields.find(field => field.apiName === 'Status');
            return statusField.isEmpty !== draftStatusLabel && statusField.isEmpty !== draftStatusLabel2 && statusField.isEmpty !== draftStatusLabel3 && statusField.isEmpty !== draftStatusLabel4 && statusField.isEmpty !== draftStatusLabel5;
           // return statusField.isEmpty !== draftStatusLabel;
          });}
        
            const listingFieldsEmpty = this.listingfields.length === 0 || this.listingfields.some(field => !field.isEmpty);
            const conveyanceListNotEmpty = this.conn > 0;
           /* let AccfieldsEmpty = false;
            if (this.InquiryType === "Agency") {
            AccfieldsEmpty = this.Accfields.some(field => !field.isEmpty);
            }*/
        
            let amlFieldsEmpty = false;
            if (this.InquiryType !== "Agency") {
                amlFieldsEmpty = this.amlfields.length === 0 || this.amlfields.some(amlfield => amlfield.recordFields.some(field => !field.isEmpty));
            }
        
            return fieldsEmpty || amlFieldsEmpty || listingFieldsEmpty || conveyanceListNotEmpty /*|| AccfieldsEmpty*/ || allDraft;
        }
        
        // The Aml Status Update 
          get AMLstatus() {
            if (this.InquiryType !== "Agency"){
            const draftStatusLabel = this.StatusOfAML;
            const draftStatusLabel2 = this.StatusOfAML2nd;
            const draftStatusLabel3 = this.StatusOfAML3rd;
            const draftStatusLabel4 = this.StatusOfAML4th;
            const draftStatusLabel5 = this.StatusOfAML5th;
            console.log('Check - 1 = '+JSON.stringify(this.amlfields)); // Debug statement
            const allDraft = this.amlfields.some(amlfield => {
              const statusField = amlfield.recordFields.find(field => field.apiName === 'Status');
              console.log('Check - 2 = '+ statusField.isEmpty); // Debug statement
              return statusField.isEmpty !== draftStatusLabel && statusField.isEmpty !== draftStatusLabel2 && statusField.isEmpty !== draftStatusLabel3 && statusField.isEmpty !== draftStatusLabel4 && statusField.isEmpty !== draftStatusLabel5;
            });
            return allDraft;
        }
          }
        
        // This is for the PB Admin 
        get isButto() {
            return this.profiletype === "PB Administrator";
        }
        
        // this is for the Conveuyance is alreday present
        get isInquiry() {
            return this.conn > 0;
        }
        
        // This is for if the Inquiry type agency then show the 3rd part Part
        get IncType() {
            return this.InquiryType != "Agency";
        }
        
        // When Field is Empty
        get isFieldsEmpty() {
            return this.isButtonDisabled && this.amlfields.length > 0 &&  !this.conn > 0;
        }
        
        // When there is no Aml
        get isAmlEmpty() {
            if (this.InquiryType !== "Agency"){
            return this.amlfields.length === 0;
            }
        }
        // When there is Field is not entere in AML
        get isButtonVisible() {
            return  !this.isButtonDisabled && this.amlfields.length > 0;
        }
        handleSubmit(event) {
             if (this.recordTypeinq === this.InquiryExclusiveProject1){
        if(this.contactNameEx === this.ContactRecordId1 ){
        event.preventDefault(); 
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'os_Conveyance__c',
                actionName: 'new',
                
            },
           state: {
            // useRecordTypeCheck: 1,
             recordTypeId: this.ConveyanceExclusiveProject1,
              
               // defaultFieldValues: `Inquiry__c=${this.recordId},,Developer_Name__c=${this.DeveloperNameTextEx},DeveloperName__c=${this.DeveloperNameLookupIdEx},Project_Name__c=${this.ProjectNameEx}`   
               defaultFieldValues: `os_Inquiry__c=${this.recordId},os_Listing1__c=${this.ListingPrefilled},os_Buyer_Represented_By__c	=${this.owner},os_Seller_Represented_By__c=${this.owner},os_Is_Direct_Buyer__c=${encodeURIComponent('YES')},os_First_Broker__c=${this.FirstBrokerEx},Contract_Value__c=${this.ListMaxPriceEx},os_Transaction_Type__c=${this.TransactionTypePicklist1}`
            }
        });
        // Your code for the new condition
    }else{
        event.preventDefault(); 
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'os_Conveyance__c',
                actionName: 'new',
                
            },
           state: {
            // useRecordTypeCheck: 1,
             recordTypeId: this.ConveyanceExclusiveProject1,           
               // defaultFieldValues: `Inquiry__c=${this.recordId},Developer_Name__c=${this.DeveloperNameTextEx},,DeveloperName__c=${this.DeveloperNameLookupIdEx},Project_Name__c=${this.ProjectNameEx}`  
               defaultFieldValues: `os_Inquiry__c=${this.recordId},v=${this.ListingPrefilled},os_Buyer_Represented_By__c=${this.owner},os_Seller_Represented_By__c=${this.owner},os_Is_Direct_Buyer__c=${encodeURIComponent('NO')},os_First_Broker__c=${this.FirstBrokerEx},Contract_Value__c=${this.ListMaxPriceEx},os_Transaction_Type__c=${this.TransactionTypePicklist1}`
            }
        });
    }
}
else if (this.InquiryTypecon === "Agency"){
    if (this.Transactiontype === "Offplan Primary" || this.Transactiontype === "Offplan Secondary" || this.Transactiontype === "Completed Property Transaction"){
    event.preventDefault(); 
    this[NavigationMixin.Navigate]({
        type: 'standard__objectPage',
        attributes: {
            objectApiName: 'os_Conveyance__c',
            actionName: 'new'
        },
       state: {
           // defaultFieldValues: `Inquiry__c=${this.recordId}`
           defaultFieldValues: `os_Buyer_Represented_By__c=${this.UID},os_Inquiry__c=${this.recordId},os_Transaction_Type__c=${this.Transactiontype},os_External_Brokerage_Name__c=${this.contactEBN},os_Listing1__c=${this.ListingPrefilled}`
        }
    });  
}else{
event.preventDefault(); 
this[NavigationMixin.Navigate]({
    type: 'standard__objectPage',
    attributes: {
        objectApiName: 'os_Conveyance__c',
        actionName: 'new'
    },
   state: {
       // defaultFieldValues: `Inquiry__c=${this.recordId}`
       defaultFieldValues: `os_Buyer_Represented_By__c=${this.UID},os_Inquiry__c=${this.recordId},os_External_Brokerage_Name__c=${this.contactEBN},os_Listing1__c=${this.ListingPrefilled}`
    }
});
}
}else{
    if (this.Transactiontype === "Offplan Primary" || this.Transactiontype === "Offplan Secondary" || this.Transactiontype === "Completed Property Transaction"){
        event.preventDefault(); 
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'os_Conveyance__c',
                actionName: 'new'
            },
           state: {
               // defaultFieldValues: `Inquiry__c=${this.recordId}`
               defaultFieldValues: `os_Buyer_Represented_By__c=${this.UID},os_Inquiry__c=${this.recordId},os_Transaction_Type__c=${this.Transactiontype},os_Listing1__c=${this.ListingPrefilled}`
            }
        });  
    }else{
    event.preventDefault(); 
    this[NavigationMixin.Navigate]({
        type: 'standard__objectPage',
        attributes: {
            objectApiName: 'os_Conveyance__c',
            actionName: 'new'
        },
       state: {
           // defaultFieldValues: `Inquiry__c=${this.recordId}`
           defaultFieldValues: `os_Buyer_Represented_By__c=${this.UID},os_Inquiry__c=${this.recordId},os_Listing1__c=${this.ListingPrefilled}`
        }
    });
    }

}
}
@track  showNextSection = false;
handleNext() {
    this.showNextSection = true;
    this.hideNextButton = true;
    this.hideNextButtonAll = true;
}
@track hide = true;

handleCheckboxChange() {
    this.hide = !this.hide;
}
@track isShowModal = false;  
showModalBox() {  
    this.isShowModal = true;
}

// Function to hide the modal box
hideModalBox() {  
    this.isShowModal = false;
    //  location.reload();
}

handlecancel() {
    this.isShowModal = false;
}

handlecancelstep2() {
    this.isShowModal = false;
      location.reload();
}
}
