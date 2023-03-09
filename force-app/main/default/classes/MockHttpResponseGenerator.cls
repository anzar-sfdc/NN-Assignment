@isTest
global class MockHttpResponseGenerator implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest req){
        req.setEndpoint('https://test.com');
        HttpResponse res= new HttpResponse();
        res.setHeader('Content-Type','application/json');
        //res.setBody('[{"name":"Afghanistan","alpha2Code":"AF","alpha3Code":"AFG","capital":"Kabul","region":"Asia"},{"name":"ÅlandIslands","alpha2Code":"AX","alpha3Code":"ALA","capital":"Mariehamn","region":"Europe"}]');
        res.setBody('[{"name":"Afghanistan"},{"name":"Palestine"}]');
        res.setStatusCode(200);
        return res;
    }
}