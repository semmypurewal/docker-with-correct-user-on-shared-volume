# Overview

This is one approach to creating a docker container with the correct
user/group ids on a shared volume. This is a typical use case when
you're running a container that's producing some output that ends up
on a shared volume.

You generally don't have control over a user's GID or UID, so often
you'll find approaches to this where the GID and UID gets set when the
image gets built. But what if it takes a long time to build your
image, and you'd prefer to have the user download it rather than build
it? In this case, you have to set up the user/gid info on the first
run.

That's what happens here.

## Usage

Build the image as normal.

```
$ docker build . -t permissions:latest
```

Run the image, but specify the userid/groupid as environment
variables.

```
$ docker run -it --env USER_ID=$(id -u) --env GROUP_ID=$(id -g) --env USER_NAME=$USER -v .:/app permissions:latest bash
```

You can also wrap this in a script of some sort, or a docker compose
file, to make it more usable.

## .gitattributes file

Note that if you clone this repo on Windows, the 'entrypoint.sh' file
will have Windows-style line endings. This will cause problem when
trying to copy it to the container filesystem which will be linux. So
the .gitattribute file tells git to always check out that file with
unix-style line endings so that things work as expected.
