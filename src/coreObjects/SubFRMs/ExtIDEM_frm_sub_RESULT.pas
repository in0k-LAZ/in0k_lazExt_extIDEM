unit ExtIDEM_frm_sub_RESULT;

{$mode objfpc}{$H+}

interface

uses extIDEM_frm_sub,
  Classes, SysUtils, FileUtil, Forms, Controls, StdCtrls, ExtCtrls;

type

  { TextIDEM_sub_RESULT_frm }

  TextIDEM_sub_RESULT_frm = class(tExtIDEM_sub_frm)
    cmb_forIDE: TComboBox;
    cmb_forSRC: TComboBox;
    lbl_forIDE: TLabel;
    lbl_forSRC: TLabel;
    Shape1: TShape;
    procedure cmb_forIDEChange(Sender: TObject);
    procedure cmb_forSRCChange(Sender: TObject);
  private
    procedure _forIde_Enable_  (const value:boolean);
    procedure _cmb_forIDE__SET_(const value:integer);
    function  _cmb_forIDE__GET_:integer;
    procedure _forSrc_Enable_  (const value:boolean);
    procedure _cmb_forSRC__SET_(const value:integer);
    function  _cmb_forSRC__GET_:integer;
  protected
    function forIde_ItemsCount:integer;                   virtual;
    function forIde_ItemsTitle(const idx:integer):string; virtual;
    function forIde_ItemsDescr(const idx:integer):string; virtual;
  protected
    function forSrc_ItemsCount:integer;                   virtual;
    function forSrc_ItemsTitle(const idx:integer):string; virtual;
    function forSrc_ItemsDescr(const idx:integer):string; virtual;
  public
  protected
    function getFRM_caption:string; override;
  public
    constructor Create(AOwner:TComponent); override;
  public
    property ForIde_Value :integer read _cmb_forIDE__GET_ write _cmb_forIDE__SET_;
    property ForIde_Enable:boolean                        write _forIde_Enable_;
    property ForSRC_Value :integer read _cmb_forSRC__GET_ write _cmb_forSRC__SET_;
    property ForSRC_Enable:boolean                        write _forSrc_Enable_;
  end;

implementation

const _cTXT_frmCaption_='Результат';

_cTXT_itm_title_00_='As is'; //<
_cTXT_itm_title_01_='Text (single line)'; //<
_cTXT_itm_title_02_='Text (multy line)'; //<
_cTXT_itm_title_03_='const:text (single line)'; //<
_cTXT_itm_title_04_='const:text (multy line)'; //<


_cTXT_itm_descr_00_='As is'; //<
_cTXT_itm_descr_01_='Text (single line)'; //<
_cTXT_itm_descr_02_='Text (multy line)'; //<
_cTXT_itm_descr_03_='const:text (single line)'; //<
_cTXT_itm_descr_04_='const:text (multy line)'; //<

{$R *.lfm}

constructor TextIDEM_sub_RESULT_frm.Create(AOwner:TComponent);
var i:integer;
begin
    inherited;
    //---
    cmb_forIDE.Clear;
    for i:=0 to forIde_ItemsCount-1 do begin
       cmb_forIDE.AddItem(forSrc_ItemsTitle(i),nil);
    end;
    if cmb_forIDE.Items.Count>0 then begin
       cmb_forIDE.ItemIndex:=0;
       _forIde_Enable_(true);
    end
    else begin
       cmb_forIDE.ItemIndex:=-1;
       _forIde_Enable_(false);
    end;
    cmb_forIDEChange(cmb_forIDE);
    //---
    cmb_forSRC.Clear;
    for i:=0 to forSrc_ItemsCount-1 do begin
       cmb_forSRC.AddItem(forSrc_ItemsTitle(i),nil);
    end;
    if cmb_forSRC.Items.Count>0 then begin
       cmb_forSRC.ItemIndex:=0;
       _forIde_Enable_(true);
    end
    else begin
       cmb_forSRC.ItemIndex:=-1;
       _forIde_Enable_(false);
    end;
    cmb_forSRCChange(cmb_forSRC);
end;

//------------------------------------------------------------------------------

function TextIDEM_sub_RESULT_frm.forIde_ItemsCount:integer;
begin
    result:=3;
end;

function TextIDEM_sub_RESULT_frm.forIde_ItemsTitle(const idx:integer):string;
begin
    case idx of
        0:result:=_cTXT_itm_title_00_;
        1:result:=_cTXT_itm_title_01_;
        2:result:=_cTXT_itm_title_02_;
        else result:='';
    end;
end;

function TextIDEM_sub_RESULT_frm.forIde_ItemsDescr(const idx:integer):string;
begin
    case idx of
        0:result:=_cTXT_itm_descr_00_;
        1:result:=_cTXT_itm_descr_01_;
        2:result:=_cTXT_itm_descr_02_;
        else result:='';
    end;
end;

//------------------------------------------------------------------------------

function TextIDEM_sub_RESULT_frm.forSrc_ItemsCount:integer;
begin
    result:=5;
end;

function TextIDEM_sub_RESULT_frm.forSrc_ItemsTitle(const idx:integer):string;
begin
    case idx of
        3:result:=_cTXT_itm_title_03_;
        4:result:=_cTXT_itm_title_04_;
        else result:=forIde_ItemsTitle(idx);
    end;
end;

function TextIDEM_sub_RESULT_frm.forSrc_ItemsDescr(const idx:integer):string;
begin
    case idx of
        3:result:=_cTXT_itm_descr_03_;
        4:result:=_cTXT_itm_descr_04_;
        else result:=forIde_ItemsDescr(idx);
    end;
end;

//------------------------------------------------------------------------------

procedure TextIDEM_sub_RESULT_frm.cmb_forIDEChange(Sender:TObject);
begin
    TComboBox(sender).Hint:=forIde_ItemsDescr(TComboBox(sender).ItemIndex);
    TComboBox(sender).ShowHint:=true;
end;

procedure TextIDEM_sub_RESULT_frm.cmb_forSRCChange(Sender:TObject);
begin
    TComboBox(sender).Hint:=forSrc_ItemsDescr(TComboBox(sender).ItemIndex);
    TComboBox(sender).ShowHint:=true;
end;

//------------------------------------------------------------------------------

procedure TextIDEM_sub_RESULT_frm._cmb_forIDE__SET_(const value:integer);
begin
    cmb_forIDE.ItemIndex:=value;
end;

function TextIDEM_sub_RESULT_frm._cmb_forIDE__GET_:integer;
begin
    result:=cmb_forIDE.ItemIndex
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure TextIDEM_sub_RESULT_frm._cmb_forSRC__SET_(const value:integer);
begin
    cmb_forSRC.ItemIndex:=value;
end;

function TextIDEM_sub_RESULT_frm._cmb_forSRC__GET_:integer;
begin
    result:=cmb_forSRC.ItemIndex
end;

//------------------------------------------------------------------------------

procedure TextIDEM_sub_RESULT_frm._forIde_Enable_(const value:boolean);
begin
    cmb_forIDE.Enabled:=value;
    lbl_forIDE.Enabled:=value;
end;

procedure TextIDEM_sub_RESULT_frm._forSrc_Enable_(const value:boolean);
begin
    cmb_forSrc.Enabled:=value;
    lbl_forSrc.Enabled:=value;
end;

//------------------------------------------------------------------------------

function TextIDEM_sub_RESULT_frm.getFRM_caption:string;
begin
    result:=_cTXT_frmCaption_;
end;

end.

