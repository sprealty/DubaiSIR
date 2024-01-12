import { LightningElement,wire,api,track } from 'lwc';
import getProperty from '@salesforce/apex/ManagePropertyCntrlr.getProperty';
import DynamicDisplay from '@salesforce/apex/ManagePropertyCntrlr.dynamicalResult';
import getAgentProperty from '@salesforce/apex/ManagePropertyCntrlr.getAgentProperty';
import PROPERTY_OBJECT from '@salesforce/schema/CD_Property__c';
import PROJECT_OBJ from '@salesforce/schema/CD_Project__c';
import SearchUnitHelpText from '@salesforce/label/c.SearchUnitHelpText';
import SearchUnitSeriesHelpText from '@salesforce/label/c.SearchUnitSeriesHelpText';
import AgentStatusPicklistValue from '@salesforce/label/c.AgentStatusValue';
//import STATUS_FIELD from '@salesforce/schema/pba__Request__c.pba__Status__c';
import SELLING_PRICE_FORMULA from '@salesforce/schema/CD_Property__c.Sales_Price__c';
import getSearchResult from '@salesforce/apex/ManagePropertyCntrlr.searchResults';
import { getPicklistValues,getObjectInfo } from 'lightning/uiObjectInfoApi';
import TYPE_FIELD  from '@salesforce/schema/CD_Property__c.Type__c';
import Furnished_FIELD  from '@salesforce/schema/CD_Property__c.CD_uaefields_Furnished__c';
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
import AGENT_NAMETEXT from '@salesforce/schema/CD_Property__c.CD_Agent_Name_User__c';
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
import FLOOR_TYPE from '@salesforce/schema/CD_Property__c.Floor_Type__c';

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
import GetDocActivities from '@salesforce/apex/activityCreationCntrlr.getDocActivities';
import getFilesPreview from '@salesforce/apex/activityCreationCntrlr.getFilesPreview';
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
import Id from '@salesforce/user/Id';
import PROFILE_NAME_FIELD from '@salesforce/schema/User.Profile.Name';
import {getRecord} from 'lightning/uiRecordApi';
import Recordtypeselect from '@salesforce/label/c.Manage_Property_Inventory_Reacord_type';
import strUserId from '@salesforce/user/Id';

const mobileColumn = [
    { label: 'Name', fieldName: 'Name', type:'button', typeAttributes:{label: {fieldName:'Name'}, variant:'base'}

    },

    { label: 'Status', fieldName: 'Status__c', type: 'text', typeAttributes:{label: {fieldName:'Status__c'}, variant:'base'},
    cellAttributes:{class:{fieldName:'statusColor'}}
    },
]

const mobileColumn1 = [
    { label: 'Project Name', fieldName: 'Project_Name__c', type:'button', typeAttributes:{label: {fieldName:'Project_Name__c'}, variant:'base'} 
    },
    { label: 'Unit Number', fieldName: 'CD_Unit_Number__c', type: 'button', typeAttributes:{label: {fieldName:'CD_Unit_Number__c'},variant:'base'} 
    },
    { label: 'Bedroom', fieldName: 'CD_Bedrooms__c', type: 'button', typeAttributes:{label: {fieldName:'CD_Bedrooms__c'},variant:'base'} 
    },
    { label: 'Price', fieldName: 'CD_Sales_Price__c', type: 'currency', typeAttributes:{label: {fieldName:'CD_Sales_Price__c'},variant:'base'} 
},
    { label: 'Status', fieldName: 'Status__c', type: 'text', typeAttributes:{label: {fieldName:'Status__c'}, variant:'base'},
        cellAttributes:{class:{fieldName:'statusColor'}}
    },
];

const columns = [
    { label: 'Project Name', fieldName: 'Project_Name__c', type:'button', typeAttributes:{label: {fieldName:'Project_Name__c'}, variant:'base'} 
    },
    { label: 'Unit Number', fieldName: 'CD_Unit_Number__c', type: 'button', typeAttributes:{label: {fieldName:'CD_Unit_Number__c'},variant:'base'},sortable: true 
    },
    { label: 'Bedroom', fieldName: 'CD_Bedrooms__c', type: 'button', typeAttributes:{label: {fieldName:'CD_Bedrooms__c'},variant:'base'} 
    },
    //{ label: 'Price', fieldName: 'CD_Sales_Price__c', type: 'currency', typeAttributes:{label: {fieldName:'CD_Sales_Price__c'},variant:'base',currencyCode: { fieldName: 'CurrencyIsoCode' }, currencyDisplayAs: 'code'},sortable: true 
//},
{ label: 'Sales Price', fieldName: 'Sales_Price__c', type: 'currency', typeAttributes:{label: {fieldName:'Sales_Price__c'},variant:'base',currencyCode: { fieldName: 'CurrencyIsoCode' }, currencyDisplayAs: 'code'},sortable: true 
},
    //{ label: 'CurrencyIsoCode', fieldName: 'CurrencyIsoCode', type: 'text' , currencyDisplayAs: 'code'
//},
    { label: 'View', fieldName: 'CD_View__c', type: 'button', typeAttributes:{label: {fieldName:'CD_View__c'},variant:'base'},sortable: true
    },
    
    { label: 'Tower', fieldName: 'CD_Tower__c', type: 'Text', typeAttributes:{label: {fieldName:'CD_Tower__c'},variant:'base'},sortable: true 
    },
    
    { label: 'Floor Level', fieldName: 'Floor_Type__c', type: 'Text', typeAttributes:{label: {fieldName:'Floor_Type__c'},variant:'base'},sortable: true 
    },
    { label: 'Status', fieldName: 'Status__c', type: 'text', typeAttributes:{label: {fieldName:'Status__c'}, variant:'base'},
        cellAttributes:{class:{fieldName:'statusColor'}}
    },
];


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

const unitFIELDS = ['CD_Property__c.CD_Project__c','CD_Property__c.Project_Approver__c','CD_Property__c.CD_Sales_Price__c', 'CD_Property__c.CurrencyIsoCode', 'CD_Property__c.No_of_Bedrooms__c', 'CD_Property__c.Community__c', 'CD_Property__c.Sub_Community__c' ];

export default class ManagePropertyInventory extends NavigationMixin(LightningElement) {
    userId = Id;
    @track varProfileName;
    @wire(getRecord, {
        recordId: Id,
        fields: [PROFILE_NAME_FIELD]
    }) wireuser({
        error,
        data
    }) {
        if (error) {
           this.error = error ; 
        } else if (data) {
            this.varProfileName =data.fields.Profile.value.fields.Name.value;        
        }
    }
    fields=[TYPE_FIELD,CITY_FIELD,ADDRESS_LINE,ADDRESS_2,AREA,ASKING_PRICE,BALCONY_AREA,BATHROOM_US,BATHROOM_FULL,BEDROOM_TYPE,BATHROOM,BOOK_DATE,BROKER_LISTING_ID,
        BUILD_YEAR,BUILDING_DUBIZZLE,CITY,CITY_PROPERTYFINDER,COMMERCIAL_AMENITIES,COMMUNITY_PROPERTYFINDER,COMPLETION_DATE,
        COMPLETION_DATE2,COMPLETION_STATUS, COMPLETION_STATUS2, COMPLETION_STATUS3,COUNTRY,COUNTRY_CODE,CURRENCY_CODE,DESCRIPTION,DESCRIPTION_ARABIC,
        DEVELOPER,DEVELOPER_NAME,EXTERNAL_PROPERTY,FLOOR,FLOOR1,FLOORS,FURNISHED,GEOCODE_ACCURACY,HALF_BATHROOM,IMAGE,INTERNAL_ID,LATITUDE,
        LAYOUT_TYPE,LOCATIONTEXT_DUBIZZLE,LONGITUDE,LOT_SIZE,MAIN_WEBSITE,MASTER_PROPERTY,MEASUREMENT,MIGRATION_STATE,NUMBER_OF_CHEQUES,PARENT_PROJECT,
        PARKING_SPACES,PARKING_SPACES2,PARKING_SPACES3,PRICE_ON_REQUEST,PRICE_SQUARE_FT,PRIVATE_AMENTIES,PROJECT,PROPERTY_NAME,PROPERTY_SUBTYPE,PROPERTYFINDER_REGION,
        PROPERTY_OWNER,PROPERTY_OWNER2,AGENT_NAMETEXT,SALES_PRICE,SERVICE_CHARGE,SIZE,STATE,STATE_CODE,STATUS,STORIES,STREET,SUB_COMMUNITY_PROPERTYFINDER,SYSTEM_EXTERNAL_ID
    ,SYSTEM_WEBSITE_EXTERNAL_ID,TITLE, TITLE_ARABIC,TOTAL_AREA,Furnished_FIELD,TOWER,UNIT_EXTERNAL_ID, UNIT_NUMBER,UNITS,USER_FULLNAME,VIEW,VIEW1,VIEW2,YEAR_BUILD,YEAR_BUILD2,ZIP_CODE];
    
    fields1=[PROJECT, UNIT_NUMBER, SELLING_PRICE_FORMULA, STATUS,
        TYPE_FIELD, VIEW2, TOWER, UNITS,Furnished_FIELD,  
        TOTAL_AREA, INTERNAL_ID, BALCONY_AREA, AGENT_NAME ];

    fields2=[PROPERTY_NAME, PROPERTY_SUBTYPE, LAYOUT_TYPE,  PRICE_SQUARE_FT, 
        SIZE, PARKING_SPACES,AGENT_NAMETEXT,
        BOOK_DATE, COMPLETION_DATE, BROKER_LISTING_ID, PARKING_SPACES2, 
        PARKING_SPACES3, PRICE_ON_REQUEST, PRIVATE_AMENTIES, SERVICE_CHARGE, 
        SUB_COMMUNITY_PROPERTYFINDER, UNIT_EXTERNAL_ID, USER_FULLNAME, 
        STATE, STREET, ZIP_CODE, YEAR_BUILD ];

        fields3=[PROJECT, PROPERTY_NAME, UNIT_NUMBER, SALES_PRICE, STATUS, INTERNAL_ID ,TOTAL_AREA ,Furnished_FIELD,AGENT_NAMETEXT];

        fields4=[PROJECT, PROPERTY_NAME, UNIT_NUMBER, STATUS,,AGENT_NAMETEXT, AGENT_NAME,INTERNAL_ID,BALCONY_AREA,BOOK_DATE,TOTAL_AREA,SIZE,TYPE_FIELD,SALES_PRICE];
        
             

            newPropertyFields=[PROJECT, UNIT_NUMBER, SALES_PRICE, STATUS,
                TYPE_FIELD, VIEW2, TOWER, UNITS,AGENT_NAMETEXT,Furnished_FIELD,  
                TOTAL_AREA, INTERNAL_ID, BALCONY_AREA, AGENT_NAME,
                PROPERTY_NAME, PROPERTY_SUBTYPE, LAYOUT_TYPE,  PRICE_SQUARE_FT, 
                SIZE, PARKING_SPACES,BOOK_DATE, COMPLETION_DATE, BROKER_LISTING_ID, PARKING_SPACES2, 
            PARKING_SPACES3, PRICE_ON_REQUEST, PRIVATE_AMENTIES, SERVICE_CHARGE, 
            SUB_COMMUNITY_PROPERTYFINDER, UNIT_EXTERNAL_ID, USER_FULLNAME, 
            STATE, STREET, ZIP_CODE, YEAR_BUILD];

        paymentFields=[SELLING_PRICE_FORMULA,VAT, CONVENYACING_FEE,ADDITIONAL_FEE,OTHER_FEE,NET_SELLING_PRICE,DISCOUNT,FINAL_NET ];

        label = {
            SearchUnitHelpText ,
            SearchUnitSeriesHelpText
        };  
   
    data=[];
    dataList=[];
    rowRecord={};
    columns= columns;
    columns2 = columnsAct;
    mobileColumn1 = mobileColumn1;
    storeRecId;
    loginUserId = strUserId;
    @api objectApiName=PROPERTY_OBJECT;
    // @api objectApiNameProj=PROJECT_OBJECT;
    showLayout =false;
    @track showNew = false;
    selectedTypeValue;
    selectedBedValue;
    SelectedCityValue;
    selectedStatusValue;
    selectedViewValue;
    selectedFloorTypValue;
    selectedProjectName;
    searchedUnit;
    searchedUnitSeries;
    searchedTower;
    searchedByFloor;
    
    
    inquiriesList=[];
    hidePropertyDetails =false;
    showProject=false;
   @track isShowDocument= false;
   @track isButtonDisabled= false;
   @track isAddDoc =false;
   
   // isButtonDisabled= true;
   isNotProjectDevPrfle= true;
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
  //  this.getAccounts();

   }

   @track sortDirection = 'asc';
    @track sortedBy;

    @wire(getRecord, { recordId: '$storeRecId', fields: unitFIELDS })
    unitRecord; 

    handleCreateInquiry(event) {
        event.preventDefault(); 
        console.log('unit records......CD_Project__c'+JSON.stringify(this.unitRecord.data.fields.CD_Project__c.value));
        if (this.unitRecord.data) { 
            this.storeProjId = this.unitRecord.data.fields.CD_Project__c.value;
            this.salesPrice = this.unitRecord.data.fields.CD_Sales_Price__c.value;
            this.approve_R = this.unitRecord.data.fields.Project_Approver__c.value;
            this.bed_Rooms = this.unitRecord.data.fields.No_of_Bedrooms__c.value;
            this.currency_Iso_Code = this.unitRecord.data.fields.CurrencyIsoCode.value;
            this.community = this.unitRecord.data.fields.Community__c.value;
            this.subCommunity = this.unitRecord.data.fields.Sub_Community__c.value;
        }
        console.log('this.subCommunity'+this.subCommunity);
        console.log('this.approve_R'+this.approve_R);
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'pba__Request__c',
                actionName: 'new'
            },
           state: {
                defaultFieldValues: `Unit__c=${this.storeRecId},pba__ListingPrice_pb_min__c=${this.salesPrice},pba__ListingPrice_pb_max__c=${this.salesPrice},Project__c=${this.storeProjId},Approver__c=${this.approve_R},User_Generated_Inquiry__c=${this.loginUserId},pba__Bedrooms_pb_max__c=${this.bed_Rooms},pba__Bedrooms_pb_min__c=${this.bed_Rooms},CurrencyIsoCode=${this.currency_Iso_Code},pba_uaefields__Community_Propertyfinder__c=${this.community},pba_uaefields__Sub_Community_Propertyfinder__c=${this.subCommunity}`,
                recordTypeId: Recordtypeselect,
            }
        
        });       
        
    }

    handleCreateCIF(event) {
        event.preventDefault();
        if (this.selectedProjectName) {
            console.log('this.selectedProjectName' + this.selectedProjectName);
            this.projectName = this.selectedProjectName.Id;
            console.log('this.projectName' + this.projectName);
        }
        const selectedOption = this.projNameListOptions.find(option => option.value === this.selectedProjectName);
        if (selectedOption) {
            this.selectedOptionId = selectedOption.Id;
            console.log('Selected Option ID:', this.selectedOptionId);
        }
    
        const navigationParams = {
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'CIF__c',
                actionName: 'new'
            }
        };
    
        if (this.selectedProjectName) {
            navigationParams.state = {
                defaultFieldValues: `Project__c=${this.selectedOptionId}`
            };
        }
    
        this[NavigationMixin.Navigate](navigationParams);
    }
    handleSort(event) {
        this.sortedBy = event.detail.fieldName;
        this.sortDirection = event.detail.sortDirection;
        console.log('Sort Dir '+this.sortDirection);
       // this.filterResult();
       // this.sortData(event.detail.fieldName, event.detail.sortDirection);
       if(this.searchedUnit !== null && this.searchedUnit != undefined )
       {
        console.log('In Searche Unit View Filter '+this.searchedUnit);
           this.searchedByFloor = null;
           this.selectedBedValue = null;
           this.selectedViewValue = null;
           this.selectedStatusValue = null;
           this.selectedFloorTypValue = null;
           this.searchedUnitSeries = null;
           this.searchedTower = null;
           this.searchProperty();

       }else{
        if(this.storeAgentPrfle === 'PB Agent' || this.storeAgentPrfle === 'DP_AGENT' || this.varInvAccess === "Agent")
    {
        if(this.searchedTower != null || this.searchedUnitSeries != null || this.selectedFloorTypValue != null || this.selectedViewValue != null || this.selectedBedValue != null || this.selectedStatusValue != null || this.selectedProjectName != null)
        {
            console.log("inside filter");
            this.filterResult();
        }
        else{
                this.getAgentRecords();
        }
    }
   
    else{
        if(this.searchedTower != null || this.searchedUnitSeries != null || this.selectedFloorTypValue != null || this.selectedViewValue != null || this.selectedBedValue != null || this.selectedStatusValue != null || this.selectedProjectName != null)
        {
            this.filterResult();
        }
        else{
            console.log("inside account");
            this.getAccounts();
        }
       
    }
       }
       
    }

    sortData(fieldname, direction) {
        
        let parseData = JSON.parse(JSON.stringify(this.tableData));
       
        let keyValue = (a) => {
            return a[fieldname];
        };


       let isReverse = direction === 'asc' ? 1: -1;


           parseData.sort((x, y) => {
            x = keyValue(x) ? keyValue(x) : ''; 
            y = keyValue(y) ? keyValue(y) : '';
           
            return isReverse * ((x > y) - (y > x));
        });
        
        this.tableData = parseData;


    }
   //*******for project record from************* */

   @api ObjectName = PROJECT_OBJ;
   projFields =[PROJECT_NAME, PROPERTY_ADDED_BY];
   
    @wire(getObjectInfo, { objectApiName: PROPERTY_OBJECT })
     objectInfo;

    // @wire(getObjectInfo, { objectApiNameProj: PROJECT_OBJECT })
    // objectInfo;
    isCssLoaded = false;
    renderedCallback()
    {
        if(this.cssLoaded) return
        this.isCssLoaded = true;
        loadStyle(this, COLORS).then(()=> {
                console.log("loaded successfully");
        }).catch((error) =>{
            console.log("error",error)
        })
    }
   
   @wire (getPicklistValues,{
       recordTypeId:"$objectInfo.data.defaultRecordTypeId",
       fieldApiName:TYPE_FIELD
   }) typeValues;

   @wire (getPicklistValues,{
     recordTypeId:"$objectInfo.data.defaultRecordTypeId",
     fieldApiName:CITY_FIELD
   }) cityValues;

   @wire (getPicklistValues,{
        recordTypeId:"$objectInfo.data.defaultRecordTypeId",
        fieldApiName:STATUS
    }) statusValues;
    
    @wire (getPicklistValues,{
        recordTypeId:"$objectInfo.data.defaultRecordTypeId",
        fieldApiName:NO_OF_BEDS
    }) noOfBedValues;

    @wire (getPicklistValues,{
        recordTypeId:"$objectInfo.data.defaultRecordTypeId",
        fieldApiName:STATUS
    }) statusValues;

    @wire (getPicklistValues,{
        recordTypeId:"$objectInfo.data.defaultRecordTypeId",
        fieldApiName:VIEW2
    }) view;

    @wire (getPicklistValues,{
        recordTypeId:"$objectInfo.data.defaultRecordTypeId",
        fieldApiName:FLOOR_TYPE
    }) floorType;
   

  get options() {
    return this.projNameListOptions
    }

    get bedOptions() {
        return [
                 { label: '1BR', value: '1BR' },
                 { label: '2BR', value: '2BR' },
                 { label: '3BR', value: '3BR' },
                 { label: '4BR', value: '4BR' },
                 { label: '5BR', value: '5BR' },
                 { label: '6BR', value: '6BR' }
               ];
        }

        projNameListOptions =[];

    @wire (getProject) wireProjectRecords({data, error}){
        if(data){

            this.data = data;
           let getprojNames =[];
            for(let i=0;i<data.length;i++)
            {
                getprojNames.push({value: data[i].Name,label: data[i].Name, Id: data[i].Id});
            }

            this.projNameListOptions = getprojNames;
           console.log("get proj Names",this.projNameListOptions);
            console.log('Project Data: '+data);

           
            }
        }



        statusOptions = [];

     agentStatusOptions() {
            
            let statusOptionsArray = AgentStatusPicklistValue.split(',');
            let options = [];
            for (let index = 0; index < statusOptionsArray.length; index++) {
                options.push({value: statusOptionsArray[index],label: statusOptionsArray[index]});
            }
            this.statusOptions = options;


           /* return [
                     { label: 'Available', value: 'Available' },
                     { label: 'Red Listed', value: 'Red Listed' },
                     { label: 'Sold', value: 'Sold' }
                   ];*/
            }


     handleAgentStatusChange(event)
     {
        console.log("check agent status",event.target.value);
        this.selectedStatusValue = event.target.value;
        this.filterResult()
     }

   /* handleChange(event){
        if(event.target.label === 'Project')
     {
       this.selectedProjectName = event.target.value;
       this.getProjectRec();
     }
    }
    projRecId;
    showprojectData =false;

    getProjectRec()
    {
        selectedProject({projectname : this.selectedProjectName})
        .then((result) => {

            console.log("getting project alldata",result);
            console.log("get all properties on project",result.Properties__r);
           // this.dataList=[];
            this.projRecId = result.Id;
            this.dataList = result.Properties__r;
            console.log("please show what is in dataList",this.dataList);
           // this.showprojectData = true;
         this.dataList =result.Properties__r.map(item =>{
            let statusColor;
            if(item.Status__c === 'Available')
                  {
                     statusColor = "datatable-blue"
                   //    statusColor = "datatable-yellow"
                  }
                  else if(item.Status__c === 'Pipeline')
                  {
                      statusColor = "datatable-darkblue"
  
                     //  statusColor = "datatable-purple"
                  }
                  
                  else if(item.Status__c === 'ON HOLD')
                  {
                      statusColor = "datatable-red"
                      // statusColor = "datatable-blue"
                  }
                  else if(item.Status__c === 'Processed')
                  {
                      statusColor = "datatable-yellow"
                  } 
                  else if(item.Status__c === 'Sold')
                  {
                      statusColor = "datatable-green"
                  }
                  else if(item.Status__c === 'Booked')
                  {
                      statusColor = "datatable-blue"
                  }
                  else if(item.Status__c === 'Not Released')
                  {
                      statusColor = "datatable-gray"
                  }
                  else if(item.Status__c === 'Red Alert')
                  {
                      statusColor = "datatable-darkgray" 
                  }
                  else if(item.Status__c === 'Registered at DLD')
                  {
                      statusColor = "datatable-orange" 
                  }
                  else if(item.Status__c === 'Commission Paid to Sotheby\'s')
                  {
                      statusColor = "datatable-darkgreen" 
                  }
                  else if(item.Status__c === 'Commission Paid to third party brokerage')
                  {
                      statusColor = "datatable-purple" 
                  }
           // let statusColor =item.Status__c === 'Available' ? "slds-text-color_success" :"slds-text-color_error"
            return{...item,"statusColor":statusColor}
          })
          this.storeRecId=this.dataList[0].Id;
          this.passDataValue = this.dataList[0];
          for(let i=0;i<this.dataList.length;i++){
              console.log('isblock inside 0', this.dataList[i].CD_isblocked__c);
          
          if(this.dataList[0].CD_isblocked__c === true || this.dataList[0].Status__c != 'Available'){
              console.log('isblock inside if 1 ', this.dataList[0].CD_isblocked__c);          
              this.isButtonDisabled= true;
              console.log('button 1'+this.isButtonDisabled);
          }
          else{
              this.isButtonDisabled= false;
          } 
      }

        for(let l=0; l<this.dataList.length;l++){
          if(this.dataList.Status__c !='Booked'){
              this.isAddDoc = true;
              this.hidePayment =true;
          }
          else{
              this.isAddDoc= false;
              this.hidePayment =false;
          }
        }
        this.SetrecordsToDisplay();
          console.log("passing data", this.dataList) 
         console.log("check agent name stored or not",this.storeAgentPrfle);
          if(this.storeAgentPrfle === 'PB Agent')
          {
              let agentArrayList=[];
              for(let i=0;i<this.dataList.length;i++)
              {
                  if(this.dataList[i].Status__c === 'Available' || this.dataList[i].Status__c === 'ON HOLD' || this.dataList[i].Status__c === 'Sold')
                  {
                      agentArrayList.push(this.dataList[i]);
                     // console.log("display array",agentArrayList);
                  }
              }
              this.agentDataList = agentArrayList;
              this.storeRecId = this.agentDataList[0].Id;
              this.passDataValue =this.agentDataList[0];
  
              console.log("display agent data list array",this.agentDataList);
              for(let i=0;i<this.agentDataList.length;i++){
                  console.log('isblock inside 0', this.agentDataList[i].CD_isblocked__c);
              
              if(this.agentDataList[0].CD_isblocked__c === true || this.agentDataList[0].Status__c != 'Available'){
                  console.log('isblock inside if 1 ', this.agentDataList[0].CD_isblocked__c);          
                  this.isButtonDisabled= true;
                  console.log('button 1'+this.isButtonDisabled);
              }
              else{
                  this.isButtonDisabled= false;
              } 
          }
  
            for(let l=0; l<this.agentDataList.length;l++){
              if(this.agentDataList.Status__c !='Booked'){
                  this.isAddDoc = true;
                  this.hidePayment =true;
              }
              else{
                  this.isAddDoc= false;
                  this.hidePayment =false;
              }
            }
            this.SetrecordsToDisplay();
              console.log("passing data", this.agentDataList)  
      
          }
          else{
              this.storeRecId=this.dataList[0].Id;
              this.passDataValue = this.dataList[0];
              for(let i=0;i<this.dataList.length;i++){
                  console.log('isblock inside 0', this.dataList[i].CD_isblocked__c);
              
              if(this.dataList[0].CD_isblocked__c === true || this.dataList[0].Status__c != 'Available'){
                  console.log('isblock inside if 1 ', this.dataList[0].CD_isblocked__c);          
                  this.isButtonDisabled= true;
                  console.log('button 1'+this.isButtonDisabled);
              }
              else{
                  this.isButtonDisabled= false;
              } 
          }
  
            for(let l=0; l<this.dataList.length;l++){
              if(this.dataList.Status__c !='Booked'){
                  this.isAddDoc = true;
                  this.hidePayment =true;
              }
              else{
                  this.isAddDoc= false;
                  this.hidePayment =false;
              }
            }
            this.SetrecordsToDisplay();
              console.log("passing data", this.dataList)  
          } 
        
        })
        .catch((error) => {

            console.log("display error message",error);
        })
    }
*/
    handleProject(){
        this.showProject = true;
    }
    handleSucces(){
        this.showProject = false;
    }

  
  /*@wire(getAllContacts)
  wiredContacts(result) {
    if (result.data) {
      this.contacts = result.data;
      this.error = undefined;
    } else if (result.error) {
      this.error = result.error;
      this.data = undefined;
      console.log("###Error : " + JSON.stringify(this.error));
    }
  }*/
   handleValueChange(event)
   {
     if(event.target.label === 'Property Type')
     {
       this.selectedTypeValue = event.target.value;
     }
     if(event.target.label === 'Status')
     {
       this.selectedStatusValue = event.target.value;

     }
     if(event.target.label === 'Project')
     {
       this.selectedProjectName = event.target.value;
       this.SelectedCityValue = null;
       this.selectedBedValue = null;
       this.selectedFloorTypValue = null;
       this.selectedViewValue = null;
       this.selectedStatusValue = null;
       this.searchedUnitSeries = null;
       this.searchedTower = null;
       this.searchedUnit = null;
       
     }
     if(event.target.label === 'City')
     {
       this.SelectedCityValue = event.target.value;
     }
     if(event.target.label === 'No of Beds')
     {
       this.selectedBedValue = event.target.value;
     }
     if(event.target.label === 'Search View')
     {
       this.selectedViewValue = event.target.value;
     }
     if(event.target.label === 'Floor Type')
     {
       this.selectedFloorTypValue = event.target.value;
     }
     if(event.target.label === 'Search Unit Series')
     {
       this.searchedUnitSeries = event.target.value;
     }
     if(event.target.label === 'Search Tower')
     {
       this.searchedTower = event.target.value;
     }
     
     this.tableData = [];
     this.pageNumber =1;
     this.filterResult()
     
   }
    //******Profile level access startes here******** *///
   disableOption= true;
   agentOnlyRec = false;
   storeAgentPrfle;
   onlyAdmin= true;
    onlyAdminAndSalesDirector = false;
    isAgent = false;
  varInvAccess;
    editPermission=false;
    adminEditpermission = false;
    //superUserAccess = false;
    //agentUserAccess = false;
@wire(getUserInfo, {}) 
    userData({ error, data }) {
        if(data) {

            console.log("show status picklist values",this.statusValues.data);
            console.log("tareeq profile",data);
            console.log("display profile data",data);
            this.storeAgentPrfle =data.Profile.Name;
            this.varInvAccess = data.Inventory_Access__c;
            //this.superUserAccess =data.Super_User_Access__c; 
            //this.agentUserAccess = data.Agent_Access__c;
          /*  if(data.Profile.Name === "PB Administrator")
            {
                this.adminEditpermission = true;
            }
            if(data.Profile.Name === "PB Administrator" || data.Profile.Name === "PB Listing Manager")
            {
                this.onlyAdmin = true;
                this.getAccounts();
            }
         
            if(data.Profile.Name === "PB Listing Manager")
            {
                this.editPermission = true;
            }
            if(data.Profile.Name === "PB Administrator" || data.Profile.Name === 'PB Agent' ||  data.Profile.Name === 'DP_AGENT' || data.Profile.Name === "PB Listing Manager") {    
                this.disableOption = false;
                this.isAdminUser = true;
                this.isNotProjectDevPrfle = true;
               
               // this.isNotProjectDevPrfle = false;
            }
            if(data.Profile.Name === 'PB Agent' ||  data.Profile.Name === 'DP_AGENT' || data.Profile.Name === "Development Projects" )
            {
                this.agentOnlyRec = true;
                this.onlyAdmin = false;
                console.log("checking from agent profile",this.storeAgentPrfle);
                this.getAgentRecords();
               
            }
            if(data.Profile.Name === "Development Projects" || data.Profile.Name === "PB Administrator" || data.Profile.Name === "PB Listing Manager")
            {
                this.onlyAdminAndSalesDirector = true;
            }
            if(data.Profile.Name === "Development Projects")
            {
                console.log("tareeq profile",data.Profile.Name);
               this.isNotProjectDevPrfle = false;
              // this.agentOnlyRec = true;
                this.onlyAdmin = true;
            } */
            console.log("Current Profile Name",data.Profile.Name);
            //console.log("User Access",this.agentUserAccess);
            if(data.Profile.Name === "PB Administrator" || data.Profile.Name === "Superuser" || this.varInvAccess === "Manager")
            {
                this.adminEditpermission = true;
                this.onlyAdmin = true;
                this.disableOption = false;
                this.isAdminUser = true;
                this.isNotProjectDevPrfle = true;
                this.onlyAdminAndSalesDirector = true;
                this.getAccounts();
                console.log("Inventory Access:::::",this.varInvAccess);
            }
            if(data.Profile.Name === "PB Listing Manager")
            {
                this.editPermission = true;
                this.onlyAdmin = true;
                this.disableOption = false;
                this.isAdminUser = true;
                this.isNotProjectDevPrfle = true;
                this.onlyAdminAndSalesDirector = true;
                this.getAccounts();
            }
            if(data.Profile.Name === "Development Projects")
            {
                console.log("tareeq profile",data.Profile.Name);
               this.isNotProjectDevPrfle = true;
              // this.agentOnlyRec = true;
               this.adminEditpermission = true;
              // this.agentOnlyRec = true;
                this.onlyAdmin = true;
                this.disableOption = false;
                this.onlyAdminAndSalesDirector = true;
               // this.getAgentRecords();
               this.getAccounts();
            }
            if(data.Profile.Name === 'PB Agent' ||  data.Profile.Name === 'DP_AGENT' || this.varInvAccess === "Agent")
            {
                this.agentOnlyRec = true;
                this.onlyAdmin = false;
                console.log("checking from agent profile",this.storeAgentPrfle);
                this.disableOption = false;
                this.isAdminUser = true;
                this.isNotProjectDevPrfle = true;
                this.onlyAdminAndSalesDirector = true;
                this.isAgent = true;
                this.getAgentRecords();
                this.agentStatusOptions();
               
            }

            }
           
         else if(error) {
            // error handling
            console.error(error.body.message);
        }
    }
//dupPageNum =1;
//dupPageSize = 10;

/* @wire (getProperty,{pageSize: '$dupPageSize', pageNumber: '$dupPageNum'})
wiredRecList({data,error}){

        if(data)
    {      
        var resultData = JSON.parse(data);
        this.accounts = resultData.properties;
        this.pageNumber = resultData.pageNumber;
         this.totalRecords = resultData.totalRecords;
      this.recordStart = resultData.recordStart;
     this.recordEnd = resultData.recordEnd;
    this.totalPages = Math.ceil(resultData.totalRecords / this.pageSize);
    this.isNext = (this.pageNumber == this.totalPages || this.totalPages == 0);
    this.isPrev = (this.pageNumber == 1 || this.totalRecords < this.pageSize);
   // this.dataList = this.accounts;

        console.log("passing data", data)
            this.dataList= this.accounts.map(item=>{
                let statusColor;
                if(item.Status__c === 'Available')
                {
                   statusColor = "datatable-blue"
                 //    statusColor = "datatable-yellow"
                }
                else if(item.Status__c === 'Pipeline')
                {
                    statusColor = "datatable-darkblue"

                   //  statusColor = "datatable-purple"
                }
                
                else if(item.Status__c === 'ON HOLD')
                {
                    statusColor = "datatable-red"
                    // statusColor = "datatable-blue"
                }
                else if(item.Status__c === 'Processed')
                {
                    statusColor = "datatable-yellow"
                } 
                else if(item.Status__c === 'Sold')
                {
                    statusColor = "datatable-green"
                }
                else if(item.Status__c === 'Booked')
                {
                    statusColor = "datatable-blue"
                }
                else if(item.Status__c === 'Not Released')
                {
                    statusColor = "datatable-gray"
                }
                else if(item.Status__c === 'Red Alert')
                {
                    statusColor = "datatable-darkgray" 
                }
                else if(item.Status__c === 'Registered at DLD')
                {
                    statusColor = "datatable-orange" 
                }
                else if(item.Status__c === 'Commission Paid to Sotheby\'s')
                {
                    statusColor = "datatable-darkgreen" 
                }
                else if(item.Status__c === 'Commission Paid to third party brokerage')
                {
                    statusColor = "datatable-purple" 
                }
               // let statusColor =item.Status__c === 'Available' ? "slds-text-color_success" :"slds-text-color_error"
                return{...item,"statusColor":statusColor}
            });
           

            console.log("check agent name stored or not",this.storeAgentPrfle);
            if(this.storeAgentPrfle === 'PB Agent')
            {
                let agentArrayList=[];
                for(let i=0;i<this.dataList.length;i++)
                {
                    if(this.dataList[i].Status__c === 'Available' || this.dataList[i].Status__c === 'ON HOLD' || this.dataList[i].Status__c === 'Sold')
                    {
                        agentArrayList.push(this.dataList[i]);
                       // console.log("display array",agentArrayList);
                    }
                }
                this.agentDataList = agentArrayList;
                this.storeRecId = this.agentDataList[0].Id;
                this.passDataValue =this.agentDataList[0];

                console.log("display agent data list array",this.agentDataList);
                for(let i=0;i<this.agentDataList.length;i++){
                   // console.log('isblock inside 0', this.agentDataList[i].CD_isblocked__c);
                
                if(this.agentDataList[0].CD_isblocked__c === true || this.agentDataList[0].Status__c != 'Available'){
                   // console.log('isblock inside if 1 ', this.agentDataList[0].CD_isblocked__c);          
                    this.isButtonDisabled= true;
                    console.log('button 1'+this.isButtonDisabled);
                }
                else{
                    this.isButtonDisabled= false;
                } 
                }
    
              for(let l=0; l<this.agentDataList.length;l++){
                if(this.agentDataList.Status__c !='Booked'){
                    this.isAddDoc = true;
                    this.hidePayment =true;
                }
                else{
                    this.isAddDoc= false;
                    this.hidePayment =false;
                }
              }
            //  this.SetrecordsToDisplay();
                console.log("passing data", this.agentDataList)  
        
            }
            
            //let objIndx = this.dataList.findIndex((item => item.Id == storeRecId));
          //  if(this.dataList[objIndx].CD_isblocked__c === true){
              //  console.log('isblock inside if 1 ', this.dataList[objIndx].CD_isblocked__c);          
            //    this.isButtonDisabled= false;
              //  console.log('button 1'+this.isButtonDisabled);
          //  }
            else{
                this.storeRecId=this.dataList[0].Id;
                this.passDataValue =this.dataList[0];
                for(let i=0;i<this.dataList.length;i++){
                  //  console.log('isblock inside 0', this.dataList[i].CD_isblocked__c);
                
                if(this.dataList[0].CD_isblocked__c === true || this.dataList[0].Status__c != 'Available'){
                 //   console.log('isblock inside if 1 ', this.dataList[0].CD_isblocked__c);          
                    this.isButtonDisabled= true;
                    console.log('button 1'+this.isButtonDisabled);
                }
                else{
                    this.isButtonDisabled= false;
                } 
            }
    
              for(let l=0; l<this.dataList.length;l++){
                if(this.dataList.Status__c !='Booked'){
                    this.isAddDoc = true;
                    this.hidePayment =true;
                }
                else{
                    this.isAddDoc= false;
                    this.hidePayment =false;
                }
              }
             // this.SetrecordsToDisplay();
                console.log("passing data", this.dataList)  
            }
            
    }

    if(error)
    {
       // this.dataList = undefined;
        console.log("display error",error);
    }
} */
finalPaymentPrice;
passDataValue={};
agentDataList =[];
@track showViewUnitButton;
handleRowAction(event){

    this.rowRecord = event.detail.row;
    
    console.log(JSON.parse(JSON.stringify(this.rowRecord)));
    console.log("show row data",this.rowRecord);
    console.log("show row data",this.rowRecord);
    //alert("get id");
    let eventId =this.rowRecord.Id;
    console.log("show row id",eventId);
   
    let objIndx = this.tableData.findIndex((item => item.Id == eventId));
    console.log('Agentid',this.tableData[objIndx].CD_Agent_Name_User__c);
    console.log('User id',this.userId);

    if(this.varProfileName === 'PB Administrator')
    {
        this.showViewUnitButton = true;
    }
    if((this.userId == this.tableData[objIndx].CD_Agent_Name_User__c && (this.tableData[objIndx].Status__c === 'Sold' || this.tableData[objIndx].Status__c === 'Red Listed' || this.tableData[objIndx].Status__c === 'Red List Review') )|| (this.tableData[objIndx].Status__c !== 'Sold' && this.tableData[objIndx].Status__c !== 'Red Listed') || this.varProfileName === 'PB Administrator' || this.varProfileName === 'PB Listing Manager' || this.varProfileName ==='Development Projects' || this.varProfileName=='Superuser' || this.varProfileName=='PB Superuser')
    {
        console.log('Agentid in if condition',this.tableData[objIndx].CD_Agent_Name_User__c);
        console.log('Agentid in if condition',this.userId); 
        console.log('Agentid in if condition varProfileName',this.varProfileName); 
        console.log('Agentid in if conditionvarProfileName',this.varProfileName);
    if(this.tableData[objIndx].CD_isblocked__c === true  || this.tableData[objIndx].Status__c !== 'Available'){

        console.log('isblock inside if 1 ', this.tableData[objIndx].CD_isblocked__c);          

        this.isButtonDisabled= false;

        console.log('button 1'+this.isButtonDisabled);

    }else{

        this.isButtonDisabled= false;

    }
    let objIndx2 = this.tableData.findIndex((item => item.Id == eventId));

    if(this.tableData[objIndx].Status__c !== 'Sold'){

        //console.log('isblock inside if 1 ', this.dataList[objIndx].CD_isblocked__c);          

        this.isAddDoc= true;
        this.hidePayment = true;

        console.log('button 2 to add DOc'+this.isAddDoc);

    }else{

        this.isAddDoc= false;
        this.hidePayment = false;

    }
        for(let i=0;i<this.tableData.length;i++)
        {
            if(this.tableData[i].Id === eventId)
            {
            this.storeRecId = this.tableData[i].Id;
            this.passDataValue =this.tableData[i];
            this.finalPaymentPrice = this.tableData[i].CD_Final_net_price__c;
            }
            
        }

        console.log("outside loop",this.storeRecId);
        this.showLayout = true;
        this.navigateNextPage = true;
        this.paymentPageFun(this.storeRecId);
        this.documentListCall(this.storeRecId);
        this.showDetails = true;
        this.sizeVar = 6;
    }
    else{
        this.showDetails = false;
        this.sizeVar = 12;
    }
}

hidePayment=true;
getSelectedName(event) {
    alert('You selected: ' + event.detail.selectedRows);
    const selectedRows = event.detail.selectedRows;
    // Display that fieldName of the selected rows
    for (let i = 0; i < selectedRows.length; i++) {
        alert('You selected: ' + selectedRows[i].fieldName);
    }
}

highlightRow(){

   //  this.storeRecId.add('highlight');
    /*if(this.storeRecId){
       this.dataList.forEach(ele => {
            ele.format = ele.storeRecId.typeAttributes ? 'slds-text-color_error' : 'slds-text-color_success';
        }); 
      // this.template.querySelector('div.itemColor').style.setProperty('--itemColor', data.itemColor);
        console.log('storeRecId id' +this.storeRecId)

    } */
}

handleClick(){
    this.showNew= true;

}
ViewUnitDetails(event)
{
    console.log("show selected city ViewUnitDetails",this.storeRecId);
    this[NavigationMixin.Navigate]({
        type: 'standard__recordPage',
        attributes: {
            recordId: this.storeRecId,
            objectApiName: 'CD_Property__c',
            actionName: 'view'
        },
    });
}
handleDocument(){
 this.isShowDocument = true;
}
openDocument = false;
isAdminUser= false;
handleDoc()
{
    this.openDocument = true;
}
closeManageReservation(){
    this.showNew = false;  
  }
  closeManageDocument(){
    this.isShowDocument = false;
  }

  resetResult()
  {
   this.SelectedCityValue = null;
   this.selectedTypeValue = null;
   this.selectedStatusValue = null;
   eval("$A.get('e.force:refreshView').fire();");
   console.log("show selected city",this.SelectedCityValue);
   console.log("show selected type",this.selectedTypeValue);
 
  } 

  filterProject(){
    getProjectSelected ({getProject: this.selectedProjectName})
    .then((result) => {
        console.log("Project Dynamic result", result);
        this.data=result;
    })
    .catch((error) => {

        console.log("catching filter error",error);
        // this.hidePropertyDetails =true;
        console.log("inside if there is no data");
      })
  }


 /* filterResult()
  {
    DynamicDisplay ({getStatus: this.selectedStatusValue , getBedNos: this.selectedBedValue, projName: this.selectedProjectName})
    .then((result) => {
            
      console.log("Dynamic result",result);
      console.log("fistr filter record",result[0])
      //this.dataList =result[0];
 if(result.length > 0)
 {

  this.hidePropertyDetails =false;
  //this.pictureUrl = result;
  this.dataList =result.map(item =>{
    let statusColor;
    if(item.Status__c === 'Available')
                {
                   statusColor = "datatable-blue"
                 //    statusColor = "datatable-yellow"
                }
                else if(item.Status__c === 'Pipeline')
                {
                    statusColor = "datatable-darkblue"

                   //  statusColor = "datatable-purple"
                }
                
                else if(item.Status__c === 'ON HOLD')
                {
                    statusColor = "datatable-red"
                    // statusColor = "datatable-blue"
                }
                else if(item.Status__c === 'Processed')
                {
                    statusColor = "datatable-yellow"
                } 
                else if(item.Status__c === 'Sold')
                {
                    statusColor = "datatable-green"
                }
                else if(item.Status__c === 'Booked')
                {
                    statusColor = "datatable-blue"
                }
                else if(item.Status__c === 'Not Released')
                {
                    statusColor = "datatable-gray"
                }
                else if(item.Status__c === 'Red Alert')
                {
                    statusColor = "datatable-darkgray" 
                }
                else if(item.Status__c === 'Registered at DLD')
                {
                    statusColor = "datatable-orange" 
                }
                else if(item.Status__c === 'Commission Paid to Sotheby\'s')
                {
                    statusColor = "datatable-darkgreen" 
                }
                else if(item.Status__c === 'Commission Paid to third party brokerage')
                {
                    statusColor = "datatable-purple" 
                }
   // let statusColor =item.Status__c === 'Available' ? "slds-text-color_success" :"slds-text-color_error"
    return{...item,"statusColor":statusColor}
  })

  
  if(this.dataList[0].Status__c === 'Booked' )
  {
      this.hidePayment = false;
  }
  console.log("check agent name stored or not",this.storeAgentPrfle);
            if(this.storeAgentPrfle === 'PB Agent')
            {
                let agentArrayList=[];
                for(let i=0;i<this.dataList.length;i++)
                {
                    if(this.dataList[i].Status__c === 'Available' || this.dataList[i].Status__c === 'ON HOLD' || this.dataList[i].Status__c === 'Sold')
                    {
                        agentArrayList.push(this.dataList[i]);
                       // console.log("display array",agentArrayList);
                    }
                   
                }
                this.agentDataList = agentArrayList;
                this.storeRecId = this.agentDataList[0].Id;
                this.passDataValue =this.agentDataList[0];

                console.log("display agent data list array",this.agentDataList);
                for(let i=0;i<this.agentDataList.length;i++){
                    console.log('isblock inside 0', this.agentDataList[i].CD_isblocked__c);
                
                if(this.agentDataList[0].CD_isblocked__c === true || this.agentDataList[0].Status__c != 'Available'){
                    console.log('isblock inside if 1 ', this.agentDataList[0].CD_isblocked__c);          
                    this.isButtonDisabled= true;
                    console.log('button 1'+this.isButtonDisabled);
                }
                else{
                    this.isButtonDisabled= false;
                } 
            }
    
              for(let l=0; l<this.agentDataList.length;l++){
                if(this.agentDataList.Status__c !='Booked'){
                    this.isAddDoc = true;
                    this.hidePayment =true;
                }
                else{
                    this.isAddDoc= false;
                    this.hidePayment =false;
                }
              }
             // this.SetrecordsToDisplay();
                console.log("passing data", this.agentDataList)  
        
            }
            else{

                this.storeRecId=this.dataList[0].Id;
                this.passDataValue = this.dataList[0];
                for(let i=0;i<this.dataList.length;i++){
                  //  console.log('isblock inside 0', this.dataList[i].CD_isblocked__c);
                
                if(this.dataList[0].CD_isblocked__c === true || this.dataList[0].Status__c != 'Available'){
                   // console.log('isblock inside if 1 ', this.dataList[0].CD_isblocked__c);          
                    this.isButtonDisabled= false;
                    console.log('button 1'+this.isButtonDisabled);
                }
                else{
                    this.isButtonDisabled= true;
                } 
            }
    
              for(let l=0; l<this.dataList.length;l++){
                if(this.dataList.Status__c !='Booked'){
                    this.isAddDoc = true;
                    this.hidePayment =true;
                }
                else{
                    this.isAddDoc= false;
                    this.hidePayment =false;
                }
              }
             // this.SetrecordsToDisplay();
                console.log("passing data", this.dataList)  
            }
  
}
 else if(result.length == 0)
 {
   this.hidePropertyDetails =true;
   console.log("inside else if");
 }
     
    })
    .catch((error) => {

      console.log("catching filter error",error);
      this.hidePropertyDetails =true;
      console.log("inside if there is no data");
    })
  } */
  handleSearch(event)
  {
    if(event.target.label === 'Search Unit' )
    {
        this.searchedUnit = event.target.value;
        if(this.searchedUnit !== null)
        {
            this.searchedByFloor = null;
            this.selectedBedValue = null;
            this.selectedViewValue = null;
            this.selectedStatusValue = null;
            this.selectedFloorTypValue = null;
            this.searchedUnitSeries = null;
            this.searchedTower = null;
            this.searchProperty();

        }
       
        this.isNext = (this.searchedUnit != null);
        this.isPrev = (this.searchedUnit != null);
        
    }
/*
    if(event.target.label === 'Search Unit Series' )
    {
        this.searchedUnitSeries = event.target.value;
        if(this.searchedUnitSeries !== null)
        {
            this.searchedUnit = null;
            this.searchedTower = null;
            this.selectedBedValue = null;
            this.selectedViewValue = null;
            this.selectedStatusValue = null;
            this.selectedFloorTypValue = null;
            this.searchProperty();

        }
       
        this.isNext = (this.searchedUnitSeries != null);
        this.isPrev = (this.searchedUnitSeries != null);
        
    }
    if(event.target.label === 'Search Tower' )
    {
        this.searchedTower = event.target.value;
        if(this.searchedTower !== null)
        {
            this.searchedUnit = null;
            this.searchedUnitSeries = null;
            this.selectedBedValue = null;
            this.selectedViewValue = null;
            this.selectedStatusValue = null;
            this.selectedFloorTypValue = null;
            this.searchProperty();

        }
       
        this.isNext = (this.searchedTower != null);
        this.isPrev = (this.searchedTower != null);
       
    }*/
  }
//   handleCommit()
//   {
//     this.resetResult();
    
//   }
  
 /* / *********PAGINATION STARTS HERE//
totalPages;
allData;
currentPageNum =1;
pageSize= 10;
@track data=[];
pageList =[];
totalRecords;

SetrecordsToDisplay()
{


	this.currentPageNum = 1;
    if(this.storeAgentPrfle === 'PB Agent')
    {
        this.totalRecords = this.agentDataList.length;
        this.allData = this.agentDataList;
    }
        
    
    else{
        console.log("show data length",this.dataList.length)
    this.totalRecords = this.dataList.length;
    this.allData =this.dataList;
    }
    
console.log("show reord length",this.totalRecords)
console.log("show page bfre length",this.pageSize)
this.pageSize= Number(this.pageSize);
console.log("show page aftr length",this.pageSize)
this.totalPages = Math.ceil(this.totalRecords/this.pageSize)
console.log("show totalPage num",this.totalPages);
//this.allData =this.dataList;
console.log("inside setRecord to display")
this.buildData();
}
onNext()
{
    console.log("show on next")
 this.currentPageNum += 1;
if(this.currentPageNum <= this.totalPages )
{
	this.buildData();
}
}

onPrev()
{
    console.log("inside onprev")
    this.currentPageNum -= 1;
    console.log("insid prev page num",this.currentPageNum)
if(this.currentPageNum >= 1 )
{
	this.buildData();
}

}

processMe(button)
{
	this.currentPageNum = button.target.label;;
if(this.currentPageNum <= this.totalPages || this.currentPageNum >= 1 )

{
	this.buildData();
}

}

onFirst()
{
	this.currentPageNum =1;
	this.buildData();

}

onLast()
{
	this.currentPageNum = this.totalPages;
this.buildData();
}

buildData()
{
	var x =(this.currentPageNum-1) * this.pageSize;
	var dataTemp= [];
	for(x;x<(this.currentPageNum)* this.pageSize;x++)
{
	if(this.allData[x])
{
	dataTemp.push(this.allData[x]);
}

}
	this.data = dataTemp;
	this.generatePageList();

}

generatePageList()
{
	this.currentPageNum = parseInt(this.currentPageNum);

	var pageListTemp =[];

	if(this.totalPages >= 1)
{
	if(this.totalPages <= 10)
{
	var count = 2;
	
	for(count; count<(this.totalPages);count++)
	{
	pageListTemp.push(count);

}
}
	else 
    {
	if(this.currentPageNum < 5)
	{

	pageListTemp.push(2,3,4,5,6);

}

	else
{
	if(this.currentPageNum > (this.totalPages-5))
{
	pageListTemp.push(this.totalPages-5,this.totalPages-4,this.totalPages-3,this.totalPages-2,this.totalPages-1)
}
else{
	pageListTemp.push(this.currentPageNum-2,this.currentPageNum-1,this.currentPageNum,this.currentPageNum+1,this.currentPageNum+2);
}
}
}

	this.pageList = pageListTemp;
}
	
}
get disablePrevious(){ 
    return this.currentPageNum<=1
}
get disableNext(){ 
    return this.currentPageNum>=this.totalPages
} 
 */
// *************Property creation permission starts here********* //

    // ********Navigate to property creation page starts here*****//c/displayProperty

    // 
    showAddNewproperty = false;
    handleNewProperty()
    {
        this.showAddNewproperty = true;
    }
    closeAddNewProperty()
    {
        this.showAddNewproperty = false;
    }
    ///***************FOR MOBILE NAVIGATE***************////
    mobileNewProperty = false;
    handleMobileNavigate()
    {
       this.mobileNewProperty = true;
    }
    handleMobileSuccess(event)
    {
        const evt = new ShowToastEvent({
            title: 'Property added to inventory successfully',
            message: 'Record ID: ' + event.detail.id,
            variant: 'success',
        });
        this.dispatchEvent(evt);
        this.mobileNewProperty = false;
    }
    handleMobileCancel()
    {
        this.mobileNewProperty = false;
    }
    viewProject(){

    }


    //*************Payment Add Starts here**************////c/addPropertyComp


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
            this.storePayment=this.PropoRecList[event.target.accessKey].CD_Payment__c;

            console.log('pay',this.storePayment);
       console.log('final', this.finalPaymentPrice);
     if(this.storePayment ==='')
     {
        this.storeAmount ='';
     }
     else
     {
        this.PropoRecList[event.target.accessKey].CD_Activity_Amount__c= parseInt(this.finalPaymentPrice)*parseInt(this.storePayment)/100;
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
    callActivities()
    {

        console.log("inside callactivity payment tab");
        console.log("whether called or not?");
        this.paymentPageFun(this.storeRecId)
        

        
    } 

    paymentPageFun(id)
    {
        GetActivities({propId: id})
        .then((result) => {
            console.log("returned tab clickcreated act results",result);
           
                this.activitiesData = result ;
                this.isActivityData = true;
                this.showLoadingSpinner=false;
            
               
               //  eval("$A.get('e.force:refreshView').fire();");
               
            

    })

        .catch((error) => {
            console.log("why  tab click error?",error);
        })
    }
    openPayment = false;
    openPaymentPage()
    {
        this.openPayment = true;
    }
    closePaymentPage()
    {
        this.openPayment = false;
        this.paymentPageFun(this.storeRecId);
    }

    openDocument=false;
    openDocPage()
    {
        this.openDocument = true;
    }
    closeDocPage()
    {
        this.openDocument = false;
         this.documentListCall(this.storeRecId);
    }
   
    //*********Document Added ANd files List starts here*************///
    callChildMethod()
    {
        console.log("wwwwwwwwwwwwwwwwwwwwwwww")
        this.documentListCall(this.storeRecId);
       // this.template.querySelector('c-manage-document-activity').getAllDocActivities();
    }
DocListData=[];
isDocData = false;
    documentListCall(id)
    {
        GetDocActivities({propId: id})
        .then((result) => {
            console.log("returned doc activity results",result);
           
                this.DocListData = result ;
                if(this.DocListData.length > 0 )
                {
                    this.isDocData = true;
                }
                
             //   this.showLoadingSpinner=false;      

    })

        .catch((error) => {
            console.log("why  tab click error?",error);
        })
    }
    filePreviewUrl;
    filePreviewProperty;
    handleCallApexToPreview(event) {

       let dataId = event.target.dataset.id;
       console.log("display event id",dataId);
       getFilesPreview({ fileId: dataId})
            .then((result => {
                console.log("result"+JSON.stringify(result))
                this.filePreviewUrl = Object.keys(result).map(item => ({
                  
                    " url ": `/sfc/servlet.shepherd/document/download/${item}`

                }))
                this.handleFilePreviewWithId(Object.keys(result)[0]);
                console.log("check filePreview",this.filePreviewUrl)

            }))
            .catch((error) => {
               console.log("display if error",error);
                this.filePreviewProperty = null;
            })
    }

    handleFilePreviewWithId(id) {
        console.log('handle preview id ' + id)
        this[NavigationMixin.Navigate]({
            type: 'standard__namedPage',
            attributes: {
                pageName: 'filePreview'

            },
            state: {
                selectedRecordId: id

            }
        })
            .then(url => { window.open(url) });

    }
   /* handleUploadFinished(event) {

        const uploadedFiles = event.detail.files;
        console.log(uploadedFiles)
        let uploadedFileNames = '';
        for (let i = 0; i < uploadedFiles.length; i++) {
            uploadedFileNames += uploadedFiles[i].name + ', ';
        }
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                message: uploadedFiles.length + ' Files uploaded Successfully: ' + uploadedFileNames,
                variant: 'success',
            }),
        );
        this.filePreviewProperty();
        } */
//*****************************Mobile Component Works start here***********************************************************//
navigateNextPage =false;
handleCardClick(event){

    //alert("hi")

    console.log("card click",event);
    console.log("chch",event.target.dataset.id);
    let eventId = event.target.dataset.id;
   
        let objIndx = this.tableData.findIndex((item => item.Id == eventId));

    if(this.tableData[objIndx].CD_isblocked__c === true  || this.tableData[objIndx].Status__c !== 'Available'){

        console.log('isblock inside if 1 ', this.tableData[objIndx].CD_isblocked__c);          

        this.isButtonDisabled= false;

        console.log('button 1'+this.isButtonDisabled);

    }else{

        this.isButtonDisabled= false;

    }
    let objIndx2 = this.tableData.findIndex((item => item.Id == eventId));

    if(this.tableData[objIndx].Status__c !== 'Sold'){

        //console.log('isblock inside if 1 ', this.dataList[objIndx].CD_isblocked__c);          

        this.isAddDoc= true;
        this.hidePayment = true;

        console.log('button 2 to add DOc'+this.isAddDoc);

    }else{

        this.isAddDoc= false;
        this.hidePayment = false;

    }
        for(let i=0;i<this.tableData.length;i++)
        {
            if(this.tableData[i].Id === eventId)
            {
            this.storeRecId = this.tableData[i].Id;
            this.passDataValue =this.tableData[i];
            this.finalPaymentPrice = this.tableData[i].CD_Final_net_price__c;
            }
            
        }

        console.log("outside loop",this.storeRecId);
        this.showLayout = true;
        this.navigateNextPage = true;
        this.paymentPageFun(this.storeRecId);
        this.documentListCall(this.storeRecId);

}
closePropertyPage()
{
    this.navigateNextPage= false; 
    this.showNew = false;
}


/////************PAGINATION NEW TYPE STARTS HERE*****************/////
@track loader = false;
@track error = null;
@track pageSize = 10;
@track pageNumber = 1;
@track totalRecords = 0;
@track totalPages = 0;
@track recordEnd = 0;
@track recordStart = 0;
@track isPrev = true;
@track isNext = true;
@track accounts = [];
dataList=[];
tableData=[];
//this.selectedStatusValue  this.selectedBedValue this.selectedProjectName
handlePreviousPage()
{
    this.pageNumber = this.pageNumber-1;
    if(this.storeAgentPrfle === 'PB Agent' || this.storeAgentPrfle === 'DP_AGENT'|| this.varInvAccess === "Agent")
    {
        if(this.searchedTower != null || this.searchedUnitSeries != null || this.selectedFloorTypValue != null || this.selectedViewValue != null || this.selectedBedValue != null || this.selectedStatusValue != null || this.selectedProjectName != null)
        {
            console.log("inside filter");
            this.filterResult();
        }
        else{
                this.getAgentRecords();
        }
    }
   
    else{
        if(this.searchedTower != null || this.searchedUnitSeries != null || this.selectedFloorTypValue != null || this.selectedViewValue != null || this.selectedBedValue != null || this.selectedStatusValue != null || this.selectedProjectName != null)
        {
            this.filterResult();
        }
        else{
            console.log("inside account");
            this.getAccounts();
        }
       
    }
    
}
handleNextPage()
{
    this.pageNumber = this.pageNumber+1;
    if(this.storeAgentPrfle === 'PB Agent' || this.storeAgentPrfle === 'DP_AGENT'|| this.varInvAccess === "Agent")
    {
        if(this.searchedTower != null || this.searchedUnitSeries != null || this.selectedFloorTypValue != null || this.selectedViewValue != null || this.selectedBedValue != null || this.selectedStatusValue != null || this.selectedProjectName != null)
        {
            console.log("inside filter");
            this.filterResult();
        }
        else{
                this.getAgentRecords();
        }
    }
   
    else{
        if(this.searchedTower != null || this.searchedUnitSeries != null || this.selectedFloorTypValue != null || this.selectedViewValue != null || this.selectedBedValue != null || this.selectedStatusValue != null || this.selectedProjectName != null)
        {
            this.filterResult();
        }
        else{
            console.log("inside account");
            this.getAccounts();
        }
       
    }
   // this.getAccounts();
}
nodata= false;
getAccounts()
{
  getProperty({pageSize: this.pageSize, pageNumber: this.pageNumber, sortedBy: this.sortedBy,sortDirection : this.sortDirection})
  .then((result) =>{

      this.hidePropertyDetails =false;
      //this.pictureUrl = result;
        
     
      var resultData = JSON.parse(result);
      console.log("wrapper data",resultData);
      console.log("oofset data",resultData.properties);
      this.accounts = resultData.properties;
    //  console.log("oofset data",resultData.properties);
      this.pageNumber = resultData.pageNumber;
       this.totalRecords = resultData.totalRecords;
    this.recordStart = resultData.recordStart;
   this.recordEnd = resultData.recordEnd;
  this.totalPages = Math.ceil(resultData.totalRecords / this.pageSize);
  this.isNext = (this.pageNumber == this.totalPages || this.totalPages == 0);
  this.isPrev = (this.pageNumber == 1 || this.totalRecords < this.pageSize);

  if(this.accounts.length == 0)
  {
    this.dataAvailable = false;
    
  }

  else{

   
      this.dataList =this.accounts.map(item =>{
        let statusColor;
        if(item.Status__c === 'Available')
              {
                 statusColor = "datatable-green"
               //    statusColor = "datatable-yellow"
              }
             /* else if(item.Status__c === 'Pipeline')
              {
                  statusColor = "datatable-darkblue"

                 //  statusColor = "datatable-purple"
              } */
               
              else if(item.Status__c === 'Red Listed')
              {
                  statusColor = "datatable-purple"
                  // statusColor = "datatable-blue"
              }
            /*  else if(item.Status__c === 'Processed')
              {
                  statusColor = "datatable-yellow"
              }  */
              else if(item.Status__c === 'Sold')
              {
                  statusColor = "datatable-red"
              }
           /*   else if(item.Status__c === 'Booked')
              {
                  statusColor = "datatable-blue"
              }
              else if(item.Status__c === 'Not Released')
              {
                  statusColor = "datatable-gray"
              }
              else if(item.Status__c === 'Red Alert')
              {
                  statusColor = "datatable-darkgray" 
              }
              else if(item.Status__c === 'Registered at DLD')
              {
                  statusColor = "datatable-orange" 
              }
              else if(item.Status__c === 'Commission Paid to Sotheby\'s')
              {
                  statusColor = "datatable-darkgreen" 
              }
              else if(item.Status__c === 'Commission Paid to third party brokerage')
              {
                  statusColor = "datatable-purple" 
              } */
       // let statusColor =item.Status__c === 'Available' ? "slds-text-color_success" :"slds-text-color_error"
        return{...item,"statusColor":statusColor}
      })
      
      if(this.dataList[0].Status__c === 'Sold' )
      {
          this.hidePayment = false;
          this.showDocTab = true;
      }
      console.log("check agent name stored or not",this.storeAgentPrfle);
      if(this.storeAgentPrfle === 'PB Agent' || this.storeAgentPrfle === 'DP_AGENT'|| this.varInvAccess === "Agent")
      {
          let agentArrayList=[];
          for(let i=0;i<this.dataList.length;i++)
          {
              if(this.dataList[i].Status__c === 'Available' || this.dataList[i].Status__c === 'Red Listed' || this.dataList[i].Status__c === 'Sold')
              {
                  agentArrayList.push(this.dataList[i]);
                 // console.log("display array",agentArrayList);
              }
          }
          this.agentDataList = agentArrayList;
          this.storeRecId = this.agentDataList[0].Id;
          this.passDataValue =this.agentDataList[0];

          console.log("display agent data list array",this.agentDataList);
          for(let i=0;i<this.agentDataList.length;i++){
             // console.log('isblock inside 0', this.agentDataList[i].CD_isblocked__c);
          
          if(this.agentDataList[0].CD_isblocked__c === true || this.agentDataList[0].Status__c != 'Available'){
           //   console.log('isblock inside if 1 ', this.agentDataList[0].CD_isblocked__c);          
              this.isButtonDisabled= true;
           //   console.log('button 1'+this.isButtonDisabled);
          }
          else{
              this.isButtonDisabled= false;
          } 
      }

      for(let l=0; l<this.agentDataList.length;l++){
        if(this.agentDataList[l].Status__c !== 'Sold'){
            this.isAddDoc = true;
            this.hidePayment =true;
            this.showDocTab = false;
        }
        else{
            this.isAddDoc= false;
            this.hidePayment =false;
            this.showDocTab = true;
        }
        }
       // this.SetrecordsToDisplay();
          console.log("passing data", this.agentDataList)  
          if(this.agentDataList.length > 0)
                  {
                    this.dataAvailable = true;
                    this.tableData = this.agentDataList;
                    console.log("passing agent data", this.tableData) ;
                  }
                  if(this.agentDataList == 0)
                  {
                    this.dataAvailable = false;
                  }
  
      }
      else{
          this.storeRecId=this.dataList[0].Id;
          this.passDataValue = this.dataList[0];
          for(let i=0;i<this.dataList.length;i++){
            //  console.log('isblock inside 0', this.dataList[i].CD_isblocked__c);
          
          if(this.dataList[0].CD_isblocked__c === true || this.dataList[0].Status__c != 'Available'){
              console.log('isblock inside if 1 ', this.dataList[0].CD_isblocked__c);          
              this.isButtonDisabled= true;
             // console.log('button 1'+this.isButtonDisabled);
          }
          else{
              this.isButtonDisabled= false;
          } 
      }

      for(let l=0; l<this.dataList.length;l++){
        if(this.dataList[l].Status__c !== 'Sold'){
            this.isAddDoc = true;
            this.hidePayment =true;
            this.showDocTab = false;
        }
        else{
            this.isAddDoc= false;
            this.hidePayment =false;
            this.showDocTab = true;
        }
        }
       // this.SetrecordsToDisplay();
          console.log("passing data", this.dataList)  
          if(this.dataList.length > 0)
                  {
                    this.dataAvailable = true;
                    this.tableData = this.dataList;
                    console.log("passing admin and sales director dara",this.tableData);
                  }
                  
                  if(this.dataList == 0)
                  {
                    this.dataAvailable = false;
                  }
      }
    }

  })
  .catch((error) =>{
      this.hidePropertyDetails =true;
  })
}

getAgentRecords()
{
    getAgentProperty({pageSize: this.pageSize, pageNumber: this.pageNumber, sortedBy: this.sortedBy,sortDirection : this.sortDirection})
  .then((result) =>{

      this.hidePropertyDetails =false;
      //this.pictureUrl = result;
        
     
      var resultData = JSON.parse(result);
      console.log("wrapper data",resultData);
      console.log("oofset data",resultData.properties);
      this.accounts = resultData.properties;
    //  console.log("oofset data",resultData.properties);
      this.pageNumber = resultData.pageNumber;
       this.totalRecords = resultData.totalRecords;
    this.recordStart = resultData.recordStart;
   this.recordEnd = resultData.recordEnd;
  this.totalPages = Math.ceil(resultData.totalRecords / this.pageSize);
  this.isNext = (this.pageNumber == this.totalPages || this.totalPages == 0);
  this.isPrev = (this.pageNumber == 1 || this.totalRecords < this.pageSize);

  if(this.accounts.length == 0)
  {
    this.dataAvailable = false;
    
  }

  else{

   
      this.dataList =this.accounts.map(item =>{
        let statusColor;
        if(item.Status__c === 'Available')
              {
                 statusColor = "datatable-green"
               //    statusColor = "datatable-yellow"
              }
            /*  else if(item.Status__c === 'Pipeline')
              {
                  statusColor = "datatable-darkblue"

                 //  statusColor = "datatable-purple"
              } */
              
              else if(item.Status__c === 'Red Listed')
              {
                  statusColor = "datatable-purple"
                  // statusColor = "datatable-blue"
              }
           /*   else if(item.Status__c === 'Processed')
              {
                  statusColor = "datatable-yellow"
              } */
              else if(item.Status__c === 'Sold')
              {
                  statusColor = "datatable-red"
              }
         /*     else if(item.Status__c === 'Booked')
              {
                  statusColor = "datatable-blue"
              }
              else if(item.Status__c === 'Not Released')
              {
                  statusColor = "datatable-gray"
              }
              else if(item.Status__c === 'Red Alert')
              {
                  statusColor = "datatable-darkgray" 
              }
              else if(item.Status__c === 'Registered at DLD')
              {
                  statusColor = "datatable-orange" 
              }
              else if(item.Status__c === 'Commission Paid to Sotheby\'s')
              {
                  statusColor = "datatable-darkgreen" 
              }
              else if(item.Status__c === 'Commission Paid to third party brokerage')
              {
                  statusColor = "datatable-purple" 
              } */
       // let statusColor =item.Status__c === 'Available' ? "slds-text-color_success" :"slds-text-color_error"
        return{...item,"statusColor":statusColor}
      })
       console.log("check agent name stored or not",this.storeAgentPrfle);
          this.storeRecId=this.dataList[0].Id;
          this.passDataValue = this.dataList[0];
          for(let i=0;i<this.dataList.length;i++){
            //  console.log('isblock inside 0', this.dataList[i].CD_isblocked__c);
          
          if(this.dataList[0].CD_isblocked__c === true || this.dataList[0].Status__c != 'Available'){
              console.log('isblock inside if 1 ', this.dataList[0].CD_isblocked__c);          
              this.isButtonDisabled= true;
             // console.log('button 1'+this.isButtonDisabled);
          }
          else{
              this.isButtonDisabled= false;
          } 
      }

      for(let l=0; l<this.dataList.length;l++){
        if(this.dataList[l].Status__c !== 'Sold'){
            this.isAddDoc = true;
            this.hidePayment =true;
            this.showDocTab = false;
        }
        else{
            this.isAddDoc= false;
            this.hidePayment =false;
            this.showDocTab = true;
        }
        }
       // this.SetrecordsToDisplay();
          console.log("passing data", this.dataList)  
          if(this.dataList.length > 0)
                  {
                    this.dataAvailable = true;
                    this.tableData = this.dataList;
                    console.log("passing admin and sales director dara",this.tableData);
                  }
                  
                  if(this.dataList == 0)
                  {
                    this.dataAvailable = false;
                  }
      
    }

  })
  .catch((error) =>{
      this.hidePropertyDetails =true;
  })
}
filterResult()
{
    //this.searchedUnitSeries = null;
    this.searchedUnit = null;
    //this.searchedTower = null;
  DynamicDisplay ({pageSize: this.pageSize,pageNumber: this.pageNumber,getStatus: this.selectedStatusValue , getBedNos: this.selectedBedValue, projName: this.selectedProjectName, view: this.selectedViewValue, floorType: this.selectedFloorTypValue, unitSeries: this.searchedUnitSeries, propSearchTower: this.searchedTower, sortedBy: this.sortedBy,sortDirection : this.sortDirection})
  .then((result) => {
          
    var resultData = JSON.parse(result);
    console.log("wrapper filtered result data",resultData);
    console.log("oofset filtered result data",resultData.properties);
    this.accounts = resultData.properties;
  //  console.log("oofset data",resultData.properties);
    this.pageNumber = resultData.pageNumber;
     this.totalRecords = resultData.totalRecords;
  this.recordStart = resultData.recordStart;
 this.recordEnd = resultData.recordEnd;
this.totalPages = Math.ceil(resultData.totalRecords / this.pageSize);
this.isNext = (this.pageNumber == this.totalPages || this.totalPages == 0);
this.isPrev = (this.pageNumber == 1 || this.totalRecords < this.pageSize);

if(this.accounts.length == 0)
  {
    this.dataAvailable = false;
  }
if(this.accounts.length > 0)
{
    this.dataAvailable = true;
this.hidePropertyDetails =false;
//this.pictureUrl = result;
this.dataList =this.accounts.map(item =>{
  let statusColor;
  if(item.Status__c === 'Available')
              {
                 statusColor = "datatable-green"
               //    statusColor = "datatable-yellow"
              }
           /*   else if(item.Status__c === 'Pipeline')
              {
                  statusColor = "datatable-darkblue"

                 //  statusColor = "datatable-purple"
              } */
              
              else if(item.Status__c === 'Red Listed')
              {
                  statusColor = "datatable-purple"
                  // statusColor = "datatable-blue"
              }
          /*    else if(item.Status__c === 'Processed')
              {
                  statusColor = "datatable-yellow"
              }  */
              else if(item.Status__c === 'Sold')
              {
                  statusColor = "datatable-red"
              }
         /*     else if(item.Status__c === 'Booked')
              {
                  statusColor = "datatable-blue"
              }
              else if(item.Status__c === 'Not Released')
              {
                  statusColor = "datatable-gray"
              }
              else if(item.Status__c === 'Red Alert')
              {
                  statusColor = "datatable-darkgray" 
              }
              else if(item.Status__c === 'Registered at DLD')
              {
                  statusColor = "datatable-orange" 
              }
              else if(item.Status__c === 'Commission Paid to Sotheby\'s')
              {
                  statusColor = "datatable-darkgreen" 
              }
              else if(item.Status__c === 'Commission Paid to third party brokerage')
              {
                  statusColor = "datatable-purple" 
              } */
 // let statusColor =item.Status__c === 'Available' ? "slds-text-color_success" :"slds-text-color_error"
  return{...item,"statusColor":statusColor}
})


if(this.dataList[0].Status__c === 'Sold' )
{
    this.hidePayment = false;
}
console.log("check agent name stored or not",this.storeAgentPrfle);
          if(this.storeAgentPrfle === 'PB Agent' || this.storeAgentPrfle === 'DP_AGENT' || this.varInvAccess === "Agent")
          {
              let agentArrayList=[];
              for(let i=0;i<this.dataList.length;i++)
              {
                  if(this.dataList[i].Status__c === 'Available' || this.dataList[i].Status__c === 'Red Listed' || this.dataList[i].Status__c === 'Sold')
                  {
                      agentArrayList.push(this.dataList[i]);
                     // console.log("display array",agentArrayList);
                  }
                 
              }
              this.agentDataList = agentArrayList;
              this.storeRecId = this.agentDataList[0].Id;
              this.passDataValue =this.agentDataList[0];

              console.log("display agent data list array",this.agentDataList);
              for(let i=0;i<this.agentDataList.length;i++){
                //  console.log('isblock inside 0', this.agentDataList[i].CD_isblocked__c);
              
              if(this.agentDataList[0].CD_isblocked__c === true || this.agentDataList[0].Status__c != 'Available'){
                  console.log('isblock inside if 1 ', this.agentDataList[0].CD_isblocked__c);          
                  this.isButtonDisabled= true;
                 // console.log('button 1'+this.isButtonDisabled);
              }
              else{
                  this.isButtonDisabled= false;
              } 
          }
  
          for(let l=0; l<this.agentDataList.length;l++){
            if(this.agentDataList[l].Status__c !== 'Sold'){
                this.isAddDoc = true;
                this.hidePayment =true;
                this.showDocTab = false;
            }
            else{
                this.isAddDoc= false;
                this.hidePayment =false;
                this.showDocTab = true;
            }
          }
           // this.SetrecordsToDisplay();
              console.log("passing data", this.agentDataList) ;
              if(this.agentDataList.length > 0)
                  {
                    this.dataAvailable = true;
                    this.tableData = this.agentDataList;
                    this.passDataValue= this.tableData[0];
                    console.log("passing agent data", this.tableData) ;
                  }
                  if(this.agentDataList == 0)
                  {
                    this.dataAvailable = false;
                  }
          }
          else{

              this.storeRecId=this.dataList[0].Id;
              this.passDataValue = this.dataList[0];
              for(let i=0;i<this.dataList.length;i++){
                //  console.log('isblock inside 0', this.dataList[i].CD_isblocked__c);
              
              if(this.dataList[0].CD_isblocked__c === true || this.dataList[0].Status__c != 'Available'){
                 // console.log('isblock inside if 1 ', this.dataList[0].CD_isblocked__c);          
                  this.isButtonDisabled= true;
                //  console.log('button 1'+this.isButtonDisabled);
              }
              else{
                  this.isButtonDisabled= false;
              } 
          }
  
          for(let l=0; l<this.dataList.length;l++){
            if(this.dataList[l].Status__c !== 'Sold'){
                this.isAddDoc = true;
                this.hidePayment =true;
                this.showDocTab = false;
            }
            else{
                this.isAddDoc= false;
                this.hidePayment =false;
                this.showDocTab = true;
            }
            }
           // this.SetrecordsToDisplay();
              console.log("passing data", this.dataList);
              if(this.dataList.length > 0)
                  {
                    this.dataAvailable = true;
                    this.tableData = this.dataList;
                    this.passDataValue = this.tableData[0];
                    console.log("passing admin and sales director dara",this.tableData);
                  }
                  
                  if(this.dataList == 0)
                  {
                    this.dataAvailable = false;
                  }
          }
 
}
else if(this.accounts.length == 0)
{
 this.hidePropertyDetails =true;
 console.log("inside else if");
}
   
  })
  .catch((error) => {

    console.log("catching filter error",error);
    this.hidePropertyDetails =true;
    console.log("inside if there is no data");
  })
} 
dataAvailable=false;
searchProperty()
  {
   console.log('------------------'+this.selectedProjectName);
    getSearchResult({propSearchName:this.searchedUnit, sortedBy: this.sortedBy,sortDirection : this.sortDirection,projName : this.selectedProjectName})
    .then((result) =>{

        if(result.length == 0)
        {
            this.dataAvailable = false;
        }
        
    if(result.length > 0)
    {
        this.dataAvailable = true;
    this.hidePropertyDetails =false;

    //this.pictureUrl = result;
    this.dataList =result.map(item =>{
      let statusColor;
      if(item.Status__c === 'Available')
                  {
                     statusColor = "datatable-green"
                   //    statusColor = "datatable-yellow"
                  }
             /*     else if(item.Status__c === 'Pipeline')
                  {
                      statusColor = "datatable-darkblue"
    
                     //  statusColor = "datatable-purple"
                  } */
                  
                  else if(item.Status__c === 'Red Listed')
                  {
                      statusColor = "datatable-purple"
                      // statusColor = "datatable-blue"
                  }
             /*     else if(item.Status__c === 'Processed')
                  {
                      statusColor = "datatable-yellow"
                  } */
                  else if(item.Status__c === 'Sold')
                  {
                      statusColor = "datatable-red"
                  }
             /*     else if(item.Status__c === 'Booked')
                  {
                      statusColor = "datatable-blue"
                  }
                  else if(item.Status__c === 'Not Released')
                  {
                      statusColor = "datatable-gray"
                  }
                  else if(item.Status__c === 'Red Alert')
                  {
                      statusColor = "datatable-darkgray" 
                  }
                  else if(item.Status__c === 'Registered at DLD')
                  {
                      statusColor = "datatable-orange" 
                  }
                  else if(item.Status__c === 'Commission Paid to Sotheby\'s')
                  {
                      statusColor = "datatable-darkgreen" 
                  }
                  else if(item.Status__c === 'Commission Paid to third party brokerage')
                  {
                      statusColor = "datatable-purple" 
                  } */
     // let statusColor =item.Status__c === 'Available' ? "slds-text-color_success" :"slds-text-color_error"
      return{...item,"statusColor":statusColor}
    })
    
    
    if(this.dataList[0].Status__c === 'Sold' )
    {
        this.hidePayment = false;
    }
    console.log("check agent name stored or not",this.storeAgentPrfle);
              if(this.storeAgentPrfle === 'PB Agent' || this.storeAgentPrfle === 'DP_AGENT' || this.varInvAccess === "Agent")
              {
                  let agentArrayList=[];
                  for(let i=0;i<this.dataList.length;i++)
                  {
                      if(this.dataList[i].Status__c === 'Available' || this.dataList[i].Status__c === 'Red Listed' || this.dataList[i].Status__c === 'Sold')
                      {
                          agentArrayList.push(this.dataList[i]);
                         // console.log("display array",agentArrayList);
                      }
                     
                  }
                  this.agentDataList = agentArrayList;
                  this.storeRecId = this.agentDataList[0].Id;
                  this.passDataValue =this.agentDataList[0];
    
                  console.log("display agent data list array",this.agentDataList);
                  for(let i=0;i<this.agentDataList.length;i++){
                    //  console.log('isblock inside 0', this.agentDataList[i].CD_isblocked__c);
                  
                  if(this.agentDataList[0].CD_isblocked__c === true || this.agentDataList[0].Status__c != 'Available'){
                      console.log('isblock inside if 1 ', this.agentDataList[0].CD_isblocked__c);          
                      this.isButtonDisabled= true;
                    //  console.log('button 1'+this.isButtonDisabled);
                  }
                  else{
                      this.isButtonDisabled= false;
                  } 
              }
      
              for(let l=0; l<this.agentDataList.length;l++){
                if(this.agentDataList[l].Status__c !== 'Sold'){
                    this.isAddDoc = true;
                    this.hidePayment =true;
                    this.showDocTab = false;
                }
                else{
                    this.isAddDoc= false;
                    this.hidePayment =false;
                    this.showDocTab = true;
                }
              }
               // this.SetrecordsToDisplay();
                  console.log("passing data", this.agentDataList) ;
                  if(this.agentDataList.length > 0)
                  {
                    this.dataAvailable = true;
                    this.tableData = this.agentDataList;
                    console.log("passing agent data", this.tableData) ;
                  }
                  if(this.agentDataList == 0)
                  {
                    this.dataAvailable = false;
                  }
                 
          
              }
              else{
    
                  this.storeRecId=this.dataList[0].Id;
                  this.passDataValue = this.dataList[0];
                  for(let i=0;i<this.dataList.length;i++){
                    //  console.log('isblock inside 0', this.dataList[i].CD_isblocked__c);
                  
                  if(this.dataList[0].CD_isblocked__c === true || this.dataList[0].Status__c != 'Available'){
                     // console.log('isblock inside if 1 ', this.dataList[0].CD_isblocked__c);          
                      this.isButtonDisabled= true;
                    //  console.log('button 1'+this.isButtonDisabled);
                  }
                  else{
                      this.isButtonDisabled= false;
                  } 
              }
      
              for(let l=0; l<this.dataList.length;l++){
                if(this.dataList[l].Status__c !== 'Sold'){
                    this.isAddDoc = true;
                    this.hidePayment =true;
                    this.showDocTab = false;
                }
                else{
                    this.isAddDoc= false;
                    this.hidePayment =false;
                    this.showDocTab = true;
                }
              }
               // this.SetrecordsToDisplay();
                  console.log("passing data", this.dataList);
                  if(this.dataList.length > 0)
                  {
                    this.dataAvailable = true;
                    this.tableData = this.dataList;
                    console.log("passing admin and sales director dara",this.tableData);
                  }
                  
                  if(this.dataList == 0)
                  {
                    this.dataAvailable = false;
                  }
                
                 
              }
     
    }
    else if(result.length == 0)
    {
     this.hidePropertyDetails =true;
     console.log("inside else if");
    }
    })
    .catch((error) =>{
        this.hidePropertyDetails =true;
    })
  }

  //************EDIT PROPERTY EVENTS STARTS HEREE *********************///*/
  openEditRecord = false;
  handleEditSuccess(){

    const event = new ShowToastEvent({

        title: 'Property Update',

        message: 'Property Updated Successfully',

        variant: 'Success',

    });

    this.dispatchEvent(event);

   // this.CloseChild = true;

   this.openEditRecord = false;

}
  handleEditClick()

            {
                  console.log("inside edit property");

                this.openEditRecord = true;

                console.log("inside edit property",this.openEditRecord);
            }

closeEditForm()
{
    this.openEditRecord = false;
}

showDetails=false;
sizeVar = 12;
handleCollapse(event) {
    this.showDetails = false;
    this.sizeVar = 12;
}

// clearData()
// {
//     eval("$A.get('e.force:refreshView').fire();");
//     //this.resetResult();
// } 
}