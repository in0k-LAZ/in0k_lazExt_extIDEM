unit extIDEM_McrPRM_File_CORE;

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


uses Laz2_XMLCfg,  Dialogs,
    extIDEM_coreObject, extIDEM_McrPRM_Intf,
    extIDEM_frm_sub_COMMENTs,
    extIDEM_frm_sub_RESULT,
    extIDEM_frm_sub_valFILE;

type

 TlazExt_extIDEM_maCRO_File_CORE_edit=class(TExtIDEM_McrPRM_edit_custom)
    sub_COMMENTs: TextIDEM_sub_COMMENTs_frm;
    sub_valFILE: TextIDEM_sub_valFILE_frm;
    sub_RESULT: TextIDEM_sub_RESULT_frm;
  public
    procedure Settings_Read (const node:tExtIDEM_core_objNODE);  override;
    procedure Settings_Write(const node:tExtIDEM_core_objNODE);  override;
  end;

 tLazExt_extIDEM_maCRO_File_CORE_node=class(tExtIDEM_McrPRM_node_custom)
  private
   _fName_:string;
   _alt_T_:string;  //< альтернативный текс, если файл не найден
   _alt_U_:boolean; //< использовать альтернативный текс (иначе надобы ошибку)
   _cmt_T_:string;  //< настройки комментариев
   _cmt_U_:boolean; //< использовать исключение комментариев
    procedure _fName_SET_(const value:string);
    procedure _alt_T_SET_(const value:string);
    procedure _alt_U_SET_(const value:boolean);
    procedure _cmt_T_SET_(const value:string);
    procedure _cmt_U_SET_(const value:boolean);
  protected
    class function ObjTEdit:tExtIDEM_core_objEditTYPE; override;
    class function Obj_IDNT:string;                    override;
    class function Obj_Name:string;                    override;
    class function Obj_Desc:string;                    override;
  public
    class function PUBLISED:boolean; override;
  public
    procedure node_Save(const AConfig:Laz2_XMLCfg.TXMLConfig; const Path:String); override;
    procedure node_Load(const AConfig:Laz2_XMLCfg.TXMLConfig; const Path:String); override;
  public
    constructor Create(const prmNAME:string; const EDITor:tExtIDEM_core_objEditTYPE=nil); override;
  public
    property ResultForIDE;
    property ResultForSRC;
    property FileName:string  read _fName_ write _fName_SET_;
    property Alt_Used:boolean read _alt_U_ write _alt_U_SET_;
    property Alt_Text:string  read _alt_T_ write _alt_T_SET_;
    property CMT_Used:boolean read _cmt_U_ write _cmt_U_SET_;
    property CMT_Text:string  read _cmt_T_ write _cmt_T_SET_;
  end;

implementation

{$R *.lfm}

procedure TlazExt_extIDEM_maCRO_File_CORE_edit.Settings_Read(const node:tExtIDEM_core_objNODE);
begin
    if node is tLazExt_extIDEM_maCRO_File_CORE_node then begin
        sub_valFILE.FileName:=tLazExt_extIDEM_maCRO_File_CORE_node(node).FileName;
        sub_valFILE.Alt_Used:=tLazExt_extIDEM_maCRO_File_CORE_node(node).Alt_Used;
        sub_valFILE.Alt_Text:=tLazExt_extIDEM_maCRO_File_CORE_node(node).Alt_Text;
        //---
        sub_COMMENTs.CmntUsed:=tLazExt_extIDEM_maCRO_File_CORE_node(node).CMT_Used;
        sub_COMMENTs.CmntSMBs:=tLazExt_extIDEM_maCRO_File_CORE_node(node).CMT_Text;
        //---
        sub_RESULT.ForIde_Value:=tLazExt_extIDEM_maCRO_File_CORE_node(node).ResultForIDE;
        sub_RESULT.ForSRC_Value:=tLazExt_extIDEM_maCRO_File_CORE_node(node).ResultForSRC;
    end
    else begin
        sub_valFILE.FileName:='';
        sub_valFILE.Alt_Text:='';
        sub_valFILE.Alt_Used:=false;
        //---
        sub_COMMENTs.CmntSMBs:='';
        sub_COMMENTs.CmntUsed:=false;
        //---
        sub_RESULT.ForIde_Value:=0;
        sub_RESULT.ForSRC_Value:=0;
    end;
    //---
    inherited;
end;

procedure TlazExt_extIDEM_maCRO_File_CORE_edit.Settings_Write(const node:tExtIDEM_core_objNODE);
begin
    if node is tLazExt_extIDEM_maCRO_File_CORE_node then begin
        tLazExt_extIDEM_maCRO_File_CORE_node(node).FileName:=sub_valFILE.FileName;
        tLazExt_extIDEM_maCRO_File_CORE_node(node).Alt_Used:=sub_valFILE.Alt_Used;
        tLazExt_extIDEM_maCRO_File_CORE_node(node).Alt_Text:=sub_valFILE.Alt_Text;
        //---
        tLazExt_extIDEM_maCRO_File_CORE_node(node).CMT_Used:=sub_COMMENTs.CmntUsed;
        tLazExt_extIDEM_maCRO_File_CORE_node(node).CMT_Text:=sub_COMMENTs.CmntSMBs;
        //---
        tLazExt_extIDEM_maCRO_File_CORE_node(node).ResultForIDE:=sub_RESULT.ForIde_Value;
        tLazExt_extIDEM_maCRO_File_CORE_node(node).ResultForSRC:=sub_RESULT.ForSRC_Value;
    end;
    //---
    inherited;
end;

//==============================================================================

constructor tLazExt_extIDEM_maCRO_File_CORE_node.Create(const prmNAME:string; const EDITor:tExtIDEM_core_objEditTYPE=nil);
begin
    inherited Create(prmNAME,EDITor);
   _fName_:='';
end;

//------------------------------------------------------------------------------

procedure tLazExt_extIDEM_maCRO_File_CORE_node._fName_SET_(const value:string);
begin
    if _fName_<>value then begin
       _fName_:=value;
        set_IsCHANGed;
    end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tLazExt_extIDEM_maCRO_File_CORE_node._alt_T_SET_(const value:string);
begin
    if value<>_alt_T_ then begin
       _alt_T_:=value;
        set_IsCHANGed;
    end;
end;

procedure tLazExt_extIDEM_maCRO_File_CORE_node._alt_U_SET_(const value:boolean);
begin
    if value<>_alt_U_ then begin
       _alt_U_:=value;
        set_IsCHANGed;
    end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tLazExt_extIDEM_maCRO_File_CORE_node._cmt_T_SET_(const value:string);
begin
    if value<>_cmt_T_ then begin
       _cmt_T_:=value;
        set_IsCHANGed;
    end;
end;

procedure tLazExt_extIDEM_maCRO_File_CORE_node._cmt_U_SET_(const value:boolean);
begin
    if value<>_cmt_U_ then begin
       _cmt_U_:=value;
        set_IsCHANGed;
    end;
end;

//------------------------------------------------------------------------------

const
 _cTXT_delimetr_='/';

 _cTXT_fileName_='FileName';
 _cTXT_alt_Text_='Alt_Text';
 _cTXT_comments_='Comments';

 _cTXT_value_='value';
 _cTXT_used_ ='used';

procedure tLazExt_extIDEM_maCRO_File_CORE_node.node_Save(const AConfig:Laz2_XMLCfg.TXMLConfig; const Path:String);
begin
    AConfig.SetDeleteValue(Path+_cTXT_fileName_+_cTXT_delimetr_+_cTXT_value_,_fName_,'');
    //---
    AConfig.SetDeleteValue(Path+_cTXT_alt_Text_+_cTXT_delimetr_+_cTXT_value_,_alt_T_,'');
    AConfig.SetDeleteValue(Path+_cTXT_alt_Text_+_cTXT_delimetr_+_cTXT_used_ ,_alt_U_,true);
    //---
    AConfig.SetDeleteValue(Path+_cTXT_comments_+_cTXT_delimetr_+_cTXT_value_,_cmt_T_,'');
    AConfig.SetDeleteValue(Path+_cTXT_comments_+_cTXT_delimetr_+_cTXT_used_ ,_cmt_U_,true);
    //---
    AConfig_setResultValue(AConfig,Path,0,0);
    //---
    inherited;
end;

procedure tLazExt_extIDEM_maCRO_File_CORE_node.node_Load(const AConfig:Laz2_XMLCfg.TXMLConfig; const Path:String);
begin
   _fName_:=AConfig.GetValue(ConfigPath(Path),'');
   _fName_:=AConfig.GetValue(Path+_cTXT_fileName_+_cTXT_delimetr_+_cTXT_value_,'');
    //---
   _alt_T_:=AConfig.GetValue(Path+_cTXT_alt_Text_+_cTXT_delimetr_+_cTXT_value_,'');
   _alt_U_:=AConfig.GetValue(Path+_cTXT_alt_Text_+_cTXT_delimetr_+_cTXT_used_ ,true);
    //---
   _cmt_T_:=AConfig.GetValue(Path+_cTXT_comments_+_cTXT_delimetr_+_cTXT_value_,'');
   _cmt_U_:=AConfig.GetValue(Path+_cTXT_comments_+_cTXT_delimetr_+_cTXT_used_ ,true);
    //---
    AConfig_getResultValue  (AConfig,Path,0,0);
    //---
    inherited;
end;

//------------------------------------------------------------------------------

class function tLazExt_extIDEM_maCRO_File_CORE_node.PUBLISED:boolean;
begin
    result:=FALSE;
end;

class function tLazExt_extIDEM_maCRO_File_CORE_node.ObjTEdit:tExtIDEM_core_objEditTYPE;
begin
    result:=TlazExt_extIDEM_maCRO_File_CORE_edit;
end;

class function tLazExt_extIDEM_maCRO_File_CORE_node.Obj_IDNT:string;
begin
    result:='File';
end;

class function tLazExt_extIDEM_maCRO_File_CORE_node.Obj_Name:string;
begin
    result:='Значение из Файла';
end;

class function tLazExt_extIDEM_maCRO_File_CORE_node.Obj_Desc:string;
begin
    result:='Значением является СОДЕРЖИМОЕ указанного файла.';
end;

end.

