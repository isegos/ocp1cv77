'      ������ ��� ���������� �������� "��������� ���������" (c) artbear,  2005
'
'         ��� e-mail: artbear@bashnet.ru
'         ��� ICQ: 265666057

Dim Inspector2
Dim CommonScripts

Sub Inspector2_OnGetMethodsList(ByRef MethodsList)

	MethodsList = "���������������(), �����������()"
'	Echo "Inspector2_OnGetMethodsList"
End Sub

Sub Echo(text)
	Message "Script " & SelfScript.Name & " - " & CStr(text), mNone
End Sub'Echo

' ������������� �������. param - ������ ��������,
' ����� �� ������� � �������
'
Sub Init(param)

    Set c = Nothing
    On Error Resume Next
    Set c = CreateObject("OpenConf.CommonServices")
    On Error GoTo 0
    If c Is Nothing Then
        Message "�� ���� ������� ������ OpenConf.CommonServices", mRedErr
        Message "������ " & SelfScript.Name & " �� ��������", mInformation
        Scripts.UnLoad SelfScript.Name
		Exit Sub
    End If
    c.SetConfig(Configurator)
		set CommonScripts = c

 set Inspector2 = CommonScripts.GetPluginByName("��������� ���������")
 if not Inspector2 Is Nothing Then
     ' ����������� ������ � �������� �������
		SelfScript.AddNamedItem "Inspector2", Inspector2, False

  else
      ' ������ �� ��������. �������� � ������
      Message "������ �������2 �� ��������", mRedErr
      Message "������ " & SelfScript.Name & " �� ��������", mInformation
      Scripts.Unload SelfScript.Name
      Exit Sub
  End If

End Sub

' ��� �������� ������� �������������� ���
Init 0