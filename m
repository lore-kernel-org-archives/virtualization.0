Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D02307AF4
	for <virtualization@lists.linux.dev>; Mon, 15 Jun 2026 09:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781516784; cv=none; b=pVZayVl8LuGmgjGugbXNkphwCRVMTU4ZfZmEZqhHLjRwJe5IQZA9/M19fIfjSKSIXgzrNf5+KvU6ivH6Yy2Rn9zj09UwDQjj/rc5wHZKj5KqdT0lO09dHtZdXmwNgOCYq65l1GFlPCsDuJNRnXejYBFmgx2utQJ1Ye0DjwWN/Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781516784; c=relaxed/simple;
	bh=t7l4ST9Oa1w7R2vqzUpCJ5KymjLNpAvs+tAnvsAy2MU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pf3Eja/7sCIzDH69GZF209RgNdz+qiNlk/b+/dhrtblXH5aIjYWMGYP3Dx+R2OVCmFLWnkRyJyIDHVCJ3wm3GF2dWRBgnqqaUu4Aaeho2yGr4/rEk2RiYiqI1zvHUcFxYA91UOG9oxUXF3A1s7j6ATkL3QgYrFl2t7527Aee60M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=H/4vCSUN; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="H/4vCSUN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Tw
	wRWViP38hGNPgWuPDTjmAzgremo60KsQvfDkSH1v4=; b=H/4vCSUNCr1bh/YDOC
	GplX6GO/JCBauZJCirbCkN2DaV9BeH+/eAakDdks0KUqypyjEoW2M0j03iicl/AE
	e59cSbSGhJT1jD/9BvVU6uWOT0EdIFUpwhGEvI+3zgfJfwNfCGr2Ffpi73gXWz+h
	sUFROotVRAGeBCofcg+1THpLI=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wCXwpXPyS9qmc4ZDg--.9487S2;
	Mon, 15 Jun 2026 17:45:51 +0800 (CST)
From: Longjun Tang <lange_tang@163.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: edumazet@google.com,
	kuba@kernel.org,
	xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev,
	lange_tang@163.com,
	tanglongjun@kylinos.cn
Subject: [PATCH] virtio_net: disable cb when napi_schedule_prep fails during busy-poll
Date: Mon, 15 Jun 2026 17:45:50 +0800
Message-Id: <20260615094550.106391-1-lange_tang@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXwpXPyS9qmc4ZDg--.9487S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrurWfXFW8Jw17ur45WFyrCrg_yoWDurg_Cw
	12gr4fGry5CFsYk3y7Wr45XrySka40gFyvgFnayryrt34UX345Xr4kZF18tFy3Gw4kZF1f
	G3srXF1UAr93ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRZtxh3UUUUU==
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/xtbC4Q8MOmovyc-ubgAA3b

From: Longjun Tang <tanglongjun@kylinos.cn>

When busy-poll is active, napi_schedule_prep() returns false in
skb_recv_done(), so virtqueue_disable_cb() is skipped. The device
may keep firing irqs until the next poll round reaches
virtqueue_napi_complete(). If cb is enabled under busy-poll case,
it will lead to a large number of spurious interrupts. Explicitly
disable callbacks in this case to prevent spurious interrupts.

Signed-off-by: Longjun Tang <tanglongjun@kylinos.cn>
---
 drivers/net/virtio_net.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index f4adcfee7a80..6d675fddc59b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -728,6 +728,8 @@ static void virtqueue_napi_schedule(struct napi_struct *napi,
 	if (napi_schedule_prep(napi)) {
 		virtqueue_disable_cb(vq);
 		__napi_schedule(napi);
+	} else if (test_bit(NAPI_STATE_IN_BUSY_POLL, &napi->state)) {
+		virtqueue_disable_cb(vq);
 	}
 }
 
-- 
2.25.1

