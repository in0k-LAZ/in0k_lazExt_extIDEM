unit lazExt_extIDEM;

{$mode objfpc}{$H+}

interface

uses IDEOptionsIntf,
    lazExt_extIDEM_preSet_USER,
    lazExt_extIDEM_preSet_node,
    lazExt_extIDEM_preSet_edit,
     Classes, SysUtils;


type

 tLazExt_extIDEM=class(tLazExt_extIDEM_preSetsList_core)
  private
    _ideGRP_Index_:integer;
    _ideEDT_Index_:integer;
  private
    _list_preSets_:tLazExt_extIDEM_preSetsList_core;
  protected
    constructor Create;
    destructor DESTROY; override;
  public
    property preSets:tLazExt_extIDEM_preSetsList_core read _list_preSets_;
    function preSet_FiND(const INDX:integer):tLazExt_extIDEM_preSet_Node;
    function PreSETs_ADD_Node(const Node:tLazExt_extIDEM_preSet_NodeTYPE):tLazExt_extIDEM_preSet_Node;
  end;


procedure lazExt_extIDEM_CRT;
procedure lazExt_extIDEM_INT(const GRP,EDT:integer);
function  extIDEM:tLazExt_extIDEM;

implementation

constructor tLazExt_extIDEM.Create;
begin
   _list_preSets_:=tLazExt_extIDEM_preSetsList_core.Create;
   _ideGRP_Index_:=-1;
   _ideEDT_Index_:=-1;
end;

destructor tLazExt_extIDEM.DESTROY;
begin
   _list_preSets_.FREE;
end;

//------------------------------------------------------------------------------

function tLazExt_extIDEM.preSet_FiND(const INDX:integer):tLazExt_extIDEM_preSet_Node;
begin
    result:=_list_preSets_.PreSETs_Find_INDX(INDX);
end;

function tLazExt_extIDEM.PreSETs_ADD_Node(const Node:tLazExt_extIDEM_preSet_NodeTYPE):tLazExt_extIDEM_preSet_Node;
//var fIdeOI:integer;
begin
    result:=_list_preSets_.PreSETs_Find_IDNT(Node.preSet_IDNT);
    if not Assigned(result) then begin
        result:=node.Create;
       _list_preSets_.PreSETs_ADD(result);
        result.set_def_maCROs;
    end
    else begin
        result:=nil;
    end;




{    result:=_nodes_ADD_(Node);
    if Assigned(result) then begin
        fIdeOI:=GetFreeIDEOptionsIndex(_ideGRP_Index_,_ideGRP_Index_);
       _node_setID_(result,fIdeOI);
        RegisterIDEOptionsEditor(_ideGRP_Index_, Node.def_frmEdtr, fIdeOI,_ideEDT_Index_);
        result.set_def_maCROs;
        {todo: копирование как для шаблона в UserSET}
    end;
}end;

//==============================================================================

var _LazExt_extIDEM_:tLazExt_extIDEM;


procedure lazExt_extIDEM_CRT;
begin
    if not Assigned(_LazExt_extIDEM_) then begin
       _LazExt_extIDEM_:=tLazExt_extIDEM.Create;
//       _LazExt_extIDEM_.PreSETs_ADD_Node(tExtIDEM_preSet_USER_node);

    end;
end;

procedure lazExt_extIDEM_INT(const GRP,EDT:integer);
begin
    if not Assigned(_LazExt_extIDEM_) then lazExt_extIDEM_CRT;
   _LazExt_extIDEM_._ideGRP_Index_:=GRP;
   _LazExt_extIDEM_._ideEDT_Index_:=EDT;
end;

function extIDEM:tLazExt_extIDEM;
begin
    result:=_LazExt_extIDEM_;
end;


initialization
   _LazExt_extIDEM_:=nil;

finalization
   _LazExt_extIDEM_.FREE;

end.

