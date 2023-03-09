/**********************************************************************
  @description       : Fetch Data from CountryLayer API
  @author            : Mohammad Anzar
  @test class        : CountryLayerAPITest 
  @last modified on  : 06-03-2023
  @last modified by  : Mohammad Anzar
  Modifications Log
  Ver   Date         Author           Modification
  1.0   06-03-2023   Mohammad Anzar   Initial Version
***********************************************************************/
public class CountryLayerAPI {
    @future(callout=true)
    public static void callCountryLayerService() {
        try{
            Country_Layer__mdt countryLayer = Country_Layer__mdt.getInstance('Default');
            string endpoint= UtilService.decryptAccessKey(countryLayer.Endpoint__c, countryLayer.Encrypted_Api_Key__c, countryLayer.Auth_Prefix__c, countryLayer.Encrypted_AES_Key__c, countryLayer.Encryption_Key__c);
            httpRequest request = new httpRequest();
            UtilService.setRequest(request, 'GET', endpoint);
            HttpResponse resp = UtilService.sendRequest(request);
            if(resp.getStatusCode() == 200){
                List<CountryLayer__c> clLst = new List<CountryLayer__c>();
                List<Regional_Bloc__c> rbLst = new List<Regional_Bloc__c>();
                Map<String, CountryLayer__c> mapOfExistingCountryNameVsCountry = new Map<String, CountryLayer__c>();
                Map<String, List<String>> mapOfCountryNameVsListOfAcronyms = new Map<String, List<String>>();
                for(CountryLayer__c cl : [Select Id, Name, Region__c, Subregion__c, Capital_City__c, Country_ISO_Code_2__c, Country_ISO_Code_3__c From CountryLayer__c]){
                    mapOfExistingCountryNameVsCountry.put(cl.Name, cl);
                }
                for(CountryLayerApiParser parsedObj : CountryLayerApiParser.parse(resp.getBody())){
                    if(!mapOfExistingCountryNameVsCountry.containsKey(parsedObj.name)){
                        clLst.add(createUpdateCountryLayerRecord(parsedObj, null, true));//new country
                    }
                    else{
                        CountryLayer__c cl = mapOfExistingCountryNameVsCountry.get(parsedObj.name);
                        if(cl.Name <> parsedObj.name || cl.Country_ISO_Code_2__c<>parsedObj.alpha2Code || cl.Country_ISO_Code_3__c<>parsedObj.alpha3Code || 
                            cl.Capital_City__c<>parsedObj.capital || cl.Region__c<>parsedObj.region || cl.Subregion__c<>parsedObj.subregion){
                                clLst.add(createUpdateCountryLayerRecord(parsedObj, cl.Id, false));
                        }                        
                    }
                }
                if(!clLst.isEmpty()){
                    upsert clLst;
                }
            }
            else {
                //handle error response
            }
        }catch(Exception ex){
            //log exception
        }
    }
    public static CountryLayer__c createUpdateCountryLayerRecord(CountryLayerApiParser parsedObj, string clId, boolean isNew){
        CountryLayer__c cl = new CountryLayer__c();
        if(!isNew) 
            cl.Id=clId;
        cl.Name=parsedObj.name;
        cl.Country_ISO_Code_2__c=parsedObj.alpha2Code;
        cl.Country_ISO_Code_3__c=parsedObj.alpha3Code;
        cl.Capital_City__c=parsedObj.capital;
        cl.Region__c=parsedObj.region;
        cl.Subregion__c=parsedObj.subregion;
        return cl;
    }
}