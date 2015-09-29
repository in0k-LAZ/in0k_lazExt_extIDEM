unit extIDEM_McrPRM_Text_CORE;

{$mode objfpc}{$H+}
interface
{$I in0k_lazExt_extIDEM_INI.inc}
{$ifDef lazExt_extIDEM_DEBUG_mode}
    {$define _DEBUG_}
    {$define _TSTPRM_}
    {$define _TSTABS_}
{$else}
    {$define _INLINE_}
{$endIf}


uses Laz2_XMLCfg,
    extIDEM_coreObject, extIDEM_McrPRM_Intf,
    lazExt_extIDEM_frm_sub_RESULT, lazExt_extIDEM_frm_sub_valTEXT;

type

 { TlazExt_extIDEM_maCRO_Text_CORE_edit }

 TlazExt_extIDEM_maCRO_Text_CORE_edit=class(TExtIDEM_McrPRM_edit_custom)
    sub_valTEXT: TextIDEM_sub_valTEXT_frm;
    sub_RESULT: TextIDEM_sub_RESULT_frm;
  public
    procedure Settings_Read (const node:tExtIDEM_core_objNODE);  override;
    procedure Settings_Write(const node:tExtIDEM_core_objNODE);  override;
  end;

 tLazExt_extIDEM_maCRO_Text_CORE_node=class(tExtIDEM_McrPRM_node_custom)
  private
   _value_:string;
    procedure _value_SET_(const newValue:string);
  protected
    class function ObjTEdit:tExtIDEM_core_objEditTYPE; override;
    class function Obj_IDNT:string;                    override;
    class function Obj_Name:string;                    override;
    class function Obj_Desc:string;                    override;
  public
    class function PUBLISED:boolean; override;
  public    //<
    procedure node_Save(const AConfig:Laz2_XMLCfg.TXMLConfig; const Path:String); override;
    procedure node_Load(const AConfig:Laz2_XMLCfg.TXMLConfig; const Path:String); override;
  public
    constructor Create(const prmNAME:string; const EDITor:tExtIDEM_core_objEditTYPE=nil); override;
  public
    property ResultForIDE;
    property ResultForSRC;
    property Value:string read _value_ write _value_SET_;
  end;


implementation

{$R *.lfm}

//------------------------------------------------------------------------------

procedure TlazExt_extIDEM_maCRO_Text_CORE_edit.Settings_Read(const node:tExtIDEM_core_objNODE);
begin
    if node is tLazExt_extIDEM_maCRO_Text_CORE_node then begin
        sub_valTEXT.TextValue  :=tLazExt_extIDEM_maCRO_Text_CORE_node(node).Value;
        sub_RESULT.ForIde_Value:=tLazExt_extIDEM_maCRO_Text_CORE_node(node).ResultForIDE;
        sub_RESULT.ForSRC_Value:=tLazExt_extIDEM_maCRO_Text_CORE_node(node).ResultForSRC;
    end
    else begin
        sub_valTEXT.TextValue  :='';
        sub_RESULT.ForIde_Value:=0;
        sub_RESULT.ForSRC_Value:=0;
    end;
    //---
    inherited;
end;

procedure TlazExt_extIDEM_maCRO_Text_CORE_edit.Settings_Write(const node:tExtIDEM_core_objNODE);
begin
    if node is tLazExt_extIDEM_maCRO_Text_CORE_node
    then begin
        tLazExt_extIDEM_maCRO_Text_CORE_node(node).Value:=sub_valTEXT.TextValue;
        tLazExt_extIDEM_maCRO_Text_CORE_node(node).ResultForIDE:=sub_RESULT.ForIde_Value;
        tLazExt_extIDEM_maCRO_Text_CORE_node(node).ResultForSRC:=sub_RESULT.ForSRC_Value;
    end;
    //---
    inherited;
end;

//------------------------------------------------------------------------------

{class function TlazExt_extIDEM_maCRO_Text_CORE_edit.Value_label_TEXT:string;
begin
    result:='';
    {$ifDef _DEBUG_}
        result:='Описание для редактора';
    {$endIf}
end;}

//==============================================================================

constructor tLazExt_extIDEM_maCRO_Text_CORE_node.Create(const prmNAME:string; const EDITor:tExtIDEM_core_objEditTYPE=nil);
begin
    inherited Create(prmNAME,EDITor);
   _value_:='';
end;

//------------------------------------------------------------------------------

procedure tLazExt_extIDEM_maCRO_Text_CORE_node._value_SET_(const newValue:string);
begin
    if _value_<>newValue then begin
       _value_:=newValue;
        set_IsCHANGed;
    end;
end;

//------------------------------------------------------------------------------

procedure tLazExt_extIDEM_maCRO_Text_CORE_node.node_Save(const AConfig:Laz2_XMLCfg.TXMLConfig; const Path:String);
begin
    inherited;
    AConfig.SetDeleteValue(Path+'/value',_value_,'');
    AConfig_setResultValue(AConfig,Path,0,0);
end;

procedure tLazExt_extIDEM_maCRO_Text_CORE_node.node_Load(const AConfig:Laz2_XMLCfg.TXMLConfig; const Path:String);
begin
    inherited;
   _value_:=AConfig.GetValue(Path+'/value','');
    AConfig_getResultValue  (AConfig,Path,0,0);
end;

//------------------------------------------------------------------------------

class function tLazExt_extIDEM_maCRO_Text_CORE_node.PUBLISED:boolean;
begin
    result:=FALSE;
end;

class function tLazExt_extIDEM_maCRO_Text_CORE_node.ObjTEdit:tExtIDEM_core_objEditTYPE;
begin
    result:=TlazExt_extIDEM_maCRO_Text_CORE_edit;
end;

class function tLazExt_extIDEM_maCRO_Text_CORE_node.Obj_IDNT:string;
begin
    result:='Text';
end;

class function tLazExt_extIDEM_maCRO_Text_CORE_node.Obj_Name:string;
begin
    result:='Текстовое Значение';
end;

class function tLazExt_extIDEM_maCRO_Text_CORE_node.Obj_Desc:string;
begin
    result:='Любое указанное текстовое значение.';
end;

end.

