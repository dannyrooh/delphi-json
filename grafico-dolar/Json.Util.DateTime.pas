{ ***************************************************************************
 Dannyrooh Fernandes | https://github.com/dannyrooh | Licença MIT

 converte string para TDateTime e TDateTime para string

 08/2021 - created

 *************************************************************************** }
unit Json.Util.DateTime;

interface

uses
  System.SysUtils,
  System.Math;

type
  TClassJsonUtilDateTime = class of TJsonUtilDateTime;

  TJsonUtilDateTime = class
  private
    class function FormatSettingsData: TFormatSettings;
  public
    class function Decode(value: string; const dataDefault: TDateTime = 0): TDateTime;
    class function Encode(value: TDateTime; const dataDefault: TDateTime = 0): string;
  end;

implementation

{ TJsonAsDatetime }

class function TJsonUtilDateTime.Decode(value: string; const dataDefault: TDateTime): TDateTime;
begin
  result := StrToDateTimeDef(value,dataDefault, self.FormatSettingsData);
end;

class function TJsonUtilDateTime.Encode(value: TDateTime;
  const dataDefault: TDateTime): string;
begin
  result := DateTimeToStr(ifthen(value = 0, dataDefault,value),self.FormatSettingsData);
end;

class function TJsonUtilDateTime.FormatSettingsData: TFormatSettings;
begin
  result := TFormatSettings.Create;
  result.DateSeparator := '-';
  result.ShortDateFormat := 'yyyy-MM-dd';
  result.TimeSeparator := ':';
  result.ShortTimeFormat := 'hh:mm';
  result.LongTimeFormat := 'hh:mm:ss';
end;

end.
