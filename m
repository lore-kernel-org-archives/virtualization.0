Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09B03D0C0
	for <virtualization@lists.linux.dev>; Mon, 22 Jan 2024 11:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921672; cv=none; b=fBJ66JRswDr73dcaVbGoVfUB+UYMu4V0mJCKVlbFwjjLtDhosU6PKeEjvlMrRN3TgWHZHybtlGg1luUF2GPBwizvJqdjEpsbJimhhGB/mn7/7YO+FGFIRVKqwKNIqtesByRcWD9HEk0R/c4yCa+MPz6zpeD44Tb5v6v4kfAuvo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921672; c=relaxed/simple;
	bh=tEBM8ROgFnpAjPpGkQqFn+5G7qisAii32clsfbRevhI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eeTTwTYh1aNvwQ2gek6dXg0oiaOkrcdgV4NVjVtmSl9c5GZkrpA3j8QpriURlXpXYImHUTaLs9MOlr1j6AI4AGA3x4L+b5aTiFQd+EOs3JUjsKfxd5qlTSBKmdw67byBclV869/17vMVqcbfA5IWyukA0muaQq2wtSa5cI9o2EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 40MB7TmP062317;
	Mon, 22 Jan 2024 19:07:29 +0800 (+08)
	(envelope-from Yi.Sun@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TJS153t0qz2RcY8P;
	Mon, 22 Jan 2024 19:00:09 +0800 (CST)
Received: from tj10379pcu.spreadtrum.com (10.5.32.15) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 22 Jan 2024 19:07:27 +0800
From: Yi Sun <yi.sun@unisoc.com>
To: <axboe@kernel.dk>, <mst@redhat.com>, <jasowang@redhat.com>
CC: <xuanzhuo@linux.alibaba.com>, <pbonzini@redhat.com>, <stefanha@redhat.com>,
        <virtualization@lists.linux.dev>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.sun@unisoc.com>,
        <zhiguo.niu@unisoc.com>, <hongyu.jin@unisoc.com>,
        <sunyibuaa@gmail.com>
Subject: [PATCH 2/2] virtio-blk: Ensure no requests in virtqueues before deleting vqs.
Date: Mon, 22 Jan 2024 19:07:22 +0800
Message-ID: <20240122110722.690223-3-yi.sun@unisoc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240122110722.690223-1-yi.sun@unisoc.com>
References: <20240122110722.690223-1-yi.sun@unisoc.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 40MB7TmP062317

Ensure no remaining requests in virtqueues before resetting vdev and
deleting virtqueues. Otherwise these requests will never be completed.
It may cause the system to become unresponsive. So it is better to place
blk_mq_quiesce_queue() in front of virtio_reset_device().

Function blk_mq_quiesce_queue() can ensure that requests have become
in_flight status, but it cannot guarantee that requests have been
processed by the device. Virtqueues should never be deleted before
all requests become complete status.

New function blk_mq_tagset_wait_request_completed() ensure that all
requests in virtqueues become complete status.

Signed-off-by: Yi Sun <yi.sun@unisoc.com>
---
 drivers/block/virtio_blk.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 3b6b9abb8ce1..380f009953dd 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1595,14 +1595,16 @@ static int virtblk_freeze(struct virtio_device *vdev)
 {
 	struct virtio_blk *vblk = vdev->priv;
 
+	/* Ensure no requests in virtqueues before deleting vqs. */
+	blk_mq_quiesce_queue(vblk->disk->queue);
+	blk_mq_tagset_wait_request_completed(vblk->disk->queue->tag_set);
+
 	/* Ensure we don't receive any more interrupts */
 	virtio_reset_device(vdev);
 
 	/* Make sure no work handler is accessing the device. */
 	flush_work(&vblk->config_work);
 
-	blk_mq_quiesce_queue(vblk->disk->queue);
-
 	vdev->config->del_vqs(vdev);
 	kfree(vblk->vqs);
 
-- 
2.25.1

