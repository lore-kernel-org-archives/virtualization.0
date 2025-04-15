Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDCD27991F
	for <virtualization@lists.linux.dev>; Tue, 15 Apr 2025 07:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744703103; cv=none; b=t51BwQx8SNo26Zou0nW8yeH0xokl57NGXvTU/FMWKwu2z4Vf/o6aQEfMji1JUUvtUfA67hu+hCV8AAFtIc7GP+giNPVZTi43aAMBDfC1/eWjVrphmEt7w5VHBfLT02PpmwKZbROsVYrsEOFwwvIUnJKmBAaD0aayS8dr9OvNL9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744703103; c=relaxed/simple;
	bh=fm0FD+nFpM4KIujT0zC25XQeJrJxwhYW3rijMoqQ0r0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=InKEZSYsknEvAjkZA6NqtygMVyWoW5g3lLUWfdZy7XbpA1fl6asctC4hYBwikRcseOxWdTehcnv5RRgl3QQ6VDF2qkOTasUICC4bEUFTbTkla/5p3+NkrRHzmko1eFTrSfSK+SjjsByo813VINBSxLnW7FTfXWmq/ZJ/MJisFzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bavwAFUm; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bavwAFUm"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b041afe0ee1so4286917a12.1
        for <virtualization@lists.linux.dev>; Tue, 15 Apr 2025 00:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744703100; x=1745307900; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CcTGqksFhMMv7htGFoe+A1pXwVfny33zxtLopOer7xA=;
        b=bavwAFUmhwmmSwHf2PJEMz/X7r5VZPz5IpyuEPxP8cN8BH2sKPayUaSAyc8IIRpQSD
         ZGII3wgCL6Wd0jSWw0gEKFVtmWPUnXTMXVL6ryl7cyhS6aY90DvDvHvEGKXoQVjOFaHi
         I4LEo3ijBxLB8pyeLEL4luIYm9qxVCUmTlJwPdWDuWIChrNWd8nOL5bMvBayRMbmwYYp
         Pdygu/InWQUppTeUNbBmfDeCidZ7E3QXxZ4icRZg4kApBj5CdJimUWTyTO+bQ92OwDuX
         5VpJIRPWZCWujNQCuG09SWOh7gUcjyF3R/epOczIQKJ+Ixy7GOhHGhy5MBOswLglWY7o
         Zc8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744703100; x=1745307900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CcTGqksFhMMv7htGFoe+A1pXwVfny33zxtLopOer7xA=;
        b=dHOONFzga106pXA1RAZBg/OfyjSF/sCjTCOLa94If6x2c/M0DmbFfcmrJ7yuP8w44g
         HMmyW7dsuNLdYrwb1ra/BmP8fphuuoKphQOt9g1KMxZ8SHyrVqTZLVscyV78a73L4YpE
         BfokK/SImZuN41iykWCQM4LKsPLuwr/CMhnz0X/TAy860NhZP8Zoa+fr32dUJqEjZ7Fm
         irQqXwd58TRvq3VpTikb9JFUrNXfIFyhXdU2LRwaxdGjTaF1hVSmLO7L/+LMzvuoOfE3
         O4R1MSemCoXthBUA4qo06sDID6MaYfvyvtWsY68P+gLyuCB7NhQzFKAuNGUfn7n3FO+K
         8hpg==
X-Gm-Message-State: AOJu0YxmVD+BTnBuHI3dS9IERUe74OoXlgJWUu+YnoGLj8gKMRcVGrC0
	1xrRH0mraUUxhARwfUfya9KE1oMd2rme3OvXE82aA9LB2aV5yacLPRNsdSVn/PlXPQ==
X-Gm-Gg: ASbGncsZZbb0Llvbl+ypn7jUyZ+xIvzrth+6mfVZNEDqJftb6eUlf+udUzB3n7vrypG
	xSJOFz6vGJlJ3SlDt4gE8GHU6oOAkz+T6I+l0cHeXvsQx9SX+f9uGhCsufMu27Aw/bDotH4bYGF
	k7ouSK7U4vEiGcknMyjnoL1v4UhSlZto5wejlpYJePbeGsKWQEZGjLdRgUrZRjbKhV5bDkbc1Wd
	PlF3maGdAebtP4GhkE2qqKNBKM/Fp1Jlu2BclfRY/5KV5Npof3lK7zdFzTF0dVZBTIYgyhSWhMD
	jPL73uLAENA1W4ZNyr8STTxjPTZU7blIIRISvtrAxWKF7cbzq/JxIrLB
X-Google-Smtp-Source: AGHT+IHE5AgDxSwyyov8xJNfUO5lrXFsO91K7n/gdu3YFirq9QCYmY1aQyWqJKPh15l+AnvruQPQBA==
X-Received: by 2002:a17:90b:3cc6:b0:2ff:7c2d:6ff3 with SMTP id 98e67ed59e1d1-3082367fc07mr21477127a91.35.1744703100354;
        Tue, 15 Apr 2025 00:45:00 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:2e0b:88f9:a491:c18a])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-306df401ac8sm12299767a91.45.2025.04.15.00.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 00:44:59 -0700 (PDT)
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
Subject: [PATCH v3 2/3] selftests: net: move xdp_helper to net/lib
Date: Tue, 15 Apr 2025 14:43:40 +0700
Message-ID: <20250415074341.12461-3-minhquangbui99@gmail.com>
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

