# Twitter Archive input plugin for Embulk

## Overview

* **Plugin type**: input
* **Resume supported**: yes
* **Cleanup supported**: yes
* **Guess supported**: no

## Configuration

- **option1**: directory (string, default: `null`)

## Example

```yaml
in:
  type: twitterarchive
  directory: "/path/to/extracted-twitter-archive"
```


## Build

```
$ rake
```
