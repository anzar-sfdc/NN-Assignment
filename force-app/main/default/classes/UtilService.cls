/**********************************************************************
  @description       : Utility Class for callouts
  @author            : Mohammad Anzar
  @test class        : CountryLayerAPITest 
  @last modified on  : 06-03-2023
  @last modified by  : Mohammad Anzar
  Modifications Log
  Ver   Date         Author           Modification
  1.0   06-03-2023   Mohammad Anzar   Initial Version
***********************************************************************/
public class UtilService {
    public static HttpRequest setRequest(httpRequest request, string method, string endpoint){
        request.setMethod(method);
        request.setEndpoint(endpoint);
        return request;
    }
    public static String decryptAccessKey(string endpoint, string encryptedAccessKey, string accessKeyPrefix, string aesKey, string secretKey){
        endpoint+='?'+accessKeyPrefix+'='+Crypto.decrypt('AES128', EncodingUtil.base64Decode(aesKey), Blob.valueOf(secretKey), EncodingUtil.base64Decode(encryptedAccessKey)).toString();
        return endpoint;
    }
    public static HttpResponse sendRequest(HttpRequest request){
        return new http().send(request);
    }
}