Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A04364EA4
	for <virtualization@lists.linux.dev>; Tue, 14 Jul 2026 02:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783996860; cv=none; b=N1In1oQ0IZg/scunSLlbx5FWbWgedQEki860jTW2J9WziLOoVnrqr7/pZjogav081hKYKVWIapg6T0YYjQHK5eb97M3ZiUHFmx7vCodICcl8zWGFRhMMrbZB7L+Bqfedwdbe6yvMqSiKJ0RwSqrKjCMt+pDO5lZVkMmruAOe83w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783996860; c=relaxed/simple;
	bh=xKPEW6AchvNv/x4LMiHOziyGKpV+Hj0p2OP83HlUF1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JyLYzv9pPbhSSFq0x1nsQKX7BQmo5K3PVDx8oTgzXbgsASTSV0095IFbfqSwPyYxduQpFwukLd6+pnh4xpSAzRSMryWRmDBtQo1CL3ngC3pTsA1SukX6KL7N+LkMNImrTPwbdGvGEuIPDKqhTPBf1P54MBw3xGgT04RigqF81wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CJmS5e3b; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CJmS5e3b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Tw
	WIFxfUs9S/uyj7vyCnE0UomkAQzXHUdY6cYZyxCRs=; b=CJmS5e3b8rYw8/d0SV
	gEOPSugKtOO7p/5nD8AsdIPkghfLxR0IsOeJY2GSenCx/JCrdHdvd0UVFRdLehvH
	o7OBBMgSaMR48IY6I/Z+j2NjFxr2bRcJ+kumfrpEsX/IIWUeIJuRkusj/E9vvGvX
	cvfNZaJiqGELKTR52lXTtQTn4=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wBnghqloVVqqbA+IQ--.54906S2;
	Tue, 14 Jul 2026 10:40:41 +0800 (CST)
From: weimin xiong <15927021679@163.com>
To: netdev@vger.kernel.org
Cc: mst@redhat.com,
	jasowangio@gmail.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	xiongweimin <xiongweimin@kylinos.cn>
Subject: [PATCH] virtio_net: fix spelling of aggressively in comments
Date: Tue, 14 Jul 2026 10:40:37 +0800
Message-ID: <20260714024037.186799-1-15927021679@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnghqloVVqqbA+IQ--.54906S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFy3tFyDtrWUCF4UKFyxuFg_yoWkCrb_J3
	40qr90gr45W3WY9w4UCay3ArW2kan0qay8WaySvrZxW3ykArW7GrZ2gr9rC3Zruw40yFnx
	GwsFyF1UA3sxWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8LiSJUUUUU==
X-CM-SenderInfo: jprvmjixqsilmxzbiqqrwthudrp/xtbC9AmCC2pVoam1LQAA3b

From: xiongweimin <xiongweimin@kylinos.cn>

Two receive-path comments misspell "aggressively" as "agressively".

Signed-off-by: xiongweimin <xiongweimin@kylinos.cn>
---
 drivers/net/virtio_net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 3e2a5876c..f3c7b28ce 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3190,7 +3190,7 @@ static int virtnet_open(struct net_device *dev)
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		if (i < vi->curr_queue_pairs)
-			/* Pre-fill rq agressively, to make sure we are ready to
+			/* Pre-fill rq aggressively, to make sure we are ready to
 			 * get packets immediately.
 			 */
 			try_fill_recv(vi, &vi->rq[i], GFP_KERNEL);
@@ -3419,7 +3419,7 @@ static void virtnet_rx_resume(struct virtnet_info *vi,
 			      bool refill)
 {
 	if (netif_running(vi->dev)) {
-		/* Pre-fill rq agressively, to make sure we are ready to get
+		/* Pre-fill rq aggressively, to make sure we are ready to get
 		 * packets immediately.
 		 */
 		if (refill)
-- 
2.43.0


No virus found
		Checked by Hillstone Network AntiVirus

