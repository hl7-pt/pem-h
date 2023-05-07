<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <sch:ns prefix="f" uri="http://hl7.org/fhir"/>
  <sch:ns prefix="h" uri="http://www.w3.org/1999/xhtml"/>
  <!-- 
    This file contains just the constraints for the profile Bundle
    It includes the base constraints for the resource as well.
    Because of the way that schematrons and containment work, 
    you may need to use this schematron fragment to build a, 
    single schematron that validates contained resources (if you have any) 
  -->
  <sch:pattern>
    <sch:title>f:Bundle</sch:title>
    <sch:rule context="f:Bundle">
      <sch:assert test="count(f:id) &gt;= 1">id: minimum cardinality of 'id' is 1</sch:assert>
      <sch:assert test="count(f:signature) &gt;= 1">signature: minimum cardinality of 'signature' is 1</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern>
    <sch:title>f:Bundle/f:meta</sch:title>
    <sch:rule context="f:Bundle/f:meta">
      <sch:assert test="count(f:id) &lt;= 1">id: maximum cardinality of 'id' is 1</sch:assert>
      <sch:assert test="count(f:versionId) &lt;= 1">versionId: maximum cardinality of 'versionId' is 1</sch:assert>
      <sch:assert test="count(f:lastUpdated) &lt;= 1">lastUpdated: maximum cardinality of 'lastUpdated' is 1</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern>
    <sch:title>f:Bundle/f:signature</sch:title>
    <sch:rule context="f:Bundle/f:signature">
      <sch:assert test="count(f:id) &lt;= 1">id: maximum cardinality of 'id' is 1</sch:assert>
      <sch:assert test="count(f:type) &gt;= 1">type: minimum cardinality of 'type' is 1</sch:assert>
      <sch:assert test="count(f:when) &gt;= 1">when: minimum cardinality of 'when' is 1</sch:assert>
      <sch:assert test="count(f:when) &lt;= 1">when: maximum cardinality of 'when' is 1</sch:assert>
      <sch:assert test="count(f:onBehalfOf[x]) &lt;= 1">onBehalfOf[x]: maximum cardinality of 'onBehalfOf[x]' is 1</sch:assert>
      <sch:assert test="count(f:contentType) &lt;= 1">contentType: maximum cardinality of 'contentType' is 1</sch:assert>
      <sch:assert test="count(f:blob) &lt;= 1">blob: maximum cardinality of 'blob' is 1</sch:assert>
    </sch:rule>
  </sch:pattern>
</sch:schema>
