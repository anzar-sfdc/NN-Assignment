/******************************************************************************************
  @description       : Lead Trigger Handler Class
  @author            : Mohammad Anzar
  @test class        : CountryLayerAPITest 
  @last modified on  : 06-03-2023
  @last modified by  : Mohammad Anzar
  Modifications Log
  Ver   Date         Author           Modification       Method
  1.0   06-03-2023   Mohammad Anzar   Initial Version    updateCountryDetailsOnLead
*******************************************************************************************/
public class CountryLayerTriggerHandler {
    //update related lead when any change happens in certain fields of Country
    public static void updateCountryDetailsOnLead(List<CountryLayer__c> clLst, Map<Id, CountryLayer__c> newMap) {
        List<Lead> toUpdateLeadLst = new List<Lead>();
        for(Lead ld : [Select Id, CountryLayer__c, Region_Text__c, Subregion_Text__c, Country_ISO_Code_2_Text__c, Country_ISO_Code_3_Text__c, Capital_City_Text__c From Lead Where CountryLayer__c IN : clLst]){
            CountryLayer__c cl = newMap.get(ld.CountryLayer__c);
            if(cl.Region__c <> ld.Region_Text__c)
                ld.Region_Text__c = cl.Region__c;
            if(cl.Subregion__c <> ld.Subregion_Text__c)
                ld.Subregion_Text__c = cl.Subregion__c;
            if(cl.Country_ISO_Code_2__c <> ld.Country_ISO_Code_2_Text__c)
                ld.Country_ISO_Code_2_Text__c = cl.Country_ISO_Code_2__c;
            if(cl.Country_ISO_Code_3__c <> ld.Country_ISO_Code_3_Text__c)
                ld.Country_ISO_Code_3_Text__c = cl.Country_ISO_Code_3__c;
            if(cl.Capital_City__c <> ld.Capital_City_Text__c)
                ld.Capital_City_Text__c = cl.Capital_City__c;
            toUpdateLeadLst.add(ld);
        }
        if(!toUpdateLeadLst.isEmpty())
            update toUpdateLeadLst;
    }
}