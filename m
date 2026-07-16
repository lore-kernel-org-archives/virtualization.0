Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1589E22301
	for <virtualization@lists.linux.dev>; Thu, 16 Jul 2026 01:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784164353; cv=none; b=vDi8s8NF6FdvmIwvWxajZQaG1ikdGi8v6Xf58PLH3CXSZVdvOSSI42TLW17GndiZrsePG1bjZCn1YB/avCWg2MXbua7W3j+oiYxhDgJMcNziySTlragUew7vJ+/oYDzFlSg0ozxJfV4P+PRBLVDrDP+wJdDDFdYD52hd+96ZDc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784164353; c=relaxed/simple;
	bh=DfEGZLbpNr1Td3qpQBAX25KuI+JZVPWvBAyQ+7BrePo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CPaHW1NHKSlaBLPwlKiSAKr8RSxeM5fEhs8UBzoRE1HpNoRYZLE5jXpYazkeLcpnBV3WET+BoYmFsihKVFzr5uMeXg5kzQuu2ZvG5yKwjPROGwB4wVmrfv+ZMQiJla11FF4lyawjTK1/hSl8wkZdAlDoxRqgieWql93k9zS4Ft0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hy4mgGuP; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hy4mgGuP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Jk
	mJJ/Dw/np/7CC7VDLvi1PmKMKsv3Wcz6L1/cd1zu8=; b=hy4mgGuPsW16HAfs4h
	lwt3koyx4CO6LBx1uuL9pHaJhaIrI1FBWaJPYo1pj4HA+3INgYzb0EEJ6gjZyMMz
	lgo+76WdHtrPvulozOz77kBwxvVOIEVElpRuBMURB5iqw3I7v1Ven7u1GpuWdNaS
	/n2MBDVLP8u3sJholO66iJr7g=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgCHLyvdL1hqtD_uHQ--.48655S2;
	Thu, 16 Jul 2026 09:11:58 +0800 (CST)
From: Weimin Xiong <xiongwm2026@163.com>
To: virtualization@lists.linux.dev
Cc: netdev@vger.kernel.org,
	mst@redhat.com,
	jasowangio@gmail.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] virtio_net: fix spelling of aggressively in comments
Date: Thu, 16 Jul 2026 09:12:01 +0800
Message-ID: <20260716011201.86688-1-xiongwm2026@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgCHLyvdL1hqtD_uHQ--.48655S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFy3tFyDtrWUCF4UKFyxuFg_yoWkJFb_Jr
	yjqFn0gr45Ww1Ykw4UCa13ArZFyan0qay8WaySvrZxW3yDAry7GrZ2qr9rC3Zruw40yF13
	GwsFyF1UJ343WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUeF_MDUUUUU==
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbCzh6zQ2pYL94v-gAA3y

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

