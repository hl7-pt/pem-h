

Profile:     PEMHbundleRquest
Parent:      Bundle
Title:       "Perfil Bundle de mensagem"
Description: "O Bundle da mensagem deve ser do tipo 'message', deve ter como primeira entrada o recurso MessageHeader, e como segunda o recurso."

* id 1..1 
* id ^short = "Deve ser único e mudar sempre que a mensagem for enviada."

* type = #message
* meta.profile = "http://spms.min-saude.pt/fhir/iop/profiles/med-prescription-synchronization/v1-0-3"
* meta.profile ^short = "Deve ser indicada a versão da especificação FHIR a que a mensagem corresponde"
* signature 1..1 MS
* signature ^short = "Assinatura da receita"
* signature.type 1..* MS
* signature.when 1..1 MS
* signature.who only Reference(Practitioner)  //who -> whoReference
* entry 3..* MS
* entry ^short = "Deverá existir obrigatoriamente uma entrada para cada um dos seguintes recursos, e pela ordem indicada: MessageHeader, RequestGroup."
* entry ^slicing.discriminator.type = #value
* entry ^slicing.discriminator.path = "name"
* entry ^slicing.rules = #open
* entry contains messageheader 1..1 MS and request 1..1 MS

* entry[messageheader].resource only PEMHMSH
* entry[request].resource only PEMHRequestGroup

Profile:     PEMHMSH
Id:          msh-profile
Parent:      MessageHeader
Title:       "Perfil MessageHeader"
Description: "Este recurso deve ser a primeira entrada no Bundle e deve referenciar (focus) o recurso MedicationRequest."

* id 1..1
* meta.profile = "http://spms.min-saude.pt/fhir/iop/profiles/med-prescription-synchronization-msh/v1-0-3"
* meta.tag from EventagsVS (required)
* meta.tag 1..1 MS
* source.name 1..1 MS
* source.name ^short = "Nome da aplicação que enviou a mensagem. <Aplicação_origem>"
* source.endpoint 1..1 MS 
* source.endpoint ^short = "URL da aplicação que enviou a mensagem. <URL_origem>"
* destination.name ^short = "PEMH"
* destination.endpoint = "SPMS/PEMH"
* destination.receiver only Reference(Organization) //destination.receiver -> receiver
* destination.receiver ^short = "<fornecedor_aplicação/aplicação_origem>" //destination.receiver -> receiver
* eventCoding.system = "http://spms.min-saude.pt/iop/events" //eventCoding -> event
* eventCoding.code from EventCodeVS (required) //eventCoding -> event
* eventCoding.display = "MED_PRESCRIPTION_SYNCHRONIZATION" //eventCoding -> event
//* timestamp 1..1 does not exist R4
* author ^short = "Profissional que fez a prescrição de medicação para o utente."
* focus 1..* MS
* focus only Reference(PEMHRequestGroup)
* focus ^short = "Corresponde à receita. Enviar somente um recurso RequestGroup por mensagem" //fazer invariant???



Profile:     PEMHRequestGroup
Id:          content-profile
Parent:      RequestGroup
Title:       "Perfil Conteudo Receita"
Description: "Este recurso representa a receita (Número da receita, local e central, número da linha e a data de validade )."

 
* id ^short = "ID lógico do pedido de referenciação no contexto FHIR"
* meta.profile = "http://spms.min-saude.pt/fhir/iop/profiles/med-prescriptionsynchronization-msh/v1-0-3"
* meta.lastUpdated ^short = "Indica a data da última alteração desse recurso."
* groupIdentifier 1..1 MS
* groupIdentifier ^short = "Identificador local da prescrição. NÚMERO RECEITA LOCAL"
* status 1..1 MS
* status ^short = "A prescrição é criada com status active. Status para a anulação / cancelamento da prescrição: cancelled."
// novo valueSet
* intent = #order

* extension 0..* MS
* extension ^slicing.discriminator.type = #value
* extension ^slicing.discriminator.path = "url"
* extension ^slicing.rules = #open


* extension contains PrescriptionDuplicate named PrescriptionDuplicate 0..1 
* extension[PrescriptionDuplicate] ^short = "Extensão para indicar a via da receita prescrita"
* extension contains meaning-order named MeaningOrder 0..1
* extension[meaning-order] ^short = "Extensão para indicar a via da receita prescrita"
* extension[meaning-order] ^short = "Extensão sobre a Modalidade de Prescrição. Receita com papel (RCP) ou receita sem papel (RSP) [MODALIDADE DE PRESCRIÇÃO]" 

//* action.label ^short = "Número da linha da receita (1, 2, 3, ...). [NÚMERO LINHA]"
* action.timingPeriod ^short = "Data da linha da receita [DATA VALIDADE LINHA]"
* action.resource only Reference(PEMHMedicationRequest)
* action.resource ^short = "Referência para um resource que contém informações da linha da receita"


Profile:     PEMHMedicationRequest
Id:          med-request-profile
Parent:      MedicationRequest
Title:       "Perfil informação de receita"
Description: "Este recurso contém informações da linha da receita."

* id 1..1 MS
* meta.lastUpdated ^short = "Indica a data da úlltima alteração desse recurso. Refere-se também à data de anulação da receita."

* groupIdentifier ^short = "Identificador local da prescrição"
* status 1..1
* status ^short = "A prescrição é criada com status active. Status para a anulação / cancelamento da prescrição: cancelled."

* extension 0..* MS
* extension ^slicing.discriminator.type = #value
* extension ^slicing.discriminator.path = "url"
* extension ^slicing.rules = #open


* extension contains med-prescription-dosage-instruction  named med-prescription-dosage-instruction 0..1 
* extension contains presc-print named presc-print 0..1
* extension contains presc-administration named presc-administration 0..1
* extension contains presc-transcription named presc-transcription 0..1
* extension contains presc-type named presc-type 0..1
* extension contains presc-local named presc-local 0..1
* extension contains med-prescription-framing-dispense named med-prescription-framing-dispense 0..1

* extension contains med-prescription-cancel-reason named med-prescription-cancel-reason 0..1
* extension contains med-cost named med-cost 0..1

* intent = #order
* medication[x] only Reference(PEMHMedication)
* medication[x] ^short = "Referência para o resource que contém informações do fármaco"
* subject only Reference(PEMHPatient)
* subject 1..1 MS
* subject ^short = "Referência para um resource que contém informações so utente a quem diz respeito a medicação"
* encounter only Reference(PEMHEncounter) //encounter -> context
* encounter ^short = "Referência para um resource que contém informações do episódio no contexto em que ocorreu a prescrição" //encounter -> context
* authoredOn 1..1
* authoredOn ^short = "Data e hora em que a prescrição foi emitida. Apenas preenchido no primeiro momento em que é feita a prescrição, i.e., se status = ACTIVE e não deve ser mais alterada em toda a vida do recurso."
* requester only Reference(Practitioner) //requester -> requester.agent
* requester ^short = "Referência para um resource que contém informações do profissional que inicialmente adicionou a prescrição. Este elemento não pode ser mais alterado em toda a vida do recurso."
//* requester.onBehalfOf ^short = "Referência para um resource que contém informações da instituição em que foi efetuada a prescrição"
//* requester.onBehalfOf only Reference(PEMHOrganization)
* note ^short = "Informação adicionais sobre a prescrição [OBSERVAÇÕES GERAIS]"
* dosageInstruction ^short = "Posologia"
* dosageInstruction.text ^short = "Conversão em texto da posologia estruturada definida na lista de posologias"
* dosageInstruction.timing ^short = "O elemento timing foi normalizado pela IOP com base no dataType timing do HL7 FHIR.
Recomenda-se utilizar sempre que possível os elementos que compoem o timing para representar a posologia como forma de fazer uso dos elementos fornecidos pelo standard HL7 FHIR.
Entretanto, para atender os requisitos de negócio e as normas da Prescrição da Medicação, no qual indicam para utilizar catálogos disponibilizados pelo CTC, utilizar a extension \"med-prescription-dosage-line\" para descrever a posologia.
Isso justifica-se pois os elementos do standard HL7 FHIR f azem uso de catálogos pré-definidos e required."
* dosageInstruction.timing.repeat.boundsPeriod.start ^short = "Data de início para a toma"
* dosageInstruction.timing.repeat.boundsPeriod.end ^short = "Data de termo para a toma"
* dosageInstruction.timing.repeat.durationUnit ^short = "Unidade da duração do Tratamento/Tempo
s | min | h | d | wk | mo | a - unit of time (UCUM) UnitsOfTime(Required)
e.g.: 'wk'"
* dosageInstruction.timing.repeat.period ^short = "Indica a duração do tempo durante o qual as repetições devem ocorrer; por exemplo, para expressar \"3 vezes por dia\", 3 seria a frequência e \"1 dia\" seria o período."
* dosageInstruction.timing.repeat.periodUnit ^short = "Unidades de tempo do período."

//extension TODO

* dosageInstruction.doseAndRate.doseQuantity ^short = "Valor e unidade do valor da dose da posologia [DOSE - VALOR E UNIDADE]" //dosageInstruction.doseAndRate.doseQuantity -> dosageInstruction.doseQuantity
* dispenseRequest.quantity ^short = "Quantidade prescrita do medicamento (valor e unidade)"
 //extension 2

 
Profile:     PEMHMedication
Id:          med-pemh-profile
Parent:      Medication
Title:       "Perfil Medicação"
Description: "Este recurso representa o medicamento que é referenciado pelo recurso MedicationRequest."

* code ^short = "Usar o Código CHNM, Número do Registo ou CDM par a indicar o medicamento ou produto farmacêutico.
Código CHNM da base de dados de medicamentos do Infarmed:
[CHNM]"
* code.coding ^slicing.discriminator.type = #value
* code.coding ^slicing.discriminator.path = "system"
* code.coding ^slicing.rules = #open
* code.coding contains CHNM 0..1 MS and  CÓDIGO_E_DESCRIÇÃO 0..1 MS and NUMEROREGISTO 0..1 MS and TEXTOLIVRE 0..1 MS 
* code.coding[CHNM].system = "http://infarmed.pt/chnm"
* code.coding[NUMEROREGISTO].system = "http://infarmed.pt/nregisto"
* code.coding[CÓDIGO_E_DESCRIÇÃO].system = "http://infarmed.pt/cdm"
* code.coding[TEXTOLIVRE].system 0..0
* form.coding.system = "http://www.infarmed.pt"



Profile:     PEMHPatient
Id:          patient-pemh-profile
Parent:      Patient
Title:       "Perfil Paciente"
Description: "Utente a quem diz respeito a prescrição de medicação."
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "type.coding"
* identifier ^slicing.rules = #open
* identifier contains VISTO 0..1 MS and  CC 0..1 MS and NIF 0..1 MS and SS 0..1 MS and NNU 0..1 MS and NP 0..1 MS
* identifier.type.coding.system = "http://hl7.org/fhir/v2/0203"
* identifier[VISTO].type.coding.code = #PRC
* identifier[VISTO].type.coding.display = "Permanent Resident Card Number"
* identifier[VISTO].system = "http://www.sef.pt/identifiers/prc-card"
* identifier[VISTO].value 1..1

* identifier[CC].type.coding.code = #CZ
* identifier[CC].type.coding.display = "Citizenship Card"
//* identifier[CC].system = "http://www.sef.pt/identifiers/prc-card"
* identifier[CC].value 1..1


* identifier[NIF].type.coding.code = #TAX
* identifier[NIF].type.coding.display = "Tax ID Number"
* identifier[NIF].system = "http://autoridadetributaria.pt/identifiers/nif"
* identifier[NIF].value 1..1


* identifier[SS].type.coding.code = #SS
* identifier[SS].type.coding.display = "Social Security Number"
* identifier[SS].system = "http://www.seg-social.pt/pedido-de-niss1"
* identifier[SS].value 1..1


* identifier[NNU].type.coding.code = #HC
* identifier[NNU].type.coding.display = "Health Card Number"
* identifier[NNU].system = "http://spms.min-saude.pt/rnu/identifiers/patient-id"
* identifier[NNU].value 1..1

* identifier[NP].type.coding.code = #MR
* identifier[NP].type.coding.display = "Medical Record Number"
//* identifier[NP].system = "http://spms.min-saude.pt/rnu/identifiers/patient-id"
* identifier[NP].value 1..1

* name.text ^short = "Nome completo do utente"
* name.given ^short = "Nomes próprios do utente"
* name.family ^short = "Apelidos do utente"
* telecom ^short = "Informações de contacto do utente"


* address.id ^short = "As extensões apresentadas suportam a normalização para o formato de morada em Portugal assim como para moradas estrangeiras de uma forma sistémica. Opcionalmente os elementos \"address.text\" e \"address.line\" poderão ser utilizados para uma representação não normalizada.
Para informar a morada de cada tipo de address abaixo, além de preencher os elementos consistidos pelas extensions, deverão ser utilizados os elementos do datatype address (como country, district, etc) com os valores preenchidos nos elementos display das extensions correspondentes em seus valueCodeableConcept (e.g.; caso address[0]. extension[0].extension[0].valueCodeableConcept. coding[0].display seja igual a \"Portugal\", address[0]. country também deverá ser igual a \"Portugal\").
Caso a morada seja preferencial (campo <Preferenci al>), deve ser usado o tipo de endereço \"MA\" (Main Address)
Podem ser enviadas quantas moradas forem necessárias."
//extensions TODO

* address.extension 0..* MS
* address.extension ^slicing.discriminator.type = #value
* address.extension ^slicing.discriminator.path = "url"
* address.extension ^slicing.rules = #open
* address.extension contains ptAddress  named ptAddress 0..1 




* address.text ^short = "Para informar o texto que representa a morada, de uma forma não normalizada, em alternativa ou em complemento da forma normalizada representada pelas extensões do elemento address."
* address.line ^short = "Para informar a(s) linha(a) que representa(m) a morada, de uma forma não normalizada, em alternativa ou em complemento da forma normalizada representada pelas extensões do elemento address."
* contact.relationship ^short = "Para informar que o contacto é de emergência (ContactoEmergencia)"

* contact.address.extension 0..* MS
* contact.address.extension ^slicing.discriminator.type = #value
* contact.address.extension ^slicing.discriminator.path = "url"
* contact.address.extension ^slicing.rules = #open
* contact.address.extension contains ptAddress  named ptAddress 0..1 

* contact.extension 0..* MS
* contact.extension ^slicing.discriminator.type = #value
* contact.extension ^slicing.discriminator.path = "url"
* contact.extension ^slicing.rules = #open
* contact.extension contains contactObservations  named contactObservations 0..1
* contact.extension contains contactPreference  named contactPreference 0..1


* extension 0..* MS
* extension ^slicing.discriminator.type = #value
* extension ^slicing.discriminator.path = "url"
* extension ^slicing.rules = #open
* extension contains ptOccupation  named ptOccupation 0..1 
* extension contains ptFilliation  named ptFilliation 0..1
* extension contains ptPatientOtherInfo  named ptPatientOtherInfo 0..1


Profile:     PEMHEncounter
Id:          encounter-pemh-profile
Parent:      Encounter
Title:       "Perfil Episódio"
Description: "Recurso que caracteriza o episódio a partir do qual a prescrição de medicação está a ser solicitada."

* identifier ^short = "Número do episódio no âmbito do qual foi emitida a receita"
* identifier.system = "http://spms.min-saude.pt/iop/identifiers/encounter"
* status = #in-progress
* class ^short = "Identificador do tipo de episódio que deu origem à prescrição - Módulo do Episódio
e.g.: INT, CE, URG, EMER"
* subject ^short = "Referência para um resource que contém informações do utente"
//* encounter.participant ^short = "Preencher com os profissionais envolvidos."
//* encounter.participant.individual ^short = "Referência para um resource que contém informações do profissional de saúde"
//* encounter.serviceProvider ^short = "Referência para um resource que contém informações da consulta de especialidade"

* extension 0..* MS
* extension ^slicing.discriminator.type = #value
* extension ^slicing.discriminator.path = "url"
* extension ^slicing.rules = #open
* extension contains episodeServiceSpecialty  named episodeServiceSpecialty 0..1 
* extension contains nextAppointmentDate  named nextAppointmentDate 0..1


Profile:     PEMHCoverage
Id:          coverage-pemh-profile
Parent:      Coverage
Title:       "Perfil Coverage"
Description: "Recurso utilizado para representar a relação entre beneficiário (utente) e a entidade responsável. Este recurso é referenciado no recurso Patient numa extensão própria."

* identifier ^short = "Será obrigatório somente se for uma Entidade Responsável.Número de Beneficiário do Utente na Entidade"
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "type.coding"
* identifier ^slicing.rules = #open
* identifier contains NBU 0..1 MS
* identifier[NBU].type.coding = http://spms.min-saude.pt/iop/identifiers/coverage#NBU "Número do Beneficiário na Entidade"
//* identifier[NBU].coding.display = "Número de Beneficiário do Utente"
* identifier[NBU].system = "http://spms.min-saude.pt/rnu/identifiers/nbu"
* type ^short = "Designação da Entidade Responsável, enviar outros códigos se necessário, com o respetivo sistema de codificação [CÓDIGO (EFR) E DESIGNAÇÃO (EFR)]"
* type.coding ^slicing.discriminator.type = #value
* type.coding ^slicing.discriminator.path = "code"
* type.coding ^slicing.rules = #open
* type.coding contains ExtendedHealthcare 0..1 MS
* type.coding[ExtendedHealthcare].system = "http://hl7.org/fhir/v3/ActCode"
* type.coding[ExtendedHealthcare].code = #EHCPOL
* type.coding[ExtendedHealthcare].display = "Extended healthcare"
* subscriberId ^short = "Número do documento de direito [NÚMERO (CARTÃO)]"
* beneficiary ^short = "Referência para um resource que contém informações do utente"
* payor ^short = "Referência para um resource que contém informações da Entidad e Financeira Responsável"
* period ^short = "Este elemento representa a data de emissão do documento de direito representado pelo \"start\" e a data de validade do documento de direito representado pelo \"end\"."
//extension
* extension 0..* MS
* extension ^slicing.discriminator.type = #value
* extension ^slicing.discriminator.path = "url"
* extension ^slicing.rules = #open
* extension contains CardInfo  named CardInfo 0..1 





Profile:     PEMHLocation
Id:          location-pemh-profile
Parent:      Location
Title:       "Perfil Location"
Description: "Recurso utilizado para representar informação sobre o local de prescrição da medicação."

* identifier ^short = "Código SGES do local de prescrição"
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "system"
* identifier ^slicing.rules = #open
* identifier contains SGES 0..1 MS
* identifier[SGES].system = "http://spms.min-saude.pt/sges/identifiers/entity-id"

* name ^short = "DESIGNAÇÃO DO LOCAL DA PRESCRIÇÃO, Nome do local de prescrição"

* type ^short = "Locais de prescrição definidos pelo PRVR."

* managingOrganization ^short = "Referência para um resource que contém informa ções da instituição à qual pertence este local."

/*Profile:     PEMHbundleResponse
Id:          bundle-response-profile
Parent:      Bundle
Title:       "Perfil Bundle de mensagem de resposta"
Description: "O fluxo de prescrição de medicação é um fluxo síncronopara a aplicação emissora."

* id ^short = "Deve ser único e mudar sempre que a mensagem for enviada."
* meta.profile = "http://spms.min-saude.pt/fhir/iop/profiles/outcome/v1-0-3"
*/
Profile:     PEMHMessageHeaderResposta
Id:          msh-response-profile
Parent:      MessageHeader
Title:       "Perfil Bundle de mensagem de resposta"
Description: "Este recurso deve ser a primeira entrada no Bundledas mensagens resposta de ACK de transporte e aplicacional, e deve trazer informação sobre o resultado da recepção ou processamento da mensagem pelo cliente destino."

* meta.profile = "http://spms.min-saude.pt/fhir/iop/profiles/med-prescription-synchronization-outcome-msh/v1-0-3"

* meta.tag.system =  "http://spms.min-saude.pt/iop/event-meta-tags"

* eventCoding.system = "http://spms.min-saude.pt/iop/events" //eventCoding -> event
* eventCoding.code from EventCodeVS (required) //eventCoding -> event
* eventCoding.display = "MED_PRESCRIPTION_SYNCHRONIZATION" //eventCoding -> event

* destination.name ^short = "<Aplicação de Origem>"
* destination.endpoint ^short = "<Fornecedor da Aplicação/Aplicação de Origem>"
* destination.receiver ^short = "Corresponde à organização que recebe a prescrição de medicação." //destination.receiver -> receiver
* destination.receiver only Reference(Organization) //destination.receiver -> receiver
* sender only Reference(Organization) //sender -> sender\
* sender ^short = "Corresponde à organização que envia a a prescrição de medicação."

* source.name="PEMH"
* author ^short = "Profissional que fez a prescrição de medicação para o utente."

* response.details only Reference(OperationOutcome) //response.details -> details
* response.details ^short = "Obrigatório enviar apenas em caso de erro /problemas na recepção/processamento da mensagem."
* focus only Reference(RequestGroup) //focus -> focus
* focus 1..1 MS
* focus ^short = "Corresponde ao retorno da receita contendo o identidicador central da receita e o Pin da receita.
Obrigatório enviar apenas em caso de sucesso na recepção/processamento da mensagem.
Só deve ser enviada uma referência para o recurso
RequestGroup por mensagem."



Profile:     PEMHRequestGroupResponse
Id:          content-response-profile
Parent:      RequestGroup
Title:       "Perfil Conteudo Receita"
Description: "Este recurso representa o retorno da receita quando ocorre o sucesso na recepção/processamento da mensagem. Para além disso, esse recurso contêm elementos que compõem a receita gerados somente no retorno da receita, como o \"Número Central da
Receita\" e o \"Pin da Receita\"."

 
* id ^short = "ID lógico do pedido de referenciação no contexto FHIR"
* meta.profile = "http://spms.min-saude.pt/fhir/iop/profiles/med-prescriptionsynchronization-msh/v1-0-3"
* meta.lastUpdated ^short = "Indica a data da última alteração desse recurso."
* groupIdentifier 1..1 MS
* groupIdentifier ^short = "Identificador local da prescrição. NÚMERO RECEITA LOCAL"
* status 1..1 MS
* status ^short = "A prescrição é criada com status active. Status para a anulação / cancelamento da prescrição: cancelled."
// novo valueSet
* intent = #order

* extension 0..* MS
* extension ^slicing.discriminator.type = #value
* extension ^slicing.discriminator.path = "url"
* extension ^slicing.rules = #open


* extension contains PrescriptionDuplicate named PrescriptionDuplicate 0..1 
* extension[PrescriptionDuplicate] ^short = "Extensão para indicar a via da receita prescrita"
* extension contains meaning-order named MeaningOrder 0..1
* extension[meaning-order] ^short = "Extensão para indicar a via da receita prescrita"
* extension[meaning-order] ^short = "Extensão sobre a Modalidade de Prescrição. Receita com papel (RCP) ou receita sem papel (RSP) [MODALIDADE DE PRESCRIÇÃO]" 

//* action.label ^short = "Número da linha da receita (1, 2, 3, ...). [NÚMERO LINHA]"
* action.timingPeriod ^short = "Data da linha da receita [DATA VALIDADE LINHA]"
* action.resource only Reference(PEMHMedicationRequest)
* action.resource ^short = "Referência para um resource que contém informações da linha da receita"
