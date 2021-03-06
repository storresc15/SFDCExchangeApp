/*********************************************************************************
Class Name      : HTTPCalloutMockFactory
Description     : Mock factory to test HTTP callouts from App
Created By      : Sebastian Torres
Created Date    : 2021-07-13  
Modification Log: 
---------------------------------------------------------------------------------- 
Developer                   Date                   Description
----------------------------------------------------------------------------------
Sebastian                 2021-07-13               Initial version
*********************************************************************************/
public class HTTPCalloutMockFactory implements HttpCalloutMock {
    
  protected Integer code;
  protected String status;
  protected String body;
  protected Map<String, String> responseHeaders;
  public HTTPCalloutMockFactory(Integer code, String status, String body, Map<String, String> responseHeaders) {
    this.code = code;
    this.status = status;
    this.body = body;
    this.responseHeaders = responseHeaders;
  }
  public HTTPResponse respond(HTTPRequest req) {
    HttpResponse res = new HttpResponse();
    for (String key : this.responseHeaders.keySet()) {
      res.setHeader(key, this.responseHeaders.get(key));
    }
    res.setBody(this.body);
    res.setStatusCode(this.code);
    res.setStatus(this.status);
    return res;
  }
}