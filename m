Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF8B221FB6
	for <virtualization@lists.linux.dev>; Thu, 24 Apr 2025 10:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745491810; cv=none; b=N8asIx0aZ5m1F8UqWvo+vWT8XvjrTCsjnibGiJv8LCyLXAw4hTSI7kVmBMJZdMmMvLuhwliTTxKmBgckRo0PlNJfCQ3OcZsUaCk/r9YS8BCOfIsAi4AqnX9BHazR5QOx0YEtiSZqVdheWjCTgZtCwo/fpfKOsI8mWFJD9TI1ysc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745491810; c=relaxed/simple;
	bh=MnqykwymzwHERo6nKnawUDD2AsCMTGXbvqod8pxseEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=etX/kJhWzJNe5AEMc1ZMRl+TuV9zsHUbtb8oaIOdftOd/cYc5ASkK+xMaUls37vrbeKbT9uvD1BHcKbgRz2XyCFupcihhN1GjDsZllqcj3wrwEx+KbzGO3XoDov1olUY8XPRR0w547qWXR2vZKjewdmAQTLFOvA16pRv5I6lw/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5bm6cmR; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5bm6cmR"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-736aa9d0f2aso1065845b3a.0
        for <virtualization@lists.linux.dev>; Thu, 24 Apr 2025 03:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745491807; x=1746096607; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=otKFGdVb+uXNzYPZbaE8wgcboqR2b2qzgL6mIMQa4V8=;
        b=L5bm6cmRRhcTJ2wx2apPx3I9uzE7kc5mCv4uoDpBGEaKsTy1Z3CSkSu2w9CJpQQOpk
         WRQspTeeHNe6euY//tkePxRkxv7Zw/eSIm+7z9rj46YNmdC2WqL9/FsQDxuJGJsIlHSx
         cTO/aoqtmC7HCtY+yaWqqw/rsnbOamWW3EkU+b94YUMwfB3IceHDOwgEeRWvfEiqe6Td
         snxqFVcikV7f4bnTHzOVX+659fdp54hrsdbJQ/9/GA9muhfbXFtgks5i6oUH9LFS9Xrr
         k6jZViniT35bmqIg+A3+4653sI8iv22JZP1yld9vVrtM4kOfbPbheoCXKEY2OWzLXvnH
         sTYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745491807; x=1746096607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=otKFGdVb+uXNzYPZbaE8wgcboqR2b2qzgL6mIMQa4V8=;
        b=ZNXYNAf37jTVWTYsszLa5GGRE8NLVFBUdHdhlOpCetjjNzQNCgEGPzZ8UeVxo1cV18
         /1dU148U+ynIeuUHAzDsaeNrbZGU/uSh5xJuIObV2+b62iqbGA25oAqFjN1IwUkoG6jl
         RF5FUW2hLgfuknQBV3F8/hxxgkN+yHFiIMlaMOmdQB99frYCSOTjVOHiqKp9O6geA8xD
         TQvK+tC9VFoIj9AoUNgw0uskDSWAEnmCxYzDs/4A3c2dA5jRGmdIS7oii0blO2jbrCIL
         jNFQfQegcT8c3tg6jezeiPAmo7LTStCDWpaQ37TCfnY5rr4hgdW3FG1frCMmF2ayNKwx
         8/hQ==
X-Gm-Message-State: AOJu0YyFIdrc+r3APwf2nHWo0plKiukfeS/4SmKrWYE5IPq4IQpLNphD
	iASSBB1Wvbo6kb+sEhC2teCdLRYtniGIP7SqWTXtfo9+A55cn//ozKox8ssPdgU=
X-Gm-Gg: ASbGnctj5vdYhDItHxizkTHNBca/pIrleAbLuYoZ3FEla5C3RjkS7ZjyRnfvYWfR/nb
	oQzei+NbVy7wNJkDpUwpjIJ8h5Dp+qTTdisFSkWr72XdReCaCNwpM6+lqd4Bepk0DR6P+V/m3Gn
	lnsfjLKWXtUFWqQK0Y7ZD9rbQmMZtwQ0GDOe+2XLnnBvbpxQdte8kKLuiCjmq3aSbRfTKIsiJUz
	ugmbGamuefEXkSMgGDrYW6ivNkx9tuCSkbTag7FWyxw1f0HntoFCMtlI6hdMBPgeM3NRMNpT9wg
	CrlRLjkeWdxDVsKVIFjA/oCNoSbKGdofZUlEnoC4puyqwuCMQC43QyyX
X-Google-Smtp-Source: AGHT+IGgeHDm6WkVamJnp/W1II7ZDrehvPmtPJEYMjp/1PGWmVR9+feWN1Ivt1NcPJM+kVc7pr6mIQ==
X-Received: by 2002:a05:6a00:2410:b0:73e:1e21:b653 with SMTP id d2e1a72fcca58-73e243c6011mr2778211b3a.5.1745491807205;
        Thu, 24 Apr 2025 03:50:07 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:f632:6238:46f4:702e])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73e25941bbbsm1120138b3a.65.2025.04.24.03.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 03:50:06 -0700 (PDT)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
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
	"David S. Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH v5 3/3] selftests: net: add a virtio_net deadlock selftest
Date: Thu, 24 Apr 2025 17:47:16 +0700
Message-ID: <20250424104716.40453-4-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424104716.40453-1-minhquangbui99@gmail.com>
References: <20250424104716.40453-1-minhquangbui99@gmail.com>
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
 .../testing/selftests/drivers/net/hw/Makefile |  1 +
 .../selftests/drivers/net/hw/xsk_reconfig.py  | 68 +++++++++++++++++++
 2 files changed, 69 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/hw/xsk_reconfig.py

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 07cddb19ba35..5447785c286e 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -21,6 +21,7 @@ TEST_PROGS = \
 	rss_ctx.py \
 	rss_input_xfrm.py \
 	tso.py \
+	xsk_reconfig.py \
 	#
 
 TEST_FILES := \
diff --git a/tools/testing/selftests/drivers/net/hw/xsk_reconfig.py b/tools/testing/selftests/drivers/net/hw/xsk_reconfig.py
new file mode 100755
index 000000000000..031de97a974d
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/xsk_reconfig.py
@@ -0,0 +1,68 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+# This is intended to be run on a virtio-net guest interface.
+# The test binds the XDP socket to the interface without setting
+# the fill ring to trigger delayed refill_work. This helps to
+# make it easier to reproduce the deadlock when XDP program,
+# XDP socket bind/unbind, rx ring resize race with refill_work on
+# the buggy kernel.
+#
+# The Qemu command to setup virtio-net
+# -netdev tap,id=hostnet1,vhost=on,script=no,downscript=no
+# -device virtio-net-pci,netdev=hostnet1,iommu_platform=on,disable-legacy=on
+
+from lib.py import ksft_exit, ksft_run
+from lib.py import KsftSkipEx, KsftFailEx
+from lib.py import NetDrvEnv
+from lib.py import bkg, ip, cmd, ethtool
+import time
+
+def _get_rx_ring_entries(cfg):
+    output = ethtool(f"-g {cfg.ifname}", json=True)
+    return output[0]["rx"]
+
+def setup_xsk(cfg, xdp_queue_id = 0) -> bkg:
+    # Probe for support
+    xdp = cmd(f'{cfg.net_lib_dir / "xdp_helper"} - -', fail=False)
+    if xdp.ret == 255:
+        raise KsftSkipEx('AF_XDP unsupported')
+    elif xdp.ret > 0:
+        raise KsftFailEx('unable to create AF_XDP socket')
+
+    # Retry xsk setup 3 times
+    i = 0
+    while True:
+        try:
+            return bkg(f'{cfg.net_lib_dir / "xdp_helper"} {cfg.ifindex} ' \
+                       '{xdp_queue_id} -z', ksft_wait=3)
+        except:
+            if i == 3:
+                raise KsftSkipEx('Failed to bind XDP socket in zerocopy.\n' \
+                                 'Please consider adding iommu_platform=on ' \
+                                 'when setting up virtio-net-pci')
+            else:
+                i += 1
+                time.sleep(1)
+                continue
+
+def check_xdp_bind(cfg):
+    with setup_xsk(cfg):
+        ip(f"link set dev %s xdp obj %s sec xdp" %
+           (cfg.ifname, cfg.net_lib_dir / "xdp_dummy.bpf.o"))
+        ip(f"link set dev %s xdp off" % cfg.ifname)
+
+def check_rx_resize(cfg):
+    with setup_xsk(cfg):
+        rx_ring = _get_rx_ring_entries(cfg)
+        ethtool(f"-G %s rx %d" % (cfg.ifname, rx_ring // 2))
+        ethtool(f"-G %s rx %d" % (cfg.ifname, rx_ring))
+
+def main():
+    with NetDrvEnv(__file__, nsim_test=False) as cfg:
+        ksft_run([check_xdp_bind, check_rx_resize],
+                 args=(cfg, ))
+    ksft_exit()
+
+if __name__ == "__main__":
+    main()
-- 
2.43.0

