{ ***************************************************************************
 Dannyrooh Fernandes | https://github.com/dannyrooh | Licença MIT

 mapeametno da url

 08/2021 - created

 *************************************************************************** }
unit Bcb.Servico.Url;

interface

uses
  System.SysUtils;


type
  TBcbServicoUrl = class
  strict private
    const
      URL_BCB_SERVICO = 'https://olinda.bcb.gov.br/olinda/servico/PTAX/versao/';
      URL_BCB_SERVICO_V1 = 'v1/odata/';

      URL_BCB_SERVICO_COTACAO_DOLAR_PERIODO =
        URL_BCB_SERVICO +
        URL_BCB_SERVICO_V1 +
        'CotacaoDolarPeriodo(dataInicial=@dataInicial,dataFinalCotacao=@dataFinalCotacao)?' +
        '@dataInicial=:dataInicial' +
        '&@dataFinalCotacao=:dataFinalCotacao' +
        '&$format=json' +
        '&$select=cotacaoCompra,cotacaoVenda,dataHoraCotacao';

      DATA_FORMAT = 'MM-DD-YYYY';

    public
      class function CotacaoDolarPeriodo(dataInicial, dataFinalCotacao: TDateTime): string;
  end;


implementation

{ TBcbServico }

class function TBcbServicoUrl.CotacaoDolarPeriodo(dataInicial,
  dataFinalCotacao: TDateTime): string;
begin
  result := URL_BCB_SERVICO_COTACAO_DOLAR_PERIODO
            .Replace(':dataInicial',QuotedStr( FormatDateTime( DATA_FORMAT , dataInicial) ))
            .Replace(':dataFinalCotacao',QuotedStr( FormatDateTime( DATA_FORMAT , dataFinalCotacao) ));
end;

end.
