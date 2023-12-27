# Quickstart

```
git clone https://github.com/torvalds/linux --depth=1 --branch=master
```

```
cp config linux/.config
```

```
docker run -ti --rm -v $PWD:/opt --platform=linux/amd64 ubuntu
```

```
apt-get install -y build-essential linux-source bc kmod cpio flex libncurses5-dev libelf-dev libssl-dev dwarves bison
```

```
cd linux && make -j4
```

```

