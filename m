Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFF11482EA
	for <virtualization@lists.linux.dev>; Fri, 12 Apr 2024 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934802; cv=none; b=lnjB5KlU+vgnMRIFNiGyqgNTmJhh+bsNMEhk3S6utFgu1MKOtquU+V0IM2oup2yes7UyjCFsAxEWWitNOJUTVeRg9cG6eo917LH6YgD3PHciR1BaDlcV5n1WMjuwdw3RjYPTBZ2UFVPW8cVMOiFPMJvF9mQQ0BTDH7MjJfksa38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934802; c=relaxed/simple;
	bh=ESzyqtm+jB6HKG59z9sGdyjp37OdGeh0gFmicuYbHwU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a4sr6SQ6k7b4d2o5JIXIfZv9fkREdB80MiXhihrOCYMGjQsSPwD/1DiNBzV9hmxiduvlG+ysfGqAviHQJUozZi3gf4x5b56fAOl6e4CD6mu/oWpf37pENLhrJydDDO9kRgIK+iHT6hW3k6JTa10KCKBOAjI3ScterL8NpkNGcaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=QeLBW3CQ; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="QeLBW3CQ"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-516d1ecaf25so1270882e87.2
        for <virtualization@lists.linux.dev>; Fri, 12 Apr 2024 08:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1712934798; x=1713539598; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P5Y3OCl0Ya94dXdukJGYcqnaLSv9gvjSDT/1en8tmJQ=;
        b=QeLBW3CQTxX8JE6MUn48lZHNmM0DJQxk0gyawZKka9hK55yxSYIMwMuafLe54JTtbB
         s1ZkzYPIPXaR4aXTNPVK0OwRdC2yDFSv0SXxLCQ/xBgYlri0DhKLDFD7xqxyBQti5oBk
         wm9Yaqw+JRUijdZUR9L8qhVu84y+EGZsYsSpD7qdGIcmmXTASnciVNZwne021uSucwW6
         ooTnxsEa2hufxHatEpL/mMLXZMmiefcucQQi2COpLmszbMSVc4cMairhTWFOmDF53kkl
         2xlwWE+qQikv0iQM4j5uqnHrWvDpdnR1X6YyxY6XhGN0yz5pwNetxwJymnrws/a8mij0
         LKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712934798; x=1713539598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P5Y3OCl0Ya94dXdukJGYcqnaLSv9gvjSDT/1en8tmJQ=;
        b=s/Pt+6kXhWlvX2a5mSOSUkr240EzyB0USupCrIAo0xDEc5xb0XzpP+cwNn5kQz+46+
         yCYWdpFhEQvjoLBuB0zDI1USDsQ1MLPE6R8/VQVmOZ1dU5tbCs/gjC+zGDew4B3MSAab
         90TQ9+uqp9R2eiUdjPGSOVv0swKO4zVbZPOqe6tolrkjQM/T7X9kS9ZuXFQjWCmszi34
         VVvpPaAVDjh5iHYfsGZLTrctqM7P1Gu+ZGv8m/yUlZKS/aWjMXD4Qwraoe6GEGNGmmsZ
         0h6eoAaUC6FJkrKGLSVmnJm8tsxijw6/X33aSKexMHQNKKeNFcfcJHyd8AURvM1dZSWU
         kEHA==
X-Forwarded-Encrypted: i=1; AJvYcCUiJEfA9Jn+2zl5Yt6eoo7z7O4CKW1hOUFEC0KVSUOveD89VCG42eLNyKjIwZPffgIusDBZ0XpA0jVyLeQizXG6hi6dmveNcYsVC4V41gQ=
X-Gm-Message-State: AOJu0YwD2T3QFGlw0vaIua4XCnhQHsj/jGRV+D6cbBco5e/fQEMiW2Tr
	8LHmJhICNU3Vc8X5N2wgrdos1/EyukBmrHxWUp6pEqiJ15FUcxSYg1CEhiBjnJM=
X-Google-Smtp-Source: AGHT+IEnvoqTl0xn9fALHiv7H+KFVt1wiZ94Y1cbktGtRsPcH/xi4CpFt344ob6b4S/CV9mGjJKECA==
X-Received: by 2002:ac2:5e91:0:b0:518:17ad:a6da with SMTP id b17-20020ac25e91000000b0051817ada6damr1733771lfq.44.1712934798255;
        Fri, 12 Apr 2024 08:13:18 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id p27-20020ac246db000000b00518948d6910sm88356lfo.205.2024.04.12.08.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 08:13:17 -0700 (PDT)
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
Subject: [patch net-next 0/6] selftests: virtio_net: introduce initial testing infrastructure
Date: Fri, 12 Apr 2024 17:13:08 +0200
Message-ID: <20240412151314.3365034-1-jiri@resnulli.us>
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

Jiri Pirko (6):
  virtio: add debugfs infrastructure to allow to debug virtio features
  selftests: forwarding: move couple of initial check to the beginning
  selftests: forwarding: add ability to assemble NETIFS array by driver
    name
  selftests: forwarding: add check_driver() helper
  selftests: forwarding: add wait_for_dev() helper
  selftests: virtio_net: add initial tests

 drivers/virtio/Kconfig                        |   9 ++
 drivers/virtio/Makefile                       |   1 +
 drivers/virtio/virtio.c                       |   8 ++
 drivers/virtio/virtio_debug.c                 | 109 +++++++++++++++
 include/linux/virtio.h                        |  34 +++++
 tools/testing/selftests/Makefile              |   1 +
 .../selftests/drivers/net/virtio_net/Makefile |   5 +
 .../drivers/net/virtio_net/basic_features.sh  | 127 ++++++++++++++++++
 .../net/virtio_net/virtio_net_common.sh       |  99 ++++++++++++++
 tools/testing/selftests/net/forwarding/lib.sh |  88 ++++++++++--
 10 files changed, 472 insertions(+), 9 deletions(-)
 create mode 100644 drivers/virtio/virtio_debug.c
 create mode 100644 tools/testing/selftests/drivers/net/virtio_net/Makefile
 create mode 100755 tools/testing/selftests/drivers/net/virtio_net/basic_features.sh
 create mode 100644 tools/testing/selftests/drivers/net/virtio_net/virtio_net_common.sh

-- 
2.44.0

