{
Copyright (C) 2006-2008 Matteo Salvi of SalvadorSoftware

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
}

unit CommonClasses;

interface

uses
  Classes, VirtualTrees;

type
  TNodeList = class (TList)
  private
    fMaxItems: Integer;
  protected
    procedure RemoveMaxItems;
    function  GetItems(Index: Integer): PVirtualNode;
    procedure SetItems(Index: Integer; Item: PVirtualNode);
  public
    constructor Create(MaxItems: Integer);
    destructor  Destroy; override;
    function  Add(Item: PVirtualNode): Integer;
    procedure Delete(Index: integer);
    function  First: PVirtualNode;
    function  IndexOf(Item: PVirtualNode): Integer;
    procedure Insert(Index: integer; Item: PVirtualNode);
    function  Last: PVirtualNode;
    function  Remove(Item: PVirtualNode): Integer;
    property  Items[Index: Integer]: PVirtualNode read GetItems write SetItems;
    procedure SetMaxItems(Number: Integer);
    function  GetMaxItems: Integer;
  end;

implementation

constructor TNodeList.Create(MaxItems: Integer);
begin
  fMaxItems := MaxItems;

  inherited Create;
end;

destructor TNodeList.destroy;
begin
  clear;
  inherited Destroy;
end;

function TNodeList.Add(Item: PVirtualNode): Integer;
begin
  Self.Remove(Item);

  Result := inherited Add(Item);

  if fMaxItems > 0 then
    Self.RemoveMaxItems;
end;

procedure TNodeList.Delete(Index: integer);
begin
  inherited Delete(Index);
end;

function TNodeList.First: PVirtualNode;
begin
  Result := inherited First;
end;

procedure TNodeList.RemoveMaxItems;
var
  I : Integer;
begin
  if (Self.Count - fMaxItems) > 0 then
    for I := 1 to Self.Count - fMaxItems do
      Self.Delete(fMaxItems);
end;

function TNodeList.IndexOf(Item: PVirtualNode): Integer;
begin
  Result := inherited IndexOf(Item);
end;

procedure TNodeList.Insert(Index: integer; Item: PVirtualNode);
begin
  Self.Remove(Item);

  inherited insert(Index,Item);

  if fMaxItems > 0 then
    Self.RemoveMaxItems;
end;

function TNodeList.Last: PVirtualNode;
begin
  Result := inherited Last;
end;

function TNodeList.Remove(Item: PVirtualNode): Integer;
begin
  Result := IndexOf(Item);
  if Result <> -1 then
    Delete(Result);
end;

function TNodeList.GetItems(Index: Integer): PVirtualNode;
begin
  Result  := inherited Get(Index);
end;

procedure TNodeList.SetItems(Index: Integer; Item: PVirtualNode);
begin
  inherited Put(Index, Item);
end;       

procedure TNodeList.SetMaxItems(Number: Integer);
begin
  fMaxItems := Number;
  //Remove unnecessary items
  RemoveMaxItems;
end;

function TNodeList.GetMaxItems: Integer;
begin
  Result := fMaxItems;
end;

//------------------------------------------------------------------------------

end.
