Dim	EMD
Dim vReader
Dim vDocFile
Dim vDocFile2
Dim vLstUsers

sub ReadCurUsersList()
	vLstUsers.OpenFile("C:\Documents and Settings\sushakov.SOVINTEL\My Documents\_Work_\DB\Sovintel_local_DB\Work\usrdef\users.usr")	
	MESSAGE vLstUsers.ReadNamesList, mInformation
end sub

Sub	Init(param)
	set EMD	= Plugins("ExtMD")
	if	not	EMD Is Nothing Then
	else
		'	������ �� ��������.	�������� � ������
		Scripts.Unload SelfScript.Name
	End If


	Set c = Nothing
	On Error Resume	Next
	Set	c =	CreateObject("OpenConf.CommonServices")
	On Error GoTo 0
	If c Is	Nothing	Then
		Message	"��	���� ������� ������	OpenConf.CommonServices", mRedErr
		Message	"������	" &	SelfScript.Name	& "	�� ��������", mInformation
		Scripts.UnLoad SelfScript.Name
		Exit Sub
	End	If
	c.SetConfig(Configurator)
	SelfScript.AddNamedItem	"CommonScripts", c,	False  
	
	Set vLstUsers = EMD.GetListUsers
	
end sub

' ��� �������� ������� �������������� ���
Init 0