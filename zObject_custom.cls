//Generic zObject support for Apex call out
// TODO:
// - Need to enforce type checking when a value is set.
public class zobject_custom{
    
    private String ztype;
    //primtive field name/value
    private Map<String,Object> fields = new Map<String,Object>();
    //array field name/value
    private Map<String,Object[]> arrayfields = new Map<String,Object[]>();
            
    public zobject_custom(String ztype){
        this.ztype = ztype;
    }
    
    //set the value into fields
    public void setValue(String fieldname, Object value){
        this.setValue_0(fieldname,value);           
    }    
    private void setValue_0(String fieldname, Object value){
        System.assert(fieldname != null, 'Can not set value to null field.');
        String fieldtype = this.getFieldDescribe(fieldname)[0].toLowerCase();
        if(fieldname.length() <= 0) {
            return;
        }
        if (value == null) {
            this.fields.put(fieldname,value);   
            return;
        }
/*
        if('boolean' == fieldtype){
            System.assert(value instanceof Boolean, 'Field ' + fieldname + ' value is not a boolean.');
        }
        else if('double' == fieldtype){
            System.assert(value instanceof Double, 'Field ' + fieldname + ' value is not a double.');
        }
        else if('int' == fieldtype){
            System.assert(value instanceof Integer, 'Field ' + fieldname + ' value is not an integer.');
        }
        else if('long' == fieldtype){
            System.assert(value instanceof Long, 'Field ' + fieldname + ' value is not a long.');
        }
        else if('datetime' == fieldtype){
            System.assert(value instanceof Datetime, 'Field ' + fieldname + ' value is not a datetime.');
        }
        else if('zobject' == fieldtype){
            System.assert(value instanceof zObject, 'Field ' + fieldname + ' value is not a zObject.');
        }
        else if ('xobject' == fieldtype){
        }
*/
        this.fields.put(fieldname,value);
    }    
    //set the value into arrayfields
    public void setValue(String fieldname, Object[] value){
        this.setArrayValue_0(fieldname,value);           
    }    
    private void setArrayValue_0(String fieldname, Object[] value){
        System.assert(fieldname != null && zSchema_custom.getschema(this.ztype).get(fieldname)!= null, 'Can not set value to null arrayfield.');          
        this.arrayfields.put(fieldname,value);   
    }
    //return the value of a field
    public Object getValue(String fieldname){
        return this.getValue_0(fieldname);          
    }
    public String getValueString(String fieldname){
        return getFieldValueString(this.getValue_0(fieldname));          
    }
    private Object getValue_0(String fieldname){
        System.assert(this.fields != null, 'Can not getValue from a zObject without any value in fields.');
        return this.fields.get(fieldname);
    }    
    
    public Object[] getArrayValue(String fieldname){
        return this.getArrayValue_0(fieldname);
    }
    private Object[] getArrayValue_0(String fieldname){
        System.assert(this.arrayfields != null, 'Can not getArrayValue from a zObject without any value in arrayfields.');
        return this.arrayfields.get(fieldname);
    }   
    
    public String getZtype(){
        return this.ztype;
    }
    
    public void toXml(dom.XmlNode objnode, String objNS, String serviceNS){           
        this.toXml_0(objnode, objNS, serviceNS);           
    }
    
    private void toXml_0(dom.XmlNode objnode, String objNS, String serviceNS){
        System.assert(zSchema_custom.isSupportedzType(this.ztype) != null, 'Can not convert zObject to xml; ztype not supported.');
        Set<String> fieldkeyset = zSchema_custom.getschema(this.ztype).keySet();
        
        List<String> fieldnames = new List<String>();
        fieldnames.addAll(fieldkeyset);
        // order fieldnames 
        orderFieldNames(fieldnames);
        
        for(String fieldname:fieldnames){
            if(this.isArray(fieldname)){
                Object[] fieldvalues = this.arrayfields.get(fieldname);
                if(fieldvalues != null){
                    for(Object value:fieldvalues){
                        //parse nested class into child element
                        if(iszobject(fieldname)){
                            zobject_custom zobj = (zobject_custom)value;
                            zobj.toXml(objnode.addChildElement(fieldname,serviceNS,null),objNS,serviceNS);
                        }
                        //convert to String and add to child element
                        else {                     
                            objnode.addChildElement(fieldname,objNS,null).addTextNode(getFieldValueString(value));  
                        }
                    }
                }
            }
            else{
                Object fieldvalue = this.fields.get(fieldname);             
                if(fieldvalue != null){
                    //parse nested class into child element
                    if(fieldvalue instanceof zobject_custom){
                        zobject_custom zobj = (zobject_custom)fieldvalue;
                        zobj.toXml(objnode.addChildElement(fieldname,serviceNS,null),objNS,serviceNS);
                    }
                    //exceptions
                    
                    else if(fieldvalue instanceof zApi_custom.RatePlanData){
                    	zApi_custom.RatePlanData xobj = (zApi_custom.RatePlanData)fieldvalue;
                        xobj.toXml(objnode.addChildElement(fieldname,objNS,null));
                    }
                    else if(fieldvalue instanceof zApi_custom.RatePlanChargeData){
                    	zApi_custom.RatePlanChargeData xobj = (zApi_custom.RatePlanChargeData)fieldvalue;
                        xobj.toXml(objnode.addChildElement(fieldname,serviceNS,null));
                    }
                    //convert to String and add to child element
                    else {                     
                        objnode.addChildElement(fieldname,objNS,null).addTextNode(getFieldValueString(fieldvalue));
                    }
                }
            }
        } 
    }   
    
    //Always make Id/fieldToNull first if they exist 
    //Others in alphabetical order
    private void orderFieldNames (List<String> fieldnames){
        if(fieldnames == null || fieldnames.size() <2)
            return;
        fieldnames.sort();
        for(Integer i =0; i< fieldnames.size(); i++){
            if('Id' == fieldnames[i]) {
                String field = fieldnames[0];
                fieldnames[0] = 'Id';
                fieldnames[i] = field; 
            }
            if('fieldsToNull' == fieldnames[i]) {
                String field = fieldnames[1];
                fieldnames[1] = 'fieldsToNull';
                fieldnames[i] = field; 
            }
        }       
    }         
    
    
    //query response result node is based on object namespace parsing
    public static zobject_custom loadQueryResult(dom.XmlNode objnode, String objNS, String xsiNS){           
        String ztype = objnode.getAttributeValue('type',xsiNS);
        System.assert(ztype != null, 'Can not parse null ztype to zObject.');
        zobject_custom zobj = new zobject_custom(ztype);        
        System.assert(zSchema_custom.isSupportedzType(ztype), 'Can not parse to a zObject; ztype not supported.');
        zobj.loadXmlNode(objnode, objNS);
        return zobj;  
    }
    
    //other api call result node is based on api namespace parsing
    public void loadXmlNode(dom.XmlNode objnode, String nodeNS){ 
        this.node2Object_0(objnode, nodeNS);
    }    
    private void node2Object_0(dom.XmlNode objnode, String objNS){            
        Set<String> fieldnames = zSchema_custom.getschema(this.ztype).keySet();
        for(String fieldname:fieldnames){ 
            String fieldtype = this.getFieldDescribe(fieldname)[0];
            System.debug('looking for fieldname ' + fieldname + ', with fieldtype ' + fieldtype + ', in ' + objnode);
            if(isArray(fieldname)){
                List <Object> arrayfieldvalue = new List <Object>();
                if(fieldtype != null && objnode.getChildElement(fieldname,objNS)!= null){
                    List<dom.XmlNode> fieldnodes = this.getChildrenByName(objnode,fieldname);
                    for(dom.XmlNode fieldnode: fieldnodes){
                        arrayfieldvalue.add(getFieldValueFromNode(fieldnode,fieldname,objNS,fieldtype));
                    }
                    this.setValue(fieldname,arrayfieldvalue);
                }
            }
            else{
                dom.XmlNode childnode = objnode.getChildElement(fieldname,objNS);
                if(fieldtype != null && childnode!= null){
                    Object fieldvalue = getFieldValueFromNode(childnode,fieldname,objNS,fieldtype);
                	System.debug('found field name ' + fieldname + ' and loaded value: ' + fieldvalue);
                    this.setValue(fieldname,fieldvalue);                
                }
            }
        }
    }    
    private List<dom.XmlNode> getChildrenByName(dom.XmlNode objnode, String fieldname){
        List<dom.XmlNode> namechildren = new List<dom.XmlNode>();
        for(dom.XmlNode child : objnode.getChildElements()){
            if(fieldname == child.getName()) {
                namechildren.add(child);
            }   
        }
        return namechildren;
    }    
    private Object getFieldValueFromNode(dom.XmlNode objnode,String fieldname,String objNS,String fieldtype){
        Object fieldvalue;
        System.debug('fieldname: ' + fieldname + ', fieldtype: ' + fieldtype);
        if('zobject_custom' == fieldtype.toLowerCase()){
            zobject_custom childobj = new zobject_custom(getzobjectFieldzType(fieldname));        
            System.assert(zSchema_custom.isSupportedzType(childobj.getZtype()), 'Cannot parse ' + childobj.getZtype() + ' to a zObject. Please add it to the supported ztypes.');
            childobj.loadXmlNode(objnode,objNS);
            if (fieldname == 'Errors') {
                System.debug('ZZZ ************** Code: ' + childobj.getValue('Code'));
            }
            fieldvalue = childobj;
        }
         else if('invoicedatas' == fieldtype.toLowerCase()){
        	zApi_custom.InvoiceData idata = new zApi_custom.InvoiceData();
        	idata.InvoiceItems = new List<zobject_custom>();
            List<dom.XmlNode> fieldnodes = this.getChildrenByName(objnode,zSchema_custom.Z_INVOICE);
            System.debug('fieldnodes are: ' + fieldnodes);
            if (fieldnodes.size() > 0) {
            	System.debug('loading the following XML: ' + fieldnodes[0] + ', children: ' + ((dom.XmlNode)fieldnodes[0]).getChildElements());
            	System.debug('find Amount in ns: ' + objNS + ', result: ' + ((dom.XmlNode)fieldnodes[0]).getChildElement('Amount',objNS));
	            zobject_custom childobj = new zobject_custom(zSchema_custom.Z_INVOICE);
	            childobj.loadXmlNode(fieldnodes[0],zApi_custom.objNS);
	            System.debug('parsed zobject is: ' + childobj);
	            idata.Invoice = childobj;
            }

            fieldnodes = this.getChildrenByName(objnode,zSchema_custom.Z_INVOICE_ITEM);
            System.debug('fieldnodes are: ' + fieldnodes);
	        for(dom.XmlNode child : fieldnodes){
            	System.debug('loading the following XML: ' + child + ', children: ' + child.getChildElements());
	            zobject_custom childobj = new zobject_custom(zSchema_custom.Z_INVOICE_ITEM);
	            childobj.loadXmlNode(child,zApi_custom.objNS);
	            System.debug('parsed zobject is: ' + childobj);
	            idata.InvoiceItems.add(childobj);
        	}
            fieldvalue = idata;
        }
        else if('invoicedata' == fieldtype.toLowerCase()){
        	zApi_custom.InvoiceData idata = new zApi_custom.InvoiceData();
        	idata.InvoiceItems = new List<zobject_custom>();
            List<dom.XmlNode> fieldnodes = this.getChildrenByName(objnode,zSchema_custom.Z_INVOICE);
            System.debug('fieldnodes are: ' + fieldnodes);
            if (fieldnodes.size() > 0) {
            	System.debug('loading the following XML: ' + fieldnodes[0] + ', children: ' + ((dom.XmlNode)fieldnodes[0]).getChildElements());
            	System.debug('find Amount in ns: ' + objNS + ', result: ' + ((dom.XmlNode)fieldnodes[0]).getChildElement('Amount',objNS));
	            zobject_custom childobj = new zobject_custom(zSchema_custom.Z_INVOICE);
	            childobj.loadXmlNode(fieldnodes[0],zApi_custom.objNS);
	            System.debug('parsed zobject is: ' + childobj);
	            idata.Invoice = childobj;
            }

            fieldnodes = this.getChildrenByName(objnode,zSchema_custom.Z_INVOICE_ITEM);
            System.debug('fieldnodes are: ' + fieldnodes);
	        for(dom.XmlNode child : fieldnodes){
            	System.debug('loading the following XML: ' + child + ', children: ' + child.getChildElements());
	            zobject_custom childobj = new zobject_custom(zSchema_custom.Z_INVOICE_ITEM);
	            childobj.loadXmlNode(child,zApi_custom.objNS);
	            System.debug('parsed zobject is: ' + childobj);
	            idata.InvoiceItems.add(childobj);
        	}
            fieldvalue = idata;
        }
        else {
            String fieldstring = objnode.getText();
            if(fieldstring.length() <= 0) {
                return null;
            }
            fieldvalue = getFieldValue(fieldstring,fieldtype);
        }
        System.debug('fieldvalue is: ' + fieldvalue);
        return fieldvalue;
    }

    private Object getFieldValue(String fieldstring, String fieldtype) {
        Object fieldvalue;
        if(fieldstring.length() <= 0) {
            return null;
        }
        fieldtype = fieldtype.toLowerCase();
        if('boolean' == fieldtype){
            fieldvalue = ('true' == fieldstring.toLowerCase());
        }
        else if('double' == fieldtype){
            fieldvalue = Double.valueOf(fieldstring);
        }
        else if('int' == fieldtype){
            fieldvalue = Integer.valueOf(fieldstring);
        }
        else if('long' == fieldtype){
            fieldvalue = Long.valueOf(fieldstring);
        }
        else if('datetime' == fieldtype){
            fieldvalue = DateTime.valueOf(fieldstring.replace('T', ' '));
        }
        else{
            fieldvalue = fieldstring;
        }
        return fieldvalue;
    }

    private String getFieldValueString(Object value) {
        String fieldvalue = '';
        if(value instanceof Datetime){
            fieldvalue = ((Datetime) value).format('yyyy-MM-dd\'T\'HH:mm:ss\'-08:00\'');
        }
        else{
            fieldvalue = String.valueOf(value);
        }
        return fieldvalue;
    }
    
    private Boolean isArray(String fieldname){
        return '-1' == getFieldDescribe(fieldname)[1];
    }
    private Boolean iszobject(String fieldname){
        return 'zobject' == getFieldDescribe(fieldname)[0];
    }
    private String getzobjectFieldzType(String fieldname){
        String[] fielddesc = getFieldDescribe(fieldname);
        if(3 == fielddesc.size())
            return fielddesc[2];
        else
            return null; 
    }
    
    private String[] getFieldDescribe(String fieldname){
        System.assert(zSchema_custom.isSupportedzType(this.ztype), 'Attempted to get a field description from an unsupported schema.');
        String fielddesc = zSchema_custom.getschema(this.ztype).get(fieldname);
        System.assert(fielddesc != null, 'Fieldname ' + fieldname + ' does not exist for zobject ' + this.ztype);
        return fielddesc.split(',');                
    }
    
    public class ObjectException extends Exception{
        
    }   
}