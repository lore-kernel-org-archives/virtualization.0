Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE85329414
	for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 16:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713198337; cv=none; b=QfywuWjOujRtAjDD83EHbPwy2T+972e6bqeelxNkGU6ApibVL1dy0W13tFeiOvp3/YgH3He+uRX3RETaGIqobd8Pyj3GcTL9veNGLvguJ2ew8Qt6A2am8JoYuMj9EshbPoyKebSLrF0CzveLVyNRZMdd/FwssbKFAtlFQSLm/0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713198337; c=relaxed/simple;
	bh=HrY+6R14sldOiILXyUI6rqVVYTPxkUH6QtJC9oVISG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MFvQKVLWuI3J9fxSi/6ClHM4J/RXTK4nj6da58/UHnH3zSWCXotf7oR3oqwb5DLmVn09zodF5u4YLgjERAl+ppFXbiix6g87Bdh95edl3MJPdJbpli/F5ebfERSBDJLXUH6BKdfxlNLXvRB8b/AfxbAqb7tWxZIPZSXp6Gzf1MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=fLYoXET5; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="fLYoXET5"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-518a56cdbcfso3373169e87.2
        for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 09:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713198334; x=1713803134; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+w5L6fXt4Mw80dA9l9dnOlWTsYVxq476KcvcT8ApIw8=;
        b=fLYoXET5kwo0AaLyMw3JhPeNQOmKp45BreGD6L5o2ZpghlNbrEBewHm+eNkln58EKT
         9lNBVeng2t8WLzxkpo+vKwDysfz93tHYmTfd/VHjSaMG5bt7iG7iFW8in14I/DGMw4lT
         ijjZQCdt2474vNVQX8sl9+jjhjukZj/aST1ynTq6fyiyJOBQ+gwMMqb7/mBt9mO5rQXO
         B+mwD3mQdW6mlhayOwu1g9GKyyQIYBU9He7UtkcIUvHymZkJTTFv24iqZqhOnBXjtOo1
         mLUTHecGt4ezc22OYH+dL4HFGbZpxRTj/yo2ahZmJ3ppM83yTaSxOBXh6NUcejH7BiFM
         vF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713198334; x=1713803134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+w5L6fXt4Mw80dA9l9dnOlWTsYVxq476KcvcT8ApIw8=;
        b=fGRVA2WXxOHSIHYK1z+tPKVQTejQY8AOxiLzbcM/iBLeqJGClz5wxzgpLUflboEqKd
         k8CzewJdwtLnDe8rOtaSz0rmlSAz/hPqW3LGyBUp0AzZVFJ+23P7dppNrWXEen7/yTUl
         SHHoXBs2VIsjXQH+k9KHexwBADq5drZuP6G0CC28Be6G/6i3jfzDffs0RyJ/9rf5vx3/
         0m7pOVaJmDfMmHDFOUICCYdXRZOgwQcA2myv8EuwVDgz50Nt6DfQiHkT7ZvTn/fwK56D
         TOeuOvo8pHdkvo43VQsgO5b7LGawb0m9NUd9QDG6EACVNd1NAaeA+x8wy/+jm5DenYNk
         uzXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJuYypZe7GT5XGwRUz5mvqtWbVdrrz2j0uxt3MLN71k2qUk+C/UC3lAL8X4NF9vE7uDufU7ufSRji/hvOto8OK/I5ZkXjyIDrTNDkgDNg=
X-Gm-Message-State: AOJu0Yxd2nOMctmlpg8TnwI5RnetwgTkVn3HHzxtzP9Rp3IPX1e56pTs
	29Ox9EE7OKgrBucJEAqIYKm6wJsD8qlZEbdBHkiJwzflyfmjkwhOk5kKQ1iMmxM=
X-Google-Smtp-Source: AGHT+IGQILVfb1rNV8SkbAhFTmCq5jbu6EYEDdqL0R6Ojgrbn/4ssrIeL5JM/wj71/IB5duAnmy/nQ==
X-Received: by 2002:a05:6512:10c7:b0:518:c82a:bdf9 with SMTP id k7-20020a05651210c700b00518c82abdf9mr5635913lfg.44.1713198333772;
        Mon, 15 Apr 2024 09:25:33 -0700 (PDT)
Received: from localhost (37-48-2-146.nat.epc.tmcz.cz. [37.48.2.146])
        by smtp.gmail.com with ESMTPSA id b18-20020a1709063f9200b00a523cf3293fsm4181949ejj.59.2024.04.15.09.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 09:25:33 -0700 (PDT)
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
Subject: [patch net-next v2 0/6] selftests: virtio_net: introduce initial testing infrastructure
Date: Mon, 15 Apr 2024 18:25:24 +0200
Message-ID: <20240415162530.3594670-1-jiri@resnulli.us>
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
$cat /sys/bus/virtio/devices/virtio0/features
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
make -C tools/testing/selftests/ TARGETS=drivers/net/virtio_net/ run_tests

It is assumed, as with lot of other selftests in the net group,
that there are netdevices connected back-to-back. In this case,
two virtio_net devices connected back to back. To configure this loop
on a hypervisor, one may use this script:
#!/bin/bash

DEV1="$1"
DEV2="$2"

sudo tc qdisc add dev $DEV1 clsact
sudo tc qdisc add dev $DEV2 clsact
sudo tc filter add dev $DEV1 ingress protocol all pref 1 matchall action mirred egress redirect dev $DEV2
sudo tc filter add dev $DEV2 ingress protocol all pref 1 matchall action mirred egress redirect dev $DEV1
sudo ip link set $DEV1 up
sudo ip link set $DEV2 up

---
v1->v2:
- addressed comments from Jakub and Benjamin, see individual
  patches #3, #5 and #6 for details.

Jiri Pirko (6):
  virtio: add debugfs infrastructure to allow to debug virtio features
  selftests: forwarding: move couple of initial check to the beginning
  selftests: forwarding: add ability to assemble NETIFS array by driver
    name
  selftests: forwarding: add check_driver() helper
  selftests: forwarding: add wait_for_dev() helper
  selftests: virtio_net: add initial tests

 MAINTAINERS                                   |   1 +
 drivers/virtio/Kconfig                        |   9 ++
 drivers/virtio/Makefile                       |   1 +
 drivers/virtio/virtio.c                       |   8 ++
 drivers/virtio/virtio_debug.c                 | 109 +++++++++++++++
 include/linux/virtio.h                        |  34 +++++
 tools/testing/selftests/Makefile              |   1 +
 .../selftests/drivers/net/virtio_net/Makefile |  15 +++
 .../drivers/net/virtio_net/basic_features.sh  | 127 ++++++++++++++++++
 .../selftests/drivers/net/virtio_net/config   |   2 +
 .../net/virtio_net/virtio_net_common.sh       |  99 ++++++++++++++
 tools/testing/selftests/net/forwarding/lib.sh |  82 +++++++++--
 12 files changed, 479 insertions(+), 9 deletions(-)
 create mode 100644 drivers/virtio/virtio_debug.c
 create mode 100644 tools/testing/selftests/drivers/net/virtio_net/Makefile
 create mode 100755 tools/testing/selftests/drivers/net/virtio_net/basic_features.sh
 create mode 100644 tools/testing/selftests/drivers/net/virtio_net/config
 create mode 100644 tools/testing/selftests/drivers/net/virtio_net/virtio_net_common.sh

-- 
2.44.0

