{ ***************************************************************************
 Dannyrooh Fernandes | https://github.com/dannyrooh | Licen�a MIT

 Mapeamento do d�lar

 08/2021 - created

*************************************************************************** }
unit Cotacao.Dolar.Entity;

interface

{$M+}

type
  TCotacaoDolarEntity = class
  private
    FcotacaoVenda: double;
    FcotacaoCompra: double;
    FdataHoraCotacao: string;
  published
    property cotacaoCompra: double read FcotacaoCompra write FcotacaoCompra;
    property cotacaoVenda: double read FcotacaoVenda write FcotacaoVenda;
    property dataHoraCotacao: string read FdataHoraCotacao write FdataHoraCotacao;
  end;


implementation

end.
