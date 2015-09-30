unit ExtIDEM_frm_sub;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, StdCtrls, ExtCtrls;

type

  { tExtIDEM_sub_frm }

  tExtIDEM_sub_frm = class(TFrame)
    frm_Caption: TLabel;
    frm_Data: TPanel;
  protected
    procedure SetParent(AParent: TWinControl); override;
  protected
    function getFRM_caption:string; virtual;
  public
    constructor Create(AOwner:TComponent); override;
  end;

implementation

const _cINT_bsLeft=8;

{$R *.lfm}

constructor tExtIDEM_sub_frm.Create(AOwner: TComponent);
begin
    inherited;
    //
    frm_Caption.Caption:=getFRM_caption;
    frm_Data.BorderSpacing.Left:=_cINT_bsLeft;
    frm_Data.Anchors:=frm_Data.Anchors-[akBottom];
    frm_Data.AutoSize:=TRUE;
    self    .AutoSize:=TRUE;
end;

//------------------------------------------------------------------------------

function tExtIDEM_sub_frm.getFRM_caption:string;
begin
    result:=self.ClassName;
end;

procedure tExtIDEM_sub_frm.SetParent(AParent: TWinControl);
begin
    inherited;
    //if Assigned(AParent) then begin
    if HandleAllocated and (frm_Caption.Font.Height=0)
    then frm_Caption.Font.Height:=self.Canvas.TextHeight('W')+2;
    //end;
end;

end.

