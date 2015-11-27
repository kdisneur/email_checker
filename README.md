# EmailChecker

[![Circle CI](https://circleci.com/gh/kdisneur/email_checker/tree/master.svg?style=svg)](https://circleci.com/gh/kdisneur/email_checker/tree/master)

Simple library checking the validity of an email. Checks are performed in the
following order:

* REGEX: validate the emails has a good looking format
* MX: validate the domain sever contains MX records
* SMTP: validate the SMTP behind the MX records knows this email address (no
email sent)

:warning: That's rare but, some SMTP define a catchall email address. Meaning
all emails using this domain seems valid even if they are not.

### Installation

```elixir
# mix.exs
def application do
  [mod: {YourModule, []},
   applications: [
     # other applications...
     :email_checker,
     # other applications...
     ]
  ]
end

def deps do
  [
    # other dependencies...
    {:email_checker, "~> 0.0.3"}
    # other dependencies...
  ]
end
```

### Configuration

We need to manually load DNS records to validate if a MX exists or not. When
we load the library Erlang doesn't have its DNS record list yet. So to avoid
any problem, we define a default DNS. By default the value is : `4,2,2,1` (note
that tuples are separated by commas).

You can easily override this value:

```elixir
# config/config.exs
config :email_checker, default_dns: {4,2,2,1}
```

### Usage

```elixir
EmailChecker.valid?("kevin@disneur.me")
#=> true
EmailChecker.valid?("non-existing@disneur.me")
#=> false
```

### CHANGELOG

[CHANGELOG](https://github.com/kdisneur/email_checker/blob/master/CHANGELOG)

### LICENSE

[MIT](https://github.com/kdisneur/email_checker/blob/master/LICENSE)
