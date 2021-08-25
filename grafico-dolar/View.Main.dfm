object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'ViewCotacaoGrafico | https://github.com/dannyrooh '
  ClientHeight = 647
  ClientWidth = 1405
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object EdgeBrowser1: TEdgeBrowser
    Left = 657
    Top = 61
    Width = 748
    Height = 586
    Align = alClient
    TabOrder = 0
    ExplicitTop = 0
    ExplicitHeight = 647
  end
  object onlSide: TPanel
    Left = 0
    Top = 61
    Width = 657
    Height = 586
    Align = alLeft
    Caption = 'onlSide'
    TabOrder = 1
    ExplicitTop = 0
    ExplicitHeight = 647
    object pnlHeader: TPanel
      Left = 1
      Top = 1
      Width = 655
      Height = 48
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Consulta D'#243'lar'
      Color = clWhite
      ParentBackground = False
      ShowCaption = False
      TabOrder = 0
      ExplicitLeft = -4
      ExplicitTop = -5
      object Label1: TLabel
        Left = 16
        Top = 14
        Width = 49
        Height = 16
        Caption = 'Per'#237'odo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 13785875
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 192
        Top = 15
        Width = 6
        Height = 13
        Caption = #224
      end
      object edtInicial: TDateTimePicker
        Left = 86
        Top = 13
        Width = 94
        Height = 21
        Date = 44429.000000000000000000
        Time = 0.832520694442791900
        TabOrder = 0
      end
      object edtFinal: TDateTimePicker
        Left = 204
        Top = 12
        Width = 94
        Height = 21
        Date = 44429.000000000000000000
        Time = 0.832520694442791900
        TabOrder = 1
      end
      object Button2: TButton
        Left = 304
        Top = 1
        Width = 175
        Height = 41
        Caption = 'Buscar Cota'#231#245'es'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        Style = bsCommandLink
        TabOrder = 2
        OnClick = Button2Click
      end
    end
    object pageMain: TPageControl
      Left = 1
      Top = 49
      Width = 655
      Height = 536
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      ActivePage = TabSheet1
      Align = alClient
      MultiLine = True
      TabOrder = 1
      TabPosition = tpBottom
      object TabSheet2: TTabSheet
        Caption = 'response: string Json'
        object mmoJson: TMemo
          Left = 0
          Top = 0
          Width = 647
          Height = 510
          Align = alClient
          TabOrder = 0
        end
      end
      object TabSheet1: TTabSheet
        Caption = 'html: Bootstrap + Chart.js'
        object mmoHTML: TMemo
          Left = 0
          Top = 0
          Width = 647
          Height = 510
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          Lines.Strings = (
            '<!doctype html>'
            '<html lang="pt-br">'
            '  <head>'
            '    <!-- Required meta tags -->'
            '    <meta charset="utf-8">'
            
              '    <meta name="viewport" content="width=device-width, initial-s' +
              'cale=1">'
            ''
            '    <!-- Bootstrap CSS -->'
            
              '    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dis' +
              't/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZX' +
              'EAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" cr' +
              'ossorigin="anonymous">'
            ''
            '    <title>Hello, world!</title>'
            '  </head>'
            '  <body>'
            ''
            '    <div class="container">'
            '          <div class="row row-cols-3 mb-5 mt-5">'
            ''
            '             <div class="col">'
            '                    <div class="card text-white bg-danger" >'
            '                        <div class="card-body">'
            
              '                            <h5 class="card-title text-center">M' +
              #237'nima</h5>'
            
              '                            <p class="card-text fs-1 fw-bolder t' +
              'ext-center">{{minimo}}</p>'
            '                        </div>'
            '                    </div>'
            '             </div>'
            ''
            '             <div class="col">'
            '                    <div class="col card text-white bg-primary">'
            '                        <div class="card-body">'
            
              '                            <h5 class="card-title text-center">M' +
              #233'dia</h5>'
            
              '                            <p class="card-text fs-1 fw-bolder t' +
              'ext-center">{{media}}</p>'
            ''
            '                        </div>'
            '                    </div>'
            '              </div>'
            ''
            '              <div class="col">'
            '                    <div class="col card text-white bg-success">'
            '                        <div class="card-body">'
            
              '                            <h5 class="card-title text-center">M' +
              #225'xima</h5>'
            
              '                            <p class="card-text fs-1 fw-bolder t' +
              'ext-center">{{maxima}}</p>'
            '                        </div>'
            '                    </div>'
            '              </div>'
            ''
            '          </div>'
            ''
            '          <div class="row mt-20">'
            '            <canvas id="myChart" width="400"></canvas>'
            '          </div>'
            ''
            '    </div>'
            ''
            ''
            '    <!-- Optional JavaScript; choose one of the two! -->'
            
              '    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js' +
              '/3.5.1/chart.min.js"></script>'
            '    <script>'
            ''
            '          const datalabel = [ {{datalabel}} ];'
            '          const datasetdata = [ {{datasetdata}} ];'
            ''
            
              '                var ctx = document.getElementById('#39'myChart'#39').get' +
              'Context('#39'2d'#39');'
            '                var myChart = new Chart(ctx, {'
            '                    type: '#39'line'#39','
            '                    data: {'
            '                        labels: datalabel,'
            '                        datasets: [{'
            '                            label: '#39'Pre'#231'o de Venda'#39','
            '                            data: datasetdata,'
            '                            borderColor: '#39'red'#39','
            '                            borderWidth: 2'
            '                        }]'
            '                    },'
            '                    options: {'
            '                     plugins: {'
            '                              title: {'
            '                                display: true,'
            '                                text: '#39'Cota'#231#227'o do D'#243'lar'#39','
            '                                font: {'
            '                                  size: 32,'
            '                                  family: '#39'tahoma'#39','
            '                                  weight: '#39'bold'#39','
            ''
            '                                },'
            '                              },'
            '                               subtitle: {'
            '                                display: true,'
            '                                text: '#39'{{Periodo}}'#39','
            ''
            '                              }'
            '                       },'
            ''
            '                        scales: {'
            '                              x: {'
            '                                title: {'
            '                                  display: true,'
            '                                  text: '#39'Dias'#39
            '                                }'
            '                              },'
            '                              y: {'
            '                                title: {'
            '                                  display: true,'
            '                                  text: '#39'Pre'#231'o de Venda'#39
            '                                },'
            '                                min: {{preco_minimo}},'
            '                                max: {{preco_maximo}},'
            '                                ticks: {'
            '                                  stepSize: 5'
            '                                }'
            '                              }'
            '                            }'
            ''
            '                    },'
            '                });'
            '                </script>'
            ''
            '  </body>'
            '</html>')
          ScrollBars = ssBoth
          TabOrder = 0
          WordWrap = False
        end
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1405
    Height = 61
    Align = alTop
    Caption = 
      'Transformando uma string JSON em TArray<T> | Usando TEdgeBrowse ' +
      'para fazer um gr'#225'fico utilizando CHART.JS e BOOTSTRAP'
    Color = 13785875
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 2
  end
end
