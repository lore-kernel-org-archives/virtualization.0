Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB3D1862
	for <virtualization@lists.linux.dev>; Mon, 14 Apr 2025 05:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744607392; cv=none; b=o1CV+V+C2W2p4DhqIjndLCeXpDquoD8GMtVTfT9DVx0EjiFxXcymMhrnnI35s9E96uHWakZ0O0Dx/zpewabGnKplDeMNUUePbxv7UsT6lUaIWaxUDZkxocDLgl+uIHRfvSgh4TDoEPyD/7QD8QSh21twn4CV5Mhk7XgeFjcfbk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744607392; c=relaxed/simple;
	bh=1niKW98sQ32RMpVs4DRJjX8QJwWQRiEGm9x2KiIx0VM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jZlLKjJqeGf22bwkQ/ubipesXvmiAMTknx86/gkw02a/be04Rm5fdZgAAyHkWFX4pZ1s4/2GNWjRO2Ip3ZmUvSt3zJv93BD+02CQuJaPFEziU6AXHrSekyVwzMVponkp2RDo6k9v21FEOty1zu6B7P7TIO7VOAEE6EhX9cTp/cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ip+1vRZE; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ip+1vRZE"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2241053582dso52160985ad.1
        for <virtualization@lists.linux.dev>; Sun, 13 Apr 2025 22:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744607390; x=1745212190; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=693uulZB/KQcPYpgvsd2vMghBxNx5O/cumoSUcuA5cA=;
        b=Ip+1vRZE4IuyjJ9XOUuR52TP5dr2jy3r567ZnjD9M2+OkRl8KtAbEe1TiDxgfg5Non
         rIpQ1ZKeaNdJQYmJSU3lyb/5P3OaZDzprdxeAwhVT4VizERMKeQ5Q3BBY9mdjXqSPRdD
         Kq8MAopGnwu3l6U4VmFenUZu43rCBJAlyOCFQpzC/1Rb1P2jyFNgzoPJixyjp4NBnJVQ
         q1aYC4Vi3tcvlpr4Wx0Zw7LYW67XpCbE4AAegyOODrKb0pjcOFXlXQ/mnt3TXU/imrDz
         8aVqyCWo9fBhTIRZC1+2+aPUqtl13qDPZMnNjUr4DKizo9WO0888uA3XaFhn1EwgJN8Q
         B4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744607390; x=1745212190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=693uulZB/KQcPYpgvsd2vMghBxNx5O/cumoSUcuA5cA=;
        b=KzHskN7UlGX0E8sac1gT3lzQOMFUxXNkjFr7FFrBxCE2sBsfhTF2Oss5sBhuE5mcs0
         XsyUJ9RO889SXKZiO9B/ZMTjAYcZpG8qH6zWRJb99WBLmMokGkQZn3CHkiqd7RQxYwv8
         CfwwGQBNgXX6tfoPdUy1xo8eoZmBaDxOJUgDy2hcSexW3WWE2KV3SxvpT1iXSx+U+ANq
         BziySGKlwEdmc3bNPlJ8AFLJDjORqlGQdDVDr5ZtRLFnY3/hKXIk4LveUAmnWq0+DK+N
         btYyttDbB2geFxbzZD5t24esqZ9PpT/mftcPnCkq9Nm9tdiQDNPD3ZrnpxJa6yQ1B0zJ
         jwLg==
X-Gm-Message-State: AOJu0Yy/tT4sz/TnIysMPWMhKx/4RTBa3fJN6Ti89BbylITSsGPbtLnh
	pAphze40mv9Gkef8b6Ni6jW0PJfXde+ZMNJNI4fOybCJDorcXRUQN6J2+p5F7PQ=
X-Gm-Gg: ASbGnct/e6dFUdAZA9jk0yOgXLZPABwLI3t0ZTH1vyPUxP0uhEJAudfPkQ3lQm62/NB
	9egLHGXr+5RPcxlzevfZMg3OGWtVvXBvOj6fIAGIZNDw2gvFoto2fHZGkQiUI0bivCFeAKdpyfB
	TE0c1M8Ageh1irT/jHPA9deHVZSU2wFku/t5b8ENyrVmU74XEDAH/imZLtTXTdZxxbnYjCpOTIJ
	oQQqiyG5yFQfwCfum9bm4wZKqmrruGNFRtL9wPwov2AMMmIWmpoiBgMjic05N5j8MYUiOi6s5jm
	B03h0k4U8qRr+RSBnVI4tFTelfny27d4HjY/FzuwpKvxWnQCQZZjdsLjlWCHCGfx0Q==
X-Google-Smtp-Source: AGHT+IFZXGJl9vCA/38nvO5q4mKzdH+dsnkuUuXFqvhgmC9J/jIRkCxTQToRLnncH8s2H/loWvS+7Q==
X-Received: by 2002:a17:903:fae:b0:223:37ec:63d5 with SMTP id d9443c01a7336-22bea4c6beemr181805855ad.28.1744607389401;
        Sun, 13 Apr 2025 22:09:49 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:b80:9edb:557f:f8a7])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-22ac7cb5047sm90778665ad.170.2025.04.13.22.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 22:09:49 -0700 (PDT)
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
Subject: [PATCH v2 3/3] selftests: net: add a virtio_net deadlock selftest
Date: Mon, 14 Apr 2025 12:08:37 +0700
Message-ID: <20250414050837.31213-4-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250414050837.31213-1-minhquangbui99@gmail.com>
References: <20250414050837.31213-1-minhquangbui99@gmail.com>
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

