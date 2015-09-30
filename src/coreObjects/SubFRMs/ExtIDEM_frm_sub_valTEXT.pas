unit ExtIDEM_frm_sub_valTEXT;

{$mode objfpc}{$H+}

interface

uses extIDEM_frm_sub, StringsPropEditDlg,
  Classes, Forms, Controls, StdCtrls, Buttons;

type

  TextIDEM_sub_valTEXT_frm = class(tExtIDEM_sub_frm)
    edt_Value: TEdit;
    lbl_value: TLabel;
    btn_Dialog: TSpeedButton;
    procedure btn_DialogClick(Sender: TObject);
  protected
    function getFRM_caption:string; override;
  protected
    procedure _value_set_(const value:string);
    function  _value_get_:string;
  public
    property TextValue:string read _value_get_ write _value_set_;
  end;

implementation

const _cTXT_frmCaption_='Значение';

{$R *.lfm}

procedure TextIDEM_sub_valTEXT_frm._value_set_(const value:string);
begin
    edt_Value.Text:=value;
end;

function TextIDEM_sub_valTEXT_frm._value_get_:string;
begin
    result:=edt_Value.Text;
end;

//------------------------------------------------------------------------------

procedure TextIDEM_sub_valTEXT_frm.btn_DialogClick(Sender: TObject);
begin
    with TStringsPropEditorFrm.Create(Application) do begin
        Memo.Text:=edt_Value.Text;
        if mrOK=ShowModal then begin
            edt_Value.Text:=Memo.Text;
        end;
        FREE;
    end;
end;

function TextIDEM_sub_valTEXT_frm.getFRM_caption:string;
begin
    result:=_cTXT_frmCaption_;
end;

end.

