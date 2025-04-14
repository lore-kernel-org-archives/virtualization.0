Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7EE13E02A
	for <virtualization@lists.linux.dev>; Mon, 14 Apr 2025 05:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744607385; cv=none; b=sArLHJ/vQq9ZA80hiciyHdlocxlUYZgEgDi90/yk8Lu0urQbjDumD1jrdbTWTb/IOHnKq9Ln5D8KwgI/3H73GBnk86uie/RwwTb6TlwYGIAJXlx/WGvlHyvDOpcNeIeM3RNSch8kmI77HQ5IQpkAdMqb0O6ntTLE7pSHYxMZExg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744607385; c=relaxed/simple;
	bh=fm0FD+nFpM4KIujT0zC25XQeJrJxwhYW3rijMoqQ0r0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NSB3sEzndcJzLgLgVTHTS44f/Nzjv4ep/oAE3r3HVtufUTjhanjkjiQ4cgj54gomPN4peqC241iD/qVDpTKnSmD16c/gnzDDzi9wwpJMVZ+nNv/utRNIcQ2DHYXOc6EAvtK64L79i2nN0lbsCnvb25365uQTdxF6U4LnZtJAjTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdtSB/gy; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdtSB/gy"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2241053582dso52159965ad.1
        for <virtualization@lists.linux.dev>; Sun, 13 Apr 2025 22:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744607382; x=1745212182; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CcTGqksFhMMv7htGFoe+A1pXwVfny33zxtLopOer7xA=;
        b=bdtSB/gyxa/x7n3A9pll4rF8pHmIgWt7eyCuAjziQ4/SXFEI98OyF6xBZi5nmHp54d
         aHOerv5PmtPHYjiFdiNzdM3Kp35mO4wdDpuIikLyycl/Hl6WMExra1rqad7+bKUn+cta
         sxPAZpUysPpnWsrQ/pSesDAw936izmsk5i9//e1RDjiBmXjPpeORHmgWJ0j4I6tOJEOi
         cL3ZZoam8/0lC6yq3K57AfqlK+nuct28t1Bl1ljSWtJsVEHB2e0uWgr/t3A3s46/MfTm
         ZRSQOEWYJZzEhQQ7/XuuM+mLSY/43xN9aoUsCDSNibLzBiNGfeRQlCXbZrm320z1HeyU
         UL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744607382; x=1745212182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CcTGqksFhMMv7htGFoe+A1pXwVfny33zxtLopOer7xA=;
        b=I4n3CDZYBxIBiBpBgMXHxQQvMq9A8K7kP+dYEbYpneleocdX/lZrSbjpmoekJWYwK4
         kQmbGL9JFlNprsH/PyTkgDlahwsnNwdTAG1nXRUWsQv8Wx/DpYsBAU0uJswGs42VrZc1
         YN/KezVmxpmsZBKyvDjkhXul1UhjOj2xNHzNStdZTJYUat+8XfiH+F4drqlklYrZD3k9
         WeeL4qfdPOW2VIp2vO7ZSVDs3dWQCLKn0BoGGnpUvZdX+fpKPawB98hlIo3l2lPojc3h
         8hb3fuHi8Xvw12xs2iswe5cnE0Jv2inne19Qla2gIMOoMPBEE/3tZ+6Kd+qhdvqb4lwe
         EG9Q==
X-Gm-Message-State: AOJu0YyLGKbb8ydL2kfKkOfMko4Va4rrCf5h6JtYH6M13rr2KVcHPQEH
	KRbjGgff8fMxHuaHVuAhzG/E8y9J8XrHCEJwD0e+ssBG+WZP+9pcbAkPoCNSksI=
X-Gm-Gg: ASbGncv/Wo8JCTilOOiX6bUiFsw7Tt6qrzp9XcxkX1MPmi0uZSlufmdibQEBx9klVoS
	nrA8dS0InE4ezN8lJG8hdFdCcSX0R1WDzxCHpZ+w8KOULLya5EsDaugLmpajYzDc2Ov5mGOTcXn
	5VktC6mtk3imXpxOAXywoEjGGG3Y2uURs6wCk8QSFESU2qRLNYyRCUPsmYojTxHdEGcPwNDUDht
	c4FLkMGoviQ9sXOZdHOiBIKB5d9gH8I0BsBMDWz0xy/oksrnyASwT8zZwjqY8yO2N2K0LLHSYlA
	ZtFoHjZQymLibLtTX1edB/fTe4AtBcNvY4IZyzfYWCe1miUYUxgUInw=
X-Google-Smtp-Source: AGHT+IFRDdR+y7fnmSVY24vGxnYcOYF2oSqO5tUVnC8sp//HSH6HJAZuXejI1iqoNQq9MH59YuatVA==
X-Received: by 2002:a17:902:e5cc:b0:21f:7e12:5642 with SMTP id d9443c01a7336-22bea4b5f93mr124668945ad.18.1744607381927;
        Sun, 13 Apr 2025 22:09:41 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:b80:9edb:557f:f8a7])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-22ac7cb5047sm90778665ad.170.2025.04.13.22.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 22:09:41 -0700 (PDT)
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
Subject: [PATCH v2 2/3] selftests: net: move xdp_helper to net/lib
Date: Mon, 14 Apr 2025 12:08:36 +0700
Message-ID: <20250414050837.31213-3-minhquangbui99@gmail.com>
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

Move xdp_helper to net/lib to make it easier for other selftests to use
the helper.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 tools/testing/selftests/drivers/net/Makefile                  | 2 --
 tools/testing/selftests/drivers/net/queues.py                 | 4 ++--
 tools/testing/selftests/net/lib/.gitignore                    | 1 +
 tools/testing/selftests/net/lib/Makefile                      | 1 +
 tools/testing/selftests/{drivers/net => net/lib}/xdp_helper.c | 0
 5 files changed, 4 insertions(+), 4 deletions(-)
 rename tools/testing/selftests/{drivers/net => net/lib}/xdp_helper.c (100%)

diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index 0c95bd944d56..cd74f1eb3193 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -6,8 +6,6 @@ TEST_INCLUDES := $(wildcard lib/py/*.py) \
 		 ../../net/net_helper.sh \
 		 ../../net/lib.sh \
 
-TEST_GEN_FILES := xdp_helper
-
 TEST_PROGS := \
 	netcons_basic.sh \
 	netcons_fragmented_msg.sh \
diff --git a/tools/testing/selftests/drivers/net/queues.py b/tools/testing/selftests/drivers/net/queues.py
index 06abd3f233e1..236005290a33 100755
--- a/tools/testing/selftests/drivers/net/queues.py
+++ b/tools/testing/selftests/drivers/net/queues.py
@@ -26,13 +26,13 @@ def nl_get_queues(cfg, nl, qtype='rx'):
 
 def check_xsk(cfg, nl, xdp_queue_id=0) -> None:
     # Probe for support
-    xdp = cmd(f'{cfg.test_dir / "xdp_helper"} - -', fail=False)
+    xdp = cmd(f'{cfg.net_lib_dir / "xdp_helper"} - -', fail=False)
     if xdp.ret == 255:
         raise KsftSkipEx('AF_XDP unsupported')
     elif xdp.ret > 0:
         raise KsftFailEx('unable to create AF_XDP socket')
 
-    with bkg(f'{cfg.test_dir / "xdp_helper"} {cfg.ifindex} {xdp_queue_id}',
+    with bkg(f'{cfg.net_lib_dir / "xdp_helper"} {cfg.ifindex} {xdp_queue_id}',
              ksft_wait=3):
 
         rx = tx = False
diff --git a/tools/testing/selftests/net/lib/.gitignore b/tools/testing/selftests/net/lib/.gitignore
index 1ebc6187f421..bbc97d6bf556 100644
--- a/tools/testing/selftests/net/lib/.gitignore
+++ b/tools/testing/selftests/net/lib/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 csum
+xdp_helper
diff --git a/tools/testing/selftests/net/lib/Makefile b/tools/testing/selftests/net/lib/Makefile
index c22623b9a2a5..88c4bc461459 100644
--- a/tools/testing/selftests/net/lib/Makefile
+++ b/tools/testing/selftests/net/lib/Makefile
@@ -10,6 +10,7 @@ TEST_FILES += ../../../../net/ynl
 
 TEST_GEN_FILES += csum
 TEST_GEN_FILES += $(patsubst %.c,%.o,$(wildcard *.bpf.c))
+TEST_GEN_FILES += xdp_helper
 
 TEST_INCLUDES := $(wildcard py/*.py sh/*.sh)
 
diff --git a/tools/testing/selftests/drivers/net/xdp_helper.c b/tools/testing/selftests/net/lib/xdp_helper.c
similarity index 100%
rename from tools/testing/selftests/drivers/net/xdp_helper.c
rename to tools/testing/selftests/net/lib/xdp_helper.c
-- 
2.43.0

