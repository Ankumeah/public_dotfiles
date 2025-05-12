#!/usr/bin/env python3

import json
import subprocess
import shutil
import argparse
import textwrap
import re
import sys
import termios
import tty
from typing import List, Dict


# Modifier mask map (add more as needed)
MODMASKS = {
    64: "SUPER",
    65: "SUPER+SHIFT",
    68: "SUPER+CTRL",
    72: "SUPER+SHIFT+CTRL", 
    0: ""
}


def get_keybinds() -> List[Dict]:
    try:
        output = subprocess.check_output(["hyprctl", "binds", "-j"])
        return json.loads(output)
    except Exception as e:
        print("Warning: Falling get bind list due to:", e)
        return json.loads("{}")


def format_modmask(modmask: int) -> str:
    return MODMASKS.get(modmask, f"MOD_{modmask}")


def format_keybind(entry: Dict) -> str:
    mod = format_modmask(entry["modmask"])
    key = entry["key"]
    return f"{mod}+{key}" if mod else key


def group_keybinds(binds: List[Dict]) -> List[Dict]:
    groups = {}
    for b in binds:
        key = (b["modmask"], b["dispatcher"])
        groups.setdefault(key, []).append(b)

    result = []
    for (modmask, dispatcher), entries in groups.items():
        by_arg = {}
        for b in entries:
            arg = b["arg"]
            match = re.sub(r"\d+", "..", arg)
            match = re.sub(r"(left|right|up|down|l|r|u|d)", "..", match)
            by_arg.setdefault(match, []).append(b)

        for _, group in by_arg.items():
            if len(group) == 1:
                result.extend(group)
            else:
                mod = format_modmask(group[0]["modmask"])
                keys = [e["key"] for e in group]
                args = [e["arg"] for e in group]
                key_expr = mod + "+" + "/".join(keys)
                action_expr = f"{dispatcher} " + "/".join(args)
                result.append({
                    "key": key_expr,
                    "action": action_expr
                })
    return result


def normalize_keybinds(binds: List[Dict]) -> List[Dict]:
    normalized = []
    for b in binds:
        if "key" in b and "action" in b:
            normalized.append(b)
        else:
            normalized.append({
                "key": format_keybind(b),
                "action": f"{b['dispatcher']} {b['arg']}"
            })
    return normalized


def draw_table(entries: List[Dict], term_width: int):
    key_width = min(max(len("Keybind"), max(len(e["key"]) for e in entries)) + 2, term_width // 2)
    action_width = term_width - key_width - 1
    indent_marker = '→ '

    def line(char_l, char_m, char_r):
        return f"{char_l}{'─'*key_width}{char_m}{'─'*action_width}{char_r}"

    print(line("┌", "┬", "┐"))
    print(f"│{'Keybind'.ljust(key_width)}│{'Action'.ljust(action_width)}│")
    print(line("├", "┼", "┤"))

    for i, e in enumerate(entries):
        action_lines = textwrap.wrap(e["action"], action_width - len(indent_marker))
        print(f"│{e['key'].ljust(key_width)}│{action_lines[0].ljust(action_width)}│")
        for line_extra in action_lines[1:]:
            print(f"│{' '.ljust(key_width)}│{indent_marker}{line_extra.ljust(action_width - len(indent_marker))}│")
        if i == len(entries) - 1:
            print(line("└", "┴", "┘"), end='', flush=True)


def wait_for_any_key():
    fd = sys.stdin.fileno()
    old_settings = termios.tcgetattr(fd)
    try:
        tty.setraw(fd)
        sys.stdin.read(1)
    finally:
        termios.tcsetattr(fd, termios.TCSADRAIN, old_settings)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--no-group", "-n", action="store_true", help="Do not group keybinds")
    parser.add_argument("--wait", "-w", action="store_true", help="Wait for key input before exiting")
    parser.add_argument("--sort", "-s", action="store_true", help="Sort keybinds alphabetically by key. By default the order is the same as in the config file.")
    args = parser.parse_args()

    binds = get_keybinds()
    processed = binds if args.no_group else group_keybinds(binds)
    flat = normalize_keybinds(processed)

    width = shutil.get_terminal_size((80, 20)).columns - 2
    if args.sort:
        flat.sort(key=lambda x: x['key'])
    draw_table(flat, width)

    if args.wait:
        wait_for_any_key()


if __name__ == "__main__":
    main()
