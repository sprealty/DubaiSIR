import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import PROPERTY_OBJECT from '@salesforce/schema/CD_Property__c';
import TYPE_FIELD  from '@salesforce/schema/CD_Property__c.Type__c';
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
import AGENT_NAME from '@salesforce/schema/CD_Property__c.CD_Agent_Name__c';
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

export default class AddPropertyComp extends LightningElement {

   /* fields=[TYPE_FIELD,CITY_FIELD,ADDRESS_LINE,ADDRESS_2,AREA,ASKING_PRICE,BALCONY_AREA,BATHROOM_US,BATHROOM_FULL,BEDROOM_TYPE,BATHROOM,BOOK_DATE,BROKER_LISTING_ID,
        BUILD_YEAR,BUILDING_DUBIZZLE,CITY,CITY_PROPERTYFINDER,COMMERCIAL_AMENITIES,COMMUNITY_PROPERTYFINDER,COMPLETION_DATE,
        COMPLETION_DATE2,COMPLETION_STATUS, COMPLETION_STATUS2, COMPLETION_STATUS3,COUNTRY,COUNTRY_CODE,CURRENCY_CODE,DESCRIPTION,DESCRIPTION_ARABIC,
        DEVELOPER,DEVELOPER_NAME,EXTERNAL_PROPERTY,FLOOR,FLOOR1,FLOORS,FURNISHED,GEOCODE_ACCURACY,HALF_BATHROOM,IMAGE,INTERNAL_ID,LATITUDE,
        LAYOUT_TYPE,LOCATIONTEXT_DUBIZZLE,LONGITUDE,LOT_SIZE,MAIN_WEBSITE,MASTER_PROPERTY,MEASUREMENT,MIGRATION_STATE,NUMBER_OF_CHEQUES,PARENT_PROJECT,
        PARKING_SPACES,PARKING_SPACES2,PARKING_SPACES3,PRICE_ON_REQUEST,PRICE_SQUARE_FT,PRIVATE_AMENTIES,PROJECT,PROPERTY_NAME,PROPERTY_SUBTYPE,PROPERTYFINDER_REGION,
        PROPERTY_OWNER,PROPERTY_OWNER2,SALES_PRICE,SERVICE_CHARGE,SIZE,STATE,STATE_CODE,STATUS,STORIES,STREET,SUB_COMMUNITY_PROPERTYFINDER,SYSTEM_EXTERNAL_ID
    ,SYSTEM_WEBSITE_EXTERNAL_ID,TITLE, TITLE_ARABIC,TOTAL_AREA,TOWER,UNIT_EXTERNAL_ID, UNIT_NUMBER,UNITS,USER_FULLNAME,VIEW,VIEW1,VIEW2,YEAR_BUILD,YEAR_BUILD2,ZIP_CODE]; */

     objectApiName = PROPERTY_OBJECT;

     fields1=[PROJECT, UNIT_NUMBER, SALES_PRICE, STATUS,
        TYPE_FIELD, VIEW2, TOWER, UNITS,  
        TOTAL_AREA, INTERNAL_ID, BALCONY_AREA, AGENT_NAME,
        PROPERTY_NAME, PROPERTY_SUBTYPE, LAYOUT_TYPE,  PRICE_SQUARE_FT, 
        SIZE, PARKING_SPACES,BOOK_DATE, COMPLETION_DATE, BROKER_LISTING_ID, PARKING_SPACES2, 
    PARKING_SPACES3, PRICE_ON_REQUEST, PRIVATE_AMENTIES, SERVICE_CHARGE, 
    SUB_COMMUNITY_PROPERTYFINDER, UNIT_EXTERNAL_ID,  
    STATE, STREET, ZIP_CODE, YEAR_BUILD];

/* fields2=[BALCONY_AREA, TOTAL_AREA, LAYOUT_TYPE, MASTER_PROPERTY, SIZE,
    SALES_PRICE, ASKING_PRICE, PRICE_SQUARE_FT, UNITS, BOOK_DATE, COMPLETION_DATE, 
    INTERNAL_ID, BROKER_LISTING_ID, PARKING_SPACES, PARKING_SPACES2, PARKING_SPACES3, 
    PRICE_ON_REQUEST, PRIVATE_AMENTIES, SERVICE_CHARGE, SUB_COMMUNITY_PROPERTYFINDER,
    UNIT_EXTERNAL_ID, USER_FULLNAME, STATE, STREET, ZIP_CODE, YEAR_BUILD ]; */


     handleSuccess(event) {
        const evt = new ShowToastEvent({
            title: 'Property added to inventory successfully',
            message: 'Record ID: ' + event.detail.id,
            variant: 'success',
        });
        this.dispatchEvent(evt);
    }

    handleCancel(){
        this.onCancelProperty = false;
        const cancelevent2 = new CustomEvent('cancelevent',{

            detail: this.onCancelProperty
        
        });
        this.dispatchEvent(cancelevent2)
    }
}