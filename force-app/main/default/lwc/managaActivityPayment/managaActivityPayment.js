import { LightningElement,wire,api,track } from 'lwc';
import getProperty from '@salesforce/apex/managePropertyCls.getProperty';
import DynamicDisplay from '@salesforce/apex/managePropertyCls.dynamicalResult';
import PROPERTY_OBJECT from '@salesforce/schema/CD_Property__c';
import PROJECT_OBJ from '@salesforce/schema/CD_Project__c';
//import STATUS_FIELD from '@salesforce/schema/pba__Request__c.pba__Status__c';
import getSearchResult from '@salesforce/apex/managePropertyCls.searchResults';
import { getPicklistValues,getObjectInfo } from 'lightning/uiObjectInfoApi';
import TYPE_FIELD  from '@salesforce/schema/CD_Property__c.Type__c';
import NO_OF_BEDS from '@salesforce/schema/CD_Property__c.CD_No_of_Beds__c';
import CITY_FIELD  from '@salesforce/schema/CD_Property__c.City_Dubizzle__c';
import ADDRESS_LINE from '@salesforce/schema/CD_Property__c.CD_Address_line_1__c';
import ADDRESS_2 from '@salesforce/schema/CD_Property__c.CD_Address2__c';
import AREA from '@salesforce/schema/CD_Property__c.CD_Area__c';
import ASKING_PRICE from '@salesforce/schema/CD_Property__c.CD_Asking_Price_AED__c';
import BALCONY_AREA from '@salesforce/schema/CD_Property__c.CD_Balcony_Area__c';
import BATHROOM_US from '@salesforce/schema/CD_Property__c.CD_Bathrooms_US__c';
import BATHROOM_FULL from '@salesforce/schema/CD_Property__c.CD_FullBathrooms__c';
import BEDROOM_TYPE from '@salesforce/schema/CD_Property__c.CD_Bedroom_Type__c';
import BATHROOM from '@salesforce/schema/CD_Property__c.CD_Bedrooms__c';
import BOOK_DATE from '@salesforce/schema/CD_Property__c.CD_Book_Date__c';
import BROKER_LISTING_ID from '@salesforce/schema/CD_Property__c.CD_uaefields_Broker_s_Listing_ID__c';
import BUILD_YEAR from '@salesforce/schema/CD_Property__c.CD_Year_Build_text__c';
import BUILDING_DUBIZZLE from '@salesforce/schema/CD_Property__c.CD_uaefields_Building_Dubizzle__c';
import CITY from '@salesforce/schema/CD_Property__c.CD_City__c';
import CITY_PROPERTYFINDER from '@salesforce/schema/CD_Property__c.CD_uaefields_City_Propertyfinder__c';
import COMMERCIAL_AMENITIES from '@salesforce/schema/CD_Property__c.CD_uaefields_Commercial_Amenities__c';
import COMMUNITY_PROPERTYFINDER from '@salesforce/schema/CD_Property__c.CD_uaefields_Community_Propertyfinder__c';
import COMPLETION_DATE from '@salesforce/schema/CD_Property__c.CD_Completion_Date__c';
import COMPLETION_DATE2 from '@salesforce/schema/CD_Property__c.CD_Completion_Date_pba__c';
import COMPLETION_STATUS from '@salesforce/schema/CD_Property__c.CD_Completion_Status__c';
import COMPLETION_STATUS2 from '@salesforce/schema/CD_Property__c.CD_Completion_Status_pb__c';
import COMPLETION_STATUS3 from '@salesforce/schema/CD_Property__c.CD_uaefields_Completion_Status__c';
import COUNTRY from '@salesforce/schema/CD_Property__c.CD_Country__c';
import COUNTRY_CODE from '@salesforce/schema/CD_Property__c.CD_Country_Code__c';
import CURRENCY_CODE from '@salesforce/schema/CD_Property__c.CurrencyIsoCode';
import DESCRIPTION from '@salesforce/schema/CD_Property__c.CD_Description_pb__c';
import DESCRIPTION_ARABIC from '@salesforce/schema/CD_Property__c.CD_uaefields_Description_Arabic_pb__c';
import DEVELOPER from '@salesforce/schema/CD_Property__c.CD_uaefields_Developer__c';
import DEVELOPER_NAME from '@salesforce/schema/CD_Property__c.CD_uaefield_Developer_Name__c';
import EXTERNAL_PROPERTY from '@salesforce/schema/CD_Property__c.CD_External_Property_ID__c';
import FLOOR from '@salesforce/schema/CD_Property__c.CD_Floor__c';
import FLOOR1 from '@salesforce/schema/CD_Property__c.CD_uaefields_Floor__c';
import FLOORS from '@salesforce/schema/CD_Property__c.CD_Floors__c';
import FURNISHED from '@salesforce/schema/CD_Property__c.CD_uaefields_Furnished__c';
import GEOCODE_ACCURACY from '@salesforce/schema/CD_Property__c.CD_Geocode_Accuracy_pb__c';
import HALF_BATHROOM from '@salesforce/schema/CD_Property__c.CD_Half_Bathrooms_pb__c';
import IMAGE from '@salesforce/schema/CD_Property__c.CD_Image__c';
import INTERNAL_ID from '@salesforce/schema/CD_Property__c.CD_Internal_Area__c';
import LATITUDE from '@salesforce/schema/CD_Property__c.CD_Latitude_pb__c';
import LAYOUT_TYPE from '@salesforce/schema/CD_Property__c.CD_Layout_Type__c';
import LOCATIONTEXT_DUBIZZLE from '@salesforce/schema/CD_Property__c.CD_uaefields_Locationtext_Dubizzle__c';
import LONGITUDE from '@salesforce/schema/CD_Property__c.CD_Longitude_pb__c';
import LOT_SIZE from '@salesforce/schema/CD_Property__c.CD_Lot_Size_pb__c';
import MAIN_WEBSITE from '@salesforce/schema/CD_Property__c.CD_Main_Website_Image__c';
import MASTER_PROPERTY from '@salesforce/schema/CD_Property__c.CD_Master_Property__c';
import MEASUREMENT from '@salesforce/schema/CD_Property__c.CD_Measurement_pb__c';
import MIGRATION_STATE from '@salesforce/schema/CD_Property__c.CD_gsir_Migration_State__c';
import NUMBER_OF_CHEQUES from '@salesforce/schema/CD_Property__c.CD_uaefields_Number_of_Cheques__c';
import PARENT_PROJECT from '@salesforce/schema/CD_Property__c.CD_Parent_Project__c';
import PARKING_SPACES from '@salesforce/schema/CD_Property__c.CD_Parking_spaces__c';
import PARKING_SPACES2 from '@salesforce/schema/CD_Property__c.CD_No_Parking_Spaces_pb__c';
import PARKING_SPACES3 from '@salesforce/schema/CD_Property__c.CD_uaefields_Parking_spaces__c';
import PRICE_ON_REQUEST from '@salesforce/schema/CD_Property__c.CD_uaefield_Price_on_Request__c';
import PRICE_SQUARE_FT from '@salesforce/schema/CD_Property__c.CD_Price_Sq_ft_AED__c';
import PRIVATE_AMENTIES from '@salesforce/schema/CD_Property__c.CD_uaefields_Private_Amenties__c';
import PROJECT from '@salesforce/schema/CD_Property__c.CD_Project__c';
import PROPERTY_NAME from '@salesforce/schema/CD_Property__c.Name';
import PROPERTY_SUBTYPE from '@salesforce/schema/CD_Property__c.CD_uaefield_Property_Sub_Type__c';
import PROPERTYFINDER_REGION from '@salesforce/schema/CD_Property__c.CD_uaefield_Propertyfinder_Region__c';
import PROPERTY_OWNER from '@salesforce/schema/CD_Property__c.CD_Property_owner_Contact__c';
import PROPERTY_OWNER2 from '@salesforce/schema/CD_Property__c.CD_ContactPropertyOwner_pb__c';
import SALES_PRICE from '@salesforce/schema/CD_Property__c.CD_Sales_Price__c';
import SERVICE_CHARGE from '@salesforce/schema/CD_Property__c.CD_uaefield_Service_Charge__c';
import SIZE from '@salesforce/schema/CD_Property__c.CD_Size_pb__c';
import STATE from '@salesforce/schema/CD_Property__c.CD_State_pb__c';
import STATE_CODE from '@salesforce/schema/CD_Property__c.CD_State_pb__c';
import STATUS from '@salesforce/schema/CD_Property__c.Status__c';
import STORIES from '@salesforce/schema/CD_Property__c.CD_Stories__c';
import STREET from '@salesforce/schema/CD_Property__c.CD_Street_pb__c';
import SUB_COMMUNITY_PROPERTYFINDER from '@salesforce/schema/CD_Property__c.CD_uaefield_Sub_Community_Propertyfinder__c';
import SYSTEM_EXTERNAL_ID from '@salesforce/schema/CD_Property__c.CD_System_External_Id__c';
import SYSTEM_WEBSITE_EXTERNAL_ID from '@salesforce/schema/CD_Property__c.CD_System_Website_External_Id__c';
import TITLE from '@salesforce/schema/CD_Property__c.CD_Title__c';
import TITLE_ARABIC from '@salesforce/schema/CD_Property__c.CD_Title_Arabic__c';
import TOTAL_AREA from '@salesforce/schema/CD_Property__c.CD_Total_Area__c';
import TOWER from '@salesforce/schema/CD_Property__c.CD_Tower__c';
import UNIT_EXTERNAL_ID from '@salesforce/schema/CD_Property__c.CD_gsir_master_Unit_External_Id__c';
import UNIT_NUMBER from '@salesforce/schema/CD_Property__c.CD_Unit_Number__c';
import UNITS from '@salesforce/schema/CD_Property__c.CD_Units__c';
import USER_FULLNAME from '@salesforce/schema/CD_Property__c.CD_gsir_User_Full_Name__c';
import VIEW from '@salesforce/schema/CD_Property__c.CD_View_pb__c';
import VIEW1 from '@salesforce/schema/CD_Property__c.CD_uaefields_View__c';
import VIEW2 from '@salesforce/schema/CD_Property__c.CD_View__c';
import YEAR_BUILD from '@salesforce/schema/CD_Property__c.CD_Year_Built__c';
import YEAR_BUILD2 from '@salesforce/schema/CD_Property__c.CD_Year_Built_Text__c';
import ZIP_CODE from '@salesforce/schema/CD_Property__c.CD_Zip_pb__c';
import IS_BLOCK from '@salesforce/schema/CD_Property__c.CD_isblocked__c';
import BLOCK_STATUS from '@salesforce/schema/CD_Property__c.CD_Block_Status__c';
import getUserInfo from '@salesforce/apex/PropertyCreationController.getUserInfo';
import { NavigationMixin } from 'lightning/navigation';
import selectedProject from '@salesforce/apex/managePropertyCls.selectedProject';

import getProject from '@salesforce/apex/managePropertyCls.getProject';
import getProjectSelected from '@salesforce/apex/managePropertyCls.getProjectSelected';
import PROJECT_OBJECT from '@salesforce/schema/CD_Project__c';
import PROJECT_NAME from '@salesforce/schema/CD_Project__c.Name';
import PROPERTY_ADDED_BY from '@salesforce/schema/CD_Project__c.OwnerId';
// import PROPERTY_Created_BY from '@salesforce/schema/CD_Project__c.CreatedBy.Name';
// import PROPERTY_Created_Date from '@salesforce/schema/CD_Project__c.CreatedDate';
import CURRENCY_COD from '@salesforce/schema/CD_Project__c.CurrencyIsoCode';
import AGENT_NAME from '@salesforce/schema/CD_Property__c.CD_Agent_Name__c';
import {loadStyle} from 'lightning/platformResourceLoader';
import COLORS from '@salesforce/resourceUrl/Colors';
import ACTIVITY_OBJECT from '@salesforce/schema/CD_Activity__c'
import ACTIVITY_FIELD from '@salesforce/schema/CD_Activity__c.CD_Activity__c';
import RECEIPT_ISSUED from '@salesforce/schema/CD_Activity__c.CD_Receipt_Issued__c';
import INVOICE_ISSUED from '@salesforce/schema/CD_Activity__c.CD_Invoice_Issued__c';
import INSTALLMENT_TYPE from '@salesforce/schema/CD_Activity__c.CD_Installment_Type__c';
import InsertActivities from '@salesforce/apex/activityCreationCntrlr.createActivities';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import GetActivities from '@salesforce/apex/activityCreationCntrlr.getActivities';
import { refreshApex } from '@salesforce/apex';
import SELLING_PRICE from '@salesforce/schema/CD_Property__c.CD_Sales_Price__c';
import VAT from '@salesforce/schema/CD_Property__c.CD_VAT_5__c';
import CONVENYACING_FEE from '@salesforce/schema/CD_Property__c.CD_Convenyacing_fees__c';
import ADDITIONAL_FEE from '@salesforce/schema/CD_Property__c.CD_Additional_fees__c';
import OTHER_FEE from '@salesforce/schema/CD_Property__c.CD_Other_fees__c';
import NET_SELLING_PRICE from '@salesforce/schema/CD_Property__c.CD_Net_selling_price__c'; 
import DISCOUNT from '@salesforce/schema/CD_Property__c.CD_Discount__c';
import FINAL_NET from '@salesforce/schema/CD_Property__c.CD_Final_net_price__c';
import FORM_FACTOR from '@salesforce/client/formFactor';
//import AMOUNT from '@salesforce/schema/CD_Property__c.CD_Amount__c';





const columnsAct = [
    { label: 'Activity', fieldName: 'CD_Activity__c', type:'button', typeAttributes:{label: {fieldName:'CD_Activity__c'}, variant:'base'} 
    },
    { label: 'Payment', fieldName: 'CD_Payment__c', type: 'button', typeAttributes:{label: {fieldName:'CD_Payment__c'},variant:'base'} 
    
    },
    { label: 'Amount', fieldName: 'CD_Activity_Amount__c', type: 'button', typeAttributes:{label: {fieldName:'CD_Activity_Amount__c'},variant:'base'} 
},
    { label: 'Date Added', fieldName: 'CD_Date__c', type: 'button', typeAttributes:{label: {fieldName:'CD_Date__c'},variant:'base'} 
    },
    { label: 'Installment Type', fieldName: 'CD_Installment_Type__c', type: 'button', typeAttributes:{label: {fieldName:'CD_Installment_Type__c'},variant:'base'} 
},
    { label: 'Invoice Issued', fieldName: 'CD_Invoice_Issued__c', type: 'button', typeAttributes:{label: {fieldName:'CD_Invoice_Issued__c'},variant:'base'} 
},
    { label: 'Receipt Issued', fieldName: 'CD_Receipt_Issued__c', type: 'button', typeAttributes:{label: {fieldName:'CD_Receipt_Issued__c'},variant:'base'} 
},

    
];

export default class ManagePropertyInventory extends NavigationMixin(LightningElement) {
  

  @api getdatafromparent;

    @api getidfromparent;
    
        paymentFields=[SELLING_PRICE,VAT, CONVENYACING_FEE,ADDITIONAL_FEE,OTHER_FEE,NET_SELLING_PRICE,DISCOUNT,FINAL_NET ];
        @api objectApiName=PROPERTY_OBJECT;


        @track PropoRecList=[
            {
                CD_Activity__c: '',           
                CD_Payment__c : '',
                CD_Activity_Amount__c:'',
                CD_Date__c: '',
                CD_Installment_Type__c: '',
                CD_Invoice_Issued__c: '',
                CD_Receipt_Issued__c: ''
    
            }
        ];
        selectedActivityValue;
        selectedPaymentValue;
        selectedDateValue;
        selectedInstallmentValue;
        selectedInvoiceValue;
        selectedReceiptValue;
    
        
    
      @track  keyIndex = 1;
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
 
    }

    
        @wire(getObjectInfo, { objectApiName: ACTIVITY_OBJECT })
         objectInfo2;
    
         @wire (getPicklistValues,{
            recordTypeId:"$objectInfo2.data.defaultRecordTypeId",
            fieldApiName:ACTIVITY_FIELD
        }) activityValues;
    
        @wire (getPicklistValues,{
            recordTypeId:"$objectInfo2.data.defaultRecordTypeId",
            fieldApiName:RECEIPT_ISSUED
    
        }) receiptValues;
    
        @wire (getPicklistValues,{
            recordTypeId:"$objectInfo2.data.defaultRecordTypeId",
            fieldApiName:INVOICE_ISSUED
        }) invoiceValues;
    
        @wire (getPicklistValues,{
            recordTypeId:"$objectInfo2.data.defaultRecordTypeId",
            fieldApiName:INSTALLMENT_TYPE
        }) installmentValues;
     
        addRow()
        {
            this.keyIndex+1;
            this.PropoRecList.push({
                CD_Activity__c: '',            
                CD_Payment__c : '',
                CD_Activity_Amount__c:'',
                CD_Date__c: '',
                CD_Installment_Type__c: '',
                CD_Invoice_Issued__c: '',
                CD_Receipt_Issued__c: ''
            })
        }
    
        removeRow(event)
        {
            console.log('AccessKey Check:'+event.target.accessKey);
            console.log('split check:'+event.target.id.split('-')[0]);
            if(this.PropoRecList.length > 1)
            {
                this.PropoRecList.splice(event.target.accessKey,1);
                this.keyIndex-1;
            }
        }
        storePayment;
        storeAmount;
        handleDataChange(event)
        {
            
            if(event.target.name==='Activity')
            {
                this.PropoRecList[event.target.accessKey].CD_Activity__c = event.target.value;
            }
            
            if(event.target.name==='Payment')
            {
                this.PropoRecList[event.target.accessKey].CD_Payment__c = event.target.value;
                console.log('payment',this.PropoRecList[event.target.accessKey].CD_Payment__c)
              //  this.storePayment=this.PropoRecList[event.target.accessKey].CD_Payment__c;
    
                console.log('pay with accesskey', this.PropoRecList[event.target.accessKey].CD_Payment__c);
                this.finalPaymentPrice = this.getdatafromparent.CD_Final_net_price__c;
           console.log('final', this.finalPaymentPrice);
         if( this.PropoRecList[event.target.accessKey].CD_Payment__c ==='')
         {
            this.storeAmount ='';
         }
         else
         {
            this.PropoRecList[event.target.accessKey].CD_Activity_Amount__c= parseInt(this.finalPaymentPrice)*parseInt(this.PropoRecList[event.target.accessKey].CD_Payment__c)/100;
            console.log('Amount>>>>>>>', this.PropoRecList[event.target.accessKey].CD_Activity_Amount__c);   
            this.storeAmount=this.PropoRecList[event.target.accessKey].CD_Activity_Amount__c;
         }
        
            }
      
            if(event.target.name==='Date')
            {
                this.PropoRecList[event.target.accessKey].CD_Date__c = event.target.value;
            }
      
            if(event.target.name==='Installment')
            {
                this.PropoRecList[event.target.accessKey].CD_Installment_Type__c = event.target.value;
            }
      
            if(event.target.name==='Invoice')
            {
                this.PropoRecList[event.target.accessKey].CD_Invoice_Issued__c = event.target.value;
            }
      
            if(event.target.name==='Receipt')
            {
                this.PropoRecList[event.target.accessKey].CD_Receipt_Issued__c = event.target.value;
            }
                this.secHandle()
      
        }
    
        // calculateAmount(){
        //    // alert("check calc");
        // //    this.PropoRecList.CD_Activity_Amount__c= 0;
        //    console.log('pay',this.storePayment);
        //    console.log('final', parseInt(this.finalPaymentPrice));
        //    console.log('final', this.finalPaymentPrice);
        //    if(this.storePayment !== '')
        //    {
        //     this.PropoRecList.CD_Activity_Amount__c= parseInt(this.finalPaymentPrice)*parseInt(this.storePayment)/100;
        //      }
    
        //      else
        //      {
        //         this.PropoRecList.CD_Activity_Amount__c= '';
        //      }
            
            
        //     console.log('Amount', this.PropoRecList.CD_Activity_Amount__c)
        // }
    
        showSaveAdd = false;
        secHandle()
        {
            this.showSaveAdd = true;
        }
    
        activitiesData=[];
        isActivityData = false;
        showLoadingSpinner=false;

     @api callActivitiesList(id)
        {
            console.log("getting parent data"+JSON.stringify(this.getdatafromparent));
            console.log("getting parent id",this.getidfromparent);
            console.log("show rec id",id);
            console.log("inside callactivity payment tab");
            console.log("whether called or not?");
          //  this.paymentPageFun(this.storeRecId)
          GetActivities({propId: id})
          .then((result) => {
              console.log("returned tab clickcreated act results",result);
             
                  this.activitiesData = result ;
                  this.isActivityData = true;
                  this.showLoadingSpinner=false;
              
                 
                 //  eval("$A.get('e.force:refreshView').fire();")      
  
      })
  
          .catch((error) => {
              console.log("why  tab click error?",error);
          })
            
    
            
        } 
    
        saveFile()
        {
            const isInputsCorrect =[
                ...this.template.querySelectorAll("lightning-input")
            ].reduce((validSoFar ,inputField) =>{
                inputField.reportValidity();
                return validSoFar && inputField.checkValidity();
            },true);
        
            const isInputsCorrect2 =[
                ...this.template.querySelectorAll("lightning-combobox")
            ].reduce((validSoFar ,inputField) =>{
                inputField.reportValidity();
                return validSoFar && inputField.checkValidity();
            },true);
            
            if(isInputsCorrect && isInputsCorrect2)
            {
                console.log("get propPrec List",JSON.stringify(this.PropoRecList));
            InsertActivities({getList : this.PropoRecList , propId: this.getdatafromparent.Id})
            .then((result) => {
                console.log("returned created act results",result);
    
                this.dispatchEvent(new ShowToastEvent({
                    title:'Success!',
                    message: 'Payment details stored successfully',
                    variant:'success'
                    }),);    
                  this.closeChild();
            })
            .catch((error) => {
                console.log("why is error?",error);
                this.dispatchEvent(new ShowToastEvent({
                    title:'Failed creating records!',
                    message: 'Something  went wrong',
                    variant:'error'
                    }),); 
            })
            }
    
        }
        showPaymentPage =true;
        closeChild(){

   

            this.showPaymentPage= false;
            
        
            const selectedevent= new CustomEvent("managepayment", {
             
                detail: this.showPaymentPage
            
            });
            this.dispatchEvent(selectedevent);   
        }
}