# GeoProgx86ASM
Geometric progression detection in x86 Assembly (intel)


## Prerequisites

Enable gcc to compile to different targets gcc-multilib
```
sudo apt install gcc-multilib
```


## Run

Compile & Link C with Assembly

```
gcc -m32 -g -o prog geoprog.S main.c
```
Then run the result file: `prog`

```
./prog
```


## Usage

input values: `[1, -2, 4, -8, 16]` <br>
output: 1 if geometric progression else 0
