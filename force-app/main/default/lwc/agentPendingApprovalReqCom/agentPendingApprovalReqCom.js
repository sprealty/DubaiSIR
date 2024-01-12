import { LightningElement,track,wire,api} from 'lwc';
import getList from '@salesforce/apex/customApprovalPageCntrlr.getAgentSumbittedApprvRec';
import getUserInfo from '@salesforce/apex/PropertyCreationController.getUserInfo';
import PROPERTY_OBJECT from '@salesforce/schema/CD_Property__c';
import AGENT_NAME from '@salesforce/schema/CD_Property__c.Cd_Agent_Name1__c';
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
import UNIT_NUMBER from '@salesforce/schema/CD_Property__c.CD_Unit_Number__c';
import SECOND_AGENT_NAME from '@salesforce/schema/CD_Property__c.CD_Second_Agent__c';
import FORM_FACTOR from '@salesforce/client/formFactor';

export default class AgentPendingApprovalReqCom extends LightningElement {

  @track  columns =[
        { label: 'Unit Number', fieldName: 'CD_Property_Name__c', type:'button', typeAttributes:{label: {fieldName:'CD_Property_Name__c'}, variant:'base'}
  
      },
  
      { label: 'Date of Red list', fieldName: 'CD_Block_Date__c', type: 'button', typeAttributes:{label: {fieldName:'CD_Block_Date__c'},variant:'base'}
  
      },
  
      { label: 'Expiry Date', fieldName: 'CD_Expiry_Date__c', type: 'button', typeAttributes:{label: {fieldName:'CD_Expiry_Date__c'},variant:'base'}
  
      },
      { label: 'Agent Name', fieldName: 'Cd_Agent_Name1__c', type: 'text'}
  
      
    ];

    fields2=[AGENT_NAME,UNIT_NUMBER,SPLIT_DEAL,SECOND_AGENT_NAME,CLIENT_NAME,FULL_SET_OF_DOCUMENT,DATE_RA_WILL_BE_SINGED,DATE_THE_RESERVATION_FEE,PAYMENT_MODE,PAYMENT_PERCENTAGE,BROKAGE_REPRESENTATING_CLIENT,
      AGENT_REPRESENTATING_CLIENT,BLOCK_COMMENTS]; 

      wrapperList=[];
      wrapperlistCondtion = false;
      isAgentUser= false;

      @api objectApiName=PROPERTY_OBJECT;
      @wire((getList),{})

    wiredRecords({data,error})
    {
        this.wrapperRecList= data;
        if(data)
        {
           // this.showLoadingSpinner = false;
            if(data.length > 0) 
            {
                 console.log("display data",data);
                 console.log("is it desktop view",this.deviceType);
           
            if(this.wrapperRecList.length > 0)
            {
                this.wrapperlistCondtion = true;
                this.wrapperList = this.wrapperRecList;
               // this.storeRecId = this.wrapperList[0].Property__c;
            }
            }
           
        }
    
        if(error)
        {
            console.log("display error",error);
        }
    }
    @wire(getUserInfo, {}) 
    userData({ error, data }) {
        if(data) {
           
            if(data.Profile.Name === 'PB Agent' || data.Profile.Name === 'DP_AGENT' || data.Profile.Name === "PB Administrator" || data.Profile.Name === "PB Listing Manager") {    
               
              this.isAgentUser = true;
             
            }
           else{
                this.isAgentUser = false;
           }
                }
           
         else if(error) {
            // error handling
            console.error(error.body.message);
        }
    }

    showModal=false;
    handleRowAction(event)
    {
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
          this.showModal = true;
    }
    handleClose()
    {
      this.showModal = false;
    }

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

}