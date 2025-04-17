Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BE921D59A
	for <virtualization@lists.linux.dev>; Thu, 17 Apr 2025 07:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744874987; cv=none; b=RStikzXqTXd4Ryd/lbfzKADaiKQVBQtM0CFztMRrKzKEw6SHYxOqil+nyLJsFJhshy9L0gr1j3AIUrnGUjmq9Sne5pMkrx2MUY50f2li/PgU+R0wxe/pScxJI+vhHdPY+2nX55gsct2+z6hrp+tiV7b5qPE73EaeDk3yrg123kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744874987; c=relaxed/simple;
	bh=8TizWOwqu3GwN2fiGsHw8X4OMKIAXAGE1CXOpps+ka0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ChuNJDfzpClNWWNfPBUe5uafR4+7OANx14bDgAtM5o1pRVXdJgNqpcoXY1hNzvA5t/sV96W+Pqcao719zAnKGc3BAA++Kn1thZMvRYoltiRY3QWbid2wmk+ra/FqaOXBWfNvBJ8bDDTOP4956MThkQlUBMeaFwlLDTWDtFN7Upw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKg1ysqP; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKg1ysqP"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7396f13b750so453791b3a.1
        for <virtualization@lists.linux.dev>; Thu, 17 Apr 2025 00:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744874984; x=1745479784; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJO7LyGExRfq4nKL5SVSlHdNbKD8n5gs12N9jLBapQU=;
        b=CKg1ysqPPaqI4C353XyrYynbt+F83OZyPfDf1yP1qljkOBqeOZjSpaeYG8mD1idpEm
         hX2pFteZzqIRGUCz/ezujtAoBw4dOwVtsFfJj9UN0vLkdxcsVOijh9L0P7Wc9dtA4mlK
         wBC5AkuftaOSfnhae+6dg/lJNmJfSS6Pk6ImaquaJILEzfV1cPOHABJNmRntY4F/0Cbl
         jv3I5BwmILL8oJrI7wF7DXZjNRgNlKCZqqhwxS4nnt5ipFNqjZO/caNrOOiJ6hUJzHV/
         N3O7L+a1D4x66X3PC3cWusgdx4UYZP5RP/tpuitXqqNDP5CDUDqBS86zN4LjCllWOpX2
         944w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744874984; x=1745479784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lJO7LyGExRfq4nKL5SVSlHdNbKD8n5gs12N9jLBapQU=;
        b=v2M4M4STo+Z4EG19hyeiqkxojJhqXz5BCH1Wq9a7YOLRed52qGlMjgI7l/8Oj3zgez
         dhhpjXMbUUgIz6mgGg6SZI/yPhzW4FAfe1zoqKKAUsi/vRfsZLCw9y3L9ZfbXdTpAylT
         i961A6kkiKHv7zZ8M+DJ0uW1c4ucQlZWQ+rfXXMBzIPPu2J+bNSwJXzlr+XGlui+WTAv
         wyH1g+FlFAKTl0PO7gxCuJq2PPtHboEaVty2xhiJWs0K0a8plH1lidBniYcKSjEC2zx/
         /6zH8YM91XKDLdV7vWpcGvUQtmMAWo5FC6XY7ecJEtEVkB2QGkni7JXLrH7YsLisEBCf
         QvUA==
X-Gm-Message-State: AOJu0YzLWFrd4mN0ZMYRysRoa4X6nweP7P+8tfN1HttLtkZg15FvRZfh
	uiCZRVrY7NpvWgVS231DTr3dj7WftA7otA3IpkAsmQQBMH1ulLCp9kVqfnEe
X-Gm-Gg: ASbGnctYLK9hf5s2fx8lODCcCwU9/88ITVudw/WUZ/W4MfGkQdnrOJ47ECUNV9rLy+U
	MXDdou8Lw1hudgS9ExdZeb4hcC26uocxk+J5S8WAxRNs4pLtca436mH0gbYNnly+Zjd1PseCxlk
	C/QGZRqOKeX9BCvPeXHpN2mGSrS0DsULDs5CfAKigtc8LaekpWDfU91JTRmrLkdAhCah9WRovRY
	LXILCBZNgK87FdXLjY9NqIrGXLdmYRRZTxJr/XZ1CqxF5OmDuLes6x9gcUv54zWjvYTc98hVrPc
	e6C+ttKLoBmBh1/Qvkjvz8iVUGV8aPc5u3ZV/hR4vwrV9NexAeAobdLe
X-Google-Smtp-Source: AGHT+IGNH4XYkq81bCriDB/5ZWI5rMHEk/ZZFNYuEACnhmopqi5kSRd+SZ67knR5813pGgdy8GwUJQ==
X-Received: by 2002:a05:6a00:2985:b0:736:bfc4:ef2c with SMTP id d2e1a72fcca58-73c264bf96amr7064882b3a.0.1744874984214;
        Thu, 17 Apr 2025 00:29:44 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:ab45:ee9c:5719:f829])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73bd22f0f3fsm11625344b3a.115.2025.04.17.00.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 00:29:43 -0700 (PDT)
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
Subject: [PATCH v4 4/4] selftests: net: add a virtio_net deadlock selftest
Date: Thu, 17 Apr 2025 14:28:06 +0700
Message-ID: <20250417072806.18660-5-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417072806.18660-1-minhquangbui99@gmail.com>
References: <20250417072806.18660-1-minhquangbui99@gmail.com>
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
 .../selftests/drivers/net/hw/virtio_net.py    | 65 +++++++++++++++++++
 2 files changed, 66 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/hw/virtio_net.py

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 07cddb19ba35..b5af7c1412bf 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -21,6 +21,7 @@ TEST_PROGS = \
 	rss_ctx.py \
 	rss_input_xfrm.py \
 	tso.py \
+	virtio_net.py \
 	#
 
 TEST_FILES := \
diff --git a/tools/testing/selftests/drivers/net/hw/virtio_net.py b/tools/testing/selftests/drivers/net/hw/virtio_net.py
new file mode 100755
index 000000000000..7cad7ab98635
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/virtio_net.py
@@ -0,0 +1,65 @@
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
+    try:
+        xsk_bkg = bkg(f'{cfg.net_lib_dir / "xdp_helper"} {cfg.ifindex} ' \
+                      '{xdp_queue_id} -z', ksft_wait=3)
+        return xsk_bkg
+    except:
+        raise KsftSkipEx('Failed to bind XDP socket in zerocopy. ' \
+                         'Please consider adding iommu_platform=on ' \
+                         'when setting up virtio-net-pci')
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
+        try:
+            xsk_bkg = setup_xsk(cfg)
+        except KsftSkipEx as e:
+            print(f"WARN: xsk pool is not set up, err: {e}")
+
+        ksft_run([check_xdp_bind, check_rx_resize],
+                 args=(cfg, ))
+    ksft_exit()
+
+if __name__ == "__main__":
+    main()
-- 
2.43.0

