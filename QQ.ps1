Write-Host "QQ������ing"
$URL = "https://dldir1.qq.com/qqfile/qq/PCQQ9.7.1/QQ9.7.1.28940.exe"
$OUTPUT_FILE = "./downloads/QQ.exe"

# ����ļ����Ƿ����
if (!(Test-Path "downloads")) {
    Write-Host "�ļ��в����ڣ���ʼ����"
    # �����ļ���
    New-Item -ItemType Directory -Path "downloads" | Out-Null
}else{
    Write-Host "�ļ��д���"
}

# ����ļ��Ƿ����
if (!(Test-Path $OUTPUT_FILE)) {
    Write-Host "�ļ������ڣ���ʼ����"
    # �����ļ�
    $webRequest = Invoke-WebRequest -Uri $URL -OutFile $OUTPUT_FILE
    Write-Host "������ɣ����п�ִ���ļ�"
    # ������ִ���ļ�
    Start-Process $OUTPUT_FILE
} else {
    Write-Host "�ļ����ڣ���ʼ���������"
    # ��ȡԶ���ļ��Ĵ�С
    $remoteSize = (Invoke-WebRequest -Uri $URL -Method Head).Headers['Content-Length']

    # ��ȡ�����ļ��Ĵ�С
    $localSize = (Get-Item $OUTPUT_FILE).Length

    if ($remoteSize -eq $localSize) {
        Write-Host "�ļ�����������"
        # ������ִ���ļ�
        Start-Process $OUTPUT_FILE
    } else {
        Write-Host "�ļ��𻵣���������"
        # ɾ�������ļ�
        Remove-Item $OUTPUT_FILE
        # ���������ļ�
        Invoke-WebRequest -Uri $URL -OutFile $OUTPUT_FILE
        Write-Host "������ɣ����п�ִ���ļ�"
        # ������ִ���ļ�
        Start-Process $OUTPUT_FILE
    }
}
