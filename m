Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E1516F8E4
	for <virtualization@lists.linux.dev>; Thu, 18 Apr 2024 16:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713456519; cv=none; b=GEsSnKLVBrk0QH1c+n47yhpkZucVqYWEXUS+jteNW0NSm6THjb0ilNjRO4XGtMMmNasZBNagJkX7aKvHbpNkyG+KyYCqxXZ7tHnZ4fdyqmdBJll5M6DxijigBHR+wueBVYv6P35qStiVMYZSqJNEfkp6i/jqcvh9uKoIVpoIN58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713456519; c=relaxed/simple;
	bh=weDIBLryWoYrugAPESMToLdD2SzxslmL/6FZdua4c/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iCXtwUt6CyXGM2RzoynksnWnRgHMsNZoqc5k0fVGU82tHqBpxyst19Ihbmxuj8DYYA/QGxBXWA9gG0Bm9zB9W9uvWCPben4qdwC4MNejdEqbs3Hc4rMUvGLOjAoEpEHLRCDZF56xEw/r6+U+grNfaDq8BnUKxYzmGtUmDZzSPps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=KzMMa5g7; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="KzMMa5g7"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-518e2283bd3so1560453e87.1
        for <virtualization@lists.linux.dev>; Thu, 18 Apr 2024 09:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713456515; x=1714061315; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6Kt4+AOhTs3GvEKGkYN2+viHumt1Dp25Zh+htyYxrOQ=;
        b=KzMMa5g7L/6e34iUPfSjVcXLgqphkQ4zpLy5MjEx+nX4AEHzdQBPO4P1LHdp8UFqBQ
         ieM1EuYWsknamfgYFmg5H/B6T4z/94AsgLMaL7V3Y3s5548gbc+YIgfQ9q+Ecq3Gmt+V
         DjTbSeOLrr6CK7ufA7w50EkAN0MIhfwL32RhSuDQPR1vOprhRIzh3E2mbTo2PU5AGiQ9
         3/nSqPYQEzeddF3kQQ/c/U6Su6h0dwaysdjCF1W9ZrLVSPSKsNKBgmzE2Zzs7uXFsxB7
         B0swMFq/KOqACoqpzSBM9kT0WSx0BfhnOELF36H0/fKKlet3B34GjbPOI4fkD9Nagtld
         kUzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713456515; x=1714061315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Kt4+AOhTs3GvEKGkYN2+viHumt1Dp25Zh+htyYxrOQ=;
        b=egGU9DiOBlBv1GHRK0Mzh74LQULKlreH0CL145hTgpCQuDokUqM/0kIUbbLfwMSQiJ
         HQpkq6i/AWIk9W5Mlo/w2mBTD7AXwm4Gu/EHhnMW1n6ZwI05MToyV5muyi62vuVfScdc
         MF2/xw38jlAv8wJAeC4IyMu3wba4lBW8y1mrVMUi8aE18ltTj8DnezGdfCTsq6YsTgm0
         iO9S5iRyrWKVd2OyweVXcrCio8N1oGx5s7F257Thzb0ZIgC11DNK1JF6euJiKDbfWJ6G
         SfU3CZzFuQNTz4MxWQdbEnlUNJGTbKDur8vSS0UvcJCaKq7ylQThtJv797VcPfPGwaAq
         6LBA==
X-Forwarded-Encrypted: i=1; AJvYcCXoBhKbU8u6i9KAvXLSRR7HNuQyRAXCv/IY/sK6qIhuAmxi+tb3wrwPTTRbUlsZUEfXNpixbVOv0gfklb6RyzoREEV6wF+hxzuk59xqF8g=
X-Gm-Message-State: AOJu0YzvUsP0rZvtw98dT1jIwcusj7vXjAR9EG6UQ+KDG7/G/Fmb0fH4
	C9vq3rZ3D14ZxbAYXV6A6EC23DK6ZB+MwkZdHPo5pc6/2BL3ekkAvhMABuOiS7k=
X-Google-Smtp-Source: AGHT+IEJN/IoDrgI7OoaFc2HIm5IxA5WD49uH3pqVxyOXjG3BHJEqN0L3W3WRyfSiFEph8w85BdWjw==
X-Received: by 2002:a05:6512:3c9e:b0:51a:36b6:1f5f with SMTP id h30-20020a0565123c9e00b0051a36b61f5fmr1442886lfv.3.1713456515147;
        Thu, 18 Apr 2024 09:08:35 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id l22-20020a1709065a9600b00a51b5282837sm1088437ejq.15.2024.04.18.09.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 09:08:34 -0700 (PDT)
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
Subject: [patch net-next v4 0/6] selftests: virtio_net: introduce initial testing infrastructure
Date: Thu, 18 Apr 2024 18:08:24 +0200
Message-ID: <20240418160830.3751846-1-jiri@resnulli.us>
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
v3->v4:
- addressed comments from Petr and Benjamin, more or less cosmetical
  issues. See individual patches changelog for details.
- extended cover letter by vng usage
v2->v3:
- added forgotten kdoc entry in patch #1.
v1->v2:
- addressed comments from Jakub and Benjamin, see individual
  patches #3, #5 and #6 for details.

Jiri Pirko (6):
  virtio: add debugfs infrastructure to allow to debug virtio features
  selftests: forwarding: move initial root check to the beginning
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
 include/linux/virtio.h                        |  35 +++++
 tools/testing/selftests/Makefile              |   1 +
 .../selftests/drivers/net/virtio_net/Makefile |  15 ++
 .../drivers/net/virtio_net/basic_features.sh  | 131 ++++++++++++++++++
 .../selftests/drivers/net/virtio_net/config   |   2 +
 .../net/virtio_net/virtio_net_common.sh       |  99 +++++++++++++
 tools/testing/selftests/net/forwarding/lib.sh |  70 +++++++++-
 12 files changed, 477 insertions(+), 4 deletions(-)
 create mode 100644 drivers/virtio/virtio_debug.c
 create mode 100644 tools/testing/selftests/drivers/net/virtio_net/Makefile
 create mode 100755 tools/testing/selftests/drivers/net/virtio_net/basic_features.sh
 create mode 100644 tools/testing/selftests/drivers/net/virtio_net/config
 create mode 100644 tools/testing/selftests/drivers/net/virtio_net/virtio_net_common.sh

-- 
2.44.0

