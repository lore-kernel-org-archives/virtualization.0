Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0656014EC61
	for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 15:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713799987; cv=none; b=hTrIEonNB9EHPjXZxoh9TxH0XgtByS0ao+JP+4Mh8+9MdXOqLMY+CfaInAF4DHAJYSir4iSBTbarywd5JGiwrumteGk13FcVeyoHOX2d/Tee/mKNlmrjg8BJILQnjTCa/wRJZMg7FB775PL1ZOMeyEqL6j/JqZ8IujE7Qfl2cXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713799987; c=relaxed/simple;
	bh=hW+W689dh9JE5voXEY8ToPup//dAuTdiWRhkDU4nfJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AwMeFCy1W8uq5fsFsYW7KIeQvY8lbdNtm2xGlMz6jUFiCbWaLHh6BlzS9kxBRwvgwM55AHbBsyiUSKKXWg1bd5XxiZR9qNlldK4ef5kMfxx2kRlIgaCCIxeyY71vo27wHPEkmTD39Q+mZ0DWUplcaWz7SwNTh3SKxtijpnAbsBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=AKV7uz6L; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="AKV7uz6L"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56e6affdd21so1566812a12.3
        for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 08:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713799983; x=1714404783; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rloKmfRlculxg94lh4R/4hDpw/PEqkBcoTnGmG9n9MU=;
        b=AKV7uz6LzD+JGb/l/Qu9i+tT3z+YJWsryY3J0keoZxmQd/8d4d2nmdlmHrsQAeJvue
         OP6Gj+NSqSd6il39yYT+Z2+EOhHPuD7mOVS3E2mxENcGzTC2viNaSrfX5wqpSoS44YAy
         OSwt8f0GCqGfn1fryfChe11qDG9tl6HQA8FZgku+lq10h77I+bd+SRcTpPlmDghh9yg5
         cPMdL5LIq/oTUIheqA3rwRQu2XXYtKLutIdUgicXr0oxNlJ1a3ecDrFbVwUcYUiAbxvo
         kQB4PBcam7R9p8LEW0VeBnZLGLOkZ9AEW/r/HNow+v+durkrF9EHeA+XR/mDFXJl51UR
         brXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713799983; x=1714404783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rloKmfRlculxg94lh4R/4hDpw/PEqkBcoTnGmG9n9MU=;
        b=u/y9oMKiSH/VerwOPwYnsCv+lqhwGZ7O5Kldmq2aZFiyokjWh7Zq2zpYVZvDGQs3N0
         kgd4tezo+0x2nZqW0bUby2RIb+njL/n3PA0x+l8BgrdQRG7hGkA2+LXcdcoRXDx3Ian6
         5VGeHvthQFVbyO11F2SXppSkmGmIsxZzkOTgrwMPGmoBOUcSnjVN8QgvL3Qk3PfHDWyL
         JeCQToV7aFW48WoC854fKtf08QrhlxamKVwkud8sz90eZ4b2GClZtbDzbS0Gb1IcoTgj
         IJXXS97EBHmjqdAMDHzHlyYuEnIy8oreasDuudAc2BBBQULpp5Ku4f+F0vJW/DWB7VQB
         bVsg==
X-Forwarded-Encrypted: i=1; AJvYcCV+4rkKzEdIAapB9CYOpkU3hldDz8Ejyy8Xt4I3Z+gI39arEMqnGcxLNHLksuGRljaOhtI9Owdl0++42hxKCM2nlwG8C2OO6gRflFqkPzA=
X-Gm-Message-State: AOJu0Yxv4w61kLaZaoJpY5jKPu2HsdFoWY6I+HQGZo/ZkQi7Hj2Q05r9
	VTLYZ+XifIpdrRnISVKi1CHcoSk1OvjRkjWAGHiHQCSf/65MEeI2Gng1RdI3H7s=
X-Google-Smtp-Source: AGHT+IH8GyDecZCk67hhKZaktEnqyCfF683/PQ1IicFL5A5Ip+4/EKy4WP82V94JT+QidmRTRRx1QQ==
X-Received: by 2002:a50:cd1d:0:b0:56e:d54:6d63 with SMTP id z29-20020a50cd1d000000b0056e0d546d63mr8456777edi.15.1713799983045;
        Mon, 22 Apr 2024 08:33:03 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id l10-20020a056402124a00b00571bec923bcsm5372298edw.93.2024.04.22.08.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 08:33:02 -0700 (PDT)
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
Subject: [patch net-next v5 0/5] selftests: virtio_net: introduce initial testing infrastructure
Date: Mon, 22 Apr 2024 17:32:55 +0200
Message-ID: <20240418160830.3751846-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Date: Thu, 18 Apr 2024 18:08:24 +0200
Content-Transfer-Encoding: 8bit
Message-ID: <20240422153255.4PTTy3NGkYn1VYOrhAUIvAepo0lRgp5exILydp-3CFQ@z>

From: Jiri Pirko <jiri@nvidia.com>

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

