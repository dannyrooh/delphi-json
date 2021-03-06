{ ***************************************************************************
 Dannyrooh Fernandes | https://github.com/dannyrooh | Licen?a MIT

 1) Classe para realizar a busca do cota??o do d?lar

 08/2021 - created

 *************************************************************************** }
unit Cotacao.Dolar.Proxy;

interface

uses
  Cotacao.Dolar.Entity,

  IdHttp,
  IdSSLOpenSSL,

  Rest.Json,
  System.Json,

  System.Classes,
  System.SysUtils,
  System.RegularExpressions;

type
  TCotacaoDolarProxy = class
  const
    COTACAO_URL = 'https://olinda.bcb.gov.br/olinda/servico/PTAX/versao/v1/odata/CotacaoDolarDia(dataCotacao=@dataCotacao)?@dataCotacao=%S&$top=100&$format=json&$select=cotacaoCompra,cotacaoVenda,dataHoraCotacao';
    PATTERN_COM_COLCHETES = '\[(.+)\]';
    PATTERN_SEM_COLCHETES = '(?<=\[).*?(?=\])';
    MSG_ERRO_CONEXAO = 'Verifique a sua conex?o com a internet!';
  strict private
     class function getUrl(data: TDateTime): string;
     class function getResponse(url: string): TBytes;
     class function bytesToString(value: TBytes): string;
     class function cutValue(valueJson: string): string;
     class function jsonStringToObject(valueJson: string): TCotacaoDolarEntity;
     class function getDataHora(value: string): TDateTime;
  public
    class function Exec(data: TDateTime; out precoVenda, precoCompra: double; out datahoracotacao: TDateTime): boolean;
  end;

implementation

{ TCotacaoDolarProxy }

class function TCotacaoDolarProxy.bytesToString(value: TBytes): string;
begin
  var lEncoding : TEncoding := nil;
  var lSize := TEncoding.GetBufferEncoding(value, lEncoding);
  result := lEncoding.GetString(value, lSize, Length(value) - lSize);
end;

class function TCotacaoDolarProxy.cutValue(valueJson: string): string;
begin
  result := '';
  var r := TRegex.Match(valueJson,Self.PATTERN_SEM_COLCHETES);
  if r.Success then
    result := r.value;
end;

class function TCotacaoDolarProxy.Exec(data: TDateTime; out precoVenda,
  precoCompra: double;out datahoracotacao: TDateTime): boolean;
var
  response: TBytes;
begin
  //Monta a url para envio
  var url := self.getUrl(data);

  //acessa a API e retorno o conte?do da consulta
  try
    response := self.getResponse( url );
  except
    on e: Exception do
      raise Exception.Create(MSG_ERRO_CONEXAO);
  end;

  //converte o resposne Bytes em string json
  var json := self.bytesToString(response);

  //recorta a parte do value para fazer a convers?o da data
  var value := self.cutValue(json);

  result := not value.IsEmpty;
  //n?o h? valor no dia informado
  if not result then
    Exit;

  //converte o json de value em TContacaoDolarEntity
  var cotacao := self.jsonStringToObject(value);
  try
    //retorna os dados da classe para tipos primitivos
    precoVenda := cotacao.cotacaoVenda;
    precoCompra := cotacao.cotacaoCompra;
    datahoracotacao := getDataHora(cotacao.dataHoraCotacao);
  finally
    if Assigned(cotacao) then
      FreeAndNil(cotacao);
  end;
end;

class function TCotacaoDolarProxy.getDataHora(value: string): TDateTime;
var
  fs: TFormatSettings;
  s: string;
  dt: TDateTime;
begin
  fs := TFormatSettings.Create;
  fs.DateSeparator := '-';
  fs.ShortDateFormat := 'yyyy-MM-dd';
  fs.TimeSeparator := ':';
  fs.ShortTimeFormat := 'hh:mm';
  fs.LongTimeFormat := 'hh:mm:ss';

  result := StrToDateTimeDef(value,0, fs);
end;

class function TCotacaoDolarProxy.getResponse(url: string): TBytes;
begin
   var http := TIdHTTP.Create(nil);

   //tratamento para evitar erro de SSL3
   var FHandler := TIdSSLIOHandlerSocketOpenSSL.Create(http);
   FHandler.SSLOptions.SSLVersions := [sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2];
   http.IOHandler := FHandler;

   var response := TMemoryStream.Create;
   try
     http.Get(url,response);
     if response.Size > 0 then
     begin
       SetLength(result, response.Size );
       response.Position := 0;
       response.ReadBuffer(Pointer(result)^, response.Size);
     end;
   finally
      FreeAndNil(FHandler);
      FreeAndNil(http);
      FreeAndNil(response);
   end;
end;

class function TCotacaoDolarProxy.getUrl(data: TDateTime): string;
begin
  result := Format(Self.COTACAO_URL, [ quotedStr( FormatDateTime('MM-DD-YYYY', (data))) ]);
end;

class function TCotacaoDolarProxy.jsonStringToObject(
  valueJson: string): TCotacaoDolarEntity;
begin
  var jsonValue := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(valueJson), 0);
  try
    result := TJson.JsonToObject<TCotacaoDolarEntity>( TJSONObject(jsonValue) );
  finally
    if Assigned(jsonValue) then
      jsonValue.Free;
  end;
end;

end.
