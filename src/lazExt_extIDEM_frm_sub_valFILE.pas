unit lazExt_extIDEM_frm_sub_valFILE;

{$mode objfpc}{$H+}

interface

uses lazExt_extIDEM_frm_sub, StringsPropEditDlg,
  Classes, SysUtils, FileUtil, Forms, Controls, StdCtrls, ExtCtrls, Buttons;

type

  { TextIDEM_sub_valFILE_frm }

  TextIDEM_sub_valFILE_frm = class(tExtIDEM_sub_frm)
    edt_fileName: TEdit;
    edt_altText: TEdit;
    lbl_file: TLabel;
    rdb_Halt: TRadioButton;
    rdb_Alt: TRadioButton;
    spb_fileDialog: TSpeedButton;
    spb_textDialog: TSpeedButton;
    procedure spb_textDialogClick(Sender: TObject);
  protected
    function getFRM_caption:string; override;
  end;

implementation

const _cTXT_frmCaption_='Значение';

{$R *.lfm}

procedure TextIDEM_sub_valFILE_frm.spb_textDialogClick(Sender: TObject);
begin
    with TStringsPropEditorFrm.Create(Application) do begin
        Memo.Text:=edt_altText.Text;
        if mrOK=ShowModal then begin
            edt_altText.Text:=Memo.Text;
        end;
        FREE;
    end;
end;

function TextIDEM_sub_valFILE_frm.getFRM_caption:string;
begin
    result:=_cTXT_frmCaption_;
end;

end.

