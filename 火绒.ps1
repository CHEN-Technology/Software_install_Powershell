$URL = "https://down-tencent.huorong.cn/sysdiag-all-x64-6.0.0.29-2024.05.22.1.exe"
$OUTPUT_FILE = "����.exe"

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
        Write-Host "�ļ������ڻ��𻵣���������"
        # ɾ�������ļ�
        Remove-Item $OUTPUT_FILE
        # ���������ļ�
        Invoke-WebRequest -Uri $URL -OutFile $OUTPUT_FILE
        Write-Host "������ɣ����п�ִ���ļ�"
        # ������ִ���ļ�
        Start-Process $OUTPUT_FILE
    }
}
