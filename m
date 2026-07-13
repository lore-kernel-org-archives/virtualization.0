Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018BF423A83
	for <virtualization@lists.linux.dev>; Mon, 13 Jul 2026 13:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948836; cv=none; b=VmWQzrckaODlSaI5j0vxNXtFoB3SIySK8TmvYf/y/ELD5kPsVA0ucHKh6n2y+O2up55nyh9gZF8bMQnr6nQu0R16gUndBVTYxr5eOAiQ488qTjn5sYywxgJEiA9kxkfInZ83/FXDm53LJ/59HmHkMh70fV/igrOcdlIM+assxig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948836; c=relaxed/simple;
	bh=sS0NV+DCdf1wM8DjuTL0fqn6+Kf8H65P77cwAI7hQgc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UWmqSfZD+y7Qw3h32a2tb9+UFKUj+fZrzH14tN6YA8vfa5+rD6Viq2SrvzIHm9z/f5I56rUbbad3ABi2kx548uWnMS8x1cG0/qzwaKHzd5ZJCnJgaJbDmvLw7a28vxAHoasdWLvahWnRW4rf2E8py4UN2xbZ3nGrsV02/GS4agg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=K4N0Z81M; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="K4N0Z81M"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=5455PrQ1mNoW2SXlRBrvYw7w8WZX03KznqLwbqC3/4U=;
	b=K4N0Z81M0Z5KaUqDKWGfs8/mXSBtsTU3yt9NDqiQBzhruJE7dYXcUBAeraW/v2wxoHoNAsZKD
	XMURvmwjQgFErR9gicVUEuurOQLSTY8JOcXAaP9hGH7mCzTCvdKyh/ubsaxbMJEkNV2Nyw1rANn
	rc3tz1i8+i5hRgTC6CiFPP8=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4gzNB32BdHzpSvH;
	Mon, 13 Jul 2026 21:11:39 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 9F73140561;
	Mon, 13 Jul 2026 21:20:28 +0800 (CST)
Received: from huawei.com (10.50.163.32) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 13 Jul
 2026 21:20:27 +0800
From: Jinqian Yang <yangjinqian1@huawei.com>
To: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <liuyonglong@huawei.com>,
	<wangzhou1@hisilicon.com>, <linuxarm@huawei.com>, Jinqian Yang
	<yangjinqian1@huawei.com>
Subject: [PATCH] virtio_net: fix infinite loop in virtnet_poll_cleantx when device is broken
Date: Mon, 13 Jul 2026 21:20:25 +0800
Message-ID: <20260713132025.703147-1-yangjinqian1@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500013.china.huawei.com (7.185.36.188)

virtnet_poll_cleantx() contains a do-while loop that cleans up
transmitted TX buffers and calls virtqueue_enable_cb_delayed() to check
whether more buffers need processing. When the virtio backend stops
responding during guest reboot, used->idx is never updated, so
virtqueue_enable_cb_delayed() always returns false and the loop never
terminates. Then it will block reboot process, and the guest will hang.

The problem occurs during guest reboot under network traffic:

  1. kernel_restart() -> device_shutdown() traverses the device list
  2. virtio_dev_shutdown() calls virtio_break_device() which sets
     vq->broken = true
  3. virtio_dev_shutdown() then calls virtio_synchronize_cbs() to wait
     for in-flight callbacks to complete
  4. A virtio interrupt fires, softirq is deferred to ksoftirqd which
     calls net_rx_action() -> virtnet_poll() -> virtnet_poll_cleantx()
  5. virtnet_poll_cleantx() enters the do-while loop and never exits
     because the QEMU backend has stopped updating used->idx, despite
     vq->broken having been set to true in step 2.

Since the loop runs inside ksoftirqd (a SCHED_OTHER kthread), it is
visible to the scheduler and does not trigger a hard lockup. However,
the kthread never leaves the loop, so RCU detects it as a CPU stall
and reports it periodically. Meanwhile, the reboot process remains
blocked in device_shutdown() because virtio_dev_shutdown() cannot
complete its synchronization step, and the guest hangs permanently.

This can be reproduced on a guest with a virtio-net device: run iperf3
traffic in the guest, then trigger reboot. The reboot occasionally hangs
permanently with RCU stall on ksoftirqd.

Observed on ARM64 KVM guest:

  CPU#1 RCU stall (ksoftirqd/1), repeated periodically:
    virtqueue_enable_cb_delayed_split <- virtnet_poll <- __napi_poll <-
    net_rx_action <- handle_softirqs <- run_ksoftirqd <-
    smpboot_thread_fn <- kthread

Fix by adding a virtqueue_is_broken() check to the loop condition, so
that the loop exits immediately when the device is broken, allowing
the device shutdown to proceed.

Signed-off-by: Jinqian Yang <yangjinqian1@huawei.com>
---
 drivers/net/virtio_net.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7d2eeb9b1226..c8d2d420c31d 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2970,7 +2970,8 @@ static void virtnet_poll_cleantx(struct receive_queue *rq, int budget)
 		do {
 			virtqueue_disable_cb(sq->vq);
 			free_old_xmit(sq, txq, !!budget);
-		} while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
+		} while (!virtqueue_is_broken(sq->vq) &&
+			 unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
 
 		if (sq->vq->num_free >= MAX_SKB_FRAGS + 2)
 			virtnet_tx_wake_queue(vi, sq);
-- 
2.33.0

