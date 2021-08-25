{ ***************************************************************************
 Dannyrooh Fernandes | https://github.com/dannyrooh | Licença MIT

 Retorna parte do Json que estiverem entre [ ]

 08/2021 - created

 *************************************************************************** }
unit Json.Util.Content;

interface

uses
  System.RegularExpressions;

type
  TClassJsonUtilContent = class of TJsonUtilContent;

  TJsonUtilContent = class
  const
    PATTERN_WITH_BRACKES = '\[(.+)\]';
    PATTERN_WITHOUT_BRACKES = '(?<=\[).*?(?=\])';
  private
    class function Bracks(removeBrackes: boolean): string;
  public
    class function Value(jsonString: string; const removeBrackes: boolean = false): string;
  end;


implementation


{ TJsonUtilContent }

class function TJsonUtilContent.Bracks(removeBrackes: boolean): string;
begin
  if removeBrackes then
    result := PATTERN_WITHOUT_BRACKES
  else
    result := PATTERN_WITH_BRACKES
end;

class function TJsonUtilContent.Value(jsonString: string;
  const removeBrackes: boolean): string;
begin
  result := '';
  var r := TRegex.Match(jsonString, Bracks(removeBrackes) );
  if r.Success then
    result := r.value;
end;

end.
