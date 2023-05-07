<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <sch:ns prefix="f" uri="http://hl7.org/fhir"/>
  <sch:ns prefix="h" uri="http://www.w3.org/1999/xhtml"/>
  <!-- 
    This file contains just the constraints for the profile RequestGroup
    It includes the base constraints for the resource as well.
    Because of the way that schematrons and containment work, 
    you may need to use this schematron fragment to build a, 
    single schematron that validates contained resources (if you have any) 
  -->
  <sch:pattern>
    <sch:title>f:RequestGroup</sch:title>
    <sch:rule context="f:RequestGroup">
      <sch:assert test="count(f:extension[@url = 'http://spms.min-saude.pt/iop/extensions/prescription-duplicate']) &lt;= 1">extension with URL = 'http://spms.min-saude.pt/iop/extensions/prescription-duplicate': maximum cardinality of 'extension' is 1</sch:assert>
      <sch:assert test="count(f:extension[@url = 'http://spms.min-saude/pe/top/extensions/med-request-modality']) &lt;= 1">extension with URL = 'http://spms.min-saude/pe/top/extensions/med-request-modality': maximum cardinality of 'extension' is 1</sch:assert>
      <sch:assert test="count(f:groupIdentifier) &gt;= 1">groupIdentifier: minimum cardinality of 'groupIdentifier' is 1</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern>
    <sch:title>f:RequestGroup/f:meta</sch:title>
    <sch:rule context="f:RequestGroup/f:meta">
      <sch:assert test="count(f:id) &lt;= 1">id: maximum cardinality of 'id' is 1</sch:assert>
      <sch:assert test="count(f:versionId) &lt;= 1">versionId: maximum cardinality of 'versionId' is 1</sch:assert>
      <sch:assert test="count(f:lastUpdated) &lt;= 1">lastUpdated: maximum cardinality of 'lastUpdated' is 1</sch:assert>
    </sch:rule>
  </sch:pattern>
</sch:schema>
