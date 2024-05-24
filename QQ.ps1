Write-Host "QQ下载中ing"
$URL = "https://dldir1.qq.com/qqfile/qq/PCQQ9.7.1/QQ9.7.1.28940.exe"
$OUTPUT_FILE = "./downloads/QQ.exe"

# 检查文件夹是否存在
if (!(Test-Path "downloads")) {
    Write-Host "文件夹不存在，开始创建"
    # 创建文件夹
    New-Item -ItemType Directory -Path "downloads" | Out-Null
}else{
    Write-Host "文件夹存在"
}

# 检查文件是否存在
if (!(Test-Path $OUTPUT_FILE)) {
    Write-Host "文件不存在，开始下载"
    # 下载文件
    $webRequest = Invoke-WebRequest -Uri $URL -OutFile $OUTPUT_FILE
    Write-Host "下载完成，运行可执行文件"
    # 启动可执行文件
    Start-Process $OUTPUT_FILE
} else {
    Write-Host "文件存在，开始检查完整性"
    # 获取远端文件的大小
    $remoteSize = (Invoke-WebRequest -Uri $URL -Method Head).Headers['Content-Length']

    # 获取本地文件的大小
    $localSize = (Get-Item $OUTPUT_FILE).Length

    if ($remoteSize -eq $localSize) {
        Write-Host "文件存在且完整"
        # 启动可执行文件
        Start-Process $OUTPUT_FILE
    } else {
        Write-Host "文件损坏，重新下载"
        # 删除现有文件
        Remove-Item $OUTPUT_FILE
        # 重新下载文件
        Invoke-WebRequest -Uri $URL -OutFile $OUTPUT_FILE
        Write-Host "下载完成，运行可执行文件"
        # 启动可执行文件
        Start-Process $OUTPUT_FILE
    }
}
