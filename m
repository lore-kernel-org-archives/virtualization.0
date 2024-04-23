Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED3864CF2
	for <virtualization@lists.linux.dev>; Tue, 23 Apr 2024 10:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713868877; cv=none; b=M09zS2vyM1PvGg97Umw5moABdP9DuegXf6Nq8Yi5a0K/1RzOluPW4ft1r+de/BTr7QR+3uCHte+mkaI1zfYR6HQv8TbYxc53SW1XOrFsBLQ2jApxtfhulHMb5LQFqAuiXZyow1AmPyb4rGZhwuUoOzF68QUJGh2Z2ZOT2RXfV3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713868877; c=relaxed/simple;
	bh=9q6ouA56yQo0k0bb4TWu0djK4ncNb5Fdytp5WSkJTYM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LU6U19JIUqy+2W1qPk62rZvumJ4oWa9KffE02yrpiisFv1eZrTXUMHxYhZl8MrshBifdelBWMoEBVdRV4fzkrpHtEaS0QhtXVdYSQZVzV5qmP1y25AK3iFGLZ5oKqGhc8i7GOGUi7rgdkygX+ZJn18QRIFIHZB6HhFEVvZLsQl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=2ClJwXTo; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="2ClJwXTo"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a52223e004dso521419066b.2
        for <virtualization@lists.linux.dev>; Tue, 23 Apr 2024 03:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713868873; x=1714473673; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EMOlDHcF7Ts4yl1h3F9FfhqEWMlZGrfkCOKfoDXKBRk=;
        b=2ClJwXToT6Xz2qthoklX2jcm7QZN0QUA3rP4jB0Ci5L6iRQRRQI2xbCCgqgVanY2um
         xzhjkT8j82Dp4++n28st72T1FQkxWyfNslTvpBxYS6OSsUpbqNuq7/egI0vGnVPx3ceY
         XUL7o1Yt3pp2YcX5eEmtDBxw8U1eX7W46vDOQQNki92eGkkC+qL+uY8k7Zmpl1P534gN
         SNegvtIKUCy4MExQLM0r/M/LxCR6R/UFeBoCB5+QjyKeQ/TZLQaGN8xkuBhcf5wE/wte
         DcZ1rcDUADkVYynozJ4PjzlMyzuwfcc8rpJGn+0ClBwahOYK9rdiVhRAOAkqS/AycXYz
         du1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713868873; x=1714473673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EMOlDHcF7Ts4yl1h3F9FfhqEWMlZGrfkCOKfoDXKBRk=;
        b=JtO+l77cBnlws/S4CeDNvkWCooagMS3gqLPdYkIkeOqw1tNXX9W0AmBipSxcCZm4oK
         cEp6i6BkT7bGGD6nsl5bAywvMIYq5RI6XerCoKvmusBcDtaZDQH2V+S8wGhBusYKNxnM
         epQSO9EGWPrWEs+uYnWQOB409VBYzQ776txGrIfMrV7IEpIn3zfXDx+d7z7fnIJ/zt/i
         6lE0KzBy02CVINQE4r5bakJ66qnwPmQSt4Fn7AKg/u9mWg3z94bqqW9MZvpwHQ/z0Y4u
         74zAk6AsgnDprw+LfweuLCIcrpLtrNAESbPQJiFIW5aaVeb4MvJ5hY9fFVVFvIy7bxBt
         73zQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcNTd7b/wLMPjq6gq/td8TsdyIwx8iR6p7Il5jL6nbzQE8J38mJi7cFpX7OL+Xjd0Bxak6K+9mYCU51xpfqYAH7ZhzVzD8xN5mLcIaZYI=
X-Gm-Message-State: AOJu0Yy/aBH57v4nDUSXktaP6G1cFwi3Psbtv7iVgk4bOLv2lYhBRejK
	sPc8hvCST4SZ1kFKi7OX4pd87tR4eCkof6h5YMO/drFIdj8xV/Qf0e8RzoLN+iI=
X-Google-Smtp-Source: AGHT+IF5yOlbCc3XuxtrjYBUXSuLIg6HpzDJP0wTP9amMXONrnEggK9yId+H/FpOrFLl6HvVzkVi7A==
X-Received: by 2002:a17:906:5592:b0:a58:7c50:84e4 with SMTP id y18-20020a170906559200b00a587c5084e4mr1734096ejp.2.1713868873364;
        Tue, 23 Apr 2024 03:41:13 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id qy1-20020a170907688100b00a558be8bc03sm5203755ejc.150.2024.04.23.03.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 03:41:12 -0700 (PDT)
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
Subject: [patch net-next v5 repost 0/5] selftests: virtio_net: introduce initial testing infrastructure
Date: Tue, 23 Apr 2024 12:41:04 +0200
Message-ID: <20240423104109.3880713-1-jiri@resnulli.us>
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
 tools/testing/selftests/net/forwarding/lib.sh |  65 ++++++++-
 12 files changed, 478 insertions(+), 4 deletions(-)
 create mode 100644 drivers/virtio/virtio_debug.c
 create mode 100644 tools/testing/selftests/drivers/net/virtio_net/Makefile
 create mode 100755 tools/testing/selftests/drivers/net/virtio_net/basic_features.sh
 create mode 100644 tools/testing/selftests/drivers/net/virtio_net/config
 create mode 100644 tools/testing/selftests/drivers/net/virtio_net/virtio_net_common.sh

-- 
2.44.0

