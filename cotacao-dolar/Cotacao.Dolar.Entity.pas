{ ***************************************************************************
 Dannyrooh Fernandes | https://github.com/dannyrooh | Licen?a MIT

 1) Entity

 08/2021 - created

 *************************************************************************** }
unit Cotacao.Dolar.Entity;

interface

{$M+}

type
  TCotacaoDolarEntity = class
  private
    FcotacaoVenda: double;
    FdataHoraCotacao: string;
    FcotacaoCompra: double;
  published
    property cotacaoCompra: double read FcotacaoCompra write FcotacaoCompra;
    property cotacaoVenda: double read FcotacaoVenda write FcotacaoVenda;
    property dataHoraCotacao: string read FdataHoraCotacao write FdataHoraCotacao;
  end;


implementation

end.
