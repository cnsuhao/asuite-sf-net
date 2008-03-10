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

program Updater;

{$APPTYPE CONSOLE}

uses
  Windows, SysUtils, Classes, IniFiles, ShellApi;

var
  IniFile   : TIniFile;
  UpdateFileName, CurrentVersion, ReleaseNotes, Path : String;
  SearchRec : TSearchRec;
  ErrorCode : Integer;
  FileDelete : TStringList;

Function RunAndWaitProcess(PathExe, PathDir: String): Boolean;
var
  ProcInstaller  : TProcessInformation;
  StartInstaller : TStartupInfo;
begin
  Result := False;
  FillChar(ProcInstaller, sizeof(TProcessInformation), 0);
  FillChar(StartInstaller, sizeof(TStartupInfo), 0);
  StartInstaller.cb := sizeof(TStartupInfo);
  if CreateProcess(nil, PChar('"' + PathExe + '"' + '/S /D=' + PathDir +''), nil,
                   nil, false, NORMAL_PRIORITY_CLASS, nil, nil, StartInstaller,
                   ProcInstaller) then
  begin
    WaitForSingleObject(ProcInstaller.hProcess, INFINITE);
    CloseHandle(ProcInstaller.hThread);
    CloseHandle(ProcInstaller.hProcess);
    Result := True;
  end;
end;

procedure GetErrorAndReadln(ErrMessage: String);
begin
  Writeln(ErrMessage);
  Writeln('Press execute key to exit');
  Readln(Input);
  exit;
end;

begin
  if ParamStr(1) = '-version' then
  begin
    Write('1.0');
    Exit;
  end;
  Writeln('ASuite Updater 1.0');
  Writeln;
  Path := GetCurrentDir + '\';
  //Load and read update.ini
  Write('Reading update.ini in progess');
  IniFile := TIniFile.Create(Path + 'Update.ini');
  UpdateFileName := IniFile.ReadString('ASuite','UpdateFileName','');
  CurrentVersion := IniFile.ReadString('ASuite','CurrentVersion','');
  FileDelete := TStringList.Create;
  FileDelete.Delimiter := ' ';
  FileDelete.QuoteChar := '|';
  FileDelete.DelimitedText := IniFile.ReadString('ForASuite' + CurrentVersion,'FileDelete','');
  ReleaseNotes := IniFile.ReadString('ASuite','ReleaseNotesUrl','');
  IniFile.Free;
  Writeln(' - Completed');
  //Check
  if (FileExists(UpdateFileName)) then
  begin
    Write('Updating ASuite in progess');
    //Delete ASuite's old files
    if FindFirst(Path + '*.*', faAnyFile, SearchRec) = 0 then
    begin
      repeat
        if (SearchRec.Attr <> faDirectory) and
           (FileDelete.IndexOf(SearchRec.Name) <> -1) then
        begin
          DeleteFile(Path + SearchRec.Name);
        end;
      until
        FindNext(SearchRec) <> 0;
      FindClose(SearchRec);
    end;
    //Run ASuite install in silent mode
    if RunAndWaitProcess(path + UpdateFileName,Path) then
      Writeln(' - Completed')
    else
      GetErrorAndReadln(' - Could not execute ' + UpdateFileName);
    //Run ASuite
    Write('Running ASuite');
    ShellExecute(GetDesktopWindow, 'open', PChar(ReleaseNotes),
                              nil, nil, SW_NORMAL);
    ErrorCode := ShellExecute(GetDesktopWindow, 'open', PChar('ASuite.exe'),
                              nil, nil, SW_NORMAL);
    if ErrorCode <= 32 then //Error
      GetErrorAndReadln(' - Could not execute ' + UpdateFileName);
    //Delete update.ini and UpdateFileName
    if FindFirst(Path + '*.*', faAnyFile, SearchRec) = 0 then
    begin
      repeat
        if (SearchRec.Attr <> faDirectory)    and
           ((SearchRec.Name = UpdateFileName) or
           (SearchRec.Name  = 'update.ini'))  then
        begin
          DeleteFile(Path + SearchRec.Name);
        end;
      until
        FindNext(SearchRec) <> 0;
      FindClose(SearchRec);
    end;
  end
  else //Error
    GetErrorAndReadln('Error - ' + UpdateFileName + ' file don''t found');
  FileDelete.Free;
end.
