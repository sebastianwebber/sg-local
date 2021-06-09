# sg-local

This lab contains a environment to run stackgres like it is in production - but in kind.

## Requirements:

* [kind](https://kind.sigs.k8s.io/#installation-and-usage) 0.11.0 or higher
* [helm](https://helm.sh/docs/intro/install/) 3.6.0 or higher
* [ruby](https://www.ruby-lang.org/en/documentation/installation/) 2.7.2 or higher

## usage

To list all tasks, run:

```bash
rake -AT
```

To install the entire environment:

```bash
rake setup
```


To remove everything:

```bash
rake clean
```