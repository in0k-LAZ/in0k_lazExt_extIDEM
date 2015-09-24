unit lazExt_extIDEM_frm_nodeName;

{$mode objfpc}{$H+}

interface

uses Graphics,
  Classes, SysUtils, FileUtil, Forms, Controls, StdCtrls;

type

  { TlazExt_extIDEM_nodeName_frm }

  TlazExt_extIDEM_nodeName_frm = class(TFrame)
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
  private //< управление текстовкой
     procedure _INITFNT_;
  public
     procedure setNames(const Macros,mcrPRM:string);
     procedure setUsed   (const value:boolean);
     procedure setDELETED(const value:boolean);
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

const _cTXT_XXX_='xxx';
      _cCLR_SMB_=clGrayText;
      _cCLR_Gry_=clGrayText;
      _cCLR_DEF_=clWindowText;

{$R *.lfm}

constructor TlazExt_extIDEM_nodeName_frm.Create(AOwner:TComponent);
begin
    inherited;
   _INITFNT_;
end;

//------------------------------------------------------------------------------

procedure TlazExt_extIDEM_nodeName_frm._INITFNT_;
begin
    with label2 do begin
        Font.Style:=[fsBold];
    end;
    with label4 do begin
        Font.Style:=[];
    end;
    with label6 do begin
        Font.Style:=[];
    end;
end;

procedure TlazExt_extIDEM_nodeName_frm.setNames(const Macros,mcrPRM:string);
begin
    with label3 do begin
        if Macros='' then Caption:=_cTXT_XXX_ else Caption:=Macros;
        if mcrPRM ='' then Font.Style:=[fsBold] else Font.Style:=[];
    end;
    with label5 do begin
        if mcrPRM='' then Font.Style:=[] else Font.Style:=[fsBold];
        if mcrPRM='' then Caption:=_cTXT_XXX_ else Caption:=mcrPRM;
    end;
end;

procedure TlazExt_extIDEM_nodeName_frm.setUsed(const value:boolean);
begin
    if value then begin
        with label2.Font do Color:=_cCLR_SMB_;
        with label3.Font do Color:=_cCLR_DEF_;
        with label4.Font do Color:=_cCLR_SMB_;
        with label5.Font do Color:=_cCLR_DEF_;
        with label6.Font do Color:=_cCLR_SMB_;
    end
    else begin
        with label2.Font do Color:=_cCLR_Gry_;
        with label3.Font do Color:=_cCLR_Gry_;
        with label4.Font do Color:=_cCLR_Gry_;
        with label5.Font do Color:=_cCLR_Gry_;
        with label6.Font do Color:=_cCLR_Gry_;
    end;
end;

procedure TlazExt_extIDEM_nodeName_frm.setDELETED(const value:boolean);
begin
    if value then begin
        with label2.Font do Style:=Style+[fsStrikeOut];
        with label3.Font do Style:=Style+[fsStrikeOut];
        with label4.Font do Style:=Style+[fsStrikeOut];
        with label5.Font do Style:=Style+[fsStrikeOut];
        with label6.Font do Style:=Style+[fsStrikeOut];
    end
    else begin
        with label2.Font do Style:=Style-[fsStrikeOut];
        with label3.Font do Style:=Style-[fsStrikeOut];
        with label4.Font do Style:=Style-[fsStrikeOut];
        with label5.Font do Style:=Style-[fsStrikeOut];
        with label6.Font do Style:=Style-[fsStrikeOut];
    end;
end;

end.

