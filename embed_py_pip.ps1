$ErrorActionPreference = "Inquire"

$embeddable_python_link = "https://www.python.org/ftp/python/3.13.2/python-3.13.2-embed-amd64.zip"
$output_python_dir = ".\python"
$packages_to_install = ""

Write-Output '---Downloading Python---'
Invoke-WebRequest $embeddable_python_link -OutFile .\python.zip
Expand-Archive .\python.zip -DestinationPath $output_python_dir
Remove-Item .\python.zip
Write-Output '---Python instalation completed---'

Write-Output '---Downloading get-pip.py---'
Invoke-WebRequest https://bootstrap.pypa.io/get-pip.py -OutFile .\get-pip.py
& "$output_python_dir\python.exe" .\get-pip.py --no-warn-script-location
Remove-Item .\get-pip.py

$pth_file_name = Get-Item "$output_python_dir\python*._pth" | Select-Object -First 1 -ExpandProperty name
Add-Content -Path "$output_python_dir\$pth_file_name" -Value "Lib\site-packages"
Write-Output '---Pip instalation completed---'

if ($packages_to_install){
    & "$output_python_dir\python.exe" -m pip install $packages_to_install
    Write-Output '---Python packages instalation completed---'
}

pause
