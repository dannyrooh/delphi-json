program cotacao_dolar;

uses
  Vcl.Forms,
  View.Main in 'View.Main.pas' {ViewMain},
  Cotacao.Dolar.Entity in 'Cotacao.Dolar.Entity.pas',
  Cotacao.Dolar.Proxy in 'Cotacao.Dolar.Proxy.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TViewMain, ViewMain);
  Application.Run;
end.
