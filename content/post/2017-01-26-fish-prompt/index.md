+++
title = "My command prompt"
date = "2017-01-26"
tags = ["cli", "fish", "rust"]
+++

I really like working in the command line, it just feels right for many tasks.
When I first saw a GUI (Windows 98) as a child I could not figure out how to
create a new folder so I opened a command prompt and used "the DOS window" to create the
folder. I was 11 years old. Fast forward to today, I almost always have a
terminal open and I spent way too much time on fiddling with the prompt I use.


This is what my prompt looks like in my home directory.

```
~ ➜
```

The key is minimalism. I don't like the path taking up much space in long
prompts so I only show the name of the current directory. I was not sure when I
made this change, but in practice the name of the current directory is enough to
orient myself and the few (really rare) times when it is not I simply issue a
`pwd`.

```
space ➜ pwd
/tmp/really/long/directory/paths/use/too/much/space
```

However I find it is useful to add context aware information to the prompt. Like
the current git branch.

```
.dotfiles (git:master) ➜
```

Or the currently active python virtualenv.

```
~ (venv:myvirtualenv) ➜
```

Or the currently active rust toolchain, managed by [rustup](https://rustup.rs/).

```
rustup_prompt_helper (rust:nightly) (git:master) ➜
```

All these additional things will appear based on environment variables and files
in the current directory so they are not in the way when they would not be
useful. Most if these are implemented in fish shell's own language and I
wrote a small utility script in rust, called [rustup prompt
helper](https://github.com/ijanos/rustup_prompt_helper), that prints the
toolchain information.

And finally here is a screenshot to show what it looks like on my machine, with
pretty colors.

![colorful fish prompt](post/2016-11-20-fish-prompt/cli.png "colorful fish prompt")

The full config of my fish prompt can be found in my [dotfiles repository on
GitHub](https://github.com/ijanos/dotfiles/blob/master/fish/.config/fish/functions/fish_prompt.fish).