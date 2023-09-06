from unittest import TestCase
from core.logic import get_current_version, get_next_version


class TestGetCurrentVersion(TestCase):

    def test__provides_zero_version_when_no_valid_tags_exists(self):
        self.assertEqual(get_current_version([]), "0.0.0")

    def test__provides_the_last_version_when_valid_tags_exists(self):
        self.assertEqual(get_current_version(["v0.1.0", "v0.1.1"]), "0.1.1")

    def test__provides_the_last_version_when_valid_tags_are_descending(self):
        self.assertEqual(get_current_version(["v0.1.1", "v0.1.0"]), "0.1.1")


class TestGetNextVersion(TestCase):

    def test__provides_initial_version_when_no_valid_tags_exists(self):
        self.assertEqual(get_next_version([]), "0.1.0")

    def test__provides_the_next_version_when_valid_tags_exists(self):
        self.assertEqual(get_next_version(["v0.1.1"]), "0.1.2")
