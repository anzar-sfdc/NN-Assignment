@isTest
public class CountryLayerAPITest {
    @TestSetup
    static void makeData(){
        CountryLayer__c cl = new CountryLayer__c();
        cl.Name='Palestine';
        cl.Country_ISO_Code_2__c='PAS';
        cl.Country_ISO_Code_3__c='PA';
        cl.Capital_City__c='Jerusalam';
        cl.Region__c='Middle East';
        cl.Subregion__c='';
        insert cl;

        Regional_Bloc__c rb = new Regional_Bloc__c(Name='OIC', CountryLayer__c=cl.Id);
        insert rb;
    }
    @IsTest
    static void methodName(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.Class, new MockHttpResponseGenerator());
        CountryLayerAPI.callCountryLayerService();
        Test.stopTest();
    }
}