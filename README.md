# PoShLog.Sinks.Notepad

[![psgallery](https://img.shields.io/powershellgallery/v/poshlog.sinks.notepad.svg)](https://www.powershellgallery.com/packages/PoShLog.Sinks.Notepad) [![PowerShell Gallery](https://img.shields.io/powershellgallery/p/poshlog.sinks.seq?color=blue)](https://www.powershellgallery.com/packages/PoShLog.Sinks.Notepad) [![psgallery](https://img.shields.io/powershellgallery/dt/PoShLog.Sinks.Notepad.svg)](https://www.powershellgallery.com/packages/PoShLog.Sinks.Notepad) [![Discord](https://img.shields.io/discord/693754316305072199?color=orange&label=discord)](https://discord.gg/gGFtbf)

PoShLog.Sinks.Notepad is extension module for [PoShLog](https://github.com/PoShLog/PoShLog) logging module. Contains sink that writes log messages to most recently opened `Notepad` application.

## Getting started

If you are familiar with PowerShell, skip to [Installation](#installation) section. For more detailed installation instructions check out [Getting started](https://github.com/PoShLog/PoShLog/wiki/Getting-started) wiki.

### Installation

To install PoShLog.Sinks.Notepad, run following snippet from powershell:

```ps1
Install-Module -Name PoShLog.Sinks.Notepad
```

## Usage

```ps1
Import-Module PoShLog
Import-Module PoShLog.Sinks.Notepad

New-Logger |
    Add-SinkNotepad |
    Start-Logger

Write-InfoLog 'This message should pop up in Notepad!'

# Don't forget to close the logger
Close-Logger
```

### Documentation

These examples are just to get you started fast. For more detailed documentation please check [wiki](https://github.com/PoShLog/PoShLog/wiki).

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## Authors

* [**Tomáš Bouda**](http://tomasbouda.cz/)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Credits

* `Serilog.Sinks.Notepad` - [augustoproiete/serilog-sinks-notepad](https://github.com/augustoproiete/serilog-sinks-notepad)
* Icon made by [Smashicons](https://smashicons.com/) from [www.flaticon.com](https://www.flaticon.com/).
