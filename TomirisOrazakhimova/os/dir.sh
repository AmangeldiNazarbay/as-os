#!/bin/bash
wget --no-check-certificate https://github.com/mkm-77/as-os -O- | grep 'href="/mkm-77/as-os/tree/master/' | grep '</a></span>'|sed s/'<.open "'// | sed s/'title=".*id'// | sed s/'=. '//