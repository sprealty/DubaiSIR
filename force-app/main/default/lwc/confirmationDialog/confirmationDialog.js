import { LightningElement,api, wire } from 'lwc';
import fetchApprovalRequest from '@salesforce/apex/customApprovalPageCntrlr.fetchApprovalRequest';
import { refreshApex } from '@salesforce/apex';

export default class ConfirmationDialog extends LightningElement {
    @api datevalue;
    @api isdefferclicked;
    @api visible = false; //used to hide/show dialog
    @api title = ''; //modal title
    @api name; //reference name of the component
    @api message = ''; //modal message
    @api confirmLabel = ''; //confirm button label
    @api cancelLabel = ''; //cancel button label
    @api originalMessage; //any event/message/detail to be published back to the parent component
   // commentsLabel= `${this.originalMessage} comments` ;
    @api  commentValue;
    @api passedCommentVal;
    @api passedPendingApproval;
    @api exp;
    @api getidfromparent;
    @api approveclick=false;
    @api getmessage;
    valOfcomments;
    valOfExpDate;
    hideIt = false;

    @wire ((fetchApprovalRequest),{propId: '$getidfromparent'})
    wiredRec ({data,error})
    {
        if (data)
        {
           
            console.log("what is in child aprreq data",data);
            console.log("what is getmessage",this.getmessage);
            this.valOfcomments = data.CD_Defer_Comments__c;
            this.valOfExpDate = data.CD_Expiry_Date__c;

        }
        if (error)
        {
            console.log("whats is in error",error);
        }
     

    }
    
    @api  callDataBaseMethod()
    {
        fetchApprovalRequest({propId: this.getidfromparent})
        .then((result) => {
            console.log("what is in child aprreq data",result);
            console.log("what is from parent getmessage",this.getmessage);
            this.valOfcomments = result.CD_Defer_Comments__c;
            this.valOfExpDate = result.CD_Expiry_Date__c;
            if(this.originalMessage === 'Approve')
            {
                this.storeExpiryDateCon = this.valOfExpDate;
                console.log('Display expdate',this.storeExpiryDateCon);
            }
            if(this.originalMessage === 'Reject')
            {
                this.storeExpiryDateCon = null || '';
            }
            
        })
        .catch((error) => {
            console.log("display error of returned",error);
        })
    }
    storeAprOrRejDate;
    connectedCallback(){
        let d = new Date();
        console.log("full date ",d);
    let altDate = d.toISOString().substring(0,10);
    console.log("altDate ",altDate);
    this.storeAprOrRejDate =altDate;
   // this.storeAprOrRejDate = newD.toISOString().substring(0,10);
    console.log('app/rej Date',this.storeAprOrRejDate)
    }
   
    storeExpiryDate;
    commentValue;



    //handles button clicks
    handleconformClick(event){

  /*      if(this.commentValueCon != null || this.commentValueCon !== '') 
        {
            this.commentValue = this.commentValueCon;
            this.valOfcomments =  this.commentValueCon;
        }
        else if(this.commentValueCon == null || this.commentValueCon === '' )
        {
            this.commentValue = this.valOfcomments;
        }

        if(this.storeExpiryDateCon != null || this.storeExpiryDateCon !== '')
        {
            this.storeExpiryDate = this.storeExpiryDateCon;
            this.valOfExpDate = this.storeExpiryDateCon;
        }
        else if(this.storeExpiryDateCon == null || this.storeExpiryDateCon === '')
        {
            this.storeExpiryDate = this.valOfExpDate;
        }
        console.log("show me comments",this.commentValue);
        console.log("show me date", this.storeExpiryDate);  */
        //creates object which will be published to the parent component
     /*   if(this.storeExpiryDateCon == null)
        {
            this.storeExpiryDate = this.valOfExpDate;
        }
        if(this.storeExpiryDateCon != null)
        {
            this.storeExpiryDate = this.storeExpiryDateCon;
        }
       if(this.commentValueCon === '')
        {
            this.commentValue = this.valOfcomments;
        }
        if(this.commentValueCon !== '')
        {
            this.commentValue =this.commentValueCon;
        }

        
        let finalEvent = {
            originalMessage: this.originalMessage,
            status: event.target.name,
            expiryDateTopass : this.storeExpiryDate ,
            passedCommentVal :  this.commentValue,
            finalAprvlComments : this.finalComments,
            aprOrrejDate : this.storeAprOrRejDate
        };
        */
        let finalEvent = {
            originalMessage: this.originalMessage,
            status: event.target.name,
            expiryDateTopass : this.storeExpiryDateCon ,
            passedCommentVal :  this.commentValueCon,
            finalAprvlComments : this.finalComments,
            aprOrrejDate : this.storeAprOrRejDate
        };
        //dispatch a 'click' event so the parent component can handle it
        this.dispatchEvent(new CustomEvent('click', {detail: finalEvent}));
       // refreshApex(this.wiredRec);
    }
    getDefComments(event) 
    {
       
        this.commentValueCon = event.target.value;
        console.log("null comment or not check",this.commentValueCon);
      
     
    }
    finalComments;
    getComments(event)
    {
        this.finalComments = event.target.value;

    }
 // @api  storeExpiryDate = this.exp;
 // @api  blockApproveButton= false;
    handleDateChange(event)
    {
       
        this.storeExpiryDateCon = event.target.value;
        console.log("null date or not check",this.storeExpiryDateCon);
  
    }
   /* handleDeferClick(event)
    {
        let deferEvent = {
            originalMessage: this.originalMessage,
            status: event.target.name,
            expiryDateTopass : this.storeExpiryDateCon,
            passedCommentVal :  this.commentValueCon
        };
       
        //dispatch a 'click' event so the parent component can handle it
        this.dispatchEvent(new CustomEvent('deferclick', {detail: deferEvent}));
    } */
 
}