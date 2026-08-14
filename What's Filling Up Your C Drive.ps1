Get-ChildItem -Path C:\ -Recurse -File -ErrorAction SilentlyContinue |
  Sort-Object Length -Descending |
  Select-Object -First 10 FullName, @{N="Size (GB)";E={[math]::Round($_.Length/1GB, 2)}}