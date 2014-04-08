# Heartbleed Checker

API for testing for OpenSSL
[CVE-2014-0160](https://www.openssl.org/news/secadv_20140407.txt) aka
[Heartbleed](http://heartbleed.com/).

**WARNING**: This is very untested, and you should verify the results
independently. Pull requests welcome.

## Usage

```text
$ bundle install
$ puma config.ru
```

## Credits

Relies on [heartbleeder](https://github.com/titanous/heartbleeder) by titanous.
