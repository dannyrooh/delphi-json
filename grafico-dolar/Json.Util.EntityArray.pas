{ ***************************************************************************
 Dannyrooh Fernandes | https://github.com/dannyrooh | Licença MIT

 recorta uma string json, pegando somente parte da string

 08/2021 - created

 *************************************************************************** }
unit Json.Util.EntityArray;

interface

uses
  Rest.Json,
  System.Json,
  system.SysUtils;

type
  TClassJsonUtilEntityArray = class of TJsonUtilEntityArray;

  TJsonUtilEntityArray = class
  public
    class function Encode<T: class, constructor>(value: string): TArray<T>;
    class function Decode<T: class>(value: TArray<T>): string;
  end;

implementation

{ TJsonUtilEntityArray }

class function TJsonUtilEntityArray.Decode<T>(value: TArray<T>): string;
begin

  result := ',';

  for var v in value do
    result := result + TJson.ObjectToJsonString(v);
  delete(result,1,1);

  result := '['+result+']';

end;

class function TJsonUtilEntityArray.Encode<T>(value: string): TArray<T>;
begin

  var jsonArr := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(value), 0) as TJSONArray;

  var index := 0;
  SetLength(Result,index);
  for var jsonVal: TJSONValue in jsonArr do
  begin
    SetLength(Result, succ(index));
    Result[index] := TJson.JsonToObject<T>( TJSONObject(jsonVal) );
    inc(index);
  end;

  jsonArr.Free;

end;

end.
