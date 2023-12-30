# Advent of Code 2023

## Setup Token for Import

1. sign in at https://adventofcode.com
2. refresh the page and open the developer tools
3. copy your `session` value from the cookies
4. export your cookie via terminal `export AOC_SESSION="..."`

## Importing Task

To get the current days task (only in December)

```sh
node import.ts
```

You can run this again without it overwriting your previous index.ts, but it will update the readme (usually helpful for part 2).

You can also write `node import.ts <day>` to pull a specific day if you need to for some reason (e.g you missed a day)

```sh
node import.ts 1 # downloads day 1
```

## Running

Nothing fancy, to run day 1 do:

```sh
swift run Day01Part1
```

Extrapolate for other days
