unit lazExt_extIDEM_frm_sub_valTEXT;

{$mode objfpc}{$H+}

interface

uses lazExt_extIDEM_frm_sub, StringsPropEditDlg,
  Classes, SysUtils, FileUtil, Forms, Controls, StdCtrls, ExtCtrls, Buttons;

type

  { TextIDEM_sub_valTEXT_frm }

  TextIDEM_sub_valTEXT_frm = class(tExtIDEM_sub_frm)
    Edit1: TEdit;
    Label6: TLabel;
    SpeedButton1: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
  protected
    function getFRM_caption:string; override;
  end;

implementation

const _cTXT_frmCaption_='Значение';

{$R *.lfm}

procedure TextIDEM_sub_valTEXT_frm.SpeedButton1Click(Sender: TObject);
begin
    with TStringsPropEditorFrm.Create(Application) do begin
        Memo.Text:=Edit1.Text;
        if mrOK=ShowModal then begin
            Edit1.Text:=Memo.Text;
        end;
        FREE;
    end;
end;

function TextIDEM_sub_valTEXT_frm.getFRM_caption:string;
begin
    result:=_cTXT_frmCaption_;
end;

end.

