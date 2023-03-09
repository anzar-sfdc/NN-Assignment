/**********************************************************************
  @description       : Wrapper parser for CountryLayer API
  @author            : Mohammad Anzar
  @test class        : CountryLayerAPITest 
  @last modified on  : 06-03-2023
  @last modified by  : Mohammad Anzar
  Modifications Log
  Ver   Date         Author           Modification
  1.0   06-03-2023   Mohammad Anzar   Initial Version
***********************************************************************/
public class CountryLayerApiParser {

	public String name;
	public String alpha2Code;
	public String alpha3Code;
	public String capital;
	public String region;
	public String subregion;
	public List<RegionalBlocs> regionalBlocs;

	public class RegionalBlocs {
		public String acronym;
	}
	
	public static List<CountryLayerApiParser> parse(String json) {
		return (List<CountryLayerApiParser>) System.JSON.deserialize(json, List<CountryLayerApiParser>.class);
	}
}