unit lazExt_extIDEM_node;

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

uses lazExt_extIDEM_edit,
  Classes, SysUtils;

type

 tLazExt_extIDEM_node=class(tlazExt_extIDEM_edtNode)
  private
   _next_:tLazExt_extIDEM_node;
   _edit_:tLazExt_extIDEM_frmEditTYPE; //< выбранный редактор (может отличаться от defEditor)
   _name_:string;
  public
    constructor Create(const prmNAME:string; const EDITor:tLazExt_extIDEM_frmEditTYPE=nil); virtual;
    destructor DESTROY; override;
  public
    property Next:tLazExt_extIDEM_node read _next_ write _next_;
  public
    class function defEditor:tLazExt_extIDEM_frmEditTYPE; virtual; {$ifNdef _TSTABS_}abstract;{$endif}
  end;
 tLazExt_extIDEM_nodeTYPE=class of tLazExt_extIDEM_node;


 tLazExt_extIDEM_nodesList_core=class
  protected
   _nodes_:tLazExt_extIDEM_node;
  protected
    function  _node_getNext(const node:tLazExt_extIDEM_node):tLazExt_extIDEM_node;
    procedure _node_setNext(const node:tLazExt_extIDEM_node; const value:tLazExt_extIDEM_node);
  protected
    procedure _nodes_CLR_;
    function  _nodes_FND_(const IDNT:string):tLazExt_extIDEM_node;
    procedure _nodes_INS_(const node:tLazExt_extIDEM_node);
  public
    constructor Create; virtual;
    destructor DESTROY; override;
  public
    function ADD(const prmName:string; const nodeType:tLazExt_extIDEM_nodeTYPE; const nodeEdit:tLazExt_extIDEM_frmEditTYPE=nil):boolean;
  end;



implementation

constructor tLazExt_extIDEM_node.Create(const prmNAME:string; const EDITor:tLazExt_extIDEM_frmEditTYPE=nil);
begin
   _name_:=prmNAME;
   _edit_:=EDITor;
   _next_:=nil;
end;

destructor tLazExt_extIDEM_node.DESTROY;
begin
    // наследие дельфей
   _next_:=nil;
   _edit_:=nil;
   _name_:='';
end;

//------------------------------------------------------------------------------

{$ifDef _TSTABS_}
class function tLazExt_extIDEM_node.defEditor:tLazExt_extIDEM_frmEditTYPE;
begin
    Assert(false,self.ClassName+'.defEditor mast by OVERRIDE');
    result:=NIL; {todo: вставить НОТ ДЕФ редактор}
end;
{$endif}

//==============================================================================

constructor tLazExt_extIDEM_nodesList_core.Create;
begin
    inherited;
   _nodes_:=nil;
end;

destructor tLazExt_extIDEM_nodesList_core.DESTROY;
begin
   _nodes_CLR_;
    inherited;
end;

//------------------------------------------------------------------------------

function tLazExt_extIDEM_nodesList_core.ADD(const prmName:string; const nodeType:tLazExt_extIDEM_nodeTYPE; const nodeEdit:tLazExt_extIDEM_frmEditTYPE=nil):boolean;
begin
    {$ifDef _TSTPRM_}
       // Assert(Assigned(node),'NODE === NIL');
    {$endIF}
    if not Assigned(_nodes_FND_(prmName)) then begin
       _nodes_INS_(nodeType.Create(prmName,nodeEdit));
        result:=true;
    end
    else result:=false
end;

//------------------------------------------------------------------------------

function tLazExt_extIDEM_nodesList_core._node_getNext(const node:tLazExt_extIDEM_node):tLazExt_extIDEM_node;
begin
    {$ifDef _TSTPRM_}
        Assert(Assigned(node),'NODE === NIL');
    {$endIF}
    result:=node._next_;
end;

procedure tLazExt_extIDEM_nodesList_core._node_setNext(const node:tLazExt_extIDEM_node; const value:tLazExt_extIDEM_node);
begin
    {$ifDef _TSTPRM_}
        Assert(Assigned(node),'NODE === NIL');
    {$endIF}
    node._next_:=value;
end;

//------------------------------------------------------------------------------

{procedure tLazExt_extIDEM_nodesList_core._nodes_setFIRST(const value:tObject);
begin

end;

function  tLazExt_extIDEM_nodesList_core._nodes_getFIRST:tObject;
begin

end;}

//------------------------------------------------------------------------------

// очистка списка узлов (уничтожение)
procedure tLazExt_extIDEM_nodesList_core._nodes_CLR_;
var tmp:tLazExt_extIDEM_node;
begin
    tmp:=_nodes_;
    while Assigned(tmp) do begin
       _nodes_:=tmp._next_;
        tmp.FREE;
        tmp:=_nodes_;
    end;
end;

// поиск в спискае узла с совпадающим идентификатором
function tLazExt_extIDEM_nodesList_core._nodes_FND_(const IDNT:string):tLazExt_extIDEM_node;
begin
    {$ifDef _TSTPRM_}
        Assert(IDNT='','IDNT === NIL string');
    {$endIF}
    result:=_nodes_;
    while Assigned(result) do begin
        //if 0=result._idnt_compare(IDNT) then BREAK;
        result:=result._next_;
    end;
end;

procedure tLazExt_extIDEM_nodesList_core._nodes_INS_(const node:tLazExt_extIDEM_node);
begin
    {$ifDef _TSTPRM_}
        Assert(Assigned(node),'NODE === NIL');
    {$endIF}
    node._next_:=_nodes_;
   _nodes_:=node;
end;



end.

