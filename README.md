# Pangu

Pangu is a plugin for adding space between Chinese and English characters to file in Atom.io editor.

The algorithm is from [paranoid-auto-spacing](https://github.com/vinta/paranoid-auto-spacing)


## Installing

1. Go to `Atom -> Preferences...`
2. Then select the `Install` tab
3. Enter `pangu` in the search box

#### Using apm

```sh
$ apm install pangu
```

#### Install using Git

Alternatively, if you are a git user, you can install the package and keep up to date by cloning the repo directly into your `~/.atom/packages` directory.

```sh
$ git clone https://github.com/7kfpun/atom-pangu.git ~/.atom/packages/pangu
```

#### Download Manually

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
```

#### Commands

The following commands are available and are keyboard shortcuts.

* `pangu:spacing` - Spacing - `ctrl-alt-p` `ctrl-alt-g`


## License

Released under the [MIT License](http://opensource.org/licenses/MIT).
