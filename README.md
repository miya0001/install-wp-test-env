# Install WordPress test environment

It installs WordPress test environment for PHPUnit.

## How to use

Run following command.

```
$ curl -L https://raw.githubusercontent.com/miya0001/install-wp-test-env/master/install.sh | bash
```

## Requires

* PHPUnit
* WP-CLI

## Running PHPUnit

```
$ wp scaffold plugin <plugin-slug>
$ cd <plugin-slug>
$ phpunit
```
