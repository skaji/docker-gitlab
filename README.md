# docker gitlab

Setup gitlab in just **one** container.

## usage

    > docker build -t skaji/gitlab git://github.com/shoichikaji/docker-gitlab.git
    > docker run -d -p 10022:22 -p 8080:80 skaji/gitlab

Then you can access gitlab via http://yourhost:8080.

## note

* The initial username and password is

        username: admin@local.host
        password: 5iveL!fe

* ssh access to the container is via 10022 port.
So when you add remote git repository, you shold set:

        > git remote add origin ssh://git@yourhost:10022/root/repo.git

* You can ssh to the container as root:

        > ssh -p 10022 root@yourhost  # password: root

## see also

Main install process is done by https://github.com/akagisho/gitlab-installer

## author

Shoichi Kaji
