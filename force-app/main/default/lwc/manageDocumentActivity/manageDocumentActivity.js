import { LightningElement,wire,api,track } from 'lwc';
import { getPicklistValues,getObjectInfo } from 'lightning/uiObjectInfoApi';
import ACTIVITY_OBJECT from '@salesforce/schema/CD_Activity__c'
import ACTIVITY_FIELD from '@salesforce/schema/CD_Activity__c.Documents_Activity__c';
import InsertActivities from '@salesforce/apex/activityCreationCntrlr.createActivitiesWithFiles';
import uploadFile from '@salesforce/apex/activityCreationCntrlr.uploadFile';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import FORM_FACTOR from '@salesforce/client/formFactor';

export default class ManageDocumentActivity extends LightningElement {
 @api getdatafromparent;
    @api getidfromparent;
   @track keyIndex=1;
   accessfiledata='';
     @track  PropoRecList= [
        {
            Documents_Activity__c: '',            
            CD_Date_Added__c : '',
            CD_Days_Pending__c	:'',
            fileUploader: '',
            CD_Index_No__c: ''          
      }
    ]
    @track DocDataList=[];
    @track docList=[];
    deviceType;
    ismobileRendered = false;
    displayFullData=false;
    desktopView=false;

    get acceptedFormats(){
        return['.pdf', '.png', '.jpg'];
        }
    
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

   addRow()
   {
       this.keyIndex+1;
       this.PropoRecList.push({
             Documents_Activity__c: '',            
             CD_Date_Added__c : '',
             CD_Days_Pending__c	:'',
             fileUploader: '',
            
              
       })

       console.log('book data date id check',this.getidfromparent);
       console.log('get data from parent', this.getdatafromparent.CD_Book_Date__c);
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
   dateAdded;
storePendingDays;

   handleDataChange(event)
   {

    this.PropoRecList[event.target.accessKey].CD_Index_No__c = event.target.accessKey;
    console.log("get index no of each row",this.PropoRecList[event.target.accessKey].CD_Index_No__c);
    if(event.target.name==='Activity')
        {
            this.PropoRecList[event.target.accessKey].Documents_Activity__c = event.target.value;
            console.log('activity', this.PropoRecList[event.target.accessKey].Documents_Activity__c)
           
        }
        if(event.target.name==='Date')
        {
        
           console.log('book date check', this.getdatafromparent);
            console.log('book date verify', this.getdatafromparent.CD_Book_Date__c);
            this.PropoRecList[event.target.accessKey].CD_Date_Added__c = event.target.value;
            this.dateAdded=this.PropoRecList[event.target.accessKey].CD_Date_Added__c;

            //this.PropoRecList[event.target.accessKey].CD_Days_Pending__c = parseInt(this.dateAdded)- parseInt(this.getdatafromparent.CD_Book_Date__c);
           if(this.getdatafromparent.CD_Book_Date__c != '' && this.getdatafromparent.CD_Book_Date__c != null){
           
            var parentDate = new Date(this.getdatafromparent.CD_Book_Date__c) ;
            var currentDate = new Date(this.dateAdded);
            this.PropoRecList[event.target.accessKey].CD_Days_Pending__c =(((currentDate.getTime()-parentDate.getTime())/1000)/(60*60*24));

            this.storePendingDays=this.PropoRecList[event.target.accessKey].CD_Days_Pending__c;
            
            console.log('Test run = '+this.storePendingDays);
        }
            // console.log('date Added', this.dateAdded);
            // console.log('calculated days ='+(Date.parse(this.dateAdded) - Date.parse(this.getdatafromparent.CD_Book_Date__c))/(60*60*24));
            // console.log('Pending days',this.PropoRecList[event.target.accessKey].CD_Days_Pending__c);
            // console.log('Pending days2',this.storePendingDays);
            
        }
     /*   if(event.target.name === "fileUploader")
        {
            console.log("accesskey Check",event.target.accessKey)
  this.accessfiledata=event.target.accessKey;
  console.log('acc variable ',this.accessfiledata)
   
            
            this.PropoRecList[event.target.accessKey].fileUploader = event.target.files[0];
             console.log("checking fileupload again process",this.PropoRecList[event.target.accessKey].fileUploader)
               // const file = event.target.files[0]
            const file = this.PropoRecList[event.target.accessKey].fileUploader;
             //    console.log("fileresponse---check000 again",fileResponse.name)
             console.log("fileresponse is there????? check",file)
             var reader = new FileReader()
                reader.onload = () => {
                    var base64 = reader.result.split(',')[1]
                    this.fileData = {
                        'filename': file.name,
                        'base64': base64,
                        //'recordId': this.getidfromparent
                    }
                    console.log("checking filedata123",this.fileData.filename)
                    console.log("checking filedata456",this.fileData.base64)
                }
                reader.readAsDataURL(file)
        } */
    
   }
   showSpinner = false;
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
        this.showSpinner = true;
        console.log("get propPrec with fileList",this.PropoRecList);
        console.log("get propPrec List",JSON.stringify(this.PropoRecList));
        var obj = Object.fromEntries(this.mapOfValues);
       var jsonString = JSON.stringify(obj);
        console.log('jsonstring : ',jsonString);
      /*  var obj2 = Object.fromEntries(this.mapOfFileNames);
        var jsonString2 = JSON.stringify(obj2);
       console.log('jsonstring : ',jsonString2); */
      
       
        InsertActivities({getList : this.PropoRecList,propId: this.getdatafromparent.Id,JSONresponses:jsonString})
        .then((result) => {
            console.log("returned created doc results",result);
            this.showSpinner = false;
            this.dispatchEvent(new ShowToastEvent({
                title:'Success!',
                message: 'Document details stored successfully',
                variant:'success'
                }),);  
                   // this.passingId = result[0].Id;
                  //  this.callUploadClick(this.passingId)
                this.closeChild();
               
        })
        .catch((error) => {
            console.log("why is error?",error);
            this.dispatchEvent(new ShowToastEvent({
                title:'Fail creating records!',
                message: 'Something  went wrong',
                variant:'error'
                }),); 
        })
    }
   }
   base64val;
   filenameVal;
   recId;
  /* callUploadClick(id)
    {
            console.log("inside fileclick");
          //  console.log("checkfileData",this.fileData)
           // const {base64, filename} = this.fileData
           this.base64val= this.fileData.base64;
           console.log("check base64",this.base64val);
            this.filenameVal = this.fileData.filename;
            this.recId = id;

            uploadFile({ base64:this.base64val , filename: this.filenameVal , recordIdv:this.recId })
            .then((result)=>{
              this.fileData = null
                console.log("see result",result)
                this.dispatchEvent(new ShowToastEvent({
                    title:'file uploaded successfully',
                    message: 'Successfull',
                    variant:'success'
                    }),); 
                this.closeChild();
            })
            .catch((error) => {
                console.log("see error result check")
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error inserting files',
                        message: "something went wrong uploading files",
                        variant: 'error'
                    }),
                );
               
            })
        
    } */
   closeChild(){

    this.showDocPage= false;
    

    const selectedevent= new CustomEvent("managedocument", {
     
        detail: this.showDocPage
    
    });
    this.dispatchEvent(selectedevent);   
}
   getAllDocActivities()
   {
    console.log("display datattttt")
    // alert("method called from parent");
   }

    uploadedFiles = []; 
    file;
     fileContents;
      fileReader;
       content;
        fileName;
        mapOfValues = new Map();
        storeIndex;
        fileLists;
        mapOfFileNames = new Map();
    /*    handleFilesChange(event)
        {
            this.storeIndex = event.target.accessKey;
            console.log("get index no",this.storeIndex);
            if (event.target.files.length > 0) {  
                this.uploadedFiles = event.target.files;  
                this.fileName = event.target.files[0].name;
              //  this.PropoRecList[event.target.accessKey].CD_FileAdded_Name__c = this.fileName;
                console.log("get stringified value",JSON.stringify(this.fileName));
               this.mapOfFileNames.set(this.storeIndex,this.fileName) ;
                this.file = this.uploadedFiles[0];  
                this.fileReader = new FileReader();  
            this.fileReader.onloadend = (() => {  
              this.fileContents = this.fileReader.result;  
              let base64 = 'base64,';  
              this.content = this.fileContents.indexOf(base64) + base64.length;  
              console.log("get content",this.content);
              this.fileContents = this.fileContents.substring(this.content); 
              this.fileLists = encodeURIComponent(this.fileContents);
              console.log("get file contents",this.fileContents);
             this.mapOfValues.set(this.storeIndex,this.fileLists);
             console.log("get keyset",this.mapOfValues.keys());
              console.log("display docList",JSON.stringify(this.mapOfValues));
              console.log("display docList",this.mapOfValues);
            });
            this.fileReader.readAsDataURL(this.file); 
              } 
            
        } */
        storeContentVerId;
        handleFileUpload(event)
        {
            this.storeIndex = event.target.accessKey;
            console.log("is storeIndex there?",this.storeIndex);
           this.uploadedFiles = event.detail.files;
            console.log("stored upload files",this.uploadedFiles);
            console.log("get contentversion Id",this.uploadedFiles[0].contentVersionId);
            this.storeContentVerId = this.uploadedFiles[0].contentVersionId;
            console.log("stored ConVer ID",this.storeContentVerId);
            this.fileName = event.detail.files[0].name;
            this.mapOfFileNames.set(this.storeIndex,this.fileName) ;
            console.log("show filename map",this.mapOfFileNames);
            this.mapOfValues.set(this.storeIndex,this.storeContentVerId);
            console.log("get map of content version",this.mapOfValues);

           // this.file = this.uploadedFiles[0];  
           /* this.fileReader = new FileReader();  
        this.fileReader.onloadend = (() => {  
          this.fileContents = this.fileReader.result;  
          let base64 = 'base64,';  
          this.content = this.fileContents.indexOf(base64) + base64.length;  
          console.log("get content",this.content);
          this.fileContents = this.fileContents.substring(this.content); 
          this.fileLists = encodeURIComponent(this.fileContents);
          console.log("get file contents",this.fileContents);
         this.mapOfValues.set(this.storeIndex,this.fileLists);
         console.log("get keyset",this.mapOfValues.keys());
          console.log("display docList",JSON.stringify(this.mapOfValues));
          console.log("display docList",this.mapOfValues);
        });
        this.fileReader.readAsDataURL(this.file); */
       // alert('No. of files uploaded : ' + uploadedFiles.length);
             // this.saveRec();
        }
}