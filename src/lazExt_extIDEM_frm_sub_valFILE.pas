unit lazExt_extIDEM_frm_sub_valFILE;

{$mode objfpc}{$H+}

interface

uses lazExt_extIDEM_frm_sub, StringsPropEditDlg,
  Classes, SysUtils, FileUtil, Forms, Controls, StdCtrls, ExtCtrls, Buttons;

type

  { TextIDEM_sub_valFILE_frm }

  TextIDEM_sub_valFILE_frm = class(tExtIDEM_sub_frm)
    Edit1: TEdit;
    Edit2: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure SpeedButton2Click(Sender: TObject);
  protected
    function getFRM_caption:string; override;
  end;

implementation

const _cTXT_frmCaption_='Значение';

{$R *.lfm}

procedure TextIDEM_sub_valFILE_frm.SpeedButton2Click(Sender: TObject);
begin
    with TStringsPropEditorFrm.Create(Application) do begin
        Memo.Text:=Edit2.Text;
        if mrOK=ShowModal then begin
            Edit2.Text:=Memo.Text;
        end;
        FREE;
    end;
end;

function TextIDEM_sub_valFILE_frm.getFRM_caption:string;
begin
    result:=_cTXT_frmCaption_;
end;

end.

