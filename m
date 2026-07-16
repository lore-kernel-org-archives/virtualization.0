Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2C73783BB
	for <virtualization@lists.linux.dev>; Thu, 16 Jul 2026 03:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784173931; cv=none; b=RBCcoScPdJ2bU8oIUZ5K718W2DaxqsTnHioO2L7mRwzwCV7Zd7EA+QD+Pp2raBOvjj9d2Xty1p4IMCinwX+H3y5aE14+WhLkFRFPA5Cfrz2mm+cAfKlfZIjFvxqPj2dEgNUdylpMIrUWG7lnqIgYUBgGqJ4o8AHcqKtmSePrdRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784173931; c=relaxed/simple;
	bh=No0z5O6QZXB+qmLpuRHUDHNeG8iaRsJvP+WoLxlq1fc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=byn6Arp5yyDv8zmmhOPNaHMfUkvDmvtXcCHb8S0NcQoOvJPMb2SzxOg+CEBkk/BehrexB9dTUsaOP/yG6vK2FcjDrVU0RXPmY3Zy+Wfp8g2UBlfEYSdAY5QuZSLjIzl/1LMH/Rc7UI6UqlCRDNK03bNY8cPG6E6HZqAAvDUqw3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Bxu5qc5l; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Bxu5qc5l"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=yRvdsnV1PeGfljFy+4kRqeiSeYYE4q4nVsCbMZUG6c0=;
	b=Bxu5qc5l9TSCmi10oU+HcQQ06ZfDm+jN+hwn8Mk1BMJSUXVyv+TA9/CrX3mMchwx8J7Awkb6F
	h1FbZDaJQu80ySQIDErB4I3d1vxPBaowqx2kr2PGIkAP5/ExcIVemyj1UxQcQy4tQYIuxDH66CI
	VRf1vF4UXzaf9p2fBUhXxK8=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4h0zQG4CWTz1K96s;
	Thu, 16 Jul 2026 11:42:46 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 35C004048B;
	Thu, 16 Jul 2026 11:52:04 +0800 (CST)
Received: from huawei.com (10.50.163.32) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 16 Jul
 2026 11:52:03 +0800
From: Jinqian Yang <yangjinqian1@huawei.com>
To: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <liuyonglong@huawei.com>,
	<wangzhou1@hisilicon.com>, <linuxarm@huawei.com>, Jinqian Yang
	<yangjinqian1@huawei.com>
Subject: [PATCH v2] virtio_net: fix infinite loop in virtnet_poll_cleantx when device is broken
Date: Thu, 16 Jul 2026 11:52:01 +0800
Message-ID: <20260716035201.3736582-1-yangjinqian1@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
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
Changes in v2:
  - Moved vq->broken check to virtqueue_enable_cb_delayed().

v1: https://lore.kernel.org/lkml/20260713132025.703147-1-yangjinqian1@huawei.com/
---
 drivers/virtio/virtio_ring.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index b438dc2ce1b8..5c169fbb418a 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -3233,6 +3233,14 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
+	/*
+	 * When the device is broken there is no point in polling used->idx,
+	 * the backend will never update it. Return true to let callers
+	 * exit their cleanup loops instead of spinning forever.
+	 */
+	if (unlikely(vq->broken))
+		return true;
+
 	if (vq->event_triggered)
 		data_race(vq->event_triggered = false);
 
-- 
2.33.0

