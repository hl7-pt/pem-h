O fluxo de prescrição de medicação é um fluxo síncronopara a aplicação emissora.
Assim que a IOP recebe uma mensagem do cliente emissor com a prescrição de medicação, e após validação estrutural da mesma, envia um
ACK de transporte para o cliente emissor. Seguidamente envia a mensagem para o cliente destino.
Caso o cliente destino tenha sido configurado para receber uma resposta deprocessamento síncrono, quando processa a mensagem, a aplicação cliente destino deve enviar para uma mensagem de resposta a indicar o resultado do processamento dessa mensagem.
Caso o cliente destino tenha sido configurado para receber uma resposta de processamento assíncrono,depois de processar a mensagem, o cliente destino deve enviar um ACK Aplicacional com o resultado do processamento da mensagem.

### B1) Bundle da mensagem de resposta
O Bundle da mensagem de resposta deve ser do tipo "message", deve ter como primeira entrada o recurso MessageHeader, e como segunda o recurso OperationOutcome (MessageHeader.response.details) caso exista algum problema na recepção ou processamento da mensagem.


### B1.1) MessageHeader
Este recurso deve ser a primeira entrada no Bundledas mensagens resposta de ACK de transporte e aplicacional, e deve trazer informação sobre o resultadoda recepção ou processamento da mensagem pelo cliente destino.

### B1.2) RequestGroup
Este recurso representa o retorno da receita quando ocorre o sucesso na recepção/processamento da mensagem.
Para além disso, esse recurso contêm elementos que compõem a receita gerados somente no retorno da receita, como o "Número Central da
Receita" e o "Pin da Receita".

### B1.3) OperationOutcome
Recurso que representa informação detalhada sobre problemas encontradosna recepção da mensagem pela IOP ou pelos cliente destino, ou no processamento da prescrição de medicação.
