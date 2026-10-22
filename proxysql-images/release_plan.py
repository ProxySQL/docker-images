#!/usr/bin/env python3
"""Plan runtime-image rebuilds from an explicit, reviewed release policy."""

import json
from pathlib import Path
import re
import sys


def build_plan(config):
    releases = config.get("releases")
    if not isinstance(releases, list) or not releases:
        raise ValueError("releases must be a nonempty list")
    build, publish = [], []
    versions, assigned_aliases = set(), set()
    for release in releases:
        version = release.get("version", "")
        if not isinstance(version, str) or not re.fullmatch(r"[0-9]+\.[0-9]+\.[0-9]+", version):
            raise ValueError("version must have three numeric components")
        if version in versions:
            raise ValueError(f"duplicate version: {version}")
        versions.add(version)
        aliases = release.get("aliases", [])
        allowed = {version.split(".")[0], version.rsplit(".", 1)[0], "latest"}
        if not isinstance(aliases, list):
            raise ValueError("aliases must be a list")
        for alias in aliases:
            if not isinstance(alias, str) or alias not in allowed:
                raise ValueError(f"invalid alias for {version}: {alias!r}")
            if alias in assigned_aliases:
                raise ValueError(f"alias assigned more than once: {alias}")
            assigned_aliases.add(alias)
        for dist in ("debian", "centos"):
            names = [version, *aliases]
            tags = [f"proxysql/proxysql:{name}" for name in names] if dist == "debian" else []
            tags += [f"proxysql/proxysql:{name}-{dist}" for name in names]
            sources = []
            for arch in ("amd64", "arm64"):
                staging = f"proxysql/proxysql:refresh-{version}-{dist}-{arch}"
                sources.append(staging)
                build.append({
                    "version": version, "dist": dist, "arch": arch,
                    "runner": "ubuntu-24.04-arm" if arch == "arm64" else "ubuntu-24.04",
                    "staging": staging,
                })
            publish.append({"version": version, "dist": dist, "tags": tags, "sources": sources})
    return {"build": {"include": build}, "publish": {"include": publish}}


if __name__ == "__main__":
    try:
        config = json.loads(Path(__file__).with_name("releases.json").read_text())
        print(json.dumps(build_plan(config), separators=(",", ":")))
    except (OSError, ValueError, TypeError, AttributeError) as error:
        print(f"Invalid runtime image release policy: {error}", file=sys.stderr)
        sys.exit(1)
