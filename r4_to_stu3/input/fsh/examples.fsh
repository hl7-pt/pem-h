
// @Name: Instance Example
// @Description: An example of an instance of a Patient resource

Instance: ExemploMessage
InstanceOf: PEMHbundleRquest
Description: "Exemplo 1 - Nova prescrição de medicação - Bundle"

* id = "7898e419-6983-4afc-8163-a19274a12290"
* meta.lastUpdated =  "2019-10-10T23:10:23+00:00"
* meta.profile = "http://spms.min-saude.pt/fhir/iop/profiles/med-prescription-synchronization/v1-0-3"
* type = #message
* entry[0].resource = ExemploMSH
* entry[0].fullUrl = "http://spms.min-saude.pt/fhir/MessageHeader/db6428bf-1e58-48d4-9102-b85d6c716bb1"

* entry[+].resource = ExemploRequestGroup
* entry[=].fullUrl =  "http://spms.min-saude.pt/fhir/RequestGroup/25f1ea48-e0ef-405e-86fc-498ae907f6df"
* entry[+].resource = ExemploMedicationRequest
* entry[=].fullUrl =  "http://spms.min-saude.pt/fhir/MedicationRequest/e22942f3-a461-40b9-8449-30f7a7e9d0d5"
* entry[+].resource = ExemploMedication
* entry[=].fullUrl =  "http://spms.min-saude.pt/fhir/Medication/a87cddf3-01de-4241-b9b2-7209f5f2bcab"
* entry[+].resource = ExemploPatient
* entry[=].fullUrl =  "http://spms.min-saude.pt/fhir/Patient/3616b380-01be-465a-aa29-906337c6e7a4"

* entry[+].resource = ExemploPractitioner
* entry[=].fullUrl =  "http://spms.min-saude.pt/fhir/Practitioner/f644ab44-7e32-4e05-972c-1f14bebf27a8"

* entry[+].resource = ExemploOrganization2
* entry[=].fullUrl =  "http://spms.min-saude.pt/fhir/Patient/3616b380-01be-465a-aa29-906337c6e7a4"

* entry[+].resource = ExemploOrganization1
* entry[=].fullUrl =  "http://spms.min-saude.pt/fhir/Patient/3616b380-01be-465a-aa29-906337c6e7a4"

* entry[+].resource = ExemploLocation
* entry[=].fullUrl =  "http://spms.min-saude.pt/fhir/Patient/3616b380-01be-465a-aa29-906337c6e7a4"

* entry[+].resource = ExemploCoverage
* entry[=].fullUrl =  "http://spms.min-saude.pt/fhir/Patient/3616b380-01be-465a-aa29-906337c6e7a4"

* entry[+].resource = ExemploEncounter
* entry[=].fullUrl =  "http://spms.min-saude.pt/fhir/Patient/3616b380-01be-465a-aa29-906337c6e7a4"

* signature.type = urn:iso-astm:E1762-95:2013#1.2.840.10065.1.12.1.1 "Author's Signature"
* signature.when = "2019-10-10T23:10:23+00:00"
* signature.who = Reference(ExemploPractitioner) //difference stu3 <-> R4
* signature.sigFormat = #application/signature+xml //difference stu3 <-> R4
* signature.data = "dGhpcyBibG9iIGlzIHNuaXBwZWQ=" //difference stu3 <-> R4


Instance: ExemploMSH
InstanceOf: PEMHMSH
Description: "Exemplo Message Header"


* id = "db6428bf-1e58-48d4-9102-b85d6c716bb1"
* meta.profile = "http://spms.min-saude.pt/fhir/iop/profiles/med-prescription-synchronization-msh/v1-0-3"
* meta.lastUpdated = "2019-10-10T23:10:23+00:00"
* meta.tag.system = "http://spms.min-saude.pt/iop/event-meta-tags"
* meta.tag.code = #10911
* meta.tag.display = "MED PRESCRIPTION NEW"
* eventCoding.system =  "http://spms.min-saude.pt/iop/events" //#stu3 is not supported by SUSHI
* eventCoding.code = #10724
* eventCoding.display = "MED_PRESCRIPTION_SYNCHRONIZATION"
* destination.name = "PEMH"
* destination.endpoint = "SPMS/PEMH"
* destination.receiver = Reference(ExemploOrganization1)
* destination.receiver.display = "Organização Origem"
* sender = Reference(ExemploOrganization1)
* sender.display = "Organização Origem"
// * timestamp = "2019-07-14T23:10:23+00:00"
* source.name = "Aplicação Origem"
* source.endpoint = "Endpont_Aplicação_Origem"
* focus = Reference(ExemploRequestGroup)




Instance: ExemploRequestGroup
InstanceOf: PEMHRequestGroup
Description: "Exemplo 1 - Nova prescrição de medicação - RequestGroup"

* id = "25f1ea48-e0ef-405e-86fc-498ae907f6df"
* meta.lastUpdated = "2019-10-10T23:10:23+00:00"
* groupIdentifier.system = "http://spms.min-saude.pt/his/<id-rnu-entidade>/identifiers/local-prescription-id"
* groupIdentifier.value = "6789342"
* status = #active
* intent = #order
* extension[PrescriptionDuplicate].valuePositiveInt = 1
* extension[MeaningOrder].valueCodeableConcept.coding = http://spms.min-saude.pt/bdnp/codesystem/med-request-modality#RSP "Receita sem Papel"
//* action.label = 1
* action.timingPeriod.end = "2019-01-27"

Instance: ExemploMedicationRequest
InstanceOf: PEMHMedicationRequest
Description: "Exemplo 1 - Nova prescrição de medicação - MedicationRequest"

* id = "e22942f3-a461-40b9-8449-30f7a7e9d0d5"
* meta.lastUpdated = "2019-10-10T23:10:23+00:00"
* groupIdentifier.system = "http://spms.min-saude.pt/his/<id-rnuentidade>/identifiers/local-prescription-id"
* groupIdentifier.value = "6789342"
* status = #active
* intent = #order
* medicationReference = Reference(a87cddf3-01de-4241-b9b27209f5f2bcab)
* subject = Reference(3616b380-01be-465a-aa29906337c6e7a4)
//* context.reference = "Encounter/2d3f8e19-205e-40c6-aeec7b17cbef8045"
* authoredOn = "2019-07-14T23:10:23+00:00"
//* requester.agent.reference = "Practitioner/f644ab44-7e32-4e05972c-1f14bebf27a8"
//* requester.agent.display = "Dr. António da Cruz"
//* onBehalfof.reference = "Organization/dec4d0d7-b8dd-4c6f-9c7e-71ca0ee53ace"
* note.text = "Informação sobre a prescrição"
* dosageInstruction
  * text = "500 mg daily for 5 days"
  * timing.repeat.boundsPeriod.start =  "2019-07-16"
  * timing.repeat.boundsPeriod.end = "2019-07-30"
  * timing.repeat.timeOfDay = "09:00:00"
  * route.coding = http://www.infarmed.pt#255560000 "Intravenous"
  * doseAndRate.doseQuantity.value = 400
  * doseAndRate.doseQuantity.unit = "mg"
  * doseAndRate.doseQuantity.system = "https://www.infarmed.pt"
  * doseAndRate.doseQuantity.code = #mg
  //* extension[]
* dispenseRequest.quantity.value = 30
* dispenseRequest.quantity.unit = "TAB"
* dispenseRequest.quantity.code = #TAB
* dispenseRequest.quantity.system = "https://www.infarmed.pt"

Instance: ExemploMedication
InstanceOf: PEMHMedication
Description: "Exemplo 1 - Nova prescrição de medicação - Medication"

* id = "a87cddf3-01de-4241-b9b2-7209f5f2bcab"
* code = http://infarmed.pt#10007274 "Ibuprofeno 600 mg Comp"
* form = http://www.infarmed.pt#10219000 "Comprimido"


Instance: ExemploPatient
InstanceOf: PEMHPatient
Description: "Exemplo 1 - Nova prescrição de medicação - Patient"

* id = "3616b380-01be-465a-aa29-906337c6e7a4"
* meta.lastUpdated = "2019-01-14T23:10:23+00:00"
//* identifier.type.coding =  http://hl7.org/fhir/v2/0203#HC "Health Card Number"
* identifier.type.text = "NNU"
* identifier.system = "http://spms.min-saude.pt/rnu/identifiers/patient-id"
* identifier.value = "11920641576"
* name.text = "Pedro Alvares Cabral"
* name.given = "Pedro"
* name.family = "Cabral"
* gender = #male
* birthDate = "1979-11-19"
* telecom.system = #email
* telecom.value = "PedroAlvaresCabral@dominio.pt"


Instance: ExemploEncounter
InstanceOf: PEMHEncounter
Description: "Exemplo 1 - Nova prescrição de medicação - Encounter"

* id = "2d3f8e19-205e-40c6-aeec7b17cbef8045"
* identifier.system = "http://spms.min-saude.pt/iop/identifiers/encounter"
* identifier.value = "1243546"
* status = #in-progress
* class = http://hl7.org/fhir/v3/ActCode#EMER "Emergency"

* subject = Reference(3616b380-01be-465a-aa29-906337c6e7a4)
* participant.individual = Reference(Patient/3616b380-01be-465a-aa29-906337c6e7a4)

* period.end = "2019-01-27"
* serviceProvider = Reference(ExemploOrganization1)

Instance: ExemploCoverage
InstanceOf: PEMHCoverage
Description: "Exemplo 1 - Nova prescrição de medicação - Coverage"

* id = "219eb473-8ee3-4e3d-b785-b204b71de77f"
//* identifier.type = http://spms.min-saude.pt/iop/identifiers/coverage#NBU "Número do Beneficiário na Entidade"
//* identifier.type.text = "Descrição do número de Beneficiário do Utente na Entidade"
//* identifier[NBU].system = "http://spms.min-saude.pt/rnu/identifiers/nbu"
* identifier[NBU].system = "http://spms.min-saude.pt/rnu/identifiers/nbu"
* identifier[NBU].value = "131255890"
* type = http://hl7.org/fhir/v3/ActCode#EHCPOL "Extended healthcare"
* subscriberId = "874207420C"

* subscriber = Reference(3616b380-01be-465a-aa29-906337c6e7a4)

* beneficiary = Reference(3616b380-01be-465a-aa29-906337c6e7a4)

* relationship =  http://hl7.org/fhir/policyholder-relationship#self "The Beneficiary is the Policyholder"
* payor = Reference(ExemploOrganization1)
* period.start = "2019-01-14"
* period.end = "2022-01-27"
* status = #active


Instance: ExemploLocation
InstanceOf: PEMHLocation
Description: "Exemplo 1 - Nova prescrição de medicação - Location"

* id = "04f1ea48-e0ef-405e-86fc-498ae907f6d0"
* identifier.system = "http://spms.min-saude.pt/sges/identifiers/entity-id"
* identifier.value = "2412341-3"
* name = "Hospital São João"
* alias = "Centro Hospitalar Universitário de São João"
* type = http://spms.min-saude.pt/prvr/valueset/location-type#urgencia "Urgência"
* managingOrganization = Reference(ExemploOrganization1)

Instance: ExemploOrganization1
InstanceOf: Organization
Description: "Exemplo 1 - Nova prescrição de medicação - Organization1"

* id = "dec4d0d7-b8dd-4c6f-9c7e-71ca0ee53ace"
* identifier.system = "http://spms.min-saude.pt/sges/identifiers/entity-id"
* identifier.value = "3113408"
* name = "Sclinico Hospitalar"

Instance: ExemploOrganization2
InstanceOf: Organization
Description: "Exemplo 1 - Nova prescrição de medicação - Organization2"

* id = "fab4d0d7-b8dd-4c6f-9c7e-71ca0ee53ac"
* identifier.system = "http://spms.min-saude.pt/sges/identifiers/entity-id"
* identifier.value = "3113408"
* name = "Provedor de Serviços de Cardiologia"
* telecom.system = #email
* telecom.value = "PedroAlvaresCabral@dominio.pt"
* partOf = Reference(ExemploOrganization1)



Instance: ExemploPractitioner
InstanceOf: Practitioner
Description: "Exemplo 1 - Nova prescrição de medicação - Organization2"

* id = "f644ab44-7e32-4e05-972c-1f14bebf27a8"
* identifier.type = http://hl7.org/fhir/v2/0203#MD "Medical License number"
* identifier.system = "https://www.ordemdosmedicos.pt"
* identifier.value = "33421535"
* name.text = "Dr. António da Cruz"
