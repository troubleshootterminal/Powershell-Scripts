Get-WinEvent -FilterHashtable @{LogName=
 'Security'; Id=4625} -MaxEvents 10 |
  Select-Object TimeCreated, Message