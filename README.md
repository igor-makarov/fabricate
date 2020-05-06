# (DEPRECATED) fabricate

## DEPRECATION NOTICE
Google has discontinued Fabric, and this tool no longer works.

## Description 
A small CLI tool that uploads dSYM files to Crashlytics without using their binary.
Useful for running in a Linux environment, for example.

## Installation

    $ gem install fabricate

## Usage

	$ Usage: fabricate [options]
    -v, --verbose                    Output diagnosic info
    -a APP_IDENTIFIER,               Application bundle ID
        --app_identifier
    -k, --api_key API_KEY            Fabric API key (public)
    -f, --filename FILENAME          File to upload)
    -h, --help                       Show this help message

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

