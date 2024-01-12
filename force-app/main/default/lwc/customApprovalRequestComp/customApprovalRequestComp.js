import { LightningElement, track, api, wire } from 'lwc';
import getList from '@salesforce/apex/customApprovalPageCntrlr.getSubmittedRecords';
import PROPERTY_OBJECT from '@salesforce/schema/CD_Property__c';
import TYPE_FIELD  from '@salesforce/schema/CD_Property__c.Type__c';
import CITY_FIELD  from '@salesforce/schema/CD_Property__c.City_Dubizzle__c';
import DynamicDisplay from '@salesforce/apex/managePropertyCls.dynamicalResult';
import getSearchResult from '@salesforce/apex/managePropertyCls.searchResults';
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
import AGENT_NAME from '@salesforce/schema/CD_Property__c.CD_Sales_Agent_Name__c';
import PURCHASE_DATE from '@salesforce/schema/CD_Property__c.CD_Purchase_date__c';
import PAYMENT_MODE from '@salesforce/schema/CD_Property__c.CD_Mode_of_Payment__c';
import PAYMENT_PERCENTAGE from '@salesforce/schema/CD_Property__c.CD_Reservation_Fees_be_Paid__c';
import BLOCK_DATE from '@salesforce/schema/CD_Property__c.CD_Block_Date__c';
import FULL_SET_OF_DOCUMENT from '@salesforce/schema/CD_Property__c.CD_Buyer_Documents_Received__c';
import SPLIT_DEAL from '@salesforce/schema/CD_Property__c.CD_Split_Deal__c';
import DATE_RA_WILL_BE_SINGED from '@salesforce/schema/CD_Property__c.CD_Date_the_RA_will_be_signed__c';
import BLOCK_COMMENTS from '@salesforce/schema/CD_Property__c.CD_Block_Comments__c';
import DATE_THE_RESERVATION_FEE from '@salesforce/schema/CD_Property__c.CDDate_the_reservation_fees_will_be_paid__c';
import AGENT_REPRESENTATING_CLIENT from '@salesforce/schema/CD_Property__c.CD_Agent_Representing_Client__c';
import BROKAGE_REPRESENTATING_CLIENT from '@salesforce/schema/CD_Property__c.CD_Brokerage_Representing_Client__c';
import CLIENT_NAME from '@salesforce/schema/CD_Property__c.CD_Client_Name1__c';
import SECOND_AGENT_NAME from '@salesforce/schema/CD_Property__c.CD_Second_Agent__c';
import ProcessRecords from '@salesforce/apex/customApprovalPageCntrlr.processApproval';
import { refreshApex } from '@salesforce/apex';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import fetchUpdateApproval from '@salesforce/apex/customApprovalPageCntrlr.createApprovalRequestRec';
import FORM_FACTOR from '@salesforce/client/formFactor';
import updateAprvalRqst from '@salesforce/apex/customApprovalPageCntrlr.updateApprovalReq';
//import Id from '@salesforce/user/Id';


export default class CustomApprovalRequestComp extends LightningElement {
   // userId = Id;
    @track columns =[
      { label: 'Name', fieldName: 'CD_Property_Name__c', type:'button', typeAttributes:{label: {fieldName:'CD_Property_Name__c'}, variant:'base'}

    },

    { label: 'Agent Name', fieldName: 'CD_AgentName_txt__c', type: 'button', typeAttributes:{label: {fieldName:'CD_AgentName_txt__c'},variant:'base'}

    },

    { label: 'Red List Date', fieldName: 'CreatedDate', type: 'button', typeAttributes:{label: {fieldName:'CreatedDate'},variant:'base'}

    }
    

   /* { label: 'Unit No', fieldName: 'CD_Unit_Number__c', type:'button', typeAttributes:{label: {fieldName:'CD_Unit_Number__c'}, variant:'base'}

}, */
   
    ]
    @track mobileColumns=[
        { label: 'Name', fieldName: 'CD_Property_Name__c', type:'button', typeAttributes:{label: {fieldName:'CD_Property_Name__c'}, variant:'base'}

    },
    ]


    fields=[PROPERTY_NAME,TYPE_FIELD,CITY_FIELD,PROJECT,TOWER,PARENT_PROJECT,UNITS,AREA,ASKING_PRICE,BOOK_DATE,BROKER_LISTING_ID,
        BUILD_YEAR,BUILDING_DUBIZZLE,CITY,CITY_PROPERTYFINDER,COMMERCIAL_AMENITIES,COMMUNITY_PROPERTYFINDER,COMPLETION_DATE,
        COMPLETION_DATE2,COMPLETION_STATUS, COMPLETION_STATUS2, COMPLETION_STATUS3,COUNTRY,COUNTRY_CODE,CURRENCY_CODE,DEVELOPER_NAME,SALES_PRICE,LOT_SIZE];
       
       
        fields2=[AGENT_NAME,UNIT_NUMBER,SPLIT_DEAL,SECOND_AGENT_NAME,CLIENT_NAME,FULL_SET_OF_DOCUMENT,DATE_RA_WILL_BE_SINGED,DATE_THE_RESERVATION_FEE,PAYMENT_MODE,PAYMENT_PERCENTAGE,BROKAGE_REPRESENTATING_CLIENT,
             AGENT_REPRESENTATING_CLIENT,BLOCK_COMMENTS];    
        
        
          
       
       
        @api objectApiName=PROPERTY_OBJECT;
    wrapperList=[];
    wrapperlistCondtion = false;
    showLayout= false;
    rowRecord={};
    storeRecId;
    
    isDialogVisible =false;
    originalMessage;
    showLoadingSpinner=false;
    wrapperRecList=[];

    activeSectionMessage = '';
   


   

    deviceType;

    ismobileRendered = false;

    displayFullData=false;

    desktopView=false;

   

    handleToggleSection(event) {
        this.activeSectionMessage =
            'Open section name:  ' + event.detail.openSections;
    }

    handleSetActiveSectionC() {
        const accordion = this.template.querySelector('.example-accordion');

        accordion.activeSectionName = 'C';
    }


    @wire((getList),{})

    wiredRecords({data,error})
    {
        this.wrapperRecList= data;
        if(data)
        {
           // this.showLoadingSpinner = false;
            if(data.length > 0) ``
            {
                 console.log("display data",data);
                 console.log("is it desktop view",this.deviceType);
           
            if(this.wrapperRecList.length > 0)
            {
                this.wrapperlistCondtion = true;
                this.wrapperList = this.wrapperRecList;
                this.storeRecId = this.wrapperList[0].Property__c;
            }
            }
           
        }
    
        if(error)
        {
            console.log("display error",error);
        }
    }

    handleRowAction(event){

        this.rowRecord = event.detail.row;
        
        console.log(JSON.parse(JSON.stringify(this.rowRecord)));
        console.log("show row data",this.rowRecord);
       
        let eventId =this.rowRecord.Id;
        console.log("show row id",eventId);
        
        for(let i=0;i<this.wrapperList.length;i++)
        {
            if(this.wrapperList[i].Id === eventId)
            {
              
                this.storeRecId = this.wrapperList[i].Property__c;
                console.log(this.wrapperList.length);
    
             
                console.log("inside loop",this.storeRecId);
            }
        }
            console.log("outside loop",this.storeRecId);
            this.showLayout = true;
    
    }
    isReject=false;
   /* handleDeferClick(event)
    {
        console.log("get defer details",event.detail);
        console.log("get approver comm",event.detail.passedCommentVal);
        console.log("get expDate",event.detail.expiryDateTopass);
        this.approverComments = event.detail.passedCommentVal;
        this.expiryDate = event.detail.expiryDateTopass;
        this.holdApproval()

    } */
    finalApprovalComment;
    getAprorRejDate;
    isApproveClicked = false;
    handleconformClick(event) {
        try {
        if (event.target.label === 'Approve') {
            console.log('label' + event.target.label);
          //  this.expiryDate = null;
          //  console.log("what is in date is it null?",this.expiryDate);
            this.originalMessage = event.target.label;
            this.isApproveClicked =true;
            this.isDialogVisible = true;
          this.isReject= false;
          this.template.querySelector("c-confirmation-dialog").callDataBaseMethod();
          //  this.expiryDate = '';
        }
        else if (event.target.title === 'Reject') {
            console.log('labelTitle' + event.target.title);
            this.originalMessage = event.target.title;
            this.isDialogVisible = true;
           this.isReject=false;
           this.isApproveClicked= false;

        }

        else if(event.target.label === 'Defer')
        {
            this.isDialogVisible = true;
            this.isReject=true;
        }
        else if (event.target.name === 'confirmModal') {
            console.log(event.detail);
           
            //when user clicks outside of the dialog area, the event is dispatched with detail value  as 1
            if (event.detail !== 1) {
                console.log('status' + event.detail.status); 
                if (event.detail.status === 'confirm') {

                    console.log("if processrec condition");
                    console.log("apr/rej date",event.detail.aprOrrejDate);
                    console.log("get final Aprvl cmnt",event.detail.finalAprvlComments);
                    console.log("get expiry date cmnt",event.detail.expiryDateTopass);
                  //  console.log("get final Aprvl cmnt",event.detail.finalAprvlComments);
                    this.finalApprovalComment = event.detail.finalAprvlComments;
                    this.stroreApproverComments = event.detail.passedCommentVal;
                    this.getAprorRejDate = event.detail.aprOrrejDate;
                    this.expiryDate = event.detail.expiryDateTopass;

                    if(this.expiryDate == null || this.expiryDate === '' || this.expiryDate <= this.getTodaydate)
                    {
                        this.processrec();
                        this.isDialogVisible = false;
                    }

                  /*  else if(this.expiryDate != null || this.expiryDate !== '' || this.expiryDate > this.getTodaydate)
                    {
                        this.holdApproval();
                    } */
                    else if(this.expiryDate > this.getTodaydate)
                    {
                        this.holdApproval();
                    } 
          
          
                 
                   
                } 
              else  if (event.detail.status === 'Add Defer') {

                    console.log("if add defer condition");
                        // this.processrec();
                        console.log("get defer details",event.detail);
             console.log("get approver comm",event.detail.passedCommentVal);
             console.log("get expDate",event.detail.expiryDateTopass);
             this.approverComments = event.detail.passedCommentVal;
             this.expiryDate = event.detail.expiryDateTopass;

                        this.holdApproval()
                         this.isDialogVisible = false;
              }
                
                else if (event.detail.status === 'cancel') {
                    //do something else
                    this.isDialogVisible = false;
                }
            }
            
        }
        }
        catch(e) {
            console.log(e);
        }
    }
    getTodaydate;
    connectedCallback(){

        let d = new Date();
        console.log("full date ",d);
    let altDate = d.toISOString().substring(0,10);
    console.log("altDate ",altDate);
        let newD = new Date(d.getTime() + d.getTimezoneOffset()*60000);
        console.log("date wit time  ",newD);
        this.getTodaydate=altDate;
  //  this.getTodaydate= newD.toISOString().substring(0,10);
    
    console.log('what is today date',this.getTodaydate) 

    console.log(FORM_FACTOR);

    if(FORM_FACTOR === "Large")

    {

           this.deviceType ="Desktop/Laptop";

         this.desktopView = true;

         //  console.log("is it desktop view",this.deviceType);



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
       // this.dateCal()
    }
  /*  dateCal()
    {
        console.log("inside date cal method");
        let d = new Date();
        console.log("full date ",d);
    
        let newD = new Date(d.getTime() + d.getTimezoneOffset()*60000);
        console.log("date wit time  ",newD);
    
    this.getTodaydate= newD.toISOString().substring(0,10);
    
    console.log('what is today date',this.getTodaydate);
    } */

    approverComments;
    /* getCommentsEvent(event)
    {
        console.log("get approver comment",event.detail.passedCommentVal);
        this.approverComments = event.detail.passedCommentVal;
    } */
    expiryDate;
   /* getExpiryDate(event)
    {
        console.log("get passed expiry date",event.detail.expiryDateTopass);
        this.expiryDate = event.detail.expiryDateTopass;

    } */

    dateToPass;
    holdApproval()
    {

        console.log("inside holdapproval displye date",this.expiryDate);
        console.log("inside holdapproval approver cooments",this.approverComments);
        console.log("get propertyid to create rec",this.storeRecId);
        fetchUpdateApproval({propId: this.storeRecId, approverComments: this.finalApprovalComment, expiryDate:this.expiryDate})
        .then((result) => {
            console.log("returned resultfinal check",result);
            this.isDialogVisible = false;
          //  this.dateToPass = result.CD_Expiry_Date__c;
          this.dispatchEvent(
            new ShowToastEvent({
                title: 'Partial Approval',
                message: 'Partially Approved Successfully',
                variant: 'success'
            })
        );
            window.location.reload()
            
        })
        .catch((error) => {
            console.log("display error of returned",error);
        })
       
    

    }
    storeAprveComments;
    streStatus;
    storerjctComnts;
    processrec()
    {
        this.showLoadingSpinner = true;
        var varProcessType;
        console.log("get record id into proccess rec",this.storeRecId);
        console.log("get original message into proocess rec",this.originalMessage);
       // console.log("display approver cooments",this.approverComments);
        varProcessType=this.originalMessage;
        console.log("processType vall check",varProcessType);
        ProcessRecords({recId: this.storeRecId ,processType: varProcessType ,approverComments: this.finalApprovalComment})
        .then((result) => {

          //  eval("$A.get('e.force:refreshView').fire();");
          console.log("display returned result",result) ;
          this.showLoadingSpinner = false;
          console.log("before refresh",this.wrapperRecList);
          refreshApex(this.wrapperRecList)
          console.log("after refresh",this.wrapperRecList);
            var messagetitle;
            var ivariant;
            if(varProcessType === 'Approve')
            {
                this.storeAprveComments = this.finalApprovalComment;
                this.streStatus ='Approved';
                this.updateAprReq()
                messagetitle = 'request is Approved.';
                ivariant = 'success';
            }
            else if(varProcessType === 'Reject')
            {
                this.storeAprveComments = this.finalApprovalComment;
                this.streStatus ='Declined';
                this.updateAprReq()
                messagetitle = 'Request is Rejected.';
                ivariant = 'error';
            }
         /*   this.dispatchEvent(
                new ShowToastEvent({
                    title: messagetitle,
                    message: result,
                    variant: ivariant
                })
            );
               window.location.reload(); */
              // return  refreshApex(this.wrapperRecList)
        }) 
        .catch((error) => {

            console.log("catching error",error);
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error',
                    message: error,
                    variant: 'error'
                })
            );
        })

    }
    updateAprReq()
    {
        updateAprvalRqst({propId: this.storeRecId ,approverComments: this.storeAprveComments,status: this.streStatus, finalDate: this.getAprorRejDate})
        .then((result) => {
            console.log("final approver response result",result);
           var showTitle = 'Request is '+this.streStatus+' Successfully';

            this.dispatchEvent(
                new ShowToastEvent({
                    title: showTitle,
                    message: 'Proccessed',
                    variant: 'success'
                })
            );
               window.location.reload();
        })
        .catch((error) => {
            console.log("final error",error);
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error processing Request',
                    message: 'Something went wrong',
                    variant: 'error'
                })
            );
        })
    }
   
}