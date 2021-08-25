{ ***************************************************************************
 Dannyrooh Fernandes | https://github.com/dannyrooh | Licença MIT

 Recuperar o conteúdo de uma URL

 08/2021 - created

 *************************************************************************** }
unit Http.Util;

interface

uses
  IdHttp,
  IdSSLOpenSSL,

  System.Classes,
  System.SysUtils;

type
  THttpUtil = class
  const
    MSG_ERRO_CONEXAO = 'Verifique a sua conexão com a internet!';
  private
    function getResponse(url: string): TBytes;
    function bytesToString(value: TBytes): string;
  public
    class function Get(url: string): string;
  end;

implementation

{ THttpHtil }

function THttpUtil.bytesToString(value: TBytes): string;
begin

  var lEncoding : TEncoding := nil;
  var lSize := TEncoding.GetBufferEncoding(value, lEncoding);
  result := lEncoding.GetString(value, lSize, Length(value) - lSize);

end;

class function THttpUtil.Get(url: string): string;
var
  ctx: THttpUtil;
  response: TBytes;
begin

  ctx := THttpUtil.Create;
  try

    try
      response := ctx.getResponse( url );
    except
      on e: Exception do
        raise Exception.Create(MSG_ERRO_CONEXAO);
    end;

    result := ctx.bytesToString(response);

  finally
    FreeAndNil(ctx);
  end;

end;

function THttpUtil.getResponse(url: string): TBytes;
begin
  var http := TIdHTTP.Create(nil);

   //tratamento para evitar erro de SSL3
   var handler := TIdSSLIOHandlerSocketOpenSSL.Create(http);
   handler.SSLOptions.SSLVersions := [sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2];
   http.IOHandler := handler;

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
      FreeAndNil(handler);
      FreeAndNil(http);
      FreeAndNil(response);
   end;


end;

end.
