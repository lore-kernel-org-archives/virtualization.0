Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3825C16FF54
	for <virtualization@lists.linux.dev>; Wed, 17 Apr 2024 16:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713372361; cv=none; b=iPF4esHsL00ua3B9w+tQGpMABVDlbJvjpY0cGaIetzSReh9DenDTy0RT3KhfVILtCfgSeIiprvsa3Hzy+LPcJLBecHFx1B47jEf2NdiTRshYB5vfBSj0A2OOlEhAUgW++its4g7pzgW/3K2R7VNUa3Beif7wSOfyRp3lUvenW1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713372361; c=relaxed/simple;
	bh=Kaak7gu3fcnDB6M+R04jt8aBqli+cY8tvRZ14TKFYbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BWqkWTmfd9P0p6hNCSzS9He/bb7Mg/7QoJb5q01gol9l/sv5JPqWJDwCXGIWNSnD4ml6yg0Iyc1YblZcwOeVvBwNqHxNcDSFsfrv8Mp/8IZ4qm8eTcfRfYg0Aa2XIsm5Vl4doRQa7Ce5qKxLdhQX/o0q/udltxCmHlrFR8eD0v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=WTeYxJJb; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="WTeYxJJb"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a523524e5baso700887266b.3
        for <virtualization@lists.linux.dev>; Wed, 17 Apr 2024 09:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713372356; x=1713977156; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2On83QUGJlRF1XkVFp7hMz1f3aFCzDXCcNes5I53Wcc=;
        b=WTeYxJJbI7FrI8TqoijwbVmRDU9+47thBlv2jFL+Ibb3NkOHv8zBYVLF3VPZtMid2i
         YMNwoO4iFdyuNNmDRPyC8un0kh6XnfbGj5QAGi5yzkGVGWqsG780TO4OriFntCABay23
         NB/MbTfRyHs5Gsj357HqNPPk/Xwza/w8P1LzsvB28qbsJ3P0OPNhbb+IVjvgt8G5R4si
         /+8ugFbw+cZGFetlZzZBPMhaWOOyUFEMlXqksPTyMjU69ixamtpWH6Eb5fVH+eat/I9Z
         CrUUGRWU/MdVvfujf3j7WH85BmFemJlXaGTe6rtaJN8YPxwvTUd4k1yCNuBuVTiuRFvW
         oiwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713372356; x=1713977156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2On83QUGJlRF1XkVFp7hMz1f3aFCzDXCcNes5I53Wcc=;
        b=gmNXxwfVThyZjm+U+GCrdXDKl8kAeFTqMtPX9NoGvQiMrFc512OA8ROZDkox7pCEDt
         5w0GFpnOj3QsqducvZGeIzPpsN9I4dIKkHYBjQvGoCSq5Y4mEI6b/BgKOhSM2m9ZVpa3
         eg4dqXauhSuutMjv56mWbEdpXjg8kFXlQBlVC9XSiLOr6vEDs/P/sspNtkowmqFONGXG
         KUut1Vb1XgxRSeQTtTvtEXuknmw8pP4hG0p3YpW4awp7kizkadqSUbVSTd73++NvlgFl
         yWtpWAoNGMcn6IlJ2iVMry8mZ0cTx+c1UbYHP3odrncYcq7xkLu92e07L5MLPEBNRhMY
         4qXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXydcQ0VWgRARaGv5lXOBqVu2Osik/Bf4YkoMVsaxn2a4ko0IsuHZldl5rHfFytZnDCBWypRHZF3BPI5/Dlv5QIRC0163JRNsoZMwR0FX4=
X-Gm-Message-State: AOJu0Yx86Auz0pOek5pqLc/5bPQvaHO/jbCsUj5DLsPvuGYGslzGUTvJ
	4/9/zPdnwTyhTWz4cfJSFu133RI2xkNL7jl52/lBCl1AaIcDR0XwZQaoN04hqpg=
X-Google-Smtp-Source: AGHT+IGPz1iUONHNxGqyZENzcyphI2D6dmYmARBbsyyMaiEn1s59CyxQOgOVJdVozIW7fs2g88i3SA==
X-Received: by 2002:a17:906:46ca:b0:a55:6534:8035 with SMTP id k10-20020a17090646ca00b00a5565348035mr58491ejs.11.1713372356110;
        Wed, 17 Apr 2024 09:45:56 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id y9-20020a170906470900b00a51a74409dcsm8397278ejq.221.2024.04.17.09.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 09:45:55 -0700 (PDT)
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
Subject: [patch net-next v3 0/6] selftests: virtio_net: introduce initial testing infrastructure
Date: Wed, 17 Apr 2024 18:45:48 +0200
Message-ID: <20240417164554.3651321-1-jiri@resnulli.us>
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
v2->v3:
- added forgotten kdoc entry in patch #1
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
 include/linux/virtio.h                        |  35 +++++
 tools/testing/selftests/Makefile              |   1 +
 .../selftests/drivers/net/virtio_net/Makefile |  15 +++
 .../drivers/net/virtio_net/basic_features.sh  | 127 ++++++++++++++++++
 .../selftests/drivers/net/virtio_net/config   |   2 +
 .../net/virtio_net/virtio_net_common.sh       |  99 ++++++++++++++
 tools/testing/selftests/net/forwarding/lib.sh |  77 ++++++++++-
 12 files changed, 480 insertions(+), 4 deletions(-)
 create mode 100644 drivers/virtio/virtio_debug.c
 create mode 100644 tools/testing/selftests/drivers/net/virtio_net/Makefile
 create mode 100755 tools/testing/selftests/drivers/net/virtio_net/basic_features.sh
 create mode 100644 tools/testing/selftests/drivers/net/virtio_net/config
 create mode 100644 tools/testing/selftests/drivers/net/virtio_net/virtio_net_common.sh

-- 
2.44.0

