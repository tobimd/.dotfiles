#!/usr/bin/env python3

import re
import sys
import os
import argparse as ap
import dataclasses

re_details = re.compile(r"\s*\*\s*(.+)\s+\(App name:\s+(.+)\s+\|", re.M)
re_puncts = re.compile(r"[,.:\->_\(\)\[\]+¡!¿?=\'*\{\}\"™®’]", re.M)
re_spaces = re.compile(r"  +", re.M)
re_aliases = re.compile(r"\[Legendary\.aliases\]\s?(?:\s[^\r\n]+)+", re.M)
re_sequels = re.compile(r"(^[^\r\n]+)_(\d+)$", re.M)

CONFIG_FILE: str = os.path.expanduser("~/.config/legendary/config.ini")
MAX_NAME_LEN: int = 50


@dataclasses.dataclass
class detail:
    idx: int  # game index
    gid: str  # game id (epic's internal)
    gnm: str  # original game name
    fix: str  # fixed game name
    alt: list[str]  # alternative aliases
    rem: bool = False  # if it's from the duplicated-names list

    def ini(self) -> str:
        return "\n".join(
            [f"{n} = {self.gid}" for n in sorted([self.fix, *self.alt], key=len)]
        )

    def print(self, ini: bool, aliases: bool):
        nms = sorted([self.fix, *self.alt], key=len)

        if ini:
            pre = "\x1b[2m" if self.rem else ""
            suf = "; ***\x1b[0m" if self.rem else ""
            val = "\n".join([f"{pre}{n} = {self.gid}{suf}" for n in nms])

        else:
            pre = (
                "   \x1b[1m\x1b[93m*\x1b[0m   "
                if self.rem
                else f" \x1b[2m[{self.idx:0>3}]\x1b[0m "
            )
            suf = (
                f"\x1b[2m({self.fix} ⟶ #{self.idx})\x1b[0m"
                if self.rem
                else f"\x1b[2m({', '.join([format(x,42) for x in nms])})\x1b[0m"
            )
            val = f"{pre}{format(self.gnm)} {suf}"

        print(val)


def format(name: str, length: int = MAX_NAME_LEN) -> str:
    if len(name) >= length:
        return name[: length - 3] + "..."
    else:
        return name


def clean(value: str, known: [(str, str)]) -> (dict[str, detail], dict[str, detail]):
    data: dict[str, detail] = {}
    rest: dict[str, detail] = {}
    idx = 1

    for game_name, game_id in re_details.findall(value):
        fixed_name = (
            re_spaces.sub(" ", re_puncts.sub("", game_name)).replace(" ", "_").lower()
        )

        if (sub := re_sequels.sub(r"\1\2", fixed_name)) != fixed_name:
            fixed_name = sub

        game_alts = list(
            {gn for (gn, gi) in known if gi == game_id and gn != fixed_name}
        )

        if fixed_name not in data:
            data[fixed_name] = detail(idx, game_id, game_name, fixed_name, game_alts)
            idx += 1
        else:
            rest[fixed_name] = detail(
                data[fixed_name].idx, game_id, game_name, fixed_name, game_alts, True
            )

    return (data, rest)


def write(data: str):
    with open(CONFIG_FILE, "r") as file:
        content = file.read()
        aliases = re_aliases.findall(content)[-1]

    edited = content.replace(aliases, data)

    with open(CONFIG_FILE, "w") as file:
        file.write(edited)


def read() -> [(str, str)]:
    with open(CONFIG_FILE, "r") as file:
        content = re_aliases.findall(file.read())[-1].split("\n")[1:]

    return [tuple(x.split(" = ")) for x in content]


def main(stdin: str, show_ini: bool, show_all: bool, do_aliases: bool, do_update: bool):
    known = read()
    data, rest = clean(stdin, known)
    output = "[Legendary.aliases]"

    for game in data.values():
        game.print(show_ini, do_aliases)
        output += f"\n{game.ini()}"

    if do_update:
        write(output)

    if not show_all:
        return

    for game in rest.values():
        game.print(show_ini, do_aliases)


def parser() -> ap.Namespace:
    p = ap.ArgumentParser()
    p.add_argument(
        "--ini", dest="show_ini", action="store_true", help="output in `.ini` format"
    )
    p.add_argument(
        "--all", dest="show_all", action="store_true", help="include duplicates"
    )
    p.add_argument(
        "--no-alias", dest="aliases", action="store_false", help="don't add aliases"
    )
    p.add_argument(
        "--no-update",
        dest="update",
        action="store_false",
        help="don't update config file",
    )
    p.add_argument("data", nargs="?", default=sys.stdin, help="string content")
    return p.parse_args()


if __name__ == "__main__":
    args = parser()

    show_ini = args.show_ini
    show_all = args.show_all
    aliases = args.aliases
    update = args.update
    data = args.data

    main(data, show_ini, show_all, aliases, update)
