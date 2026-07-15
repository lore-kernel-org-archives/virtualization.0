Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4E03C3C0F
	for <virtualization@lists.linux.dev>; Wed, 15 Jul 2026 08:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784102977; cv=none; b=RwieEXUEShZXn2HPipg3MnMLp36VDkFO/PwOW93ZSJHkYzRMyc8euoYoQVtxQJYndz6OcAXSTrPFYgGPEyccbzOF/kYv88Fyt5jJRTe3hMzG0spZS01JQha6RDCa6F+dfZhc9sARsgBQUaLcgGuNGjBNFmb6inzT8ipivhQikgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784102977; c=relaxed/simple;
	bh=4cWJMzkCAv3C/zlCi4LSHutTY+1YMjGtr/CaX+SC5O0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=T4hVhXLXjxeWX9YCngfcQ1W666D1PRbe4ZHXrsNQL4+buWR/FFIfsgvjegpq1hlUg1hU8QodLFIN0jX3xkyFmN8oMWyhfCfFvPt9UaS9SpyvcbqKTz4lquIgwKQYoBX3HaKS/uHutevaYi9iGzE/QD5yi6ZSxQcIueVnoDjBxjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PEeN/xjS; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PEeN/xjS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Z/
	6cXtUzkdZNOhZvo6Rch1yn9Bdh5qP279YVHBNwpXE=; b=PEeN/xjSKMOooN7WLp
	n70v74ym4c4ldf1pWHI91R82DqWAyiIYRBNABQJl0gJMNA7mnYBvCemAp3FuIvSF
	yZtPNcIWO4eCwYV/8mYs9qgDzs97LdDrxhvUm49crLy2+ncSiErf+eVVL3tp0BQ7
	KJaTib6utQ2lgucYz+9I40EW4=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgD3XxA8QFdqk49aHw--.23294S2;
	Wed, 15 Jul 2026 16:09:32 +0800 (CST)
From: Weimin Xiong <xiongwm2026@163.com>
To: virtualization@lists.linux.dev
Subject: [PATCH 11/12] vhost-vringh: use uintptr_t for address casting
Date: Wed, 15 Jul 2026 16:09:32 +0800
Message-ID: <20260715080932.21923-1-xiongwm2026@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgD3XxA8QFdqk49aHw--.23294S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrWktr4UAF18tw4fXw1UJrb_yoWfXrX_Gr
	Z7Wr1kWrn3Kr1q9F1v9ry7ZFWftwnrXr1rZ3WFv3sxZrW7Zr1Sya4kurn5J3WrGr4fZrW7
	ZrZ8tr15uF1xCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0dWrJUUUUU==
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbC7xyPH2pXQDz5qAAA3z

From: xiongweimin <xiongwm2026@163.com>

Use (void *)(uintptr_t) instead of (void *)(long) for cleaner
unsigned address handling. The uintptr_t type makes the intent clearer
that we're handling pointer-sized unsigned values.

Signed-off-by: Weimin Xiong <xiongwm2026@163.com>
Co-authored-by: Cursor <cursoragent@cursor.com>
---
 drivers/vhost/vringh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index b4a06454f..654567ee5 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -351,7 +351,7 @@ __vringh_iov(struct vringh *vrh, u16 i,
 				slowrange = range;
 			}
 
-			addr = (void *)(long)(a + range.offset);
+			addr = (void *)(uintptr_t)(a + range.offset);
 			err = move_to_indirect(vrh, &up_next, &i, addr, &desc,
 					       &descs, &desc_max);
 			if (err)
-- 
2.43.0

