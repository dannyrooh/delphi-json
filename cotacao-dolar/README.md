# Cotação do Dólar
---

Este exemplo tem como finalidade buscar a cotação oficial do dólar, consumindo a API do Bacen (Banco Central do Brasil) em Json, e retornar a data e hora da cotação, preço de compra e venda.

> Para saber mais sobre o projeto de dados abertos do Banco Central do Brasil, acesse o link <https://olinda.bcb.gov.br/olinda/servico/Expectativas/versao/v1/documentacao>


## Versão utilizada do Delphi

Delphi Community 10.4

## O que foi utilizado

- Regex
  
    Utilizado para pegar somente o conteúdo de value, utilizado o pattern **(?<=\[).*?(?=\])** com  __TRegex.Match__ da unit __System.RegularExpressions__

    **Pattern** 
    >Retorna tudo que estiver entre colchetes 
    ~~~~
    (?<=\[).*?(?=\])
    ~~~~
    
    ~~~~delphi 
    {"@odata.context": "https://was-p.bcnet.bcb.gov.br/olinda/servico/PTAX/versao/v1/odata$metadata#_CotacaoDolarDia(cotacaoCompra,cotacaoVenda,dataHoraCotacao)",
    "value": [ {
                "cotacaoCompra": 5.2404,
                "cotacaoVenda": 5.241,
                "dataHoraCotacao": "2021-08-06 13:11:22.291"
                } ]
  }

  retorno

  {"cotacaoCompra": 5.2404,
   "cotacaoVenda": 5.241,
   "dataHoraCotacao": "2021-08-06 13:11:22.291"
  } 

  ~~~~

- Http
    
     Executa o get na url e retorna os dados em Stream
    > unit __IdHTTP__ , classe __TIdHTTP__

- Conversão de Stream em String 
   > TEncoding.GetBufferEncoding

- Conversão de um string Json para uma um objeto<T>  __Generics__
   > TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(strJson), 0)

   >  TJson.JsonToObject\<T>


## Uses

* IdHTTP
* IdSSLOpenSSL
  
* System.JSON
* Rest.Json

* System.Classes,
* System.SysUtils,
* System.RegularExpressions
