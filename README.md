# SSHKit::Chunky::Runner

[![Build Status](https://travis-ci.org/deees/sshkit-chunky-runner.svg)](https://travis-ci.org/deees/sshkit-chunky-runner)
[![Code Climate](https://codeclimate.com/github/deees/sshkit-chunky-runner/badges/gpa.svg)](https://codeclimate.com/github/deees/sshkit-chunky-runner)

Runs ssh commands in few chunks. It divides hosts into static number of chunks,
you just need to specify how many chunks you need.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sshkit-chunky-runner'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sshkit-chunky-runner

## Usage

```ruby
hosts = %w(
  1.example.com
  2.example.com
  3.example.com
  4.example.com
  5.example.com
  6.example.com
  7.example.com
  8.example.com
)
on hosts, in: :chunks, count: 3, wait: 5 do
  within '/opt/sites/example.com' do
    as :deploy  do
      with rails_env: :production do
        rake 'assets:precompile'
      end
    end
  end
end
```

This will divide all hosts into 3 groups.

First group will have `1.example.com`, `2.example.com`, `3.example.com`, second
group - `4.example.com`, `5.example.com`, `6.example.com`, and the last one -
`7.example.com`, `8.example.com`.

If you add more hosts, each group then will have more hosts. Number of groups
remain the same.

## Contributing

1. Fork it ( https://github.com/deees/sshkit-chunky-runner/fork )
2. Create your feature branch (`git checkout -b features/my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin features/my-new-feature`)
5. Create a new Pull Request
