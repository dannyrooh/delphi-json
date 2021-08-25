{ ***************************************************************************
 Dannyrooh Fernandes | https://github.com/dannyrooh | Licença MIT

 classe de teste

 08/2021 - created

 *************************************************************************** }
unit Cotacao.Dolar.Proxy.Teste;

interface

uses
  Cotacao.Dolar.Entity,
  Json.Util,

  IdHttp,
  IdSSLOpenSSL,

  Rest.Json,
  System.Json,

  System.Classes,
  System.SysUtils,
  System.RegularExpressions;

CONST
  COTACAODIA = '{"cotacaoCompra": 5.1972,"cotacaoVenda": 5.1978,"dataHoraCotacao": "2021-07-22 13:06:20"}';

  COTACAOMES = '[' +
        '{"cotacaoCompra": 5.0049,"cotacaoVenda": 5.0055,"dataHoraCotacao": "2021-07-01 13:03:46.579"},'+
        '{"cotacaoCompra": 5.0287,"cotacaoVenda": 5.0293,"dataHoraCotacao": "2021-07-02 13:08:30.132"},'+
        '{"cotacaoCompra": 5.0743,"cotacaoVenda": 5.0749,"dataHoraCotacao": "2021-07-05 13:03:50.569"}'+
        ']';

type
  TCotacaoDolarProxyTextLocal = class
  public
    //converte o Json em TClasse
    class function Cotacao: TCotacaoDolarEntity;
    class function cotacaoJson: string;

    class function Cotacoes: TArray<TCotacaoDolarEntity>;
    class function CotacoesJson: string;
  end;

implementation

{ TCotacaoDolarProxyText }

class function TCotacaoDolarProxyTextLocal.Cotacao: TCotacaoDolarEntity;
begin
  result := TJsonUtil.Entity.Encode<TCotacaoDolarEntity>(COTACAODIA);
end;

class function TCotacaoDolarProxyTextLocal.cotacaoJson: string;
begin
  var c := Cotacao;
  result := TJsonUtil.Entity.Decode(c);
  FreeAndNil(c);
end;

class function TCotacaoDolarProxyTextLocal.Cotacoes: TArray<TCotacaoDolarEntity>;
begin
  result := TJsonUtil.Array.Encode<TCotacaoDolarEntity>(COTACAOMES);
end;

class function TCotacaoDolarProxyTextLocal.CotacoesJson: string;
begin
  var a := Cotacoes;
  result := TJsonUtil.Array.Decode<TCotacaoDolarEntity>(a);
  for var item in a do
      item.Free;
end;

end.
