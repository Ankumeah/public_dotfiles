#! /bin/env python

import os
import sys
import random

FILE_NAME: str = "quotes"

def main() -> int:
  home: str = os.environ.get("HOME", "")
  if not home:
    print("HOME not set")
    return 1

  quotes: list[str] | int = get_quotes(os.path.join(home, FILE_NAME))
  if isinstance(quotes, int):
    return quotes
  if not quotes:
    print(f"{os.path.join(home, FILE_NAME)} is empty")
    return 1

  print(random.choice(quotes))
  return 0

def get_quotes(source_file: str) -> list[str] | int:
  if not os.path.isfile(source_file):
    print(f"No such file: {source_file}")
    return 1

  quotes: list[str] = []

  try:
    with open(source_file, "r") as file_raw:
      file: str = file_raw.read()
      quotes: list[str] = [quote for quote in file.split("\n") if quote]
  except Exception as e:
    print(f"An error occured: {e}")
    return 1

  return quotes

if __name__ == "__main__":
  res: int = main()
  sys.exit(res)
