

#'@title Grab all scan sites with certain parameter
#'
#'@param elementCd SCAN element code (see \code{\link{scan_elements}} for full list of codes)
#'
#'@return A list of site triplets as character strings
#'
#'@examples
#'sites_vec = scan_sites_by_element_code('SMS')
#'
#'@export
scan_sites_by_element_code = function(elementCd){
	
	root = newXMLNode("soap:Envelope", namespaceDefinitions=c("soap"="http://schemas.xmlsoap.org/soap/envelope/", "xsd"="http://www.w3.org/2001/XMLSchema"))
	
	body = newXMLNode("soap:Body", parent=root)
	
	cmd = newXMLNode("tns:getStations", namespaceDefinitions=c("tns"="http://www.wcc.nrcs.usda.gov/ns/awdbWebService"), parent=body)
	
	newXMLNode("elementCds", elementCd, parent=cmd)
	newXMLNode("ordinals", 1, parent=cmd)
	newXMLNode("logicalAnd", "false", parent=cmd)
	
	out = POST(service_url, content_type("text/soap_xml; charset-utf-8"), body=toString.XMLNode(root))
	sites = xpathSApply(content(out), '//return', xmlValue)
	return(sites)
}

