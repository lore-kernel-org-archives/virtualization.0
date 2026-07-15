Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C492DCC1C
	for <virtualization@lists.linux.dev>; Wed, 15 Jul 2026 08:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784102976; cv=none; b=mewsWp6ndgeqhGD4PAgfQ7+LeF+lm4xNmAIzBherQmJeQ9FNT5s32qPuA3oF0WNCjMhGo6IPlf+Byzfgpr28F0P4dIhsvZzW1zWrLHZBw9MhD73wSHCxvU7mbmz6HUUtNELdXGTpGwiwAZ429ec9pz8HBoBNhGbxh0VOnCIO7Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784102976; c=relaxed/simple;
	bh=fqNa7QCKdmathDAsvkyfxeAbjQVQLNj3foU3EYYcTV0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=h1Ex5ufrmmCNhUrgNKAhCx3OAUU9bLakGGMmgrbQFx75p/QUIWTPvPsk0kC6boUZCZwdoFPAF7m9W7nGIOUQu/dCRGah8Vg991kZIJjAFDP+CyeKSdjRlexoLFlnKiWm9coGVKzgXD5pRtK9lw7d8oEWo7GjMO0WvKHisaAoxu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=byTV7nNp; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="byTV7nNp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=ef
	GJ+tlrKhc5w1Jchitb1CPp6/++yNSH7SZIxJeL3ac=; b=byTV7nNprQ7V9uVBsh
	TfLxUqizOLlB4jOKnVhgWBx5r4kvSWefYHzooaIVD4XZmQJdbPnFnGin15KxnoXM
	Cc1bBQZYpGBJFIHE+O9a38NxeEpMQCzJyrBmrSZJoCuG+sBeRSLBCNUw6qufjFFD
	vYJpC1pdCk0i5ImsAuaAJHo/s=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD317U7QFdqiog2Iw--.54212S2;
	Wed, 15 Jul 2026 16:09:31 +0800 (CST)
From: Weimin Xiong <xiongwm2026@163.com>
To: virtualization@lists.linux.dev
Subject: [PATCH 10/12] vhost-vringh: use size_mul() for overflow-safe multiplication
Date: Wed, 15 Jul 2026 16:09:31 +0800
Message-ID: <20260715080931.21910-1-xiongwm2026@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD317U7QFdqiog2Iw--.54212S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw4fKFWktr1xuw15AFW3trb_yoW8GrWfpF
	4qkF45Ar4vkFnrK3W2kFnIyFy5ua97Gry7JF9rW3Z8ZF9Fyr1q9an3Kr9IgrZ7CrZrCryr
	Zr1jvF1Yk3yDurJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jY1v3UUUUU=
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbCzhyPH2pXQDx4sgAA3J

From: xiongweimin <xiongwm2026@163.com>

The multiplication sizeof(*dst) * num could potentially overflow if num
is very large. Use size_mul_overflow() for overflow-safe multiplication,
consistent with patterns used elsewhere in the kernel.

Signed-off-by: Weimin Xiong <xiongwm2026@163.com>
Co-authored-by: Cursor <cursoragent@cursor.com>
---
 drivers/vhost/vringh.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index 9066f9f12..b4a06454f 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -9,6 +9,7 @@
 #include <linux/vringh.h>
 #include <linux/virtio_ring.h>
 #include <linux/kernel.h>
+#include <linux/overflow.h>
 #include <linux/ratelimit.h>
 #include <linux/uaccess.h>
 #include <linux/slab.h>
@@ -621,8 +622,11 @@ static inline int putused_user(const struct vringh *vrh,
 			       const struct vring_used_elem *src,
 			       unsigned int num)
 {
-	return copy_to_user((__force void __user *)dst, src,
-			    sizeof(*dst) * num) ? -EFAULT : 0;
+	size_t total_size;
+
+	if (unlikely(size_mul_overflow(sizeof(*dst), num, &total_size)))
+		return -EINVAL;
+	return copy_to_user((__force void __user *)dst, src, total_size) ? -EFAULT : 0;
 }
 
 static inline int xfer_from_user(const struct vringh *vrh, void *src,
-- 
2.43.0

