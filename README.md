# GR-MANGO オフライン開発環境 Dockerfile
基本的に[公式情報](https://github.com/d-kato/RZ_A2M_Mbed_samples)の手順通りです。デバッグ環境は含みません。

## コンテナのビルド

```
docker build -t gr-mango:beta .
```
名前はご自由に。

## コンテナの起動
```
docker run --rm -it -v ~/projects:/mbed/projects gr-mango:beta
```
volumeを使っているのでプロジェクトを格納するディレクトリを指定してください。
例では、ホームディレクトリあるprojectsを指定しています。

※ファイルのオーナーがrootになって扱いにくいので、`umask 000`としてます。

## 使い方
RZ_A2M_Mbed_samplesをコピーして使い回しても構わないのですが、プロジェクト毎にmbed-os等を持ってくるとディスクを喰うのでシンボリックリンクがオススメです。

シンボリックリンクを作成するスクリプトを用意しているので、必要に応じて使用ください。
```
prepare
```

ビルドは
```
mbed compile -m GR_MANGO -t GCC_ARM --profile debug
```
ですが、長いのでaliasも用意しています。
```
build
```
でビルドできます。

## ビルド例

1. RZ_A2M_Mbed_samples
```
$ cd /mbed/projects
$ git clone https://github.com/d-kato/RZ_A2M_Mbed_samples
$ cd RZ_A2M_Mbed_samples
$ prepare
$ build
```

2. 自作プロジェクトの場合
```
$ cd /mbed/projects
$ mkdir myproj
$ cd myproj
$ touch .mbed
$ prepare
main.cppにプログラム作成
$ build
```
