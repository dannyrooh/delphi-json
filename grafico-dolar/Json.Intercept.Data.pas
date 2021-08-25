unit Json.Intercept.Data;

interface

uses
  Dialogs,
  Rest.Json,
  System.Json,

  REST.JsonReflect,

  System.DateUtils,
  system.SysUtils,
  System.Rtti;


type

  TFormatSettingsBR = class
  public
    class function fs:TFormatSettings;
  end;

  TSuppressZeroDateInterceptor = class(TJSONInterceptor)
  public
    function StringConverter(Data: TObject; Field: string): string; override;
    procedure StringReverter(Data: TObject; Field: string; Arg: string); override;
  end;

  SuppressZeroAttribute = class(JsonReflectAttribute)
  public
    constructor Create;
  end;

implementation

{ TSuppressZeroDateInterceptor }

function TSuppressZeroDateInterceptor.StringConverter(Data: TObject;
  Field: string): string;
var
  ctx: TRTTIContext;
  date: TDateTime;
begin
  showmessage('StringConverter');
  date := ctx.GetType(Data.ClassType).GetField(Field).GetValue(Data).AsType<TDateTime>;
  if date = 0 then begin
    result := EmptyStr;
  end
  else begin
    //result := DateToISO8601(date, True);
    result := DateTimeToStr(date,TFormatSettingsBR.fs);
  end;
end;

procedure TSuppressZeroDateInterceptor.StringReverter(Data: TObject; Field, Arg: string);
var
  ctx: TRTTIContext;
  date: TDateTime;
begin
  showmessage('StringReverter');
  if Arg.IsEmpty then
    date := 0
  else
    date := StrToDateTimeDef(Arg,0, TFormatSettingsBR.fs);

  ctx.GetType(Data.ClassType).GetField(Field).SetValue(Data, date);
end;

{ SuppressZeroAttribute }

constructor SuppressZeroAttribute.Create;
begin
  inherited Create(ctString, rtString, TSuppressZeroDateInterceptor);
end;

{ TFormatSettingsBR }

class function TFormatSettingsBR.fs: TFormatSettings;
begin
  result := TFormatSettings.Create;
  result.DateSeparator := '-';
  result.ShortDateFormat := 'yyyy-MM-dd';
  result.TimeSeparator := ':';
  result.ShortTimeFormat := 'hh:mm';
  result.LongTimeFormat := 'hh:mm:ss';
end;

end.
