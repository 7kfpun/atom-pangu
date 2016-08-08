[![Dependency Status](https://david-dm.org/7kfpun/atom-pangu.svg)](https://david-dm.org/7kfpun/atom-pangu)

# Pangu

Pangu is a plugin for adding space between Chinese/Japanese/Korean and English characters to file in Atom.io editor.

The algorithm is from [pangu.js](https://github.com/vinta/pangu.js)

## Installing

1. Go to `Atom -> Preferences...`
2. Then select the `Install` tab
3. Enter `pangu` in the search box

#### Install using apm

```sh
$ apm install pangu
```

#### Or using Git

Alternatively, if you are a git user, you can install the package and keep up to date by cloning the repo directly into your `~/.atom/packages` directory.

```sh
$ git clone https://github.com/7kfpun/atom-pangu.git ~/.atom/packages/pangu
```

#### Or download manually

1. Download the files using the [GitHub .zip download](https://github.com/7kfpun/atom-pangu/archive/master.zip) option and unzip them
2. Move the files inside the folder to `~/.atom/packages/pangu`


## Usage

#### Plugin settings page

To access the Pangu Settings:

1. Go to `Atom -> Preferences...` or `cmd-,`
2. In the `Filter Packages` type `pangu`

```
# Auto spacing on save
Enabled | default: `false` (true, false)
# Auto spacing ignored names
ignoredNames | default: ``
# Skip on lines without Chinese, Japanese and Korean
skipNoCKJLine | default: false
# Ignoring text with the matched pattern, e.g. \\*\\*[^\\*\\*]+\\*\\*, <pre>(.*?)</pre>
ignoredPattern | default: ``
```

#### Commands

The following commands are available and are keyboard shortcuts.

* `pangu:spacing` - Spacing - `ctrl-alt-p` `ctrl-alt-g`


## License

Released under the [MIT License](http://opensource.org/licenses/MIT).
