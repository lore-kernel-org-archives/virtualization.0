Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B93253B52
	for <virtualization@lists.linux.dev>; Mon,  4 Aug 2025 11:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754307005; cv=none; b=bXcz3JEkMgIROj5wlwXCv5taQeWTsergbhu4UIqWvHlyW/rsayd3HyZOmuXjn2MMI2izqIwLSHfvryXVoYeHYjl8loCdQvf9ML0UeZ3IpOfjwSUQiPGgI0yW/QiCmL48doCIAqBWDEI4LZrMcBS3YQZh497KKt+D+vmUPQ4RuKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754307005; c=relaxed/simple;
	bh=tTDUsBXsPeQGzlryvB0NPAsroThBBrNMmq8k5cEQFwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R4pj5LWyUo8CIXloIqWXLshuv5r5geri4JrQpUqUZGftkNtgDNKJM8a2Af1YBs3g6JqTGM8LjFyGS/18kUnRpqt0i2CE4lECmtHO0MIH+Jr1nv5MiaXSe5GepkRNLtGNdqMlprLerPlv+43Dpa8FayOrR+bAczRmipWcCWTaFbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqB4kT1M; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqB4kT1M"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7682560a2f2so4065529b3a.1
        for <virtualization@lists.linux.dev>; Mon, 04 Aug 2025 04:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754307003; x=1754911803; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wvgE21mt8Nkxs3REibthkNPZrx5ubt1AxIt2mJnpkqw=;
        b=RqB4kT1MTwFSpvWRGH/RCQmcwa/bc8p5ANITEWnKGIs7o8Jei7yGHP4cvVkBikAIPm
         PAXdDO2Z/GXen6zKFVH9jApc9lubGMIwbSsQ5uwHhxIaKiwiiBiAQlImR+zZ38YQtAbA
         ZDruMaUtILx7xzOL1XcyRBa+X6Q8CisINKepRTKaYU+wLC21sTxric7+SKpciWOPxY3Y
         akAJJFm1AVTJu1dVh6XZ0BPMbF59OoRmleCLwoQw5bdJGRO2UjfDRSoxFd/aXxw17B4F
         X4k1MbLpSHJNED4tJ29urKsPJGxllommHkR504mnOaOa0kzX1rP/y83+woRqCqK1sbXC
         sGSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754307003; x=1754911803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wvgE21mt8Nkxs3REibthkNPZrx5ubt1AxIt2mJnpkqw=;
        b=FLm3d3ExhhcdthsSW87TgUvoBlDDkw0wITxFgip1FkJY7QoH6sfZyBCTbpB8KT4uVP
         uzLrIrzfQ1l1tQh3ggZy7fpTxzgNUXdG8Sv/K9n1OOFfpAC3Dn2/0PfFnKYLoBINXJ/g
         /GZp2NyItxR640f0+rUtIInaamh4ALobDfS/tH77d3avMXGWIddO3l774XVzbE1lxpZq
         bWpcd/oSXPpCcxzxoZXBuoWSpaDfEwMwroXyNwaJ+MX9fGOzy+bVJIVbxn7y+jqbhX4H
         IaTpjTajjH7Xm7L4Yk2FNvi8gI2jhYBRViqMCwJ8CaTu8eQabnBn4Mfrxx64k9jkoUvw
         kf6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXSk1oZ3mb3XhtynJ2hDSyi0oiMxhDw59+bfPs0Kq1/IC8HClhp0BdbsOHu9nq6b5lyDR+lnOUh0HriUDzU5w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyNfJGV0mJjQL47S+s4t2918pVGISqpmCW3hNqX7YhgAMs+TKz5
	ucfiimeVxWl4NONTSe3Hroly4a4pQUc9efPeugp6VqIlgG1A80ceXwpI
X-Gm-Gg: ASbGncumC2+BRHq/BX9gXGKoTw5CWvo2apNZvt+6NuY6YDhW3unHXNKRSQCN1niWRmo
	Z7XxMpXfxHpXP8GFN0R8Fj8LF149DM1X2ZvXyMfcrY0YYINVBKzMugjM4p4hb60mbPWrUpQya6+
	dC01F+8wb7wcZzLMTtER9wydy36F3AE3ejofwB6lAmpzzcNRrIQwWxYggnI5ykuCycczgadTCcu
	KJRknuHYmbKCcc8KV9PF0kvE4hgGxPB+xkOJJxAyAYSKIQwxgRcg6mBMKVN45BqV0LYOQUZ3c4x
	g6Jq3QO7kl25jqNlx74tUDrKuIY69tfAtYuRnBTRnQlwujXZsae50DCw8hD4B7BJWaz/i7Rj0DX
	CMRW7sNL3vnydgUQk50mpXvmvQp75iECb
X-Google-Smtp-Source: AGHT+IGzu6hKk4pv2fmINX8NvSw0SR6b16DoazjKoD+x2PNZOZIigvNZIun/V7bREmyAtP2VlzWf6g==
X-Received: by 2002:a05:6a00:2d0a:b0:76b:ea1e:78b9 with SMTP id d2e1a72fcca58-76bea1e7b6cmr10521687b3a.1.1754307003180;
        Mon, 04 Aug 2025 04:30:03 -0700 (PDT)
Received: from avinash ([2406:8800:9014:d938:f647:9d6a:9509:bc41])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bf8f12c95sm3999526b3a.2.2025.08.04.04.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 04:30:02 -0700 (PDT)
From: Abinash Singh <abinashsinghlalotra@gmail.com>
To: amit@kernel.org
Cc: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Abinash Singh <abinashsinghlalotra@gmail.com>
Subject: [PATCH] drivers/char/virtio_console : refactor resource cleanup to use scope-based helpers
Date: Mon,  4 Aug 2025 17:00:20 +0530
Message-ID: <20250804113020.620352-1-abinashsinghlalotra@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This refactors the 'alloc_buf' function to replace traditional goto-based
error handling with scope-based cleanup helpers.

No functional changes intended.

Signed-off-by: Abinash Singh <abinashsinghlalotra@gmail.com>
---
 drivers/char/virtio_console.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 088182e54deb..9875f5f07b32 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -27,6 +27,7 @@
 #include <linux/module.h>
 #include <linux/dma-mapping.h>
 #include <linux/string_choices.h>
+#include <linux/cleanup.h>
 #include "../tty/hvc/hvc_console.h"
 
 #define is_rproc_enabled IS_ENABLED(CONFIG_REMOTEPROC)
@@ -404,7 +405,7 @@ static void reclaim_dma_bufs(void)
 static struct port_buffer *alloc_buf(struct virtio_device *vdev, size_t buf_size,
 				     int pages)
 {
-	struct port_buffer *buf;
+	struct port_buffer *buf __free(kfree) = NULL;
 
 	reclaim_dma_bufs();
 
@@ -414,7 +415,7 @@ static struct port_buffer *alloc_buf(struct virtio_device *vdev, size_t buf_size
 	 */
 	buf = kmalloc(struct_size(buf, sg, pages), GFP_KERNEL);
 	if (!buf)
-		goto fail;
+		return NULL;
 
 	buf->sgpages = pages;
 	if (pages > 0) {
@@ -432,7 +433,7 @@ static struct port_buffer *alloc_buf(struct virtio_device *vdev, size_t buf_size
 		 */
 		buf->dev = vdev->dev.parent;
 		if (!buf->dev)
-			goto free_buf;
+			return NULL;
 
 		/* Increase device refcnt to avoid freeing it */
 		get_device(buf->dev);
@@ -444,16 +445,11 @@ static struct port_buffer *alloc_buf(struct virtio_device *vdev, size_t buf_size
 	}
 
 	if (!buf->buf)
-		goto free_buf;
+		return NULL;
 	buf->len = 0;
 	buf->offset = 0;
 	buf->size = buf_size;
 	return buf;
-
-free_buf:
-	kfree(buf);
-fail:
-	return NULL;
 }
 
 /* Callers should take appropriate locks */
-- 
2.50.1

