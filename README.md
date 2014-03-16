# Fantassh

Provides a list of all the ssh connections you made in the past and let's you select
an entry by fuzzy matching.
This way connecting to often used ssh connections gets very easy and fast.

When invoked it reads all the ssh connections from the bash history and stores them
in a separate file for later use. This is useful because your bash history won't hold
them forever.
There is also support for a list of excluded ssh connections, so the provided list
doesn't get cluttered up with entries you don't need anymore.

Fantassh depends on the fantastic fuzzy matcher [selecta](https://github.com/garybernhardt/selecta).

## Installation

1. Install selecta (include it in your path)
2. Install fantassh

```
$ gem install fantassh
```

## Usage

    $ fantassh

Select the desired entry by using selecta's fuzzy matching.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
