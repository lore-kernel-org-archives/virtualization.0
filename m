Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A784347B4
	for <virtualization@lists.linux.dev>; Sat, 11 Oct 2025 03:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760153437; cv=none; b=r8t0y823VwAKPMKr+YlbpaLKlTv69bxFtjR0+ExUBn50f1vvW4t8Wc5rIic9QWU4Ro3z1/OiPjKBFTpNKiKgitdo3hQVdYt0YMz6hZQ6k9fVqXsvYsDTc8awjWTYDdLyrjDYTHVWjxgw9VSa/7DfbbF1T7/qBh+MTv3UJ/fuCc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760153437; c=relaxed/simple;
	bh=Z80sDuh2r2K1uwZc7/gJ2dh8n1n4WacbpmU5bYMlaSY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HFZoZlD+joSlafTY+FCvXRt7PW6zolIUOoz5dIZy8MDovvCU79H519QnURzRrREwmH9+Is+SUj1ovFOUVrZnjCnK/RQk3q3E75lNPi0CqeOUnxiNaUPxBjXMN0CMoz5k9ghDSkJ/fg4HZMupGfixuFMheJremoiJ/Cxd4pSKh6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTW0JxrO; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTW0JxrO"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-33292adb180so2585815a91.3
        for <virtualization@lists.linux.dev>; Fri, 10 Oct 2025 20:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760153435; x=1760758235; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0sYbk5VmU4v1pNPH+Fa3K2iS1n3qdqJuuATj2vp0zUU=;
        b=LTW0JxrOzGQxSPzEmfqE6fNoqI6XrXdbrEV6Z7dvAIvro17LpHeUxxN8aP5J3v66Eq
         ama9CvJYy81PmkGywooeGKGGQdpFNsqvd9uzbq67qFfKKmYdLzHmowlaWP4i5M1LcXJv
         AJ1BB82QGdeSR9fAokudxBUf9Z8HT1BY+5YubBsTenE7+4d9zFDiMk7rcjb+XzbclK4F
         YsuUdHqobNqhdQol3jGw+do1M53oVNs5u4OsiM2hd4dkTqkQ9E0LBAk1fmyHG+bgsJXD
         8NPC+RUPICDVtTi2Anaf9vi2sHkm7kRqPtbD7mAB37pbkAZGuF2FAiXZIxZMfp5tGvCi
         n2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760153435; x=1760758235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0sYbk5VmU4v1pNPH+Fa3K2iS1n3qdqJuuATj2vp0zUU=;
        b=ezCS53xBiC1+GiRw1JdyNIp9PHUzpD6OHm6zRkXMmSeF4YvQI1+3AwYQoDf3MtbLDn
         zHF+2CfuC2Ax8cU3AqnfKEyqG1IW7SiWKLD0h+oDNmhb91EVcAuOaGNFz1eZKaY9HWTG
         m4KmiaAqegK9gXQHh9mflCJk1Oq1M11CSKUxMJQW2XAtmT7CQW15cO4ec3C8vwT4abSe
         AQuWeJ2sca3DG24bVKSYaKVZJlrH3B0NEC+u9bCOn/JmR1csOiehlFxmHuOLrKecuLEU
         57eBaOCFJdb1oUrD1CZt5Q860n7hEV7s+yYlI0S1dE78hfs9OGNi8GrNDyeFCZiCnY1O
         od/A==
X-Gm-Message-State: AOJu0Yyp9aOhCf3xze/P1t6UREmhjVrG0N4cRElA67zU9hbFn7MojvnC
	O+aqCza1rS9hifvtzISoMfRAU73HpC2ql8sdoJg9uds5mXEH4AIbrk9Q
X-Gm-Gg: ASbGncvqCXwaYtA3KT88GuDcqbL06lOCVdl1e0P8er/taTQpm91gzKgLiNb4HTZ9pMz
	hjwLdexVlJfGVzyM7ob/WXCVY1j+YIgT+f2VFcfpRp523IUdRX2kSnFpzFwMbcZbfzlUkAf9xux
	2p2BksXa1wi+f3K54yhlr5GsbKuAfv3JTgoxmkvuqEfr4qB0fEiasFvO8plF3MwwLqTggH5cnEx
	wEiOaA7DHY/EMnysGZr8C8gAr4kznj4ORef64JdhDV63g4LWSEdvfnHXAXkbGhBHPy1+LqJuso1
	ics106Hkpg3Ro+cSS+bWIORxR0GQdxUv+102WvCLJiD9ryZTyNBZNSx4vj010XB6js0RMX6mUq8
	oTdtaGRhrz4eWCZgnF2JbDik/R0F17NxeVXET3hCXnrH2GEpSyJOeHrzUxJbZsJbC
X-Google-Smtp-Source: AGHT+IEVIfe6WZXTqBnz7nHlm3cwkJC0ZhBYUyRpN3slh0vrMoKKnT/vtaUEkQVAZyedNiVv/bJUOA==
X-Received: by 2002:a17:90b:1e0c:b0:32e:749d:fcb6 with SMTP id 98e67ed59e1d1-33b51118ef7mr22146055a91.12.1760153435086;
        Fri, 10 Oct 2025 20:30:35 -0700 (PDT)
Received: from localhost.localdomain ([104.193.89.9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b529f51b5sm4215540a91.7.2025.10.10.20.30.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Oct 2025 20:30:34 -0700 (PDT)
From: Wei Gong <gongwei833x@gmail.com>
To: vgoyal@redhat.com,
	stefanha@redhat.com,
	miklos@szeredi.hu
Cc: virtualization@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Wei Gong <gongwei09@baidu.com>
Subject: [PATCH] virtiofs: remove max_pages_limit in indirect descriptor mode
Date: Sat, 11 Oct 2025 11:30:18 +0800
Message-Id: <20251011033018.75985-1-gongwei833x@gmail.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Gong <gongwei09@baidu.com>

Currently, indirect descriptor mode unnecessarily restricts the maximum
IO size based on virtqueue vringsize. However, the indirect descriptor
mechanism inherently supports larger IO operations by chaining descriptors.

This patch removes the artificial constraint, allowing indirect descriptor
mode to utilize its full potential without being limited by vringsize.
The maximum supported descriptors per IO is now determined by the indirect
descriptor capability rather than the virtqueue size.

Signed-off-by: Wei Gong <gongwei09@baidu.com>
---
 fs/fuse/virtio_fs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 76c8fd0bfc75..c0d5db7d7504 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -12,6 +12,7 @@
 #include <linux/memremap.h>
 #include <linux/module.h>
 #include <linux/virtio.h>
+#include <linux/virtio_ring.h>
 #include <linux/virtio_fs.h>
 #include <linux/delay.h>
 #include <linux/fs_context.h>
@@ -1701,9 +1702,11 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
 	fc->sync_fs = true;
 	fc->use_pages_for_kvec_io = true;
 
-	/* Tell FUSE to split requests that exceed the virtqueue's size */
-	fc->max_pages_limit = min_t(unsigned int, fc->max_pages_limit,
-				    virtqueue_size - FUSE_HEADER_OVERHEAD);
+	if (!virtio_has_feature(fs->vqs[VQ_REQUEST].vq->vdev, VIRTIO_RING_F_INDIRECT_DESC)) {
+		/* Tell FUSE to split requests that exceed the virtqueue's size */
+		fc->max_pages_limit = min_t(unsigned int, fc->max_pages_limit,
+						virtqueue_size - FUSE_HEADER_OVERHEAD);
+	}
 
 	fsc->s_fs_info = fm;
 	sb = sget_fc(fsc, virtio_fs_test_super, set_anon_super_fc);
-- 
2.32.0

