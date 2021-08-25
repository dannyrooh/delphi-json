{ ***************************************************************************
 Dannyrooh Fernandes | https://github.com/dannyrooh | Licença MIT

 1) realiza consulta da cotação do Banco Central
 2) monta uma pagina com BootStrap e Chart.js

 08/2021 - created

 *************************************************************************** }
unit View.Main;

interface

uses
  Cotacao.Dolar.Proxy,
  Cotacao.Dolar.Entity,
  Json.Util,
  System.DateUtils,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WebView2, Winapi.ActiveX, Vcl.StdCtrls,
  Vcl.Edge, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.WinXCtrls;

type
  TForm1 = class(TForm)
    EdgeBrowser1: TEdgeBrowser;
    pnlHeader: TPanel;
    edtInicial: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    edtFinal: TDateTimePicker;
    pageMain: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    mmoHTML: TMemo;
    onlSide: TPanel;
    mmoJson: TMemo;
    Button2: TButton;
    Panel1: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FCacheHtml: String;
    FCotacao: TArray<TCotacaoDolarEntity>;
    procedure ClearCotacao;
    procedure montarHtml;
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button2Click(Sender: TObject);
var
  msgErro: string;
begin
  ClearCotacao;

  if not TCotacaoDolarProxy.CotacaoPeriodo(
    edtInicial.Date,
    edtFinal.Date,FCotacao,
    msgErro
  ) then
  begin
    EdgeBrowser1.Navigate( 'about:blank' );
    mmoHTML.Clear;
    mmoJson.Clear;
    ShowMessage('Nenhum registro encontrado!')
  end
  else
  begin
    TButton(Sender).Enabled := false;
    try
      mmoJson.Lines.Clear;
      mmoJson.Lines.Add( TJsonUtil.Array.Decode<TCotacaoDolarEntity>(FCotacao));
      montarHtml;
    finally
      TButton(Sender).Enabled := true;
    end;
  end;
end;

procedure TForm1.ClearCotacao;
begin
  if Assigned(FCotacao) then
    for var item in FCotacao do
      FreeAndNil(item);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  //armazena o html com as marcações
  FCacheHtml := mmoHTML.Lines.Text;

  edtFinal.Date := Now;
  edtInicial.Date := IncMonth(edtFinal.Date,-1);

  //inicializa o browser
  EdgeBrowser1.UserDataFolder := ExtractFileDir(Application.ExeName);
  EdgeBrowser1.Navigate('about:blank');

  //verificar vazamento de memória
  ReportMemoryLeaksOnShutdown := True;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  ClearCotacao;
end;

procedure TForm1.montarHtml;
var
  minima, maxima, media: double;
  datasetdata, datalabel: string;

  fs: TFormatSettings;
begin
  var html := FCacheHtml;

  minima := MaxCurrency;
  maxima := MinCurrency;
  media := 0;

  fs := TFormatSettings.Create('en-US');

  datasetdata := EmptyStr;
  datalabel := EmptyStr;

  for var item in FCotacao do
  begin

    //header
    media := media + item.cotacaoVenda;

    if item.cotacaoVenda > maxima then
      maxima := item.cotacaoVenda;

    if item.cotacaoVenda < minima then
      minima := item.cotacaoVenda;

    //label
    datalabel := datalabel + ','+
      QuotedStr(
        FormatDateTime('dd-mmm',TJsonUtil.DateTime.Decode(item.dataHoraCotacao)
      )
    );

    //dataset
    datasetdata := datasetdata + ','+ FloatToStr( item.cotacaoVenda ,fs );
  end;

  media := media / Length(FCotacao);

  Delete(datasetdata,1,1);
  Delete(datalabel,1,1);

  //localiza as marcações no Html e faz a substituição
  mmoHTML.Lines.Text :=
    html
      .Replace('{{datalabel}}',datalabel)
      .Replace('{{datasetdata}}',datasetdata)

      .Replace('{{minimo}}',FloatToStr( minima ,fs ))
      .Replace('{{media}}',FormatFloat('0.0000', media ,fs ))
      .Replace('{{maxima}}',FloatToStr( maxima ,fs ))

      //valores máximo e mínimos do eixo y
      .Replace('{{preco_minimo}}',FloatToStr( minima-(minima*0.07) ,fs ))
      .Replace('{{preco_maximo}}',FloatToStr( maxima+(maxima*0.07) ,fs ))

      .Replace('{{Periodo}}',Format('Período de %s à %s',
        [
          DateToStr(edtInicial.Date),
          DateToStr(edtFinal.Date)
        ]))
      ;

  EdgeBrowser1.NavigateToString( mmoHTML.Lines.Text );

end;

end.
