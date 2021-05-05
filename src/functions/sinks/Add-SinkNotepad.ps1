function Add-SinkNotepad {
	<#
	.SYNOPSIS
		Writes log events into opened notepad
	.DESCRIPTION
		Adds sink that will write log events into most recently(by default) opened notepad.
	.PARAMETER LoggerConfig
		Instance of LoggerConfiguration
	.PARAMETER LevelSwitch
		A switch allowing the pass-through minimum level to be changed at runtime.
	.PARAMETER Formatter
		A formatter, such as JsonFormatter(See Get-JsonFormatter), to convert the log events into text for the file. If control of regular text formatting is required, use Default parameter set.
	.PARAMETER OutputTemplate
		A message template describing the format used to write to the sink.
	.PARAMETER FormatProvider
		Supplies culture-specific formatting information, or null.
	.PARAMETER RestrictedToMinimumLevel
		The minimum level for events passed through the sink. Ignored when LevelSwitch is specified.
	.PARAMETER NotepadProcessFinderFunc
		Func that will find the target `notepad.exe` process where log messages will be sent to.
	.PARAMETER SyncRoot
		An object that will be used to `lock` (sync) access to the Notepad output. 
		If you specify this, you will have the ability to lock on this object, and guarantee that the Notepad sink will not be able to output anything while the lock is held.
	.INPUTS
		Instance of LoggerConfiguration
	.OUTPUTS
		LoggerConfiguration object allowing method chaining
	.EXAMPLE
		PS> New-Logger | Add-SinkNotepad | Start-Logger
	#>

	[OutputType([Serilog.LoggerConfiguration])]
	[Cmdletbinding()]
	param(
		[Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Default')]
		[Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'Formatter')]
		[Parameter(Mandatory = $true, ValueFromPipeline = $true, ParameterSetName = 'FormatProvider')]
		[Serilog.LoggerConfiguration]$LoggerConfig,

		[Parameter(Mandatory = $false, ParameterSetName = 'Default')]
		[Serilog.Core.LoggingLevelSwitch]$LevelSwitch = $null,

		[Parameter(Mandatory = $true, ParameterSetName = 'Formatter')]
		[Serilog.Formatting.ITextFormatter]$Formatter = $null,

		[Parameter(Mandatory = $false, ParameterSetName = 'Default')]
		[Parameter(Mandatory = $true, ParameterSetName = 'FormatProvider')]
		[string]$OutputTemplate = '{Timestamp:yyyy-MM-dd HH:mm:ss.fff zzz} [{Level:u3}] {Message:lj}{NewLine}{ErrorRecord}{Exception}',

		[Parameter(Mandatory = $true, ParameterSetName = 'FormatProvider')]
		[System.IFormatProvider]$FormatProvider = $null,

		[Parameter(Mandatory = $false, ParameterSetName = 'Default')]
		[Serilog.Events.LogEventLevel]$RestrictedToMinimumLevel = [Serilog.Events.LogEventLevel]::Verbose,

		[Parameter(Mandatory = $false, ParameterSetName = 'Default')]
		[System.Func``1[System.Diagnostics.Process]]$NotepadProcessFinderFunc = $null,

		[Parameter(Mandatory = $false, ParameterSetName = 'Default')]
		[object]$SyncRoot = $null
	)

	switch ($PSCmdlet.ParameterSetName) {
		'Formatter'{
			$LoggerConfig = [Serilog.NotepadLoggerConfigurationExtensions]::Notepad([Serilog.Configuration.LoggerSinkConfiguration]$LoggerConfig.WriteTo, 
				[Serilog.Formatting.ITextFormatter]$Formatter,
				[Serilog.Events.LogEventLevel]$RestrictedToMinimumLevel,
				[Serilog.Core.LoggingLevelSwitch]$LevelSwitch,
				[System.Func``1[System.Diagnostics.Process]]$NotepadProcessFinderFunc,
				[object]$SyncRoot
			)
		}
		{($_ -eq 'Default') -or ($_ -eq 'FormatProvider')} {
			$LoggerConfig = [Serilog.NotepadLoggerConfigurationExtensions]::Notepad([Serilog.Configuration.LoggerSinkConfiguration]$LoggerConfig.WriteTo, 
				[Serilog.Events.LogEventLevel]$RestrictedToMinimumLevel, 
				[string]$OutputTemplate,
				[System.IFormatProvider]$FormatProvider,
				[Serilog.Core.LoggingLevelSwitch]$LevelSwitch,
				[System.Func``1[System.Diagnostics.Process]]$NotepadProcessFinderFunc,
				[object]$SyncRoot
			)
		}
	}

	$LoggerConfig
}