import importlib.util
from pathlib import Path
import unittest

SPEC = importlib.util.spec_from_file_location(
    "release_plan", Path(__file__).resolve().parents[1] / "release_plan.py"
)
MODULE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(MODULE)


class ReleasePlanTests(unittest.TestCase):
    def plan(self, releases):
        return MODULE.build_plan({"releases": releases})

    def test_each_release_tests_both_distros_on_both_native_architectures(self):
        plan = self.plan([{"version": "3.0.11", "aliases": ["3.0", "3", "latest"]}])
        build = plan["build"]["include"]
        self.assertEqual(
            {(j["dist"], j["arch"]) for j in build},
            {("debian", "amd64"), ("debian", "arm64"), ("centos", "amd64"), ("centos", "arm64")},
        )
        for job in build:
            self.assertEqual(job["runner"], "ubuntu-24.04-arm" if job["arch"] == "arm64" else "ubuntu-24.04")
            self.assertEqual(job["staging"], f'proxysql/proxysql:refresh-3.0.11-{job["dist"]}-{job["arch"]}')

    def test_default_aliases_only_publish_the_explicitly_selected_version(self):
        plan = self.plan([
            {"version": "2.7.4", "aliases": ["2.7", "2"]},
            {"version": "3.0.11", "aliases": ["3.0", "3", "latest"]},
        ])
        latest_jobs = [j for j in plan["publish"]["include"] if "proxysql/proxysql:latest" in j["tags"]]
        self.assertEqual([(j["version"], j["dist"]) for j in latest_jobs], [("3.0.11", "debian")])
        centos = next(j for j in plan["publish"]["include"] if j["version"] == "3.0.11" and j["dist"] == "centos")
        self.assertEqual(centos["tags"], [
            "proxysql/proxysql:3.0.11-centos", "proxysql/proxysql:3.0-centos",
            "proxysql/proxysql:3-centos", "proxysql/proxysql:latest-centos",
        ])
        self.assertEqual(len(centos["sources"]), 2)

    def test_two_releases_cannot_publish_the_same_alias(self):
        with self.assertRaisesRegex(ValueError, "alias"):
            self.plan([
                {"version": "3.0.11", "aliases": ["3"]},
                {"version": "3.1.11", "aliases": ["3"]},
            ])

    def test_alias_cannot_point_to_an_unrelated_release_line(self):
        with self.assertRaisesRegex(ValueError, "alias"):
            self.plan([{"version": "3.0.11", "aliases": ["2.7"]}])

    def test_untrusted_version_and_alias_strings_are_rejected(self):
        for version in ["3.0.11;id", "$(id)", "latest", "3.0", "v3.0.11"]:
            with self.subTest(version=version), self.assertRaises(ValueError):
                self.plan([{"version": version, "aliases": []}])
        for alias in ["3$(id)", "latest;id", "3.0.11", "../latest"]:
            with self.subTest(alias=alias), self.assertRaises(ValueError):
                self.plan([{"version": "3.0.11", "aliases": [alias]}])

    def test_empty_and_duplicate_release_lists_are_rejected(self):
        for releases in [[], [{"version": "3.0.11", "aliases": []}] * 2]:
            with self.subTest(releases=releases), self.assertRaises(ValueError):
                self.plan(releases)

    def test_old_version_can_be_refreshed_without_moving_floating_tags(self):
        plan = self.plan([{"version": "3.0.10", "aliases": []}])
        self.assertEqual(len(plan["publish"]["include"]), 2)
        debian = next(j for j in plan["publish"]["include"] if j["dist"] == "debian")
        self.assertEqual(debian["tags"], ["proxysql/proxysql:3.0.10", "proxysql/proxysql:3.0.10-debian"])


if __name__ == "__main__":
    unittest.main()
