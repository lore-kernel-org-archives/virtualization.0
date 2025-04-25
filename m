Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35572235368
	for <virtualization@lists.linux.dev>; Fri, 25 Apr 2025 07:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745565131; cv=none; b=G/iIlupAS7wg+Tmlf298+Zs+ZJpvhEEUBdQGShx+wn70LqVNB5YVSdP2z05D7iJe09esISWVb0v8wkW9oFM9rHYuwdz5Oc5fnlDk0SZFWFo5fZtFP7OWI1tDJQDAQuOMDw51m2jRypy7eDbf7iENh1e3hqnPKw2eRwGrvJDGiJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745565131; c=relaxed/simple;
	bh=2QfJQ7dcrhKuX+Tq551J8RtKTlD3rjHY/Eo0FkW4GEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RA8JZsrkUnCWJXs9FBXcTD2LZ7sPZRZP/RkHGchkI4iUzAbcPQfXX5eDqdy2pOSCnr+hhyN0DuSjcmdDY0ngb3El03flLDYyMAF5xra6luqqfTbl/aGSHlhq6KH6Q4MaaLNgL3+hQCT0kT2fWrteAbHmBDUS8ER+Ie/nBFeoM2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IHO4BpwU; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHO4BpwU"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22d95f0dda4so29221435ad.2
        for <virtualization@lists.linux.dev>; Fri, 25 Apr 2025 00:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745565129; x=1746169929; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5KTzXr+eJ6VOU6pnmjI7NKvMZ52qKy79/3M/WgxOiNU=;
        b=IHO4BpwUcU1OhhVrh3eDyegB641Jijl0AufpE5oM75qwBy1h18AdzHWKoXa909zgIx
         xxJvVLL6s+XDqMcfAxqgyGq0dQCDehbKYDTaq5I1iUKMi5HE/NCHt3SfQNVIZss71CrO
         akgEEAWVJ8L0C4QBGdjU7QhV5150zVknHbBYQGc7w+4mw4w/6xG06Mn3YWKx9HuAV7Jq
         wzdOqkyHTtUEz4ss2Budl+74IfKtoaqHG8+1JyIBB5qYtHIWAZmomFM8Xz21D8nxwfOJ
         d0/KrPq3I3u2NRwDzNznju0qUL+t6+STAyUAec8wWU+j02aAc6V33wUZKZBLgoxoWIxl
         nSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745565129; x=1746169929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5KTzXr+eJ6VOU6pnmjI7NKvMZ52qKy79/3M/WgxOiNU=;
        b=FSk+r0kUhZlBHN15RzoR2mb7Ve7rhYSPDXN3KX7y6Ii3jXlOeoEFHeoFrl+aWZg+Fl
         F8TVFtq3ClyksAjA5gOj8+Qcw5UwMfyjSF+F9wUwhr2c8gDDWcLNJUGSXj/3Tj0HGp16
         5VYWKH6upyHlVNqJrfxgK1ra6uv/7kGq1ovOYbbjfs/EN6YNMALFLbvz0rYYQiZYRHBL
         l77uEDhRwriCx/f878KfHfhTqjAluxSEH15UnZ5rN79up7XeFTcJN8WRcs6OZwelLn8b
         og/lo+L10HBvmkn02QUoO4sd7uLhshPyncp8vqQYnceIvv3+rGgNT3k5YUulMBFwliNL
         Fc3g==
X-Gm-Message-State: AOJu0YwzxhzSPABdGhkhkr6xt37UW7zkVdZw7SH9wrF06U0uOvFebwA8
	yBoG+Gmad6NUo8jSx1k5Xxq8Tkkf8+iHJl6wfTnxO92Zob9j7adoPJ5RApoO
X-Gm-Gg: ASbGncuvMUt+p5WarZxZJP/tcv1wSFNjrlGzqWBwQc/7ddtLJG2HpHgs0IikClCg8+3
	zyFCor2TQTOHMTvX1R5Na2U3OV2Sxdd5ql5dQ+WplaHtqPx267Krj+hz3NiAIsWqUrz9HcGZW48
	BSKKQ/R8jzMmncVS6IgFilfbHzlXAX3EjB/g1ZPYRCe7uuSpdkQcCKSkDjkjRo8PIvwMOPxi+EC
	S0g4cBkPqbDMm3HQr2gJaPpPruFz8y98ZE86H/c+xVMm5EuJLg5Bv5EzL7tuE5EcgVQB5d70PSn
	3zonvT0FSwK2b7fCZ9D5eecDspR3yPRoAp3RQBUp8q+Dt+JXvICbD2wk
X-Google-Smtp-Source: AGHT+IHbdQaaI+TlUD8wQDF+D7xEsxbXV0AtWO6xb3b+HZ9IeIZ1AgtMWePNiAGk/CXJX9Q3ks1G9w==
X-Received: by 2002:a17:903:94c:b0:223:5ca8:5ecb with SMTP id d9443c01a7336-22dbf62335emr20904505ad.42.1745565129029;
        Fri, 25 Apr 2025 00:12:09 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:1c5b:42af:3362:3840])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-22db51028basm25322425ad.196.2025.04.25.00.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 00:12:08 -0700 (PDT)
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
Subject: [PATCH v6 4/4] selftests: net: add a virtio_net deadlock selftest
Date: Fri, 25 Apr 2025 14:10:18 +0700
Message-ID: <20250425071018.36078-5-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425071018.36078-1-minhquangbui99@gmail.com>
References: <20250425071018.36078-1-minhquangbui99@gmail.com>
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
 .../selftests/drivers/net/hw/xsk_reconfig.py  | 60 +++++++++++++++++++
 2 files changed, 61 insertions(+)
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
index 000000000000..d19d1d518208
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/xsk_reconfig.py
@@ -0,0 +1,60 @@
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
+    try:
+        return bkg(f'{cfg.net_lib_dir / "xdp_helper"} {cfg.ifindex} ' \
+                   '{xdp_queue_id} -z', ksft_wait=3)
+    except:
+        raise KsftSkipEx('Failed to bind XDP socket in zerocopy.\n' \
+                         'Please consider adding iommu_platform=on ' \
+                         'when setting up virtio-net-pci')
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

