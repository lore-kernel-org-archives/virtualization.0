Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0424C3382C5
	for <virtualization@lists.linux.dev>; Tue, 14 Jul 2026 03:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783999467; cv=none; b=gB+AdXxQ9mqp8s0AQym5Hm6Z80wP4HLaGoovLa1mDXlTuuScQe8QprsuAJiS3PIQ5W8QC3XmPfhZf6hjRfFWDYro99GDyuZyhtBqdXuiLMAssL10FkCiNBT9dk2qVf/cfpnue2LiNlIu2XFBC9RnWow4tPAuIWIUbm68R64YbBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783999467; c=relaxed/simple;
	bh=jKpDtyQZEpk/Okad7ueehj/BvCAlYBxNMmHS+NI/mDY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ILEF29BZSsYBGdgCKk9pWFwjvDq4GA3f6tD2VTqgkvxG67Lv/gYA07w/ReSQhdqjoxMiB6426m3/V/hpjhxOKbJg5Iw0gen/uULQMbm+trsQ7y7YFZrASk5UteVxEnQYr/BxRhpjnyQNPbHREcfmnq6i1UO/iCMwpZk11kT0WyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=f6NdErHx; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="f6NdErHx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Qn
	kcrxOZBDZlnQiCf8DFNuzu8auyAbknY82gsxd/Bm8=; b=f6NdErHxE8Hct8AVre
	Hc+lL6roWqukL6WQZjZNKEqnfOmpld5Vb8suW8Uqhf18lgYWZRxy0mbll/L/dGRX
	85bVQWCj2MmMwSCpsbrBgZ1a3qj7AEarFnuZq4wEPjoJapQn+ZQ3XMWz1XA0hT06
	EZye+319Uyll2ANDyMJ0Si6ZI=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDHhCThq1Vqf2GzJg--.22706S2;
	Tue, 14 Jul 2026 11:24:17 +0800 (CST)
From: weimin xiong <xiongwm2026@163.com>
To: mst@redhat.com
Cc: jasowangio@gmail.com,
	david@redhat.com,
	virtualization@lists.linux.dev,
	xiongweimin <xiongweimin@kylinos.cn>
Subject: [PATCH] virtio_mem: fix typo in comment
Date: Tue, 14 Jul 2026 11:24:17 +0800
Message-ID: <20260714032417.201353-1-xiongwm2026@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHhCThq1Vqf2GzJg--.22706S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrWDWw4rKryDXF45KryDJrb_yoWfWFgEkr
	48X397tFn8WFn2kFWDArZ5uryYya18ZFykWan3t3yxX3y8ta1DGFZrWr4UGFy3Wr4xKFZx
	Ars5XrnYqw4SkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUeJDG5UUUUU==
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbCzQETompVq+HlfwAA3S

From: xiongweimin <xiongweimin@kylinos.cn>

Correct "actipn" to "action".

Signed-off-by: xiongweimin <xiongweimin@kylinos.cn>
---
 drivers/virtio/virtio_mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 11c441501..90d8ef0b9 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -1080,7 +1080,7 @@ static int virtio_mem_memory_notifier_cb(struct notifier_block *nb,
 		atomic64_sub(size, &vm->offline_size);
 		/*
 		 * Start adding more memory once we onlined half of our
-		 * threshold. Don't trigger if it's possibly due to our actipn
+		 * threshold. Don't trigger if it's possibly due to our action
 		 * (e.g., us adding memory which gets onlined immediately from
 		 * the core).
 		 */
-- 
2.43.0


No virus found
		Checked by Hillstone Network AntiVirus

