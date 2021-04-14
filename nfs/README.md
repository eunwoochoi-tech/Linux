# nfs서버 설정

## 1. nfs 프로그램 설치
```
sudo apt install nfs-kernel-server rpcbind portmap
```

## 2. nfs 설정 수정
```
설정파일 : /etc/export

/nfs 192.168.219.106/24(rw, sync, no_subtree_check, no_root_squash)

<!--
 - ro, rw : read-only, read-write
 - async, sync : sync:nfs 디렉터리에 쓰기와 같은 연산이 발생하면 공유 디렉터리와 서버 nfs디렉터리를 즉시 동기화
 - no_subtree_check : client가 특정 파일을 요청할 경우 subtree checking실행하지 않음
    * subtree checking이란 하위 디렉터리까지 탐색하는 것
 - no_root_squash : 사용자가 client에서 root로 접속할 경우 서버에서도 root권한을 가짐
-->
```

## 3. client에서 마운트 실행
```
sudo apt install nfs-common

mount -t <server ip>:<server nfs dir> /public_data

```
