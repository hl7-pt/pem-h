A Prescrição de Medicação vem responder à necessidade de maior interoperabilidade entre as diversas aplicações externas/terceiras da SPMS no âmbito da prescrição de medicamentos e produtos farmacêuticos. As operações relacionadas à Prescrição de Medicação são representadas a seguir:

| Operação                       | Código  | Descrição                                   |
|--------------------------------|---------|---------------------------------------------|
| MED_PRESCRIPTION_NEW           | 10911   | Prescrever Medicação                        |
| MED_PRESCRIPTION_ACK           | 10917   | Retorno da Prescrição da Medicação          |
| MED_PRESCRIPTION_CANCEL        | 10912   | Cancelar Prescrição de Medicação            |
| MED_PRESCRIPTION_CANCEL_ACK    | 10923   | Retorno de Cancelar Prescrição da Medicação |


**caracterização dos pedidos**
| Evento                                  | Protocolo de Comunicação | Método | URL do endpoint                                                       | Accept-Charset | Header                                                                                                                             |
|-----------------------------------------|--------------------------|--------|-----------------------------------------------------------------------|----------------|------------------------------------------------------------------------------------------------------------------------------------|
| 10724 MED_PRESCRIPTION_SYNCHRO NIZATION | HTTP REST                | Post   | http://<hostname\>:<porta\>/fhirServerDstu3$process-message?async=true | UTF-8          | **Content-Type:** application/json   **Authorization.Type:** Basic  **Authorization.Username:** <requisitar\>  **Authorization.Password:** <requisitar\> |



De forma a cumprir o standard HL7 FHIR, uma Prescrição de Medicação deve ir empacotado num Bundle cujo recurso principal é o recurso RequestGroup.

Os recursos presentes no bundle serão:
###  A. Bundle da mensagem de pedido
O Bundle da mensagem deve ser do tipo "message", deve ter como primeira entrada o recurso MessageHeader, e como segunda o recurso.

### A1) Informações complementares sobre a assinatura
Informaçõo adaptada de: https://www.hl7.org/fhir/stu3/datatypes.html#Signature
Quando a assinatura é uma XML Digital Signature (contentType = application / signature + xml), as seguintes regras se aplicam:
* O Signature.blob é uma assinatura XML codificada em base64;
* A assinatura XML é uma assinatura Detached   (onde o conteúdo que é assinado e separado da própria assinatura);
* A assinatura DEVE estar em conformidade com XAdES-X-L para dar suporte a assinaturas de longo prazo. A especificação XAdES-X-L adiciona o carimbo de data / hora da assinatura, inclusão do certificado da assinatura e a declaração de revogação;
Existem três níveis de verificação da assinatura:
* Verificar se o bloco da assinatura digital em si tem integridade por meio da verificação da assinatura na assinatura XML; 
* Confirmação de que o signatário é autêntico, não revogado e adequado ao propósito da assinatura;
* Confirmar que o conteúdo de interesse assinado não foi modificado usando o algoritmo de hash.
Desvios dessas regeas precisam ser expressas e enumeradas no bloco XML-Signature. Por exemplo, alguns ambientes podem escolher um perfil XAdES diferente, algoritmo de hashing, identificador de política ou vocabulário depropósito de assinatura. A assinatura pode ser usada nos seguintes rerursos: Bundle, Contract e Provenance.
Assinatura, Independente

A assinatura é sobre o conteúdo externo ao elemento de assinatura e pode ser identificada por meio de um URI ou transformação. Consequentemente, a assinatura é "separada" do conteúdo que assina. Essa definição normalmente se aplica a objetos de dados separados, mas também inclui a instância em que a assinatura e o objeto de dados residem no mesmo documento XML, mas são elementos "irmãos".

### A2) MessageHeader
Este recurso deve ser a primeira entrada no Bundle e deve referenciar (focus) o recurso MedicationRequest.

### A3) RequestGroup
Este recurso representa a receita (Número da receita, local e central, número da linha e a data de validade ).

### A4) MedicationRequest
Este recurso contém informações da linha da receita.

### A5) Medication
Este recurso representa o medicamento que é referenciado pelo recurso MedicationRequest.

### A6) Patient
Utente a quem diz respeito a prescrição de medicação.

#### RelatedPerson
Este recurso é complementar ao recurso PATIENT para atender a extensão sobre a filiação do utente "patient-parents" (Mother/Father).
Especificidades do recurso Patient
Na tabela a seguir são apresentados elementos do recurso Patient (item A6 desta especificação) com especificidades para essa Especificação
Técnica. Para os demais campos seguem as regras definidas no respectivo perfil.


### A7) Encounter
Recurso que caracteriza o episódio a partir do qual a prescrição de medicação está a ser solicitada.

### A8) Coverage
Recurso utilizado para representar a relação entre beneficiário (utente) e a entidade responsável. Este recurso é referenciado no recurso Patient numa extensão própria.

### A9) Location 
Recurso utilizado para representar informação sobre o local de prescrição da medicação


