unit ChequeController;

{$MODE Delphi}

interface

uses
  Classes, sqldb, SysUtils, ChequeClienteVO, Contnrs, fgl;

type
  TChequeController = class
  protected
  public
    class Function IncluirCheque(pListaCheque: TFPGObjectList<TChequeClienteVO>): boolean;
    class Function ExcluiCheque(Id: Integer):boolean;
  end;

implementation

uses UdmPrincipal;

var
  ConsultaSQL : String;
  Query: TSQLQuery;


class function TChequeController.IncluirCheque(pListaCheque:  TFPGObjectList<TChequeClienteVO>): boolean;
var
  i : integer;
  Cheque : TChequeClienteVO;
begin
  ConsultaSQL :=  'insert into ECF_CHEQUE_CLIENTE ( '+
                  'ID_BANCO,' +
                  'ID_CLIENTE,' +
                  'ID_ECF_MOVIMENTO,' +
                  'NUMERO_CHEQUE,' +
                  'DATA_CHEQUE,' +
                  'AGENCIA,' +
                  'CONTA,' +
                  'OBSERVACOES,' +
                  'TIPO_CHEQUE,' +
                  'VALOR_CHEQUE) values ('+
                  ':pID_BANCO,' +
                  ':pID_CLIENTE,' +
                  ':pID_ECF_MOVIMENTO,' +
                  ':pNUMERO_CHEQUE,' +
                  ':pDATA_CHEQUE,' +
                  ':pAGENCIA,' +
                  ':pCONTA,' +
                  ':pOBSERVACOES,' +
                  ':pTIPO_CHEQUE,' +
                  ':pVALOR_CHEQUE)';


  try
    try
      Query := TSQLQuery.Create(nil);
      Query.DataBase := dmPrincipal.IBCon;
      for i := 0 to Pred(pListaCheque.Count) do
      begin
        Cheque := pListaCheque.Items[i];
        Query.sql.Text := ConsultaSQL;
        Query.ParamByName('pID_BANCO').AsInteger         := cheque.IdBanco;
        Query.ParamByName('pID_CLIENTE').AsInteger       := cheque.IdCliente;
        Query.ParamByName('pID_ECF_MOVIMENTO').AsInteger := cheque.IdEcfMovimento;
        Query.ParamByName('pNUMERO_CHEQUE').AsInteger    := cheque.NumeroCheque;
        Query.ParamByName('pDATA_CHEQUE').AsString       := cheque.DataCheque;
        Query.ParamByName('pAGENCIA').AsString           := cheque.Agencia;
        Query.ParamByName('pCONTA').AsString             := cheque.Conta;
        Query.ParamByName('pOBSERVACOES').AsString       := cheque.Observacoes;
        Query.ParamByName('pTIPO_CHEQUE').AsString       := cheque.TipoCheque;
        Query.ParamByName('pVALOR_CHEQUE').AsFloat       := cheque.ValorCheque;

        Query.ExecSQL();
      end;

      result := True;
    except
      result := false;
    end;
  finally
    Query.Free;
  end;

end;

class function TChequeController.ExcluiCheque(Id: Integer): boolean;
begin
  ConsultaSQL :=  'delete from ECF_CHEQUE_CLIENTE  where id = :pID ';

  try
    try
      Query := TSQLQuery.Create(nil);
      Query.DataBase := dmPrincipal.IBCon;
      Query.sql.Text := ConsultaSQL;

      Query.ParamByName('pID').AsInteger := Id;

      Query.ExecSQL();

      result := True;
    except
      result := false;
    end;
  finally
    Query.Free;
  end;
end;

end.
