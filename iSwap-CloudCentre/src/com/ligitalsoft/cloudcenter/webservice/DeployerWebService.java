package com.ligitalsoft.cloudcenter.webservice;

import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebService;
import javax.xml.bind.annotation.XmlSeeAlso;
import javax.xml.ws.RequestWrapper;
import javax.xml.ws.ResponseWrapper;

/**
 * This class was generated by Apache CXF 2.2.10
 * Mon Jun 20 16:57:42 CST 2011
 * Generated source version: 2.2.10
 * 
 */
 
@WebService(targetNamespace = "http://webservice.cloudcenter.ligitalsoft.com/", name = "DeployerWebService")
@XmlSeeAlso({ObjectFactory.class})
public interface DeployerWebService {

    @RequestWrapper(localName = "deploy", targetNamespace = "http://webservice.cloudcenter.ligitalsoft.com/", className = "com.ligitalsoft.cloudcenter.webservice.Deploy")
    @WebMethod
    @ResponseWrapper(localName = "deployResponse", targetNamespace = "http://webservice.cloudcenter.ligitalsoft.com/", className = "com.ligitalsoft.cloudcenter.webservice.DeployResponse")
    public void deploy(
        @WebParam(name = "arg0", targetNamespace = "")
        java.lang.String arg0
    );

    @RequestWrapper(localName = "undeploy", targetNamespace = "http://webservice.cloudcenter.ligitalsoft.com/", className = "com.ligitalsoft.cloudcenter.webservice.Undeploy")
    @WebMethod
    @ResponseWrapper(localName = "undeployResponse", targetNamespace = "http://webservice.cloudcenter.ligitalsoft.com/", className = "com.ligitalsoft.cloudcenter.webservice.UndeployResponse")
    public void undeploy(
        @WebParam(name = "arg0", targetNamespace = "")
        java.lang.String arg0
    );
}
