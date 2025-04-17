Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B4F219A8C
	for <virtualization@lists.linux.dev>; Thu, 17 Apr 2025 07:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744874976; cv=none; b=c7qbSIlt2OLxsQacuTeIhz6de0DRASFid1T0oDYPQtws8NAI3AkZlNs1i15MORYUh6RIxOZg1kg1xH0a/qBSfvpNB3M8YCfdA20XmlhNhxbsZQyMIld93stUtc4KyoEUiRtVl1hHxqqA/yoF7MxRRRSeYDQXgdDhJqv1bJot+sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744874976; c=relaxed/simple;
	bh=fm0FD+nFpM4KIujT0zC25XQeJrJxwhYW3rijMoqQ0r0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JRpzGzvtureKs8Lf42TqV5wEW3iev0IbRvVyTdXR+RB09jlNxD97dCiJYp6aqRAZu0lSEQNEBZNcfbSS6KOpI0QD4MaL49LaBCL5PjDvDoduNV4m5WL+gXL+tzsK/KF22BbLQcn2kl+L8MSBRgdtWa1QT96rQxkwC4SlhplpuwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=beZpSPbp; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="beZpSPbp"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7398d65476eso413034b3a.1
        for <virtualization@lists.linux.dev>; Thu, 17 Apr 2025 00:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744874973; x=1745479773; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CcTGqksFhMMv7htGFoe+A1pXwVfny33zxtLopOer7xA=;
        b=beZpSPbpf2eh22zeUjWU45zJaDz+WqtWnBB29sil5dxOAvG2+//rXwWm9KSdxbad6S
         wd7K7+sm8VB3mTVKPGTyfqg6Bz/lYI3GjY5Z49rpT9IDQs8A+tUIwC+Kdi+OHUl9nwDk
         BNt5yhnbckSY5voG5Ht168MrCCpYlMrambaPJvKBV7uWycpgQc9nvXzJzoxzMx9AKibJ
         srC5MxAA0JSmRalxe/xB2wmg/7CrQpdyjp7qCFTstWC1GXefhYsn9XGI9dpZxBmMijK3
         YqybNPL7VAq8y6/FQq5U1i5KVgPhfua4w6/iTtGWFXQAXRui3yU0Mk5o49QACTjmof+z
         naiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744874973; x=1745479773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CcTGqksFhMMv7htGFoe+A1pXwVfny33zxtLopOer7xA=;
        b=wapqzJLMTM8ZNR/Uvyb+u1X3cVHwSjyzN9arbDgXlvZ82hO4LtRcdzAOGgDu88XubY
         dKVuumkJuPdkUp5y1tsP5Gisdbz9gpgqQrG8JkwjiD5+m4b/ri0VENZ3GzMMFB68+9WF
         ZWP7YyAHpVYc2XT81lZRc6zNAWBqeECBbJCyHEbPgstwDN3QpC+6VgGKdqeeF3WYGUps
         TG/QotnpZPqT2PfA42TDPS0bpqB0ICbbJ8p4/Qq7ABMMvWWVhebGqtX5id87iKD/bxSH
         lmHpKvg+uxj23myKukPMdbIOFZ0QWMoU5iTuoC5dbgD5MVc/rPC0Ye/j2TIMJUnWi45w
         yflA==
X-Gm-Message-State: AOJu0Yw+TB/Z6jLqtZzNv42OhCHfaa+MExJjZEjLMnwE+FbVYVKTw6yh
	CO2gjUQt6isf3V6OLDyHC+n4X2BjMGr6I+I+QnGbFB0qC+nVWMhDtcSZ4qC0
X-Gm-Gg: ASbGnctIuUflQymVSKZUu6On2rDj5isv5cYq+Px/veckcE1Nkv+97PQYugSdR7b3roD
	S9X9EPvNGOzxmdSjl1yOH0Qxb8ZV5e9mSZb7GrJWYWUHeAiU8JML6E218j0mrdlf6M37X6owm0g
	pgkTaqtW9WRJDNdzbZowgG47J9JaybsQAWqEFpRMsIIcEENbI3ufhhdLt6EZ5lCYevD0iPJXEaZ
	gY5v9SQejlKT8M32vYZWUPArq3EyDYH6t0V6r8XV00M1jobDu8KNrPZOYMWBrgoMqGuXTe2Dw8j
	mMBYlpWdrMnuiz8VFsKNMiATPs8AjCcc+VtqtfFXK4CauR6b08L1XZPklX4B//Od89w=
X-Google-Smtp-Source: AGHT+IEPUyy0fzYHOBy5qcKeDGEAL1lZs+bWSz+cNnQwUcKvh5PbOd1OY9+pCbu7+dik767iIp715Q==
X-Received: by 2002:a05:6a00:1141:b0:736:b400:b58f with SMTP id d2e1a72fcca58-73cd000d338mr3662142b3a.0.1744874972941;
        Thu, 17 Apr 2025 00:29:32 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:ab45:ee9c:5719:f829])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73bd22f0f3fsm11625344b3a.115.2025.04.17.00.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 00:29:32 -0700 (PDT)
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
Subject: [PATCH v4 2/4] selftests: net: move xdp_helper to net/lib
Date: Thu, 17 Apr 2025 14:28:04 +0700
Message-ID: <20250417072806.18660-3-minhquangbui99@gmail.com>
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

