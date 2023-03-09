/*****************************************************************************************************************
  @description       : Scheduler class to Fetch Data from CountryLayer API, runs daily at 3:00 AM
  @author            : Mohammad Anzar
  @last modified on  : 06-03-2023
  @last modified by  : Mohammad Anzar
  Modifications Log
  Ver   Date         Author           Modification
  1.0   06-03-2023   Mohammad Anzar   Initial Version
******************************************************************************************************************/
public class CountryLayerApiScheduler implements Schedulable{
    public void execute(SchedulableContext SC) {
        CountryLayerAPI.callCountryLayerService();
    }
}