Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20198230BFD
	for <virtualization@lists.linux.dev>; Fri, 25 Apr 2025 07:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745565114; cv=none; b=l8JOIyNnHIa74+yKe/CXUgCy5wCKF4hHTTyrJjEbXBK6utL1OIYLaq5DxbaUuWUc4sPXPBS6tCYw43Y7kUsh9dVn+vs/9eG7d8f5rtq0iIk1b2ObCqms7KYdoSMsjxwQeSnFjKvc5vsKs2/Wr2SVvyxFxb7Q6Bgr9KtQm4EDtnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745565114; c=relaxed/simple;
	bh=mAFnFm9FlcZV4NvoQvjfbcmlE0Ubh8CcyejzVeGNsbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RK7568Solv/Mo5loyldkEXRXaNOkFihqJmiqAwBwGI5QOYgkcxZvdd9D5dOtK7kIhgRdRnmPn5kMyFVXh8LZUEQWaMWwOa9wpKaVbCcptZfwOURIFGZ5U7NGasxChnRVlO76tMI+hqNTZT+xHTxi0io7emra843/X4U7FIIYu5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IdRWcC6s; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdRWcC6s"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-224171d6826so30424705ad.3
        for <virtualization@lists.linux.dev>; Fri, 25 Apr 2025 00:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745565112; x=1746169912; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+JOGRgGKufTsNtNc5oEXqegFkT9LBJnCqXIPnSP+xEU=;
        b=IdRWcC6sTbmT26ctWyce04/YnDEceh9UIP7w5vQ7BO3Yi40JlM39G3Ekvb42okvFPm
         LcyTXdkHHJVYWNp9m805jT1EbOft2giEbgFNYXnbDXN+EF6IUK6NFqHtIAZCn4tCCER4
         y7c+fbtG+da++LXesRpIv2EGjdUJMIdZJJe2YaZR+nX7q3btlSl0diEvMY7MDMxvtWOD
         3lt9ozy1o9o5/9UJsj45QVYXKaLoqcVmb74qrQeQrVfVOIPQ13k/B7pPitbA+9I7Hgrz
         l9JruIOF2JPpDGGhJvUTd0nsw/lP/zD9c43Bk6YpKKMMIe8VC16TPguI7PfezBYFa5CJ
         91jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745565112; x=1746169912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+JOGRgGKufTsNtNc5oEXqegFkT9LBJnCqXIPnSP+xEU=;
        b=wbeFQ41lSMoSmhbGfDmAxQ7CQybCriY5tTbAeLn2en+teffGnHqY4nsy9nAuxm4AYB
         b8RL5NKDkzcxT4mys307vs2XyJTjFwhgJpjMIf2RVm3T7jToj2tkpiETPkEvHKrqITgy
         7ymFntXfRmSJgdu7OqpJ6gACuDhX+pUCD+KgXubRldsGE6iO9pChz/KtWW2BKE1wdT1C
         IaFovtzvnorqp1GhbfA19GJ5zXILRvqaPRhWxcKECKRyEfPropMAoxX8Kt+waWvGQsm5
         u4bl3RdRnDJCjbc0FcfOQfmjQXAden8BAZ8aIm/0UlXGPsxMZvrDQPXGEZbO3u27W7QR
         B5TA==
X-Gm-Message-State: AOJu0YyN/7eib6B6qbVyDhyi2/GgAWmVrauocyHzFCnitidTkQtKqQ0S
	CSUQ5AJOJb83PGpuvNpHS1+BxK8c7soykNHszb+CtxjXcycMcTcE8/jaRFSF+DQ=
X-Gm-Gg: ASbGncut8ou/S8tR85p8AS98pCnAynfIBODiyjJRHnMcYF2dBFX2S2oNJdjehXZWaRq
	LQhoEzgKWqp6tRkn9GeTlTWQUU0VmuMWmX2hp/IV80uUVCEEtTqRSCszWDIuqZWNqSOmQa0ksDf
	gQngv2TDo82Ql+wSrTlZQAUxMU+rLeLxIEhJh9qq0y8o7yA64G2N2tPB3wTeAOuyHA5xVsgxCVh
	Nli0sMSq5lW5dXoE6CgwYrR+fPTD80D4TiXDvmLRo6GJ0tEPi8ivDoG97K6EBveWB91k/XATvzz
	0vAx/1E8FyIuq7RYVHr2oKE3+PEVMLVHNI3+85Ng1MCVgroulo0rdCrA
X-Google-Smtp-Source: AGHT+IElAol3//I0LM/LyoucdlPuB7fBU0sANzkXGvmGVaSDn+awApeht13o+Gsd2p3PLalBkVxYgw==
X-Received: by 2002:a17:902:d501:b0:224:5a8:ba29 with SMTP id d9443c01a7336-22dbf6409eemr20756635ad.43.1745565111782;
        Fri, 25 Apr 2025 00:11:51 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:1c5b:42af:3362:3840])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-22db51028basm25322425ad.196.2025.04.25.00.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 00:11:51 -0700 (PDT)
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
Subject: [PATCH v6 1/4] selftests: net: move xdp_helper to net/lib
Date: Fri, 25 Apr 2025 14:10:15 +0700
Message-ID: <20250425071018.36078-2-minhquangbui99@gmail.com>
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

Move xdp_helper to net/lib to make it easier for other selftests to use
the helper.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 tools/testing/selftests/drivers/net/.gitignore                | 1 -
 tools/testing/selftests/drivers/net/Makefile                  | 1 -
 tools/testing/selftests/drivers/net/napi_id_helper.c          | 2 +-
 tools/testing/selftests/drivers/net/queues.py                 | 4 ++--
 tools/testing/selftests/net/lib/.gitignore                    | 1 +
 tools/testing/selftests/net/lib/Makefile                      | 1 +
 tools/testing/selftests/{drivers/net => net/lib}/ksft.h       | 0
 tools/testing/selftests/{drivers/net => net/lib}/xdp_helper.c | 0
 8 files changed, 5 insertions(+), 5 deletions(-)
 rename tools/testing/selftests/{drivers/net => net/lib}/ksft.h (100%)
 rename tools/testing/selftests/{drivers/net => net/lib}/xdp_helper.c (100%)

diff --git a/tools/testing/selftests/drivers/net/.gitignore b/tools/testing/selftests/drivers/net/.gitignore
index 72d2124fd513..d634d8395d90 100644
--- a/tools/testing/selftests/drivers/net/.gitignore
+++ b/tools/testing/selftests/drivers/net/.gitignore
@@ -1,3 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
 napi_id_helper
-xdp_helper
diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
index 47247c2ef948..17db31aa58c9 100644
--- a/tools/testing/selftests/drivers/net/Makefile
+++ b/tools/testing/selftests/drivers/net/Makefile
@@ -8,7 +8,6 @@ TEST_INCLUDES := $(wildcard lib/py/*.py) \
 
 TEST_GEN_FILES := \
 	napi_id_helper \
-	xdp_helper \
 # end of TEST_GEN_FILES
 
 TEST_PROGS := \
diff --git a/tools/testing/selftests/drivers/net/napi_id_helper.c b/tools/testing/selftests/drivers/net/napi_id_helper.c
index 7e8e7d373b61..eecd610c2109 100644
--- a/tools/testing/selftests/drivers/net/napi_id_helper.c
+++ b/tools/testing/selftests/drivers/net/napi_id_helper.c
@@ -8,7 +8,7 @@
 #include <arpa/inet.h>
 #include <sys/socket.h>
 
-#include "ksft.h"
+#include "../../net/lib/ksft.h"
 
 int main(int argc, char *argv[])
 {
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
 
diff --git a/tools/testing/selftests/drivers/net/ksft.h b/tools/testing/selftests/net/lib/ksft.h
similarity index 100%
rename from tools/testing/selftests/drivers/net/ksft.h
rename to tools/testing/selftests/net/lib/ksft.h
diff --git a/tools/testing/selftests/drivers/net/xdp_helper.c b/tools/testing/selftests/net/lib/xdp_helper.c
similarity index 100%
rename from tools/testing/selftests/drivers/net/xdp_helper.c
rename to tools/testing/selftests/net/lib/xdp_helper.c
-- 
2.43.0

