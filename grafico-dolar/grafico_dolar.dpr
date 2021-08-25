program grafico_dolar;

uses
  Vcl.Forms,
  View.Main in 'View.Main.pas' {Form1},
  Cotacao.Dolar.Entity in 'Cotacao.Dolar.Entity.pas',
  Cotacao.Dolar.Proxy.Teste in 'Cotacao.Dolar.Proxy.Teste.pas',
  Cotacao.Dolar.Proxy in 'Cotacao.Dolar.Proxy.pas',
  Json.Util.DateTime in 'Json.Util.DateTime.pas',
  Json.Util.Entity in 'Json.Util.Entity.pas',
  Json.Util.EntityArray in 'Json.Util.EntityArray.pas',
  Json.Util in 'Json.Util.pas',
  Json.Util.Content in 'Json.Util.Content.pas',
  Http.Util in 'Http.Util.pas',
  Bcb.Servico.Url in 'Bcb.Servico.Url.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
