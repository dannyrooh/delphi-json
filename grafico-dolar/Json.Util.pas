{ ***************************************************************************
 Dannyrooh Fernandes | https://github.com/dannyrooh | Licença MIT

 Concentra as chamadas das classes de Json

 08/2021 - created

 *************************************************************************** }
unit Json.Util;

interface

uses
  Json.Util.Entity,
  Json.Util.EntityArray,
  Json.Util.Content,
  Json.Util.DateTime,

  System.SysUtils;

type
  TJsonUtil = class
  public
    //converte string para object e objeto para string
    class function Entity: TClassJsonUtilEntity;
    //converte string para TArray<T> e TArray<T> para string
    class function &Array: TClassJsonUtilEntityArray;
    //recorta uma string json, pegando somente parte da string
    class function Content: TClassJsonUtilContent;
    //conversão da string para TDateTime
    class function DateTime: TClassJsonUtilDateTime;
  end;

implementation

{ TJsonUtil }

class function TJsonUtil.&Array: TClassJsonUtilEntityArray;
begin
  result := TJsonUtilEntityArray;
end;

class function TJsonUtil.Content: TClassJsonUtilContent;
begin
  result := TJsonUtilContent;
end;

class function TJsonUtil.DateTime: TClassJsonUtilDateTime;
begin
  result := TJsonUtilDateTime;
end;

class function TJsonUtil.Entity: TClassJsonUtilEntity;
begin
  result := TJsonUtilEntity;
end;

end.
