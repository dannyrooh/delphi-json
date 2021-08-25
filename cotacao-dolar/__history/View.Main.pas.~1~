unit View.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls;

type
  TViewMain = class(TForm)
    Button1: TButton;
    dtpCotacao: TDateTimePicker;
    Label1: TLabel;
    edtCotacao: TEdit;
    Label2: TLabel;
    edtPrecoVenda: TEdit;
    Label3: TLabel;
    edtPrecoCompra: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ViewMain: TViewMain;

implementation

uses
  Cotacao.Dolar.Proxy;


{$R *.dfm}

procedure TViewMain.Button1Click(Sender: TObject);
var
  venda, compra: double;
  cotacao: TDateTime;
begin

  //uso da classe
  if TCotacaoDolarProxy.Exec(dtpCotacao.Date, venda, compra, cotacao ) then
  begin
    edtCotacao.Text := DateTimeToStr(Cotacao);
    edtPrecoVenda.Text := FloatToStr(venda);
    edtPrecoCompra.Text := FloatToStr(compra);
  end
  else begin
    edtCotacao.Clear;
    edtPrecoVenda.Clear;
    edtPrecoCompra.Clear;
  end;

  //usado para validar o gerenciamento de memória  em tempo de teste
  ReportMemoryLeaksOnShutdown := True;
end;

procedure TViewMain.FormCreate(Sender: TObject);
begin
  dtpCotacao.Date := Now();
end;

end.
