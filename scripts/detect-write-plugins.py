import json
from argparse import ArgumentParser, Namespace
from collections import defaultdict
from pathlib import Path
from typing import Any, Dict, Union
from urllib.request import urlopen

AWESOME_NVIM_README_URL: str = "https://raw.githubusercontent.com/rockerBOO/awesome-neovim/main/README.md"
PLUGIN_LOCK_FILE_PATH: Path = Path("~/.config/nvim/plugin-lock.json").expanduser()
PLUGINS_MD_FILE_PATH: Path = Path("~/.config/nvim/PLUGINS.md").expanduser()


def get_args() -> Namespace:
    parser = ArgumentParser()
    parser.add_argument(
        "-d",
        "--details-url",
        type=str,
        default=AWESOME_NVIM_README_URL,
        required=False,
        help="URL to retrieve plugin details",
    )
    parser.add_argument(
        "-l",
        "--lock-file-path",
        type=str,
        default=PLUGIN_LOCK_FILE_PATH,
        required=False,
        help="Location of the plugin-lock.json file",
    )
    parser.add_argument(
        "-p",
        "--plugins-md-file-path",
        type=str,
        default=PLUGINS_MD_FILE_PATH,
        required=False,
        help="Location of the PLUGINS.md file",
    )
    parser.add_argument("-v", "--verbose", action="store_true", default=False, help="Enable verbose mode")
    parser.add_argument(
        "-r",
        "--disable-readme-ending",
        action="store_true",
        default=False,
        help="Disable writing info about awesome-neovim at the end of the markdown file",
    )
    args, opts = parser.parse_known_args()
    return parser.parse_args()


class PluginDetails:
    def __init__(self, name: str = "", category: str = "", description: str = "", link: str = "") -> None:
        self.full_name = name
        self.category = category
        self.description = description
        self.link = link


def get_online_plugin_details(url: str, verbose: bool = False) -> Dict[str, str]:
    """Retrieve plugin details from the awesome-neovim repo's README file

    Args:
        url (str): URL to the README file
        verbose (bool): Enable verbose mode

    Returns:
        A dictionary containing plugin details
    """
    out: Dict[str, PluginDetails] = {}

    category_list_started: bool = False
    curr_category: str = ""

    try:
        with urlopen(url) as response:
            if verbose:
                print(f"Retrieving plugin details from {url}")

            for line in response:
                line = line.decode("utf-8")

                if line.startswith("## Plugin Manager"):
                    category_list_started = True

                if category_list_started and line.startswith("## "):
                    curr_category: str = line[3:].strip()

                if category_list_started and line.startswith("- ["):
                    plugin_name: str = line.split("[")[1].split("]")[0]
                    plugin_link: str = line.split("(")[1].split(")")[0]
                    plugin_description: str = line[line.index(")") + 1 :][2:].strip()
                    out[plugin_name] = PluginDetails(plugin_name, curr_category, plugin_description, plugin_link)
    except Exception as e:
        print(f"Error: {e}")

    return out


def get_installed_plugin_details(lock_file_path: Union[str, Path], verbose: bool = False) -> Dict[str, PluginDetails]:
    """Retrieve installed plugins details from the Neovim configuration via plugin-lock.json

    Args:
        lock_file_path (str): Path to the plugin-lock.json file
        verbose (bool): Enable verbose mode

    Returns:
        A dictionary containing installed plugins
    """
    assert Path(lock_file_path).exists(), f"{lock_file_path} does not exist"

    out: Dict[str, Dict[str, str]] = defaultdict(PluginDetails)
    with open(PLUGIN_LOCK_FILE_PATH, "r") as f:
        if verbose:
            print(f"Retrieving installed plugin details from {lock_file_path}")

        for k, v in json.load(f).items():
            out[k] = PluginDetails(category="Not Categorized")

    return out


def write_plugins_md(
    plugin_details: Dict[str, PluginDetails],
    md_filename: Union[str, Path],
    verbose: bool = False,
    disable_readme_ending: bool = False,
) -> None:
    """Write plugin details to a markdown file
    Args:
        plugin_details (Dict[str, PluginDetails]): Plugin details
        md_filename (str): Markdown file name
        verbose (bool): Enable verbose mode
        disable_readme_ending (bool): Disable writing info about awesome-neovim at the end of the markdown file
    """
    categories: Dict[str, list[str]] = defaultdict(list)

    for p, d in plugin_details.items():
        categories[d.category].append(p)

    if "Not Categorized" in categories:
        uncategorized: list[str] = categories.pop("Not Categorized")
        categories["Not Categorized"] = uncategorized

    for k, v in categories.items():
        categories[k] = sorted(v)

    with open(md_filename, "w") as f:
        if verbose:
            print(f"Writing plugin details to {md_filename}")

        f.write("# PLUGINS\n\n")
        for c, ps in categories.items():
            f.write(f"## {c}\n\n")

            for p in ps:
                d: PluginDetails = plugin_details[p]
                if d.description == "":
                    if "." in p:
                        p = p.replace(".", "&#46;")
                    f.write(f"- {p}\n")
                else:
                    f.write(f"- [{p}]({d.link}) - {d.description}\n")

            f.write("\n")

        if not disable_readme_ending:
            # fmt: off
            f.write( "---\n\nCategories and descriptions are extracted from [awesome-neovim](https://github.com/rockerBOO/awesome-neovim)")
            # fmt: on


def run() -> None:
    args: Namespace = get_args()

    installed_plugins: Dict[str, Any] = get_installed_plugin_details(args.lock_file_path, args.verbose)
    assert len(installed_plugins) > 0, "No plugins are installed on the system"

    plugin_details: Dict[str, PluginDetails] = get_online_plugin_details(args.details_url, args.verbose)
    assert len(plugin_details) > 0, f"No plugins details are retrieved from {args.details_url}"

    matched_plugin_count = 0
    for p, d in plugin_details.items():
        pp: list[str] = p.split("/")
        if len(pp) > 1:
            p: str = pp[1]
            if p in installed_plugins:
                installed_plugins[p].full_name = d.full_name
                installed_plugins[p].category = d.category
                installed_plugins[p].description = d.description
                installed_plugins[p].link = d.link
                matched_plugin_count += 1

    if args.verbose:
        # fmt: off
        print(f"Detected {len(plugin_details):<4} plugins from {args.details_url}")
        print(f"Detected {len(installed_plugins):<4} installed plugins from {args.lock_file_path}")
        print(f"Detected {matched_plugin_count:<4} installed plugins with details")
        print(f"Detected {len(installed_plugins) - matched_plugin_count:<4} installed plugins that do not have any details")
        # fmt: on

    write_plugins_md(installed_plugins, args.plugins_md_file_path, args.verbose, args.disable_readme_ending)


if __name__ == "__main__":
    run()
