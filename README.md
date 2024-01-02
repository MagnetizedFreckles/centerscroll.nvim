# centerscroll.nvim

**Ok so clearly I don't know what I'm doing. I thought this was going to be easy, and now I'm stuck at trying to make my plugin work with lazy.**
**It installs fine, but it just doesn't work. I don't know what I'm doing wrong, and I'm too tired to care.**
**For now, I'll go back to using this code as part of simple config.**
**If someone discovers this repo, feel free to do whatevs.**

***The code is most probably of very low quality, and some things could, or should, be done differently.***
***PRs and explanations always welcome, thank you.***

A small plugin that makes line with cursor stay in the middle of the screen, regardless of position in the file.  
Made because every builtin and 'simpler' solution is, well, bad, in one way or another.

## Why not just use scrolloff option?

The main problem with it is that it doesn't center the line with cursor when it's half the screen or less near the end of file.
That was the dealbreaker for me.

## Why not setting keymaps with "motion+zz"?

I used this for quite a while, and it mostly worked for me.  
Problems arise though when you need to navigate through large file.
This causes lots of lag and stuttering, which is very annoying.  
Interestingly enough, the "scrolloff" way is far less jittery.

So, I guess, the ideal way is to somehow combine these two different ways into one.  
That's what I aim to do.

Plugin shouldn't conflict with your existing keymaps, and it also should dynamically adapt to your screen size.
However, there may be bugs, since I'm very inexperienced, to say the least.

## Installation

*Coming soon*
