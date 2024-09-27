Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEAC17A597
	for <virtualization@lists.linux.dev>; Fri, 27 Sep 2024 08:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727426466; cv=none; b=Kk/iMFwE9OJ9+hsq21l+E/gxAMyjq4NHEfy8YuiFFyx3ND17RPDgxQ2qJbmd12BNVt5tUcb0rHQFNyWHv+EUgUvE7sjHS4hhjC4L1vTRGePNZV9cAcVfB7tUwAqHWX6KClxcFmZ7BvEf9Q93w6vrdFrbJZ5slhdwkvrSllAGijg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727426466; c=relaxed/simple;
	bh=AOxp4hRhw4ffiQydMMnVDt7YirAsI2cruYRs3SLM/h8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hCtGxltUXSNsJ3/Vx/frIsXqV38+QXc51hFiI0lzhJ3wnIwN1TjUHWKrzV7A1FgjLG65sStPdPAUvewNgRhLsZnNp+U1qECEUxDYgpomrIQGG0BVs/DdMLX5hyP6rRZImKRPGQiFftuS3rNVkZcHfOvbHQzzbcqpgpwPSOQzoec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8h3f93Z; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8h3f93Z"
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-2dee9d86f4dso1653994a91.3
        for <virtualization@lists.linux.dev>; Fri, 27 Sep 2024 01:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727426465; x=1728031265; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Ydo/pKZERVs0bqoqAlHXeOYxiKkpvzcXkDRwOGg+5o=;
        b=l8h3f93ZMQit8CTPsI4xpuuLm2+io83FNwF8BjP4RoCiCMd3sHUj6R+9bWTp9muWZ+
         yHYDAQ29BmWbfK2HmdVjofR+nhm4dkm5vzkiqBMohL+UWy+fJgp8bVP3fPUDd/1pPUxW
         MtspxdVHtba7qwkRmrsg45Oz+qGPpEFFumeqgkmJGC5GsvNZkTlqduZ34Rj3FZwT0T6Q
         motDIMuqMKrTWKX0oQVLuvC54OSRSxWlPORQDxWnE3I1ZqK/8YaRoo/S2l8PJLLuIqmg
         qsYATZNYNKDln4L2IdQRxKAIYuQFK1lhwlbWA24pCcIM4ajqyKth07v2b0nFSI9k64GN
         JsIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727426465; x=1728031265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Ydo/pKZERVs0bqoqAlHXeOYxiKkpvzcXkDRwOGg+5o=;
        b=r4iO4nWBCsc3o9/TL8rkOBQTqxzQwsxalUD/3R5NpeoAFQ8EbQJO3qKJilW2rCcBn3
         lp4YPmfmMfZTGAgu+A85v3HxZ3NVzwwRe67Cd/gk9m5SjhX/y3/KfehP9s/NboyvUHJ6
         EUn2dSWq+7n/aeiwvtar94HBoGtY3vn55iuuM6Bz+uNd24/+BkLWWu7VfGDNjLE08xsL
         VosOtzTlJDByFXMYBtIFxo7j5KJFm7G2Yb4vjD+EQe6Z4naYW305ZPwYRaQ0scEoVXwW
         Ghe55aGPrM4KudDTaXbjyBz9mrmfbxsmJk3IIyYx0pQqfQWsBKTdtmdGNh3lJ8V2mf4+
         eSHQ==
X-Gm-Message-State: AOJu0YyzrJfzYb/G5gP9IhECFOP5W5CJaSW6xq7ksw9Sr5MknbtRD7iF
	ThZBQzAWMbydDkbCxfQDeunXUeSDb4prIC1A1kZLy7SjiQp5635b
X-Google-Smtp-Source: AGHT+IEMOi60RjhnrsN90Q1PLv2GM/tYKsZ2PE5A15HJTUNAtUl/wmC3n+nECtpIf0liaEVnHlkXng==
X-Received: by 2002:a17:90a:f00a:b0:2d8:3fe8:a18e with SMTP id 98e67ed59e1d1-2e0b8872d71mr3143054a91.5.1727426464532;
        Fri, 27 Sep 2024 01:41:04 -0700 (PDT)
Received: from tom-QiTianM540-A739.. ([106.39.42.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e08c35fed5sm2488411a91.0.2024.09.27.01.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 01:41:03 -0700 (PDT)
From: Qiu-ji Chen <chenqiuji666@gmail.com>
To: amit@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Qiu-ji Chen <chenqiuji666@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] virtio: console: Fix atomicity violation in fill_readbuf()
Date: Fri, 27 Sep 2024 16:40:56 +0800
Message-Id: <20240927084056.7193-1-chenqiuji666@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The atomicity violation issue is due to the invalidation of the function 
port_has_data()'s check caused by concurrency. Imagine a scenario where a 
port that contains data passes the validity check but is simultaneously 
assigned a value with no data. This could result in an empty port passing 
the validity check, potentially leading to a null pointer dereference 
error later in the program, which is inconsistent.

To address this issue, we believe there is a problem with the original 
logic. Since the validity check and the read operation were separated, it 
could lead to inconsistencies between the data that passes the check and 
the data being read. Therefore, we moved the main logic of the 
port_has_data function into this function and placed the read operation 
within a lock, ensuring that the validity check and read operation are 
not separated, thus resolving the problem.

This possible bug is found by an experimental static analysis tool
developed by our team. This tool analyzes the locking APIs
to extract function pairs that can be concurrently executed, and then
analyzes the instructions in the paired functions to identify possible
concurrency bugs including data races and atomicity violations.

Fixes: 203baab8ba31 ("virtio: console: Introduce function to hand off data from host to readers")
Cc: stable@vger.kernel.org
Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
---
 drivers/char/virtio_console.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index de7d720d99fa..5aaf07f71a4c 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -656,10 +656,14 @@ static ssize_t fill_readbuf(struct port *port, u8 __user *out_buf,
 	struct port_buffer *buf;
 	unsigned long flags;
 
-	if (!out_count || !port_has_data(port))
+	if (!out_count)
 		return 0;
 
-	buf = port->inbuf;
+	spin_lock_irqsave(&port->inbuf_lock, flags);
+	buf = port->inbuf = get_inbuf(port);
+	spin_unlock_irqrestore(&port->inbuf_lock, flags);
+	if (!buf)
+		return 0;
 	out_count = min(out_count, buf->len - buf->offset);
 
 	if (to_user) {
-- 
2.34.1
