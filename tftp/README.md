# TFTP 설정 방법

## 1. tftp 설치
```
sudo apt install xinetd tftp tftpd
```

## 2. tftp 설정
```
/etc/xinetd.d/tftp

service tftp
{
    socket_type = dgram	
    protocol    = udp
    wait        = yes					<!-- yes일 경우 싱글스레드로 생성-->
    user        = root
    server      = /usr/sbin/in.tftpd	<!-- 이 서비스를 실행시킬 프로그램(데몬) -->
    server_args = -s /tftp				<!-- -s : 다운로드 가능, -c : 업로드 가능, /tftp : 공유 tftp디렉터리-->
    disable     = no					<!-- tftp 비활성화 여부 -->	
    per_source  = 11					<!-- per ip당 최대 instance 개수 -->
	cps         = 100 2					<!-- 100:초당 처리할 연결요청, 2:서비스가 disabled된 이후 다시 enabling되가 까지 대기시간
    flags       = IPv4					<!-- service를 IPv4로 서비스 한다 -->
}

```
## 3. remote에서 tftp 접속
```

