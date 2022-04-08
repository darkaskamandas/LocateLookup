unit MainUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient, Vcl.Grids,
  Vcl.DBGrids, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons;

type
  TForm1 = class(TForm)
    TableEmployees: TClientDataSet;
    TableEmployeesEmpNo: TIntegerField;
    TableEmployeesLastName: TStringField;
    TableEmployeesFirstName: TStringField;
    TableEmployeesPhoneExt: TStringField;
    TableEmployeesHireDate: TDateTimeField;
    TableEmployeesSalary: TFloatField;
    DataSourceEmployees: TDataSource;
    DBGridEmployees: TDBGrid;
    StatusBar: TStatusBar;
    LabelFirstName: TLabel;
    LabelLastName: TLabel;
    EditFieldName: TEdit;
    EditSearchValue: TEdit;
    BitBtnLocate: TBitBtn;
    BitBtnLookup: TBitBtn;
    BitBtnSearchManual: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TableEmployeesAfterOpen(DataSet: TDataSet);
    procedure TableEmployeesAfterScroll(DataSet: TDataSet);
    procedure BitBtnLocateClick(Sender: TObject);
    procedure BitBtnLookupClick(Sender: TObject);
    procedure BitBtnSearchManualClick(Sender: TObject);
    procedure EditFieldNameChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.BitBtnLocateClick(Sender: TObject);
begin
//Locate
 if not TableEmployees.Locate(EditFieldName.Text, EditSearchValue, []) then
  ShowMessage('The record is not found!');

end;

procedure TForm1.BitBtnLookupClick(Sender: TObject);
var
V: Variant;
begin
//Lookup

 V := TableEmployees.Lookup(EditFieldName.Text, EditSearchValue.Text,
 'EmpNo;FirstName;LastName;PhoneExt;HireDate;Salary');

 if (not VarIsNull(V)) then
 begin
   ShowMessage(
   'EmpNo: ' + AnsiString(V[0]) + ', ' +
     'FirstName: ' + AnsiString(V[1]) + ', ' +
     'LastName: ' + AnsiString(V[2]) + ', ' +
     'PhoneExt: ' + AnsiString(V[3]) + ',' + #13#10 +
     'HireDate: ' + DateTimeToStr(V[4]) + ', ' +
     'Salary: ' + FloatToStrF(Double(V[5]), ffCurrency, 15, 0);
    LabelResult.Color := RGB(245, 255, 245);
 end
 begin
   ShowMessage('The record is not found!');
 end;
end;

procedure TForm1.BitBtnSearchManualClick(Sender: TObject);
var
found: Boolean;
begin
//SearchManual
 found := False;
  TableEmployees.First;
  while not TableEmployees.Eof do
  begin

 if EditFieldName.Text = 'EmpNo') then
 if(TableEmployeesEmpNo.AsString = EditSearchValue.Text) then
  found := True;

  if EditFieldName.Text = 'LastName') then
 if(TableEmployeesLastName.AsString = EditSearchValue.Text) then
  found := True;

  if EditFieldName.Text = 'PhoneExt') then
 if(TableEmployeesPhoneExt.AsString = EditSearchValue.Text) then
  found := True;

  if EditFieldName.Text = 'HireDate') then
 if(TableEmployeesHireDate.AsString = EditSearchValue.Text) then
  found := True;

  if EditFieldName.Text = 'Salary') then
 if(TableEmployeesSalary.AsString = EditSearchValue.Text) then
  found := True;

  if EditFieldName.Text = 'FirstName') then
 if(TableEmployeesFirstName.AsString = EditSearchValue.Text) then
  found := True;

  if found then Break;
  TableEmployees.Next;
  end;

  if not found then ShowMessage('The record is not found!');



end;

procedure TForm1.EditFieldNameChange(Sender: TObject);
var
b: Boolean;

begin
      (EditFieldName.Text <> '') and (EditSearchValue.Text <> '')
      BitBtnLocate.Enabled := b;
      BitBtnLookup.Enabled := b;
      BitBtnSearchManual.Enabled := b;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 if (TableEmployees.Active) then TableEmployees.Close();
  TableEmployees.FileName :=
	  ExtractFilePath(Application.ExeName) + 'Employees.xml';
  if (not TableEmployees.Active) then TableEmployees.Open();
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
if (TableEmployees.Active) then TableEmployees.Close();
end;

procedure TForm1.TableEmployeesAfterOpen(DataSet: TDataSet);
begin
StatusBar.Panels.Items[0].Text :=
    ' Record Count := ' + IntToStr(TableEmployees.RecordCount);
end;

procedure TForm1.TableEmployeesAfterScroll(DataSet: TDataSet);
begin
StatusBar.Panels.Items[1].Text := ' Employee: ' +
	  TableEmployeesFirstName.AsString + ' ' +
	  TableEmployeesLastName.AsString + ' - Salary: ' +
	  FloatToStrF(TableEmployeesSalary.AsFloat, ffCurrency, 15, 0);
end;

end.
