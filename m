Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67422221FDD
	for <virtualization@lists.linux.dev>; Thu, 24 Apr 2025 10:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745491797; cv=none; b=gcuB9V09ct0GRkQVtC/2nFarh9m2guNuBkk3hGKg+iOZMeoP/6aEX/m8yKBvpiXh+lz4uASGMPieU0+NTFJATkb2meI1e1wcJST+pTUvsJpPTy/Dg9v6IGMDqOHH1s6g35NXv2hjOaabFZE0/Ja1IzoSxqPzKU41WuowXxWxuh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745491797; c=relaxed/simple;
	bh=fm0FD+nFpM4KIujT0zC25XQeJrJxwhYW3rijMoqQ0r0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lJOB/kayNjmMapIc1FAV7aqEwAIZkurAestWmEYGc4lIGyGDrQGv/0NSiSYRaiw6lsU15rqWJX/ThGcvzgWTvG2uEwrz7vZfPTXz6KNYjHvCCXzocFn4nxCmhGQRPWaTU9jG+TjkNJ66KUAlw8hCNgJyzTJG+8UOI1VsyTdjFnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6Er23TG; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6Er23TG"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-739525d4e12so667638b3a.3
        for <virtualization@lists.linux.dev>; Thu, 24 Apr 2025 03:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745491795; x=1746096595; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CcTGqksFhMMv7htGFoe+A1pXwVfny33zxtLopOer7xA=;
        b=a6Er23TGpiApccPoh+fsinvE/PcnQZpIVXoVr86pN64nNACSdopaMPQOyApP0at8YF
         lgXQNhiX+awdPjA44G8y3N1vg/OFtc2dcRE/Lwh2ApoH1GlaLYZG2entG+TkgxZWVkfU
         pJjVfkxeVIrnZQFE3fIGMmjgc0PWJtXx2VKtwZsDlVyvU7WY3duuIA2jqM0r/bFT8JNc
         P0I4r4O8rin+MWqPbJMYcpv2hUpWP7SB8Uuv+oHsBzofCWrfeuxOySIIlj/2MGX7Hnav
         Yg8IPwdOqETQ2NE3+nv/YoYuDqcM+rXVkeDxyAFXGYnRvgp2jkFCj0+rp61MXMswldtj
         ZjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745491795; x=1746096595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CcTGqksFhMMv7htGFoe+A1pXwVfny33zxtLopOer7xA=;
        b=uJ/TQIGVCZzly50OiP4OovaxD3yc2uLWXJ5rtc0F57Gg8yh9MeuzGh5eN7qEtnxkxc
         zpMat7KxYckMgW8UTUyBj74dToyB4NUAcr0SZMjnhyojUYK2Y2BCc/kZrDPy4mW7rl3I
         UD2R6euOzXyfcKSscIycblSesijc4WZ38Kk0r6APfvhXBa7piF1Y52IL5SbO/xxeZ6Xx
         n88p7ykqOTWbqe6njKhhZFNA82m3JcYNRe5B5tHbY3hbRmS5V6OwiqHQv70M7QKiruYs
         gzSuezTGzEBMUQI5v4kr38bhQZvXuaFWhKnYYePWasC3btgxR1G9bj9JL0WO7ZhEE9KB
         hFbA==
X-Gm-Message-State: AOJu0YwZHjwf5QrroCT2SZieIv/m8cyHwFp/Oh2YM+lwpEy306Jeyy7B
	XVYhlirOh5LKpdCXJ09Aq0fYGsMjk9PPYLnw3IwUHwSZSFXP3zu2PVVOZ//Fmac=
X-Gm-Gg: ASbGncvyTr2UCiYjrHEsiFoHm2q/ijJlFMUxOPaHYleTWvi1+qkMzsv6HwfYDGX2YyI
	0Uf+YTyyDdd7DZJ81rvAvpJLeIDVVEr0biiIhyUkdXMq0zXntemYD9yuFcO8ToGM7IfTEre9A91
	9+9WEZIkuFfCwPD9OXotB/v9dXeAdnTFq1EOZABPiuUrVSjelLk8msxVg1kVNNEN7pZzFFeZ+ex
	2qxqcdemTRz5IdUN5EmrKwF5o/x1O86d0lJ3uTe26+0nOW4NqaihNpCBLVmkvfACzd9j+eOyTyh
	cTuWi9q/L/KtzRED/m52pDw+PDHkb9rAJTg5p1Q8CxUbfz4+kD3f+ffmkinVKV/O1Jo=
X-Google-Smtp-Source: AGHT+IGs1NWG02trRr5fLXhr7umLQzDhYVTGMHaf9AQpRz+KF7MH5lJcU6z/o7zq0i7To22znOcydQ==
X-Received: by 2002:a05:6a20:ce44:b0:1ee:b8bc:3d2e with SMTP id adf61e73a8af0-20444e70080mr3316057637.8.1745491794602;
        Thu, 24 Apr 2025 03:49:54 -0700 (PDT)
Received: from minh.192.168.1.1 ([2001:ee0:4f0e:fb30:f632:6238:46f4:702e])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73e25941bbbsm1120138b3a.65.2025.04.24.03.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 03:49:54 -0700 (PDT)
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
Subject: [PATCH v5 1/3] selftests: net: move xdp_helper to net/lib
Date: Thu, 24 Apr 2025 17:47:14 +0700
Message-ID: <20250424104716.40453-2-minhquangbui99@gmail.com>
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

