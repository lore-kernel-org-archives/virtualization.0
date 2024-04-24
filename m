Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118CF159579
	for <virtualization@lists.linux.dev>; Wed, 24 Apr 2024 10:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713955259; cv=none; b=Jiq8sr6BWRLzubMKWKb1UOrSeEKA0Jfs9UvJeuwLCw0HBEaDfB4N23i4ZnHvJgW2VqpYoxCofpgPPgvoYhS4LlKGQM5niEFKNYb7rdXM7Oe7mormdqtsZLdb6lYPlBtmfAaVZnjDhufrpzqCt45xC/lAvVLjehhyhi9ar2LqfDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713955259; c=relaxed/simple;
	bh=9JcMIim2AxGlmts+KkFUqqLwHcgOQ7OvJ2AwErYMn/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AYlTZUjGsiebzV+IdsProFhqgHOuFyGp8jqmmrKbBNNKovLFs4hSiFewReAyYuHqJ2RkylX7Pzm9HtjvmxIgNlcWJwIjAcbyjRbu4s1Gj4+4e8A7wl9YTU2QTs7TVEr3WO+Z6lAhV+wdMpNuAujJS22CbjudyurOHxo1y+hmyPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=AW3tTILj; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="AW3tTILj"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51b09c3a111so5388137e87.1
        for <virtualization@lists.linux.dev>; Wed, 24 Apr 2024 03:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713955255; x=1714560055; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N4+OySXqohdnDZrtl87O33OEWoDiUo7Nu55zUTWNpdQ=;
        b=AW3tTILjmntA5Xpt3q2CcLoF5NxNaExcvLVPkqYSDWbRovkke+4QpCDHvg1MwJLEUs
         SridPQW8iH9+Sm1fNCVJYKOne6iRBSMaho7vB6tHrWGVbLsu+iDqnCjLxjstE1xcJXNn
         dTTZyKNmIDk2+06owpfMGiZWi3MHNsQXBSvkbj10ukaq2LV/8BSw4LmobdUqx+BDh2uG
         N593kHFlRyoli9mj88C3Gxygu3xf3dVCNV/tCXSYnGqEjiM/0aUbMdqZSRmr8rJDWJ8u
         KgO9EaC9X2nSDxjSNFRe9AXvy9JQTxFolAGl1F20CRbwYmwBKQLSU7ORLGfPIU2BC+C4
         mrpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713955255; x=1714560055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N4+OySXqohdnDZrtl87O33OEWoDiUo7Nu55zUTWNpdQ=;
        b=ZuKjm4TKIhxONg/14WgvzqLsW961kHctxkWWmaid+J12/es69u1QnJfgaPvt34hV7O
         C2EeR8zkFSAen/GgeL0NZwAC28n6uI7LTfZc/C7wFkKZ9YHFYEUZBhKo5yQj2Cu6dV5m
         pLBDV724oDUiOy0WKomn5QzVZJhT3C7s5sDG+5UOm96ir5mbiZ/BvBe+OoSnLz2YrEWu
         TQyGbP0ilr/pgixUuJhV284J/l9X2zGTqORXUY6V2tod5+SLn8QzuSjPoU+CIzsjWsmr
         f/CyfhvGpXpC47pkoNLdJ861tFgHZP6lGcjFvXOHK48SspUGdFH2P+E6zaUamakqa3qu
         +Edg==
X-Forwarded-Encrypted: i=1; AJvYcCXndgCZQiteucZcmps2+cAepZN8VbAJzgRn3GPnmoRRxrMBQgEO3Z0qoDA95VJq3m3KJoYSs4ETqFkanncmj0Sd+Cx2g9M2vqWQvwZGoE4=
X-Gm-Message-State: AOJu0Yy7qyeet41aaClL1uImyhutPtUy3GiyX5FhEB9FKF0LFCfjuosR
	j5CzKynL1mBVUUtvZOIi4K/E3/qoCNVIiD8dhuOsQhP9y6yQbD2rAWcxgbIEzsJ5AcIm7KQmeR+
	zO8I=
X-Google-Smtp-Source: AGHT+IEVnEntDH1vJfp87AhxZXLdAyKx0mTX7w/yogKylLbcds/KRI+5bBmfwFbUvWc2d5luW9bLrQ==
X-Received: by 2002:ac2:5e2b:0:b0:516:a6ff:2467 with SMTP id o11-20020ac25e2b000000b00516a6ff2467mr1413194lfg.0.1713955254731;
        Wed, 24 Apr 2024 03:40:54 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id kx18-20020a170907775200b00a57e2d39d56sm2730454ejc.223.2024.04.24.03.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 03:40:54 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	parav@nvidia.com,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	shuah@kernel.org,
	petrm@nvidia.com,
	liuhangbin@gmail.com,
	vladimir.oltean@nxp.com,
	bpoirier@nvidia.com,
	idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: [patch net-next v6 0/5] selftests: virtio_net: introduce initial testing infrastructure
Date: Wed, 24 Apr 2024 12:40:44 +0200
Message-ID: <20240424104049.3935572-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

This patchset aims at introducing very basic initial infrastructure
for virtio_net testing, namely it focuses on virtio feature testing.

The first patch adds support for debugfs for virtio devices, allowing
user to filter features to pretend to be driver that is not capable
of the filtered feature.

Example:
$ cat /sys/bus/virtio/devices/virtio0/features
1110010111111111111101010000110010000000100000000000000000000000
$ echo "5" >/sys/kernel/debug/virtio/virtio0/filter_feature_add
$ cat /sys/kernel/debug/virtio/virtio0/filter_features
5
$ echo "virtio0" > /sys/bus/virtio/drivers/virtio_net/unbind
$ echo "virtio0" > /sys/bus/virtio/drivers/virtio_net/bind
$ cat /sys/bus/virtio/devices/virtio0/features
1110000111111111111101010000110010000000100000000000000000000000

Leverage that in the last patch that lays ground for virtio_net
selftests testing, including very basic F_MAC feature test.

To run this, do:
$ make -C tools/testing/selftests/ TARGETS=drivers/net/virtio_net/ run_tests

It is assumed, as with lot of other selftests in the net group,
that there are netdevices connected back-to-back. In this case,
two virtio_net devices connected back to back. If you use "tap" qemu
netdevice type, to configure this loop on a hypervisor, one may use
this script:
#!/bin/bash

DEV1="$1"
DEV2="$2"

sudo tc qdisc add dev $DEV1 clsact
sudo tc qdisc add dev $DEV2 clsact
sudo tc filter add dev $DEV1 ingress protocol all pref 1 matchall action mirred egress redirect dev $DEV2
sudo tc filter add dev $DEV2 ingress protocol all pref 1 matchall action mirred egress redirect dev $DEV1
sudo ip link set $DEV1 up
sudo ip link set $DEV2 up

Another possibility is to use virtme-ng like this:
$ vng --network=loop
or directly:
$ vng --network=loop -- make -C tools/testing/selftests/ TARGETS=drivers/net/virtio_net/ run_tests

"loop" network type will take care of creating two "hubport" qemu netdevs
putting them into a single hub.

To do it manually with qemu, pass following command line options:
-nic hubport,hubid=1,id=nd0,model=virtio-net-pci
-nic hubport,hubid=1,id=nd1,model=virtio-net-pci

---
v5->v6:
- fixed a rebase mistake in patch #3
v4->v5:
- added exported symbols into patch #1
- remove original patch #2
v3->v4:
- addressed comments from Petr and Benjamin, more or less cosmetical
  issues. See individual patches changelog for details.
- extended cover letter by vng usage
v2->v3:
- added forgotten kdoc entry in patch #1.
v1->v2:
- addressed comments from Jakub and Benjamin, see individual
  patches #3, #5 and #6 for details.

Jiri Pirko (5):
  virtio: add debugfs infrastructure to allow to debug virtio features
  selftests: forwarding: add ability to assemble NETIFS array by driver
    name
  selftests: forwarding: add check_driver() helper
  selftests: forwarding: add wait_for_dev() helper
  selftests: virtio_net: add initial tests

 MAINTAINERS                                   |   1 +
 drivers/virtio/Kconfig                        |  10 ++
 drivers/virtio/Makefile                       |   1 +
 drivers/virtio/virtio.c                       |   8 ++
 drivers/virtio/virtio_debug.c                 | 114 +++++++++++++++
 include/linux/virtio.h                        |  35 +++++
 tools/testing/selftests/Makefile              |   1 +
 .../selftests/drivers/net/virtio_net/Makefile |  15 ++
 .../drivers/net/virtio_net/basic_features.sh  | 131 ++++++++++++++++++
 .../selftests/drivers/net/virtio_net/config   |   2 +
 .../net/virtio_net/virtio_net_common.sh       |  99 +++++++++++++
 tools/testing/selftests/net/forwarding/lib.sh |  62 +++++++++
 12 files changed, 479 insertions(+)
 create mode 100644 drivers/virtio/virtio_debug.c
 create mode 100644 tools/testing/selftests/drivers/net/virtio_net/Makefile
 create mode 100755 tools/testing/selftests/drivers/net/virtio_net/basic_features.sh
 create mode 100644 tools/testing/selftests/drivers/net/virtio_net/config
 create mode 100644 tools/testing/selftests/drivers/net/virtio_net/virtio_net_common.sh

-- 
2.44.0

