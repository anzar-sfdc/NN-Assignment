trigger CountryLayerTrigger on CountryLayer__c (after update) {
    if(Trigger.isUpdate && Trigger.isAfter){
        CountryLayerTriggerHandler.updateCountryDetailsOnLead(Trigger.new, Trigger.newMap);
    }
}