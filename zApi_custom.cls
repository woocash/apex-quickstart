/*    Copyright (c) 2011 Zuora, Inc.
 *
 *   Permission is hereby granted, free of charge, to any person obtaining a copy of 
 *   this software and associated documentation files (the "Software"), to use copy, 
 *   modify, merge, publish the Software and to distribute, and sublicense copies of 
 *   the Software, provided no fee is charged for the Software.  In addition the
 *   rights specified above are conditioned upon the following:
 *
 *   The above copyright notice and this permission notice shall be included in all
 *   copies or substantial portions of the Software.
 *
 *   Zuora, Inc. or any other trademarks of Zuora, Inc.  may not be used to endorse
 *   or promote products derived from this Software without specific prior written
 *   permission from Zuora, Inc.
 *
 *   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *   FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
 *   ZUORA, INC. BE LIABLE FOR ANY DIRECT, INDIRECT OR CONSEQUENTIAL DAMAGES
 *   (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 *   LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 *   ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 *   (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *   SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

public class zApi_custom{
    
    //call out must specify the endpoint first( query from ZuoraConfig for now)
    private String endpoint;
    private String sessionid;
    public static final String soapNS = 'http://schemas.xmlsoap.org/soap/envelope/';
    public static final String xsiNS = 'http://www.w3.org/2001/XMLSchema-instance';
    public static final String xsdNS = 'http://www.w3.org/2001/XMLSchema';
    public static final String serviceNS = 'http://api.zuora.com/';
    public static final String objNS = 'http://object.api.zuora.com/';       

    public void setEndpoint(String endpoint){
        this.endpoint = endpoint;
    }
    
    public void setSessionId(String sessionid){
        this.sessionid = sessionid;
    }
    
    //API for login
    public LoginResult zlogin(String username, String password){        
        return zlogin_0(username,password);
    }
    private zApi_custom.LoginResult zlogin_0(String username, String password){
        String loginrequest= genLoginRequest(username,password);        
        String responseXml = sendDomRequest(loginrequest);
        List<dom.XmlNode> results = getResponseNode(responseXml,'loginResponse');
        System.assert(results.size() == 1, 'Unexpected login response, login failed.');
        zApi_custom.LoginResult loginresult = new zApi_custom.LoginResult();        
        loginresult.loadResult(results[0]);
        return loginresult;
    }

    //API not static method for reason of setting sessionID and endpoint
    //API for create object in Zuora
    public List<zApi_custom.SaveResult> zcreate(List<zobject_custom> zobjects,boolean singletransaction){
        
        if(singletransaction)
        {
        	return zrequest_1(zobjects, 'create','createResponse',singletransaction);
        }
        return zrequest_0(zobjects, 'create','createResponse');
    }
    
    private List<zApi_custom.SaveResult> zrequest_1(List<zobject_custom> zobjects,String verb, String responseType,boolean singletransaction){
        String request= genCUDRequest_1(verb,zobjects,singletransaction); 
        System.debug('ZZZ Zuora zApi_custom.zrequest_0: create request: ' + request);
        String responseXml = sendDomRequest(request);
        System.debug('ZZZ Zuora zApi_custom.zrequest_0: create response: ' + responseXml);
        List<dom.XmlNode> results = getResponseNode(responseXml,responseType);
        List<zApi_custom.SaveResult> saveresults = new List<zApi_custom.SaveResult>();
        for(dom.XmlNode result: results){
            zApi_custom.SaveResult saveresult = new zApi_custom.SaveResult();   
            saveresult.loadResult(result);
            saveresults.add(saveresult);        
        }
        return saveresults;        
    }    
    
     //generate create/update/delete soap request based on input parameters
    private String genCUDRequest_1(String verb, List<zobject_custom> zobjects,boolean singletransaction){        
        System.assert(verb == 'create' || verb == 'update' || verb == 'delete' || verb == 'generate','Invalid operation for api!');
        DOM.Document doc = getsoapenv_1(true,singletransaction);   
        dom.XmlNode envelope = doc.getRootElement();
        dom.XmlNode body = envelope.addChildElement('Body', soapNS, null).
                        addChildElement(verb,serviceNS, '');
                                               
        System.assert(zobjects!=null,'Can\'t create a null list');
        System.assert(zobjects.size()>0,'Can\'t create for a list without any instance.'); 

        String ztype = zobjects[0].getZtype();
        System.assert(zSchema_custom.isSupportedzType(ztype),'Not supported ztype for api call.');
        if('delete' == verb){
            body.addChildElement('type',serviceNS, null).addTextNode(ztype);
            for(zobject_custom zobj:zobjects){
                body.addChildElement('ids',serviceNS, null).addTextNode(zobj.getValueString('Id'));
            }
        }
        else{
            for(zobject_custom zobj:zobjects){
                dom.XmlNode objnode = body.addChildElement('zObjects',serviceNS, null);
                objnode.setAttribute('xsi:type','obj:' + ztype);
                zobj.toXml(objnode,objNS,serviceNS);
            }
        }
        
        return doc.toXmlString();
    }
    
   private DOM.Document getsoapenv_1(Boolean login,boolean singletransaction){
        DOM.Document doc = new DOM.Document();              
        dom.XmlNode envelope = doc.createRootElement('Envelope', soapNS, 'env');
        envelope.setNamespace('xsi', xsiNS);
        envelope.setNamespace('xsd', xsdNS);      
        envelope.setNamespace('obj', objNS);
        
        dom.XmlNode header = envelope.addChildElement('Header', soapNS, null);  
        //if login append sessionid
        if(login){             
            header.addChildElement('SessionHeader',serviceNS, '').
            addChildElement('session', null, null).addTextNode(sessionid);   
        }
        if(singletransaction){             
        	string singletran = 'true';
            header.addChildElement('CallOptions',serviceNS, '').
            addChildElement('useSingleTransaction', null, null).addTextNode(singletran);   
        }
        
              
        return doc;
    }
    
    //API for update object in Zuora
    public List<zApi_custom.SaveResult> zupdate(List<zobject_custom> zobjects){
        return zrequest_0(zobjects, 'update','updateResponse');
    }
    private List<zApi_custom.SaveResult> zrequest_0(List<zobject_custom> zobjects,String verb, String responseType){
        String request= genCUDRequest(verb,zobjects); 
        System.debug('ZZZ Zuora zApi_custom.zrequest_0: create request: ' + request);
        String responseXml = sendDomRequest(request);
        System.debug('ZZZ Zuora zApi_custom.zrequest_0: create response: ' + responseXml);
        List<dom.XmlNode> results = getResponseNode(responseXml,responseType);
        List<zApi_custom.SaveResult> saveresults = new List<zApi_custom.SaveResult>();
        for(dom.XmlNode result: results){
            zApi_custom.SaveResult saveresult = new zApi_custom.SaveResult();   
            saveresult.loadResult(result);
            saveresults.add(saveresult);        
        }
        return saveresults;        
    }    
    
    //API for delete object in Zuora, pass in type and ids
    public List<zApi_custom.DeleteResult> zdelete(String ztype, String[] ids){     
        return this.zdelete_0(ztype, ids);  
    }    
    private List<zApi_custom.DeleteResult> zdelete_0(String ztype, String[] ids){
        List <zobject_custom> zobjects = new List<zobject_custom>();
        for(String id : ids){
            zobject_custom zobj = new zobject_custom(ztype);
            zobj.setValue('Id', id);
            zobjects.add(zobj);
        }
        String deleterequest= genCUDRequest('delete',zobjects); 
        String responseXml = sendDomRequest(deleterequest);
        List<dom.XmlNode> results = getResponseNode(responseXml,'deleteResponse');
        List<zApi_custom.DeleteResult> deleteresults = new List<zApi_custom.DeleteResult>();
        for(dom.XmlNode result: results){
            zApi_custom.DeleteResult deleteresult = new zApi_custom.DeleteResult();   
            deleteresult.loadResult(result);
            deleteresults.add(deleteresult);        
        }
        return deleteresults;
    }
    
    //API for query object in Zuora
    public List<zobject_custom> zquery (String zoql){      
        return query_0(zoql);         
    }
    //convert xml to zObject_custom list, only for query
    private List<zobject_custom> query_0(String zoql){
        String queryrequest= genQueryRequest(zoql); 
        String responseXml = sendDomRequest(queryrequest);
        
         System.debug('chintan--->Response XML' + responseXml);
         
        return parseQueryResponse(responseXml);        
    }
    //parse query response
    private List<zobject_custom> parseQueryResponse(String responseXml){
        List<dom.XmlNode> results = getResponseNode(responseXml,'queryResponse');              
        System.assert(1 == results.size(),'Query returned invalid response:' + responseXml);
        //check result is success
        dom.XmlNode done = results[0].getChildElement('done',serviceNS);        
        dom.XmlNode size= results[0].getChildElement('size',serviceNS);
        System.assert(done != null && size != null,'Query returned invalid response:' + responseXml);        
        if('true' == done.getText()){  
            List<zobject_custom> records = new List<zobject_custom>();     
            if(Integer.valueOf(size.getText()) > 0){     
                List<dom.XmlNode> resultchildren = results[0].getChildren();                
                for(dom.XmlNode resultchild: resultchildren){
                    if('records' == resultchild.getName())
                        records.add(zobject_custom.loadQueryResult(resultchild, objNS,xsiNS));
                }
            }
            return records;
        }
        else{
            throw new zApi_customException('Zuora query failed:' + responseXml);
            return null;
        }
    }

    public List<SubscribeResult> zsubscribe(List<SubscribeRequest> sub_reqs){       
        return zsubscribe_0(sub_reqs);
    }

    private List<SubscribeResult> zsubscribe_0(List<SubscribeRequest> sub_reqs){
        System.assert(sub_reqs!= null && sub_reqs.size()>0,'Can\'t make subscribe with null request.');
        Boolean valid = true;       
        String request = genSubscribeRequest(sub_reqs); 
        System.debug('ZZZ Zuora zApi_custom.zsubscribe_0: subscribe request: ' + request);
        String responseXml = sendDomRequest(request);
        System.debug('ZZZ Zuora zApi_custom.zsubscribe_0: subscribe response: ' + responseXml);
        List<dom.XmlNode> results = getResponseNode(responseXml,'subscribeResponse');
        List<zApi_custom.SubscribeResult> subscriberesults = new List<zApi_custom.SubscribeResult>();
        for(dom.XmlNode result: results){
            zApi_custom.SubscribeResult subscriberesult = new zApi_custom.SubscribeResult();   
            subscriberesult.loadResult(result);
            subscriberesults.add(subscriberesult);      
        }
        return subscriberesults;
    }
    
    /*
    <complexType name="zObject">
                <sequence>
                    <element minOccurs="0" maxOccurs="unbounded" name="fieldsToNull" nillable="true" type="string" />
                    <element minOccurs="0" maxOccurs="1" name="Id" nillable="true" type="zns:ID" />
                </sequence>
            </complexType>
    
    public class zObjectc {
        public string[] fieldsToNull;
        public string Idc;
        
           
         public void toXml(dom.XmlNode reqnode){
                        
           if ( Idc != null ) {
               Idc.toXml(reqnode.addChildElement('Id',serviceNS,null),objNS,serviceNS);
            }
            for(string fldstonl : fieldsToNull){
                            
                //reqnode.addChildElement('RatePlanData',serviceNS,null).addTextNode(String.valueOf(RatePlanData));
                
                fldstonl.toXml(reqnode.addChildElement('fieldsToNull',serviceNS,null),objNS,serviceNS);
            }
                     
        }
    }     */
    
     public class GenerateRequest{
        public zobject_custom[] zObjectarr;
           
        
        public void toXml(dom.XmlNode reqnode){
             
             for(zobject_custom zobjt : zObjectarr){
                            
                //reqnode.addChildElement('RatePlanData',serviceNS,null).addTextNode(String.valueOf(RatePlanData));
                
                zobjt.toXml(reqnode.addChildElement('zObjects',serviceNS,null),objNS,serviceNS);
            }
                     
        }
    }
    
    
    public List<zApi_custom.SaveResult> zgenerate(List<zobject_custom> zobjects){       
        return zgenerate_0(zobjects,'generate','generateResponse');
    }

    private List<zApi_custom.SaveResult> zgenerate_0(List<zobject_custom> zobjects,String verb, String responseType){
            String request= genCUDRequest(verb,zobjects); 
            System.debug('ZZZ Zuora zApi_custom.zgenerate_0: generate request: ' + request);
            String responseXml = sendDomRequest(request);
            System.debug('ZZZ Zuora zApi_custom.zrequest_0: generate response: ' + responseXml);
            List<dom.XmlNode> results = getResponseNode(responseXml,responseType);
            List<zApi_custom.SaveResult> saveresults = new List<zApi_custom.SaveResult>();
            for(dom.XmlNode result: results){
                zApi_custom.SaveResult saveresult = new zApi_custom.SaveResult();   
                saveresult.loadResult(result);
                saveresults.add(saveresult);        
            }
            return saveresults;    
    }
    
    
    public List<AmendResult> zamend(List<AmendRequest> sub_reqs){       
        return zamend_0(sub_reqs);
    }

    private List<AmendResult> zamend_0(List<AmendRequest> sub_reqs){
        System.assert(sub_reqs!= null && sub_reqs.size()>0,'Can\'t make amend with null request.');
        Boolean valid = true;       
        String request = genAmendRequest(sub_reqs); 
        System.debug('ZZZ Zuora zApi_custom.zamend_0: amend request: ' + request);
        String responseXml = sendDomRequest(request);
        System.debug('ZZZ Zuora zApi_custom.zamend_0: amend response: ' + responseXml);
        
        
        List<dom.XmlNode> results = getAmendNode(responseXml,'amendResponse');
        List<zApi_custom.AmendResult> amendResults = new List<zApi_custom.AmendResult>();
       
        	results = getAmendNode(responseXml,'amendResponse');
        amendResults = new List<zApi_custom.AmendResult>();
        //--Soum
        if ( results != null ){
	        for(dom.XmlNode result: results){
	            zApi_custom.AmendResult amendResult = new zApi_custom.AmendResult();   
	            amendResult.loadResult(result);
	            amendResults.add(amendResult);      
	        }
        }
    		return amendResults;
        
        
        /*
        List<dom.XmlNode> results = getAmendNode(responseXml,'amendResponse');
        List<zApi_custom.AmendResult> amendResults = new List<zApi_custom.AmendResult>();
        for(dom.XmlNode result: results){
            zApi_custom.AmendResult amendResult = new zApi_custom.AmendResult();   
            amendResult.loadResult(result);
            amendResults.add(amendResult);      
        }
        return amendResults;
        */
    }
        
   
    
    //generate login soap request
    private String genLoginRequest(String username, String password){
        DOM.Document doc = getsoapenv(false);   
        dom.XmlNode envelope = doc.getRootElement();
        dom.XmlNode body = envelope.addChildElement('Body', soapNS, null).
                        addChildElement('login',serviceNS, '');
        body.addChildElement('username',serviceNS, null).addTextNode(username);
        body.addChildElement('password',serviceNS, null).addTextNode(password);
        
        return doc.toXmlString();
    }    
    
    //generate create/update/delete soap request based on input parameters
    private String genCUDRequest(String verb, List<zobject_custom> zobjects){        
        System.assert(verb == 'create' || verb == 'update' || verb == 'delete' || verb == 'generate','Invalid operation for api!');
        DOM.Document doc = getsoapenv(true);   
        dom.XmlNode envelope = doc.getRootElement();
        dom.XmlNode body = envelope.addChildElement('Body', soapNS, null).
                        addChildElement(verb,serviceNS, '');
                                               
        System.assert(zobjects!=null,'Can\'t create a null list');
        System.assert(zobjects.size()>0,'Can\'t create for a list without any instance.'); 
                             
        String ztype = zobjects[0].getZtype();
        System.assert(zSchema_custom.isSupportedzType(ztype),'Not supported ztype for api call.');
        if('delete' == verb){
            body.addChildElement('type',serviceNS, null).addTextNode(ztype);
            for(zobject_custom zobj:zobjects){
                body.addChildElement('ids',serviceNS, null).addTextNode((String)zobj.getValue('Id'));
            }
        }
        else{
            for(zobject_custom zobj:zobjects){
                dom.XmlNode objnode = body.addChildElement('zObjects',serviceNS, null);
                objnode.setAttribute('xsi:type','obj:' + ztype);
                zobj.toXml(objnode,objNS,serviceNS);
            }
        }
        
        return doc.toXmlString();
    }

    //generate create/update/delete soap request based on input parameters
    private String genSubscribeRequest(List<SubscribeRequest> sub_reqs){        
        DOM.Document doc = getsoapenv(true);   
        dom.XmlNode envelope = doc.getRootElement();
        dom.XmlNode body = envelope.addChildElement('Body', soapNS, null).
                        addChildElement('subscribe',serviceNS, '');   
        
        for(SubscribeRequest req:sub_reqs){
            dom.XmlNode objnode = body.addChildElement('subscribes',serviceNS, null);
            req.toXml(objnode);
        }                
        return doc.toXmlString();
    }
    
    //generate create/update/delete soap request based on input parameters
    private String genAmendRequest(List<AmendRequest> sub_reqs){        
        DOM.Document doc = getsoapenv(true);   
        dom.XmlNode envelope = doc.getRootElement();
        dom.XmlNode body = envelope.addChildElement('Body', soapNS, null).
                        addChildElement('amend',serviceNS, '');   
        
        for(AmendRequest req:sub_reqs){
            dom.XmlNode objnode = body.addChildElement('requests',serviceNS, '');
            req.toXml(objnode);
        }                
        return doc.toXmlString();
    }
    
    
     private String genGeneraterequest(List<GenerateRequest> sub_reqs){        
        DOM.Document doc = getsoapenv(true);   
        dom.XmlNode envelope = doc.getRootElement();
        dom.XmlNode body = envelope.addChildElement('Body', soapNS, null).
                        addChildElement('generate',serviceNS, '');   
        
        for(GenerateRequest req:sub_reqs){
         //dom.XmlNode objnode = body.addChildElement('zobjects',serviceNS, null);
           req.toXml(body);
       }                
        return doc.toXmlString();
    }
    
    
    
    
    //generate query soap request
    //return the response soap xml
    //ensure the return result not exceed 1M size limitation?
    private String genQueryRequest(String zoql){
        DOM.Document doc = getsoapenv(true);   
        dom.XmlNode envelope = doc.getRootElement();
        dom.XmlNode body = envelope.addChildElement('Body', soapNS, null).
                        addChildElement('query',serviceNS, '');
        body.addChildElement('queryString',serviceNS, '').addTextNode(zoql);        
        
        return doc.toXmlString();
    }
        
    //generate the soap envelop
    private DOM.Document getsoapenv(Boolean login){
        DOM.Document doc = new DOM.Document();              
        dom.XmlNode envelope = doc.createRootElement('Envelope', soapNS, 'env');
        envelope.setNamespace('xsi', xsiNS);
        envelope.setNamespace('xsd', xsdNS);      
        envelope.setNamespace('obj', objNS);
        
        dom.XmlNode header = envelope.addChildElement('Header', soapNS, null);  
        //if login append sessionid
        if(login){             
            header.addChildElement('SessionHeader',serviceNS, '').
            addChildElement('session', null, null).addTextNode(sessionid);   
        }      
        return doc;
    }
    
    //send the dom request to Zuora
    private String sendDomRequest(String soaprequest) {   
        Integer ContentLength = 0;
        ContentLength = soaprequest.length();     
           
        Http h= new Http();
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();      

        req.setMethod('POST');        
        req.setEndPoint(endpoint); 
        req.setHeader('Content-type','text/xml');
        req.setHeader('Content-Length',ContentLength.format());    
        req.setBody(soaprequest);
        req.setBody(soaprequest);
        req.setTimeout(60000); // in milliseconds
        
        
        System.debug('chintan----> request XML -->' + soaprequest);
        
        
        Long startTime = Datetime.now().getTime();
		//--Soum Edit
		if ( endpoint != 'Invalid')
        		res = h.send(req);
    
        Long endTime = Datetime.now().getTime();
        System.debug('ZZZ Zuora zApi_custom.sendDomRequest: call duration: ' + (endTime - startTime)/1000 + ' secs.');
        //--Soum Edit
        String returnsoap='';
        if ( endpoint != 'Invalid' )
        		returnsoap = res.getBody();   
        	else
        	    	returnsoap = 'Invalid';     
        return returnsoap;   
    }
    
    
    //get the response Node to a SaveResult list
    public static List<dom.XmlNode> getResponseNode(String responseXml,String responseType){
        dom.Document doc = new Dom.Document();
        //Soum
        List<dom.XmlNode> results = new List<dom.XmlNode>();
        if ( responseXml != 'Invalid' ){
	        doc.load(responseXml);          
	        dom.XmlNode responsenode = doc.getRootElement().getChildElement('Body',soapNS)
	                    .getChildElement(responseType,serviceNS);  
	        if(responsenode == null){
	            throw new zApi_customException ('Server Exception: ' + responseXml);
	        }
	        
	        for(dom.XmlNode result:responsenode.getChildElements()){
	            if('result' == result.getName()){
	                results.add(result);
	            }
	        }  
        }
        
        
        /*
        doc.load(responseXml);          
        dom.XmlNode responsenode = doc.getRootElement().getChildElement('Body',soapNS)
                    .getChildElement(responseType,serviceNS);  
        if(responsenode == null){
            throw new zApi_customException ('Server Exception: ' + responseXml);
        }
        List<dom.XmlNode> results = new List<dom.XmlNode>();
        for(dom.XmlNode result:responsenode.getChildElements()){
            if('result' == result.getName()){
                results.add(result);
            }
        }    */       
        return results;                                     
    }
    
    //get the response Node to a SaveResult list
    public static List<dom.XmlNode> getAmendNode(String responseXml,String responseType){
        dom.Document doc = new Dom.Document();
        
        //Soum
        List<dom.XmlNode> results = new List<dom.XmlNode>();
        if ( responseXml != 'Invalid' ){
        	        doc.load(responseXml);   
		        	dom.XmlNode responsenode = doc.getRootElement().getChildElement('Body',soapNS)
		                    .getChildElement(responseType,serviceNS);  
		        if(responsenode == null){
		            throw new zApi_customException ('Server Exception: ' + responseXml);
		        }
		        for(dom.XmlNode result:responsenode.getChildElements()){
		            if('results' == result.getName()){
		                results.add(result);
		            }
		        }
        }
        /*       
        doc.load(responseXml);  
        dom.XmlNode responsenode = doc.getRootElement().getChildElement('Body',soapNS)
                    .getChildElement(responseType,serviceNS);  
        if(responsenode == null){
            throw new zApi_customException ('Server Exception: ' + responseXml);
        }
        List<dom.XmlNode> results = new List<dom.XmlNode>();
        for(dom.XmlNode result:responsenode.getChildElements()){
            if('results' == result.getName()){
                results.add(result);
            }
        } */
        
                  
        return results;                                     
    }
    
    public class LoginResult{
        public String Session;
        public String ServerUrl;
        private zobject_custom loginresult = new zobject_custom(zSchema_custom.Z_LOGIN_RESULT);
        
        public void loadResult(dom.XmlNode objnode){
            loginresult.loadXmlNode(objnode, serviceNS);
            this.Session = (String)loginresult.getValue('Session');
            this.ServerUrl = (String)loginresult.getValue('ServerUrl');
        }
    }
    public class SaveResult {
        public List<zobject_custom> Errors;
        public String Id;
        public Boolean Success;
        private zobject_custom saveresult = new zobject_custom(zSchema_custom.Z_SAVE_RESULT);
        
        public void loadResult(dom.XmlNode objnode){
            saveresult.loadXmlNode(objnode, serviceNS);
            List<Object> errorlist = saveresult.getArrayValue('Errors');
            if(errorlist != null){
                this.Errors = new List<zobject_custom>();
                for(Object error : errorlist){
                    this.Errors.add((zobject_custom)error);
                }
            }           
            this.Id = (String)saveresult.getValue('Id');
            this.Success = (Boolean)saveresult.getValue('Success');
        }
        
    }
    public class DeleteResult {
        public zobject_custom[] errors;
        public String id;
        public Boolean success;
        private zobject_custom deleteresult = new zobject_custom(zSchema_custom.Z_DELETE_RESULT);
        
        public void loadResult(dom.XmlNode objnode){
            deleteresult.loadXmlNode(objnode, serviceNS);
            List<Object> errorlist = deleteresult.getArrayValue('errors'); 
            if(errorlist != null){
                this.errors = new List<zobject_custom>();
                for(Object error : errorlist){
                    this.errors.add((zobject_custom)error);
                }
            }       
            this.Id = (String)deleteresult.getValue('id');
            this.Success = (Boolean)deleteresult.getValue('success');
        }        
    }
    
    public class InvoiceData {
         public zobject_custom Invoice;
         public zobject_custom[] InvoiceItems;
           
/* TBD: Needs to be corrected to include type attribute.
         public void toXml(dom.XmlNode reqnode){
                        
           if ( Invoice != null ) {
                Invoice.toXml(reqnode.addChildElement('Invoice',serviceNS,null),objNS,serviceNS);
            }
            for(zobject_custom invItm : InvoiceItem){
                            
                //reqnode.addChildElement('RatePlanData',serviceNS,null).addTextNode(String.valueOf(RatePlanData));
                
                invItm.toXml(reqnode.addChildElement('InvoiceItem',serviceNS,null),objNS,serviceNS);
            }
        }
        */
    }      
     
    public class SubscribeResult {
        public String AccountId;
        public String AccountNumber;
        public List<zobject_custom> Errors;
        public zApi_custom.InvoiceData InvoiceData;
        public String InvoiceId;
        public String InvoiceNumber;
        public String PaymentTransactionNumber;
        public String SubscriptionId;
        public String SubscriptionNumber;
        public Boolean Success;
        private zobject_custom subscriberesult = new zobject_custom(zSchema_custom.Z_SUB_RESULT);
        
        public void loadResult(dom.XmlNode objnode){
            this.subscriberesult.loadXmlNode(objnode, serviceNS);
            this.AccountId = (String)subscriberesult.getValue('AccountId');
            this.AccountNumber = (String)subscriberesult.getValue('AccountNumber');
            this.InvoiceData = (InvoiceData)subscriberesult.getValue('InvoiceData');
            List<Object> errorlist = subscriberesult.getArrayValue('Errors');
            if(errorlist != null){
                
                Errors = new List<zobject_custom>();
                
                for(Object error : errorlist){
                    this.Errors.add((zobject_custom)error);
                }
            }
            this.InvoiceId = (String)subscriberesult.getValue('InvoiceId');
            this.InvoiceNumber = (String)subscriberesult.getValue('InvoiceNumber');
            this.PaymentTransactionNumber = (String)subscriberesult.getValue('PaymentTransactionNumber');
            this.SubscriptionId = (String)subscriberesult.getValue('SubscriptionId');
            this.SubscriptionNumber = (String)subscriberesult.getValue('SubscriptionNumber');
            this.Success = (Boolean)subscriberesult.getValue('Success');
        }

        public zobject_custom getResult() {
            return subscriberesult;
        }
    }
    
    //add the class for fields are not in object namespace
    public class SubscribeOptions {
        public Boolean GenerateInvoice;
        public Boolean ProcessPayments;       
        
        public void toXml(dom.XmlNode objnode){
            objnode.addChildElement('GenerateInvoice',serviceNS,null).addTextNode(String.valueOf(GenerateInvoice)); 
            objnode.addChildElement('ProcessPayments',serviceNS,null).addTextNode(String.valueOf(ProcessPayments));  
        }
    
    }
    
    public class PreviewOptions {
        public Boolean EnablePreviewMode;
        public Integer NumberOfPeriods;       
        
        public void toXml(dom.XmlNode objnode){
            objnode.addChildElement('EnablePreviewMode',serviceNS,null).addTextNode(String.valueOf(EnablePreviewMode)); 
            objnode.addChildElement('NumberOfPeriods',serviceNS,null).addTextNode(String.valueOf(NumberOfPeriods));  
        }
    }
    
    
    
    
    //SubscribeRequest & SubscriptionData class for not alphabetical ordered field
    //only used for subscribe call out
    public class SubscriptionData {
        public zobject_custom Subscription;
        public zApi_custom.RatePlanData[] RatePlanData;
           
         public void toXml(dom.XmlNode reqnode){
                        
            if ( Subscription != null ) {
                dom.XmlNode tempnode = reqnode.addChildElement('Subscription',serviceNS,null);
                tempnode.setAttribute('xsi:type','obj:' + Subscription.getZtype());
                Subscription.toXml(tempnode,objNS,serviceNS);
            }
            for(zApi_custom.RatePlanData rpd : RatePlanData){
                            
                //reqnode.addChildElement('RatePlanData',serviceNS,null).addTextNode(String.valueOf(RatePlanData));
                
                rpd.toXml(reqnode.addChildElement('RatePlanData',serviceNS,null));
            }
                     
        }
    }      

    public class InvoiceProcessingOptions {
        public Datetime InvoiceTargetDate;
               
        //2009-07-03T08:07:55-07:00
        //2009-07-03T08:07:55-07:00
        //xml datetime --> 2001-10-26T21:32:52
        //'yyyy-MM-dd\'T\'HH:mm:ss\'-08:00\''
        public void toXml(dom.XmlNode objnode){
            objnode.addChildElement('InvoiceTargetDate',serviceNS,null).addTextNode(getFieldValueString(InvoiceTargetDate)); 
              //objnode.addChildElement('InvoiceTargetDate',serviceNS,null).addTextNode(String.valueOf('2009-07-03T08:07:55'));
              //objnode.addChildElement('InvoiceTargetDate',serviceNS,null);  
        }
        
        public String getFieldValueString(Object value) {
        String fieldvalue = '';
        if(value instanceof Datetime){
            fieldvalue = ((Datetime) value).format('yyyy-MM-dd\'T\'HH:mm:ss\'-08:00\'');
        }
        else{
            fieldvalue = String.valueOf(value);
        }
        return fieldvalue;
    }
    
    }
    
    
    public class AmendOptions {
        
        public zApi_custom.InvoiceProcessingOptions InvoiceProcessingOptions;       
        
        public void toXml(dom.XmlNode objnode){
            
            if(InvoiceProcessingOptions != null)
            {
                //objnode.addChildElement('InvoiceProcessingOptions',serviceNS,null).addTextNode(String.valueOf(InvoiceProcessingOptions)); 
                //RatePlanChargeData.toXml(reqnode.addChildElement('RatePlanChargeData',serviceNS,null));
                InvoiceProcessingOptions.toXml(objnode.addChildElement('InvoiceProcessingOptions',serviceNS,null));
            }
        }
    }
    
    public class RatePlanChargeData{
        public zobject_custom RatePlanCharge;
        public zobject_custom[] RatePlanChargeTier;
           
         public void toXml(dom.XmlNode reqnode){
                        
            if ( RatePlanCharge != null ) {
                dom.XmlNode tempnode = reqnode.addChildElement('RatePlanCharge',serviceNS,null);
                tempnode.setAttribute('xsi:type','obj:' + RatePlanCharge.getZtype());
                RatePlanCharge.toXml(tempnode,objNS,serviceNS);
            }
            if ( RatePlanChargeTier != null ) 
            {
               for(zobject_custom rtplnchrgtier : RatePlanChargeTier){
                            
                //reqnode.addChildElement('RatePlanData',serviceNS,null).addTextNode(String.valueOf(RatePlanData));
                
                dom.XmlNode tempnode = reqnode.addChildElement('RatePlanChargeTier',serviceNS,null);
                tempnode.setAttribute('xsi:type','obj:' + rtplnchrgtier.getZtype());
                rtplnchrgtier.toXml(tempnode,objNS,serviceNS);
            }
          }
        }       
    }
    
    public class RatePlanData{
        public zobject_custom RatePlan;
        public zApi_custom.RatePlanChargeData[] RatePlanChargeData;
           
         public void toXml(dom.XmlNode reqnode){
                        
            if ( RatePlan != null ) {
                dom.XmlNode tempnode = reqnode.addChildElement('RatePlan',serviceNS,null);
                tempnode.setAttribute('xsi:type','obj:' + RatePlan.getZtype());
                RatePlan.toXml(tempnode,objNS,serviceNS);
            }
            
           if ( RatePlanChargeData != null ) {
                   
            for(zApi_custom.RatePlanChargeData rtplnchgdt : RatePlanChargeData){
                            
                //reqnode.addChildElement('RatePlanData',serviceNS,null).addTextNode(String.valueOf(RatePlanData));
                
                rtplnchgdt.toXml(reqnode.addChildElement('RatePlanChargeData',serviceNS,null));
            }
           }
        }       
    }       
                
    public class AmendRequest{
        public zobject_custom[] Amendment;
        public zApi_custom.AmendOptions AmendOptions;
        public zApi_custom.PreviewOptions PreviewOptions;       
           
         public void toXml(dom.XmlNode reqnode){
                        
                      
            for(zobject_custom amndItm : Amendment){
                            
                //reqnode.addChildElement('RatePlanData',serviceNS,null).addTextNode(String.valueOf(RatePlanData));
                
                amndItm.toXml(reqnode.addChildElement('Amendments',serviceNS,''),objNS,serviceNS);
            }
            
            if ( AmendOptions != null ) {
                AmendOptions.toXml(reqnode.addChildElement('AmendOptions',serviceNS,null));
            }
           if ( PreviewOptions != null ) {
                PreviewOptions.toXml(reqnode.addChildElement('PreviewOptions',serviceNS,null));
            }
             
        }       
                
    }       
    
    /*
                <complexType name="AmendResult">
                    <sequence>
                        <element minOccurs="0" maxOccurs="unbounded" name="AmendmentIds" nillable="true" type="zns:ID" />
                        <element minOccurs="0" maxOccurs="unbounded" name="Errors" nillable="true" type="zns:Error" />
                        <element minOccurs="0" maxOccurs="unbounded" name="InvoiceDatas" nillable="true" type="zns:InvoiceData" />
                        <element minOccurs="0" maxOccurs="1" name="Success" type="boolean" />
                    </sequence>
                </complexType>
    
    */
    
    public class AmendResult{
        
        public List<String> AmendmentIds ;
        public List<zobject_custom> Errors;
        public boolean success;
        public zApi_custom.InvoiceData InvoiceDatas;
        private zobject_custom amendresult = new zobject_custom(zSchema_custom.Z_AMEND_RESULT);       
           
         public void loadResult(dom.XmlNode objnode){
            amendresult.loadXmlNode(objnode, serviceNS);
            
           /* List<String> amendmentlist = amendresult.getArrayValue('AmendmentId');
            if(amendmentlist != null){
                for(String amenetid : amendmentlist){
                    this.AmendmentIds.add(amenetid);
                }
            }*/
            
            List<Object> errorlist = amendresult.getArrayValue('Errors');
            if(errorlist != null){
                for(Object error : errorlist){
                    this.Errors.add((zobject_custom)error);
                }
            }
            
            this.Success = (Boolean)amendresult.getValue('Success');
            this.InvoiceDatas = (InvoiceData)amendresult.getValue('InvoiceDatas');
            
        }
      
    }           
    
    public class SubscribeRequest{
        public zobject_custom ZAccount;
        public zobject_custom PaymentMethod ;
        public zobject_custom BillToContact;
        public zApi_custom.PreviewOptions PreviewOptions;
        public zobject_custom SoldToContact;
        public zApi_custom.SubscribeOptions SubscribeOptions;
        public zApi_custom.SubscriptionData SubscriptionData;       
        
        public void toXml(dom.XmlNode reqnode){
            /*
            System.assert(ZAccount!= null && PaymentMethod!= null  && BillToContact!= null && SoldToContact!= null 
                && SubscribeOptions!= null && SubscriptionData!= null, 'Subscribe request has null value, call out failed.');
            */
            dom.XmlNode tnode = reqnode.addChildElement('Account',serviceNS,null);
            tnode.setAttribute('xsi:type','obj:' + ZAccount.getZtype());
            ZAccount.toXml(tnode,objNS,serviceNS);
            
            if ( PaymentMethod != null ) {
                dom.XmlNode tempnode = reqnode.addChildElement('PaymentMethod',serviceNS,null);
                tempnode.setAttribute('xsi:type','obj:' + PaymentMethod.getZtype());
                PaymentMethod.toXml(tempnode,objNS,serviceNS);
            }
            if ( BillToContact != null ) {
                dom.XmlNode tempnode = reqnode.addChildElement('BillToContact',serviceNS,null);
                tempnode.setAttribute('xsi:type','obj:' + BillToContact.getZtype());
                BillToContact.toXml(tempnode,objNS,serviceNS);
            }
            if ( PreviewOptions != null ) {
                PreviewOptions.toXml(reqnode.addChildElement('PreviewOptions',serviceNS,null));
            }     
            if ( SoldToContact != null ) {
                dom.XmlNode tempnode = reqnode.addChildElement('SoldToContact',serviceNS,null);
                tempnode.setAttribute('xsi:type','obj:' + SoldToContact.getZtype());
                SoldToContact.toXml(tempnode,objNS,serviceNS);
            }
            if ( SubscribeOptions != null ) {
                SubscribeOptions.toXml(reqnode.addChildElement('SubscribeOptions',serviceNS,null));
            }
                 
            SubscriptionData.toXml(reqnode.addChildElement('SubscriptionData',serviceNS,null));
        }
    }
 
    public class zApi_customException extends Exception{
        
    }
    
    public static TestMethod void testSubscribeResult(){       
        String responseXml = '<?xml version=\"1.0\" encoding=\"UTF-8\"?><soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"><soapenv:Body><ns1:subscribeResponse xmlns:ns1=\"http://api.zuora.com/\"><ns1:result><ns1:AccountId xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:nil=\"1\" /><ns1:AccountNumber xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:nil=\"1\" /><ns1:InvoiceData><ns1:Invoice xmlns:ns2=\"http://object.api.zuora.com/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:type=\"ns2:Invoice\"><ns2:AccountId>4028e6992dea3a85012df36dba060a6b</ns2:AccountId><ns2:Amount>90.00</ns2:Amount><ns2:AmountWithoutTax>90.00</ns2:AmountWithoutTax><ns2:TaxAmount>0.0</ns2:TaxAmount></ns1:Invoice><ns1:InvoiceItem xmlns:ns2=\"http://object.api.zuora.com/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:type=\"ns2:InvoiceItem\"><ns2:AccountingCode></ns2:AccountingCode><ns2:ChargeAmount>100.00</ns2:ChargeAmount><ns2:ChargeDate>2011-02-04T17:26:53.906-08:00</ns2:ChargeDate><ns2:ChargeDescription></ns2:ChargeDescription><ns2:ChargeName>To be discounted</ns2:ChargeName><ns2:ProductId>4028e6992bd5bcbd012c136b217325a6</ns2:ProductId><ns2:Quantity>1</ns2:Quantity><ns2:ServiceEndDate>2012-02-02T00:00:00.000-08:00</ns2:ServiceEndDate><ns2:ServiceStartDate>2011-02-03T00:00:00.000-08:00</ns2:ServiceStartDate><ns2:TaxAmount>0.0</ns2:TaxAmount><ns2:TaxExemptAmount>0.0</ns2:TaxExemptAmount><ns2:UnitPrice>100.000000000</ns2:UnitPrice><ns2:UOM></ns2:UOM></ns1:InvoiceItem><ns1:InvoiceItem xmlns:ns2=\"http://object.api.zuora.com/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:type=\"ns2:InvoiceItem\"><ns2:AccountingCode></ns2:AccountingCode><ns2:ChargeAmount>-10.00</ns2:ChargeAmount><ns2:ChargeDate>2011-02-04T17:26:53.940-08:00</ns2:ChargeDate><ns2:ChargeDescription></ns2:ChargeDescription><ns2:ChargeName>Test Discount</ns2:ChargeName><ns2:ProductId>4028e6992bd5bcbd012c136b217325a6</ns2:ProductId><ns2:Quantity>1.000000000</ns2:Quantity><ns2:ServiceEndDate>2012-02-02T00:00:00.000-08:00</ns2:ServiceEndDate><ns2:ServiceStartDate>2011-02-03T00:00:00.000-08:00</ns2:ServiceStartDate><ns2:TaxAmount>0.0</ns2:TaxAmount><ns2:TaxExemptAmount>0.0</ns2:TaxExemptAmount><ns2:UnitPrice>10.000000000</ns2:UnitPrice><ns2:UOM></ns2:UOM></ns1:InvoiceItem></ns1:InvoiceData><ns1:InvoiceId xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:nil=\"1\" /><ns1:InvoiceNumber xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:nil=\"1\" /><ns1:SubscriptionId xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:nil=\"1\" /><ns1:SubscriptionNumber xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:nil=\"1\" /><ns1:Success>true</ns1:Success></ns1:result></ns1:subscribeResponse></soapenv:Body></soapenv:Envelope>';
        System.debug('ZZZ Zuora zApi_custom.zsubscribe_0: subscribe response: ' + responseXml);
        List<dom.XmlNode> results = getResponseNode(responseXml,'subscribeResponse');
        List<zApi_custom.SubscribeResult> subscriberesults = new List<zApi_custom.SubscribeResult>();
        for(dom.XmlNode result: results){
            zApi_custom.SubscribeResult subscriberesult = new zApi_custom.SubscribeResult();   
            subscriberesult.loadResult(result);
            subscriberesults.add(subscriberesult);      
        }
        
        List<zApi_custom.SubscribeResult> resultList = subscriberesults;
        System.debug('chintanxxxxxx making call ');
        
        for(zApi_custom.SubscribeResult zobj : resultList)
        {
            System.debug('chintan ------SubResult------> =' + zobj);
            System.debug('chintanxxxxxx inside the subscribe result loop-->zobj.Success ' + zobj.Success);
           
          if(zobj.Success)
          {
             System.debug('chintanxxxxxx inside success Account id is = ' +  zobj.AccountID);
          
            zApi_custom.InvoiceData invdata = zobj.InvoiceData;
            System.debug('chintan ------Invoice------> =' + invdata.Invoice);
            
            zobject_custom invc = invdata.Invoice;
            System.debug('chintan ------Invoice------> =' + invc.getValueString('Amount'));

            for(zobject_custom invItem : invdata.InvoiceItems)
            {
                     System.debug('chintan ------InvoiceItem------> =' + invItem.getValueString('ChargeAmount'));
            }
          
          }
          else
          {
            //zobject_custom[] errs = zobj.Errors;
          
            //for(zobject_custom er : errs)
            //{
                //System.debug('chintan ------------>error =' + er.getValueString('error'));
            //}
            }
          }
    } 
    
    private static TestMethod void testme(){       
        zobject_custom rpcd = new zobject_custom(zSchema_custom.Z_RATEPLAN_CHARGE_DATA);     
        zobject_custom rpc = new zobject_custom(zSchema_custom.Z_RATEPLAN_CHARGE);
        //zobject_custom rpd = new zobject_custom(zSchema_custom.Z_RATEPLAN_DATA);
        zobject_custom rp = new  zobject_custom(zSchema_custom.Z_RATEPLAN);
        zobject_custom sub = new zobject_custom(zSchema_custom.Z_SUBSCRIPTION);      
        zobject_custom acc = new zobject_custom(zSchema_custom.Z_ACCOUNT);
        zobject_custom billto = new zobject_custom(zSchema_custom.Z_CONTACT);
        zobject_custom soldto = new zobject_custom(zSchema_custom.Z_CONTACT);
        zobject_custom pm = new zobject_custom(zSchema_custom.Z_PAYMENT_METHOD);
        
        zobject_custom im = new zobject_custom(zSchema_custom.Z_INVOICE_ITEM);
         
        zApi_custom.SubscriptionData sd = new zApi_custom.SubscriptionData();
        zApi_custom.SubscribeOptions so= new zApi_custom.SubscribeOptions();
        zApi_custom.SubscribeRequest sub_req = new zApi_custom.SubscribeRequest();
        
        //init rateplan charge
        rpc.setValue('ProductRatePlanChargeId', '4028e699261bcbd001262049d260159a');
        rpc.setValue('Price', 100.00);
        rpc.setValue('Quantity', 10.0);
                
        //assign rateplan charge to rateplan charge data array       
        rpcd.setValue('RatePlanCharge', rpc);
        
        //init a rateplan and assign to rateplan data
        //assign rateplan charge data as a list to rateplan data
        rp.setValue('ProductRatePlanId', '4028e699261bcbd001262047fe5e1598');
        //rpd.setValue('RatePlan', rp);
        //rpd.setValue('RatePlanChargeData', new List<zobject_custom>{rpcd});
        
        //init a subscription
        sub.setValue('Name', 'Api.subscribe() - SubscriptionName');
        sub.setValue('ContractEffectiveDate', '2010-03-09T02:47:06');
        sub.setValue('InitialTerm', 3);
        sub.setValue('RenewalTerm', 3);
        
        //assign subscription and rateplandata as a list to subscription data
        zApi_custom.RatePlanData[] rtpl = new zApi_custom.RatePlanData[1];
        zApi_custom.RatePlanData rtpln = new zApi_custom.RatePlanData();

        rtpl[0] = rtpln;
        
        
        sd.Subscription = sub;
        sd.RatePlanData = rtpl;
        
        //init an Account
        acc.setValue('Name', 'Api.subscribe() - Account Name');
        acc.setValue('CrmId','4028e69926587be3012658f8a9060087');
        acc.setValue('Currency','USD');
        acc.setValue('BillCycleDay',1);
        acc.setValue('PaymentTerm','Net 30');
        acc.setValue('Batch','Batch1');        
       
        //init billto
        billto.setValue('FirstName','bill to');
        billto.setValue('LastName','bt last');
        billto.setValue('WorkEmail', 'test@zuora.com');
        billto.setValue('Country','US');
        billto.setValue('State','CA');
       
        //init soldto
        soldto.setValue('FirstName', 'sold to');
        soldto.setValue('LastName', 'st last');
        soldto.setValue('WorkEmail', 'test2@zuora.com');
        soldto.setValue('Country', 'US');
        soldto.setValue('State','CA');
        
        //init subscription option
        so.GenerateInvoice = true;
        so.ProcessPayments = false;

        //init payment method
        pm.setValue('CreditCardAddress1', '52 Vexford Lane');
        pm.setValue('CreditCardAddress2', '');
        pm.setValue('CreditCardCity', 'Anaheim');
        pm.setValue('CreditCardCountry', 'United States');
        pm.setValue('CreditCardExpirationMonth', '03');
        pm.setValue('CreditCardExpirationYear', '2011');
        pm.setValue('CreditCardHolderName', 'Firstly Lastly');
        pm.setValue('CreditCardNumber', '4111111111111111');
        pm.setValue('CreditCardPostalCode', '22042');
        pm.setValue('CreditCardState', 'California');
        pm.setValue('CreditCardType', 'Visa');
        pm.setValue('Type','Credit Card');
        
         im.setValue('fieldsToNull','None');
         im.setValue('AccountingCode','ASSF');
         im.setValue('ChargeAmount','33.44');
         im.setValue('ChargeDate','2/13/2012');
         im.setValue('ChargeDescription','None');
         
       
        //assign all the object to subscribe request
        sub_req.ZAccount = acc;
        sub_req.BillToContact = billto;
        sub_req.SoldToContact = soldto;
        sub_req.SubscribeOptions = so;
        sub_req.SubscriptionData = sd;
        sub_req.PaymentMethod = pm; 
          
         
        zApi_custom api = new zApi_custom();  
        api.setEndpoint('endpoint');
        api.setSessionId('sessionid');
        api.genSubscribeRequest(new List<SubscribeRequest> {sub_req}); 
        api.genLoginRequest('username', 'password');
        api.genCUDRequest('create', new List<zobject_custom>{acc});
        api.genCUDRequest('update', new List<zobject_custom>{acc});
        acc.setValue('Id','4028e69926e9852f0126ead18246043f');
        api.genCUDRequest('delete', new List<zobject_custom>{acc});
        api.genQueryRequest('SELECT Id,Name,CrmId,BillToId,SoldToId,Batch,Status,PaymentTerm,Currency from Account Where ID =\'4028e69926e9852f0126ead18246043f\'');
        api.getsoapenv(true);
        
        zApi_custom.SubscribeResult subres = new zApi_custom.SubscribeResult();      
        zApi_custom.LoginResult logres = new zApi_custom.LoginResult();
        zApi_custom.DeleteResult delres = new zApi_custom.DeleteResult();
        zApi_custom.SaveResult saveres = new zApi_custom.SaveResult();
        
        String responsexml = '<?xml version=\'1.0\' encoding=\'UTF-8\'?><soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">'
                              +'<soapenv:Body><ns1:subscribeResponse xmlns:ns1="http://api.zuora.com/"><ns1:result>'
                              +'<ns1:AccountId xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:nil="1" />'
                             + '<ns1:AccountNumber xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:nil="1" /><ns1:Errors>'
                             +'<ns1:Code>INVALID_VALUE</ns1:Code><ns1:Message>CyberSource gateway can not support ACH payment method</ns1:Message>'
                             +'</ns1:Errors><ns1:InvoiceId xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:nil="1" />'
                             +'<ns1:InvoiceNumber xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:nil="1" />'
                             +'<ns1:SubscriptionId xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:nil="1" />'
                             +'<ns1:SubscriptionNumber xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:nil="1" /><ns1:Success>false</ns1:Success>'
                             +'</ns1:result></ns1:subscribeResponse></soapenv:Body></soapenv:Envelope>';
        
        List<dom.XmlNode> responsenode = zApi_custom.getResponseNode(responsexml,'subscribeResponse');
        logres.loadResult(responsenode[0]);
        saveres.loadResult(responsenode[0]);
        subres.loadResult(responsenode[0]);
        responsexml = '<?xml version=\'1.0\' encoding=\'UTF-8\'?><soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">'
                              +'<soapenv:Body><ns1:subscribeResponse xmlns:ns1="http://api.zuora.com/"><ns1:result>'
                              +'<ns1:AccountId xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:nil="1" />'
                             + '<ns1:AccountNumber xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:nil="1" /><ns1:errors>'
                             +'<ns1:Code>INVALID_VALUE</ns1:Code><ns1:Message>CyberSource gateway can not support ACH payment method</ns1:Message>'
                             +'</ns1:errors><ns1:InvoiceId xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:nil="1" />'
                             +'<ns1:InvoiceNumber xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:nil="1" />'
                             +'<ns1:SubscriptionId xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:nil="1" />'
                             +'<ns1:SubscriptionNumber xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:nil="1" /><ns1:Success>false</ns1:Success>'
                             +'</ns1:result></ns1:subscribeResponse></soapenv:Body></soapenv:Envelope>';
        responsenode = zApi_custom.getResponseNode(responsexml,'subscribeResponse');
        
        responsexml ='<?xml version=\'1.0\' encoding=\'UTF-8\'?><soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">' 
                     + '<soapenv:Body><ns1:queryResponse xmlns:ns1="http://api.zuora.com/"><ns1:result><ns1:done>true</ns1:done>' 
                     + '<ns1:queryLocator xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:nil="1" />' 
                     + '<ns1:records xmlns:ns2="http://object.api.zuora.com/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="ns2:Account">'
                     + '<ns2:Id>4028e6992745e8af012746e8096d0042</ns2:Id><ns2:Batch>Batch1</ns2:Batch><ns2:CrmId>4028e69926587be3012658f8a9060087</ns2:CrmId>'
                     + '<ns2:Currency>USD</ns2:Currency><ns2:Name>Apex api.zcreate()</ns2:Name><ns2:PaymentTerm>Net 30</ns2:PaymentTerm>'
                     + '<ns2:Status>Draft</ns2:Status></ns1:records><ns1:size>1</ns1:size></ns1:result></ns1:queryResponse></soapenv:Body></soapenv:Envelope>';
        api.parseQueryResponse(responsexml);
        delres.loadResult(responsenode[0]);        
        zSchema_custom.isSupportedzType('test');

        try {
            api.zsubscribe(new List<SubscribeRequest> {sub_req});
        }
        catch (Exception e) {
            System.debug('e: ' + e);
        }

        try {
            api.zlogin('test', 'testing');
        }
        catch (Exception e) {
            System.debug('e: ' + e);
        }

        try {
            api.zcreate(new List<zobject_custom> {new zobject_custom(zSchema_custom.Z_ACCOUNT)},true);
        }
        catch (Exception e) {
            System.debug('e: ' + e);
        }

        try {
            api.zupdate(new List<zobject_custom> {new zobject_custom(zSchema_custom.Z_ACCOUNT)});
        }
        catch (Exception e) {
            System.debug('e: ' + e);
        }

        try {
            api.zdelete(zSchema_custom.Z_ACCOUNT, new String[]{'xxxxxxx'});
        }
        catch (Exception e) {
            System.debug('e: ' + e);
        }

        try {
            api.zquery('select Id from Account');
        }
        catch (Exception e) {
            System.debug('e: ' + e);
        }
        //--Soum
        zApi_custom ztest = new zApi_custom();
        zApi_custom.AmendResult apiAR = new zApi_custom.AmendResult();
        DOM.Document doc = new DOM.Document();
		String soapNS1 = 'http://schemas.xmlsoap.org/soap/envelope/'; 
		String xsi1 = 'http://www.w3.org/2001/XMLSchema-instance'; 
		String serviceNS1 = 'http://www.myservice.com/services/MyService/';
		dom.XmlNode envelope = doc.createRootElement('Envelope', soapNS1, 'soapenv');
		envelope.setNamespace('xsi', xsi1); 
		envelope.setAttributeNS('schemaLocation', soapNS1, xsi1, null);
		dom.XmlNode body = envelope.addChildElement('Body', soapNS1, null);
		body.addChildElement('echo', serviceNS1, 'req').addChildElement('category', serviceNS1, null). addTextNode('classifieds');
        apiAR.loadResult(body);
        GenerateRequest gr = new GenerateRequest();
        
        zobject_custom zcapi = new zobject_custom(zSchema_custom.Z_AMENDMENT);
        zcapi.setValue('Id','4028e69926e9852f0126ead18246043f');
        
        gr.zObjectarr = new List<zobject_custom>();
        gr.zObjectarr.add(zcapi);
        gr.toXml(body);
        
        
        zApi_custom.AmendRequest apiARe = new zApi_custom.AmendRequest();
        apiARe.Amendment= new List<zobject_custom>();
         apiARe.Amendment.add(zcapi);
        apiARe.toXml(body);
        
        
        List<zApi_custom.AmendRequest> testList = new List<zApi_custom.AmendRequest>();
        testList.add(apiARe );
        ztest.setSessionId('asdsadasd');
        ztest.setEndpoint('Invalid');
        ztest.zamend(testList);
        
        List<zobject_custom> ListZObj = new List<zobject_custom>();
        ListZObj.add(rpcd);
        ztest.zgenerate(ListZObj);
        
       zApi_custom.PreviewOptions preView = new zApi_custom.PreviewOptions();
       preView.EnablePreviewMode = true;
       preView.NumberOfPeriods =3;
       preView.toXml(body);
       
      
    }   
     
    
    
    
    
    
    
    
    
    
}