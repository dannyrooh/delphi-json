{ ***************************************************************************
 Dannyrooh Fernandes | https://github.com/dannyrooh | Licença MIT

 Consulta a cotação do dólar entre duas datas

 08/2021 - created

 *************************************************************************** }
unit Cotacao.Dolar.Proxy;

interface

uses
  Cotacao.Dolar.Entity,
  Json.Util,
  Http.Util,
  Bcb.Servico.Url,

  System.SysUtils;

type
  TCotacaoDolarProxy = class
  const
    NOT_FOUND_COTACAO =  'Not found values';
  public
    class function CotacaoPeriodo(dataInicial, datafinal: TDateTime;
      out cotacoes: TArray<TCotacaoDolarEntity>;
      out msgErro: string): boolean;
  end;

implementation

{ TCotacaoDolarProxy }

class function TCotacaoDolarProxy.CotacaoPeriodo(dataInicial,
  datafinal: TDateTime; out cotacoes: TArray<TCotacaoDolarEntity>;
  out msgErro: string): boolean;
var
  json: string;
begin
  try
    //return string Json
    json := THttpUtil.Get(
      TBcbServicoUrl.CotacaoDolarPeriodo( dataInicial, datafinal )
    );
  except
    on e: exception do
    begin
      result := false;
      msgErro := e.Message;
      exit;
    end;
  end;

  //return dataValues
  json := TJsonUtil.Content.Value(json);

  //isEmpty?
  if json.IsEmpty or (json.CompareTo('[]') = 0) then
  begin
    result := false;
    msgErro := NOT_FOUND_COTACAO;
    exit;
  end;

  //stringJson to TArray<TCotacaoDolarEntity>
  cotacoes := TJsonUtil.Array.Encode<TCotacaoDolarEntity>(json);

  result := Length(cotacoes) > 0;

end;

end.
