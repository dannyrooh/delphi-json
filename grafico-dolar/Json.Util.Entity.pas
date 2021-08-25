{ ***************************************************************************
 Dannyrooh Fernandes | https://github.com/dannyrooh | Licença MIT

 converte string para object e objeto para string

 08/2021 - created

 *************************************************************************** }
unit Json.Util.Entity;

interface

uses
  Rest.Json,
  System.Json,
  system.SysUtils;

type
  TClassJsonUtilEntity = class of TJsonUtilEntity;

  TJsonUtilEntity = class
  public
    class function Encode<T: class, constructor>(value: string): T;
    class function Decode(value: TObject): string;
  end;

implementation

{ TJsonUtilEntity }

class function TJsonUtilEntity.Decode(value: TObject): string;
begin
  result := TJson.ObjectToJsonString(value);
end;

class function TJsonUtilEntity.Encode<T>(value: string): T;
begin
  var jsonValue := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(value), 0);
  try
    result := TJson.JsonToObject<T>( TJSONObject(jsonValue) );
  finally
    if Assigned(jsonValue) then
      jsonValue.Free;
  end;
end;

end.
