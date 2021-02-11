# Script to measure the encoders speed-levels

> **NOTE**: please use [this repo](https://github.com/lu-zero/speed-levels-rs) instead.

The scripts use hyperfine and bash.
Optionally you can merge different runs in a ods spreadsheet with the provided python script.

## Usage

### Comparison scripts

```sh
bash compare-all.sh SAMPLEFILE PLATFORM_ID NUMBER_OF_FRAMES
bash compare-rav1e.sh SAMPLEFILE PLATFORM_ID NUMBER_OF_FRAMES PATH_TO_ENCODER <PATH_TO_ENCODER..>
```

### Merge all the speed tests results

```sh
python3 -m venv env
. env/bin/activate
pip install -r requirements.txt
python3 merge_all.py SAMPLEFILE PLATFORM_ID NUMBER_OF_FRAMES
```

## Test files

You will be able to download test files from
http://ultravideo.cs.tut.fi/#testsequences

## If you are curious

Just call `set +x` before launching the bash scripts.
