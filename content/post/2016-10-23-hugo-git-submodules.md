+++
title = "Hugo & git submodules"
draft = false
date = "2016-10-23T14:13:01+02:00"
tags = ["git", "hugo", "github"]
+++

The official [Hugo tutorial](https://gohugo.io/tutorials/github-pages-blog/)
suggests using git submodules to keep track of your blog on GitHub. This seemed
like a good idea but after using this workflow I wonder why is it advertised at
all. Every time I commit a change to my theme or publish a new version to GitHub
Pages I have to create another commit in the parent repository too. While at
first glance it makes sense to couple the blog content, the theme and the public
HTML files together on a second thought I do not want to litter the history of
the blog source repository with this information.

In case of the `public` directory I see no reason to link its contents to the
parent repository. I can see the point of doing this for the theme. If I keep my
theme in a submodule then I can checkout any revision of the blog and build it
with the version of the theme I used at that time. I do not consider this useful
for me.

Git subtrees could be a solution, but with them I had to watch out every time to
avoid commits that contains files both inside and outside of the subtree. I
decided to go the dumb route instead. Keep full git repositories inside the
`public` and `themes` directories and ignore them in the parent repository. The
Hugo tutorials example deploy bash script works just the same but no commit is
needed in the parent repository anymore.

Since I started with submodules I had to remove them first, which turned out to
be harder than expected.

I deleted the `.gitmodules` file and removed the mention of submodules from
`.git/config` and put the directories in `.gitignore`. After committing and
pushing these changes the GitHub interface still showed placeholders for the
submodules. Cloning the repo created the empty directories, which is unusual.
Trying to do a `submodule update --init --recursive` results in an error:

```
fatal: No url found for submodule path 'public' in .gitmodules
```

I clearly messed up the removing. After looking at the output of `git ls-files
--stage` I can see there are special files still in the repository, I had to
remove these with `git rm` to finish the work. I don't see why the `git
submodule` command does not have a `remove` or similar action.
