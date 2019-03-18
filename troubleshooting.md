# Тут будут описаны способы решения проблем с запуском системы

Если решения твоей проблемы нет в этом документе, но оно есть у тебя, было бы неплохо добавить его в этот файл и открыть pull request :)

## На винде

* При установке докера проблема с отсутствием виртуализации: смотрим например [тут](https://support.qnap.ru/hc/ru/articles/360000723294-%D0%9A%D0%B0%D0%BA-%D0%B2%D0%BA%D0%BB%D1%8E%D1%87%D0%B8%D1%82%D1%8C-%D0%BF%D0%BE%D0%B4%D0%B4%D0%B5%D1%80%D0%B6%D0%BA%D1%83-%D0%B0%D0%BF%D0%BF%D0%B0%D1%80%D0%B0%D1%82%D0%BD%D0%BE%D0%B9-%D0%B2%D0%B8%D1%80%D1%82%D1%83%D0%B0%D0%BB%D0%B8%D0%B7%D0%B0%D1%86%D0%B8%D0%B8-Intel-VTx-AMD-SVM-%D0%B2-%D1%81%D0%B5%D1%82%D0%B5%D0%B2%D0%BE%D0%BC-%D1%85%D1%80%D0%B0%D0%BD%D0%B8%D0%BB%D0%B8%D1%89%D0%B5-QNAP-
) или просто гуглим.

* SECURITY WARNING
```
SECURITY WARNING: You are building a Docker image from Windows against a non-Win dows Docker host. All files and directories added to build context will have '-r wxr-xr-x' permissions. It is recommended to double check and reset permissions f or sensitive files and directories.
```
Это просто предупреждение можно не обращать внимания.

* proxy input/output error
```
C:\Program Files\Docker\Docker\Resources\bin\docker.exe: Error response from daemon: driver failed programming external connectivity on endpoint confident_elbakyan (a0c50014a5332bdba02aa202209b2b8cb3ad083c15698cddb42ab723cd4cсdc9): Error st arting userland proxy: mkdir /port/tcp:0.0.0.0:8000:tcp:172.17.0.2:8000: input/output error.
```
Снизу справа ищем значок докера (кит), тыкаем правой кнопкой, там Settings, в открывшемся окне вкладка Reset, там тыкаем Restart Docker Desktop, ждём перезапуска и пробуем снова, должно работать.

## На линуксе

Линукс идеален, никаких проблем :)

## Запуск без интернетов

Это можно сделать только локально и не делая пулл с докерхаба. Для этого запускаем скрипт/команду в режиме noupdate без параметра --pull. Если это скрипт, то нужно его открыть и убрать этот параметр.
