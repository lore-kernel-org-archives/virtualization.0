Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FCA27FD7B
	for <virtualization@lists.linux.dev>; Tue, 15 Apr 2025 07:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744703108; cv=none; b=eI82t39Iqqmx6lX8y/Xw3hjZjms+noqGRIgt6EW/Of4+OCusB01Con33RjjvdOHPLsZtR4aztioBOe5QQc0T7xZP+8Kk7xoDyKdjgkTtMhEQ9hM+Ek58MAOp5m0y6MzTmA9iZzIvv0oAEJtExDgEc0fcucZW+nC6IwxcnivrzUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744703108; c=relaxed/simple;
	bh=1niKW98sQ32RMpVs4DRJjX8QJwWQRiEGm9x2KiIx0VM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LO/zQlleOpUwZw2ddDGjaDBSD33wb+nBS4UzPvWEgrvnZ+ni86eMOynmvKszwCyelQ1yJ4wf+oJbWg7Gt8x/7DeKtYlyEvw31bztpgSZoOPyoDKLKoUGZcT/QxHMR8w0hHO27Bec4SPtV6RQMPoV64v+uTeNy8OGaiCcrcZsXy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/48Xs0U; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/48Xs0U"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-30384072398so4670631a91.0
        for <virtualization@lists.linux.dev>; Tue, 15 Apr 2025 00:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744703105; x=1745307905; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=693uulZB/KQcPYpgvsd2vMghBxNx5O/cumoSUcuA5cA=;
        b=N/48Xs0UXG9ZUht2GAw0lrACe+KjQwGpUZBtXf+gJxB+MWB76AyvQXmmZ1UgVKeUPS
         1v30IPKNlI7porDm7QiC7lJ/ruklzBKX3L7Xl8SaOGb2IC2gIvOijlWRu+GEDpMbfF7H
         GQcJuvPqDM/pJJ/HeISSAE+0m6wwtgTi2tsWydPAlNKE3bbpk3uxWTiYXipSTHiOCgqs
         c1/yfkCFPXnOF2LiGULuuplkHAGUZYJ+pc5F7LgmlIym0DWdVDb6uWrSeSR2/MZXa9oa
         UgoyjIep+w8CByv8ysiPo8YUhZ38+sgqQxjRxG/I7HmxBduyePJm6skL1Y5wXi+wPzwU
         H8tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744703105; x=1745307905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=693uulZB/KQcPYpgvsd2vMghBxNx5O/cumoSUcuA5cA=;
        b=L+h7HjxRzteVjb2NHBfXWA4xR4ZkLVbqcKSPgf5XdJkdVCvox6NClxmPKigudpBIhI
         JH2lHhMBN+il44I7GM+IqTVMcj2nD8ti0mu0xFrUCqhWa/kZSx3oqzqVKAz4LDh5A3Mx
         N6SLcet+OUulW6pqRLrlrIVa7jeKd622MJU4IAHce0Jj5+xLxcFmIexKGtyvZpXEyQ9D
         KiyAjbujq2UPhVHCiF+2/LLDGyEd3rfVAwSOqNhJ+kB1QkGzZvGjgECc5UMAt9Vpfrl3
         WOMBrgv+p4gSl/Drl6xA7slhc7P+/i0+DwHmfP4TQJ8tjHt+X/vPHdrGYNczt6oMiXbA
         L3Zw==
X-Gm-Message-State: AOJu0YwAgUVrq/TtqYp3Zkf188xChKSeW6JSKdkGyWiGvLW/4r2qviB/
	HzTFD4ERfzdKstEaIThl1MheRnu7M2WYZW+wRghS666eVnqmHqsGOl8evZ1FXajZWQ==
X-Gm-Gg: ASbGnctSwjZ9jmbjzXZmuSm7gx2tPn1IJNwI4RvpxfHMR6Ob6qCY4+5T6df7Yq7+muf
	lUrg6Wyscll7sk7HtAE2iPQbuQO6ZYr4OxRJfNWKOBZDPMh3tWkbzg4jgGMXGtdzKdqHrZYoN5/
	fuI4K6fyCo+2DZZV0+VSd3PSqO+/xMcv/Qf4S81O7XiYEDqtcZNLzvL080MtyUB2xbWJZfte9Oa
	AQ2om2/eYIrQLI7HyfXFEX919cPva6b8ebRgWuqlyHuO73Do8Zy1vKQ29jBCK9wg1xBWJV2uVM3
	JssxPcTb+xK4vgPCy0RSy8/qb1sPpoxp+6JmO1CH/a7epORskBJ6mkP32FD5l8375lc=
X-Google-Smtp-Source: AGHT+IH+G17f4AOelzFwX1SUg4M9HSnGkdTV05DRb9VJ6OVH1IN3h5ijtvA9l3wacdqrXeHJfCrK0Q==
X-Received: by 2002:a17:90b:544c:b0:2fe:99cf:f566 with SMTP id 98e67ed59e1d1-3082377c5dbmr22710108a91.13.1744703105441;
        Tue, 15 Apr 2025 00:45:05 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:2e0b:88f9:a491:c18a])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-306df401ac8sm12299767a91.45.2025.04.15.00.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 00:45:05 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: virtualization@lists.linux.dev
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH v3 3/3] selftests: net: add a virtio_net deadlock selftest
Date: Tue, 15 Apr 2025 14:43:41 +0700
Message-ID: <20250415074341.12461-4-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415074341.12461-1-minhquangbui99@gmail.com>
References: <20250415074341.12461-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The selftest reproduces the deadlock scenario when binding/unbinding XDP
program, XDP socket, rx ring resize on virtio_net interface.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 tools/testing/selftests/Makefile              |  2 +-
 .../selftests/drivers/net/virtio_net/Makefile |  2 +
 .../selftests/drivers/net/virtio_net/config   |  1 +
 .../drivers/net/virtio_net/lib/py/__init__.py | 16 ++++++
 .../drivers/net/virtio_net/xsk_pool.py        | 52 +++++++++++++++++++
 5 files changed, 72 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/drivers/net/virtio_net/lib/py/__init__.py
 create mode 100755 tools/testing/selftests/drivers/net/virtio_net/xsk_pool.py

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index c77c8c8e3d9b..0a6b096f98b7 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -130,7 +130,7 @@ TARGETS_HOTPLUG = cpu-hotplug
 TARGETS_HOTPLUG += memory-hotplug
 
 # Networking tests want the net/lib target, include it automatically
-ifneq ($(filter net drivers/net drivers/net/hw,$(TARGETS)),)
+ifneq ($(filter net drivers/net drivers/net/hw drivers/net/virtio_net,$(TARGETS)),)
 ifeq ($(filter net/lib,$(TARGETS)),)
 	INSTALL_DEP_TARGETS := net/lib
 endif
diff --git a/tools/testing/selftests/drivers/net/virtio_net/Makefile b/tools/testing/selftests/drivers/net/virtio_net/Makefile
index 7ec7cd3ab2cc..82adda96ef15 100644
--- a/tools/testing/selftests/drivers/net/virtio_net/Makefile
+++ b/tools/testing/selftests/drivers/net/virtio_net/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+ OR MIT
 
 TEST_PROGS = basic_features.sh \
+        xsk_pool.py \
         #
 
 TEST_FILES = \
@@ -8,6 +9,7 @@ TEST_FILES = \
         #
 
 TEST_INCLUDES = \
+        $(wildcard lib/py/*.py ../lib/py/*.py) \
         ../../../net/forwarding/lib.sh \
         ../../../net/lib.sh \
         #
diff --git a/tools/testing/selftests/drivers/net/virtio_net/config b/tools/testing/selftests/drivers/net/virtio_net/config
index bcf7555eaffe..12e8caa22613 100644
--- a/tools/testing/selftests/drivers/net/virtio_net/config
+++ b/tools/testing/selftests/drivers/net/virtio_net/config
@@ -6,3 +6,4 @@ CONFIG_NET_L3_MASTER_DEV=y
 CONFIG_NET_VRF=m
 CONFIG_VIRTIO_DEBUG=y
 CONFIG_VIRTIO_NET=y
+CONFIG_XDP_SOCKETS=y
diff --git a/tools/testing/selftests/drivers/net/virtio_net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/virtio_net/lib/py/__init__.py
new file mode 100644
index 000000000000..b582885786f5
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/virtio_net/lib/py/__init__.py
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0
+
+import sys
+from pathlib import Path
+
+KSFT_DIR = (Path(__file__).parent / "../../../../..").resolve()
+
+try:
+    sys.path.append(KSFT_DIR.as_posix())
+    from net.lib.py import *
+    from drivers.net.lib.py import *
+except ModuleNotFoundError as e:
+    ksft_pr("Failed importing `net` library from kernel sources")
+    ksft_pr(str(e))
+    ktap_result(True, comment="SKIP")
+    sys.exit(4)
diff --git a/tools/testing/selftests/drivers/net/virtio_net/xsk_pool.py b/tools/testing/selftests/drivers/net/virtio_net/xsk_pool.py
new file mode 100755
index 000000000000..3f80afd97d4e
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/virtio_net/xsk_pool.py
@@ -0,0 +1,52 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+# This is intended to be run on a virtio-net guest interface.
+# The test binds the XDP socket to the interface without setting
+# the fill ring to trigger delayed refill_work. This helps to
+# make it easier to reproduce the deadlock when XDP program,
+# XDP socket bind/unbind, rx ring resize race with refill_work on
+# the buggy kernel.
+
+from lib.py import ksft_exit, ksft_run
+from lib.py import KsftSkipEx, KsftFailEx
+from lib.py import NetDrvEnv
+from lib.py import bkg, ip, cmd, ethtool
+import re
+
+def _get_rx_ring_entries(cfg):
+    output = ethtool(f"-g {cfg.ifname}").stdout
+    values = re.findall(r'RX:\s+(\d+)', output)
+    return int(values[1])
+
+def setup_xsk(cfg, xdp_queue_id = 0) -> bkg:
+    # Probe for support
+    xdp = cmd(f'{cfg.net_lib_dir / "xdp_helper"} - -', fail=False)
+    if xdp.ret == 255:
+        raise KsftSkipEx('AF_XDP unsupported')
+    elif xdp.ret > 0:
+        raise KsftFailEx('unable to create AF_XDP socket')
+
+    return bkg(f'{cfg.net_lib_dir / "xdp_helper"} {cfg.ifindex} {xdp_queue_id}',
+               ksft_wait=3)
+
+def check_xdp_bind(cfg):
+    ip(f"link set dev %s xdp obj %s sec xdp" %
+       (cfg.ifname, cfg.net_lib_dir / "xdp_dummy.bpf.o"))
+    ip(f"link set dev %s xdp off" % cfg.ifname)
+
+def check_rx_resize(cfg, queue_size = 128):
+    rx_ring = _get_rx_ring_entries(cfg)
+    ethtool(f"-G %s rx %d" % (cfg.ifname, queue_size))
+    ethtool(f"-G %s rx %d" % (cfg.ifname, rx_ring))
+
+def main():
+    with NetDrvEnv(__file__, nsim_test=False) as cfg:
+        xsk_bkg = setup_xsk(cfg)
+
+        ksft_run([check_xdp_bind, check_rx_resize],
+                 args=(cfg, ))
+    ksft_exit()
+
+if __name__ == "__main__":
+    main()
-- 
2.43.0

