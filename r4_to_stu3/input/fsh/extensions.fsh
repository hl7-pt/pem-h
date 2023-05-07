Extension: MeaningOrder
Id:        meaning-order
Title:    "MODALIDADE DE PRESCRIÇÃO"
Description: "Receita com papel (RCP) ou receita sem papel (RSP)."
* value[x] only CodeableConcept
* value[x] from MeaningOrderVS (required)
* ^url = "http://spms.min-saude/pe/top/extensions/med-request-modality"


Extension: PrescriptionDuplicate
Id:        prescription-duplicate
Title:    "NÚMERO DE VIAS"
Description: "Via da receita no caso de ser renovável (1, 2, 3, ...)."
* value[x] only positiveInt
* ^url = "http://spms.min-saude.pt/iop/extensions/prescription-duplicate"

Extension: MedPrescriptionDosageLine
Id:        med-prescription-dosage-line
Title:    "NÚMERO DE VIAS"
Description: "Via da receita no caso de ser renovável (1, 2, 3, ...)."
* value[x] only positiveInt
* ^url = "http://spms.min-saude.pt/iop/extensions/med-prescription-dosage-line"


Extension: med-prescription-dosage-instruction
Id:       med-prescription-dosage-instruction
Title:    "FREQ+HORÁRIO"
Description: "Extensões referentes a frequência e horário de toma do medicamento e a duração de tratamento da posologia em valor e unidade."
* ^url = "http://spms.min-saude.pt/iop/extensions/med-prescription-dosage-instruction"

* extension contains
    med-prescription-frequency-time 1..1 MS and
    med-prescription-duration 1..1 MS 

* extension[med-prescription-frequency-time].value[x] only CodeableConcept
* extension[med-prescription-frequency-time].value[x] from MedPrescriptionFrequencyTimeVS (required)
* extension[med-prescription-frequency-time] ^short = "Indica a frequência e horário de toma do medicamento definidos pelo CTC."

* extension[med-prescription-duration].value[x] only Quantity
* extension[med-prescription-duration].value[x] from MedPrescriptionDurationVS (required) 
* extension[med-prescription-duration] ^short = "Indica a duração de tratamento da posologia - Valor e Unidade"


Extension: presc-print
Id:       presc-print
Title:    "IMPRESSÃO"
Description: "Indicar se a receita foi impressa"
* value[x] only boolean
* ^url = "http://spms.min-saude.pt/iop/extensions/med-prescription-print"

Extension: presc-administration
Id:       presc-administration
Title:    "ADMINISTRAÇÃO"
Description: "Indicar se a prescrição é para administração interna ou SFH; true: administração interna; false: SFH"
* value[x] only boolean
* ^url = "http://spms.min-saude.pt/iop/extensions/med-prescription-internal-administration"


Extension: presc-transcription
Id:       presc-transcription
Title:    "RECEITA MANUSCRITA"
Description: "Indicar se trata-se de uma transcrição de uma receita manuscrita."
* value[x] only boolean
* ^url = "http://spms.min-saude.pt/iop/extensions/med-prescription-transcript"

Extension: presc-type
Id:       presc-type
Title:    "TIPO DE RECEITA"
Description: "Tipo de prescrição: e.g.: FH, RE, BIO ou OUT."
* value[x] only CodeableConcept
* value[x] from MedPrescriptionTypeVS (required)
* ^url = "http://spms.min-saude.pt/iop/extensions/med-request-type"


Extension: presc-local
Id:       presc-local
Title:    "LOCAL"
Description: "Referência para um resource que contém informações do local de prescrição"
* value[x] only Reference(Location)
* ^url = "http://spms.min-saude.pt/iop/extensions/med-prescription-local"



Extension: med-prescription-framing-dispense
Id:       med-prescription-framing-dispense
Title:    "Tipo enquadramento"
Description: "Extensões referentes ao enquadramento da dispensa"
* ^url = "http://spms.min-saude.pt/iop/extensions/med-prescription-framing-dispense"

* extension contains
    med-prescription-framing-type 0..1 MS and
    med-prescription-legal-diploma 0..1 MS 

* extension[med-prescription-framing-type].value[x] only CodeableConcept
* extension[med-prescription-framing-type].value[x] from MedPrescriptionFramingTypeVS (required)
* extension[med-prescription-framing-type] ^short = "Sub-extensão relativa ao Diploma Legal que estabelece o regime especial ou excecional de comparticipação."

* extension[med-prescription-legal-diploma].value[x] only CodeableConcept
* extension[med-prescription-legal-diploma].value[x] from MedPrescriptionLegalDiplomaVS (required)
* extension[med-prescription-legal-diploma] ^short = "Sub-extensão relativa ao Diploma Legal que estabelece o regime especial ou excecional de comparticipação."




Extension: med-prescription-cancel-reason
Id:       med-prescription-cancel-reason
Title:    "MOTIVO ANULAÇÃO"
Description: "Motivo de anulação da receita."
* value[x] only CodeableConcept
* value[x] from MedPrescriptionCancelReasonVS (required)
* ^url = "http://spms.min-saude.pt/iop/extensions/med-prescription-cancel-reason"

Extension: med-cost
Id:       med-cost
Title:    "Custo"
Description: "Extensão referente ao valor e a moeda da terapêutica"
* ^url = "http://spms.min-saude.pt/iop/extensions/med-cost"

* extension contains
    med-currency 1..1 MS and
    med-value 1..1 MS 

* extension[med-currency].value[x] only CodeableConcept
* extension[med-currency].value[x] from urn:iso:std:iso:4217 (required)
* extension[med-currency] ^short = "Sub-extensão referente a moeda"

* extension[med-value].value[x] only decimal
* extension[med-value] ^short = "Sub-extensão referente ao valor da terapêutica"



/// PATIENT EXTENSIONS ////

Extension: ptAddress
Id:       ptAddress
Title:    "Endereço"
Description: "Extensão referente ao endereço"

* extension contains
    address-type 0..1 MS and
    street-type 0..1 MS and
    street 0..1 MS and
    building-type 0..1 MS and
    door-number 0..1 MS and
    door-side 0..1 MS and
    floor 0..1 MS and
    place 0..1 MS and
    locality 0..1 MS and
    state 0..1 MS and
    city 0..1 MS and
    postal-code 0..1 MS and
    parish 0..1 MS and
    foreign-address 0..1 MS and
    foreign-region 0..1 MS and
    foreign-city 0..1 MS and
    foreign-district 0..1 MS and
    foreign-postal-code 0..1 MS and
    country 0..1 MS 

* extension[address-type].value[x] only Coding
* extension[address-type].value[x] from AddressTypeVS (required)

* extension[address-type] ^short = "Sub-extensão para o Tipo de via"

* extension[street-type].value[x] only CodeableConcept
* extension[street-type] ^short = "Sub-extensão para o Tipo de via"

* extension[street].value[x] only CodeableConcept
* extension[street] ^short = "Sub-extensão para o Nome da via"

* extension[building-type].value[x] only CodeableConcept
* extension[building-type] ^short = "Sub-extensão para o Tipo de Edificio"

* extension[door-number].value[x] only CodeableConcept
* extension[door-number] ^short = "Sub-extensão para o Número da porta"

* extension[door-side].value[x] only CodeableConcept
* extension[door-side] ^short =  "Sub-extensão para o Tipo de lado da porta"

* extension[floor].value[x] only CodeableConcept
* extension[floor] ^short = "Sub-extensão para o Andar"

* extension[place].value[x] only CodeableConcept
* extension[place] ^short = "Sub-extensão para o Lugar"

* extension[locality].value[x] only CodeableConcept
* extension[locality] ^short = "Sub-extensão para a Localidade"

* extension[state].value[x] only CodeableConcept
* extension[state] ^short = "Sub-extensão para o Distrito"

* extension[city].value[x] only CodeableConcept
* extension[city] ^short = "Sub-extensão para o Concelho"

* extension[parish].value[x] only CodeableConcept
* extension[parish] ^short = "Sub-extensão para a Freguesia"

* extension[postal-code].value[x] only CodeableConcept
* extension[postal-code] ^short =  "Sub-extensão para código postal"

* extension[foreign-address].value[x] only string
* extension[foreign-address] ^short = "Sub-extensão para o endereço da morada no estrangeiro"

* extension[foreign-region].value[x] only string
* extension[foreign-region] ^short =   "Sub-extensão para Região no estrangeiro"

* extension[foreign-city].value[x] only string
* extension[foreign-city] ^short =  "Sub-extensão para a Cidade no estrangeiro"

* extension[foreign-district].value[x] only string
* extension[foreign-district] ^short =  "Sub-extensão para a Localidade no estrangeiro"

* extension[foreign-postal-code].value[x] only string
* extension[foreign-postal-code] ^short = "Sub-extensão para a Código Postal no estrangeiro"

* extension[country].value[x] only CodeableConcept
* extension[country].value[x] from urn:iso:std:iso:3166 (required)
* extension[country] ^short = "Sub-extensão para o País Estrangeiro"


* ^url = "http://spms.min-saude.pt/rnu/extensions/address"




Extension: contactObservations
Id:       contactObservations
Title: "Observações relacionadas com o bloco dos contactos do Utente"
Description:    "Extensão para Observações relacionadas com o bloco dos contactos do Utente"

* value[x] only string
* ^url = "http://spms.min-saude.pt/rnu/extensions/contact-observations"

Extension: contactPreference
Id:       contactPreference
Title:    "Contacto preferencial"
Description: "Extensão para informar se o contacto atual é o preferencial"
* value[x] only boolean
* ^url = "http://spms.min-saude.pt/rnu/extensions/preferred-contact"


Extension: ptOccupation
Id:       ptOccupation
Title:    "Profissão do utente"
Description: "Extensão para a profissão do utente"
* ^url = "http://spms.min-saude.pt/rnu/extensions/occupation"
* extension contains
    code 0..1 MS and
    status 0..1 MS and
    education 0..1 MS
* extension[code].value[x] only CodeableConcept
* extension[status].value[x] only CodeableConcept
* extension[education].value[x] only CodeableConcept

* extension[code] ^short = "Sub-extensão que corresponde à Profissão"
* extension[status] ^short =  "Sub-extensão que corresponde à Situação da Profissão"
* extension[education] ^short =  "Sub-extensão para as Habilitações Literárias do utente"


Extension: ptFilliation
Id:       ptFilliation
Title:    "Filiação do utente"
Description: "Extensão Filiação do utente"
* ^url = "http://spms.min-saude.pt/rnu/extensions/patient-parents"

* extension contains
    mother 0..1 MS and
    father 0..1 MS 
* extension[mother].value[x] only Reference(RelatedPerson)
* extension[father].value[x] only Reference(RelatedPerson)
* extension[mother] ^short = "Sub-extensão para indicar a mãe"
* extension[father] ^short = "Sub-extensão para indicar o pai"


Extension: ptPatientOtherInfo
Id:       ptPatientOtherInfo
Title:    "OUTRA INDICAÇÃO"
Description: "Extensão referente a informações sobre o utente"
* ^url = "http://spms.min-saude.pt/iop/extensions/med-patient-info"
* value[x] only string


//// ENCOUNTER ////


Extension: episodeServiceSpecialty
Id:       episodeServiceSpecialty
Title:    "CÓDIGO ESPECIALIDADE CONSULTA"
Description: "Extensão para indicar o código e a descrição da especialidade médica da consulta ou da prestação"
* ^url = "http://spms.min-saude.pt/iop/extensions/episode-service-specialty"
* value[x] only CodeableConcept
* value[x] from episodeServiceSpecialtyVS (required)


Extension: nextAppointmentDate
Id:       nextAppointmentDate
Title:    "DATA PROXIMA CONSULTA"
Description: "Extensão para indicar a data e hora da próxima consulta da mesma especialidade no mesmo âmbito da emissão da prescrição"
* ^url = "http://spms.min-saude.pt/iop/extensions/next-specialty-appointment-date"
* value[x] only dateTime


/// COVERAGE ////


Extension: CardInfo
Id:       CardInfo
Title:    "Informações sobre o cartão do beneficiário relativo a entidade"
Description: "Extensão para indicar a data e hora da próxima consulta da mesma especialidade no mesmo âmbito da emissão da prescrição"
* ^url = "http://spms.min-saude.pt/iop/extensions/coverage-card-info"

* extension contains
    card-type 1..1 MS and
    card-country 0..1 MS 
* extension[card-type].value[x] only CodeableConcept
* extension[card-type].value[x] from CardInfoTypeVS (required)

* extension[card-country].value[x] only CodeableConcept
* extension[card-country].value[x] from CardCountryVS (required)
