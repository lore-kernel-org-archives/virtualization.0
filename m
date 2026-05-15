Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0801F3A7F73
	for <virtualization@lists.linux.dev>; Fri, 15 May 2026 22:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778885811; cv=none; b=QIjBt08fVcIppMV4UoN/R9n5sL89xuOWoXONcXcEkC2ktvowfSkn/jZ1NnkemYUd6h9eRHFPpfZy/G7vT9Lh4KHpxoHtYxlnPDORSWIg/YRvupCTq601/yPkgBF55PtBxnjq/xs8U1kAt4YU+rAe/BKOk7UW+GCrF31nJicxvjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778885811; c=relaxed/simple;
	bh=rXwApuFN1SdxpBDQ2BXUqq0bmhkFOjR/Es1q6yrCnu8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hB/6MlXWy0DbXiXOruKE1YP1A62zxhWUbbOhJbdTohRfUzZ3F73Gjtwcut2ktK5Krrzc37+ZfPqDRyl8bt0Nq5TJk39sFWsux8eHfbA43LhF0LMcfQ+kXy/qvLtSd03abYNpltzyE0xSNTOA5hj5v6zcCaLjqmiXzehaFlIt+B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yh51GAfQ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yh51GAfQ"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2bd9c3b550aso2897645ad.2
        for <virtualization@lists.linux.dev>; Fri, 15 May 2026 15:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778885807; x=1779490607; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c8et1in+2rcZs0uws1Ukv+gI0DMN5vcCabd9NrHMTYY=;
        b=Yh51GAfQE11vsHUepZMfIxBvGLa1PN6Ug0fpEKEM87Cn0ron7cd5E1UZpf89E1yT8P
         6zLUDuJVwZX4ToS2vRAbWgDzq19eiIQE50hxKvlAThFtSiaWUbNfzITeav7ZMN8D0fX+
         Y90UwAqZZFlrGY1Ew51gaZKBWqlj1LfimKFxSR7bDSKnI2D930Us6QUPOX7yDYt1+gNZ
         XGpvLD4KXAC81UQ54/20QUxOj15xI3WmPomm2rzBiIoqjZRhikqe81bFtbG/wPO2FDo+
         PRDY+CRc+5VSY3QhxEiESiOiGTbXkfEuxn+KZdeHxZFLDmQ3hA2J01LA9sjUxB4Xnse+
         S64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778885807; x=1779490607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8et1in+2rcZs0uws1Ukv+gI0DMN5vcCabd9NrHMTYY=;
        b=ktsaAH8bn2j+6RdWA9xYb7ljvFnrENvD8YSWBahFmzwongMET/SGBqemsxYMDO74AE
         OMy1c/K9yVPRropQbiaifdgE1J7AMIxWtHjR2mLqN5aYTDZ9p4UxktJD1KvNBUkUpSdb
         AvRFDNN4H3jmBAdgF9p2CXH1xsySOZCV6Rt9LXTkdHlPx2EljIpHC3wulgE5quT3LsWl
         AghITrkWbbZ2sie99VOaFPrFs8AVfGvrq8bWqzc/dy1WGEAMQL0CI4I1ZwdNOdI7XGBu
         44wP81ZtT9nGtvQpM/PpbUuUnfzb5XgXC0yPOy7rfNfpUzZoiQsqtslZnV/lG/Br29Q/
         baaQ==
X-Gm-Message-State: AOJu0YxOrDfxU6Hf+WnFkx3vNEIQE91Hdu1avEq8nHzbhvh0eaOZ0TRp
	3Q6EHnG3/BDRxeNRvxiHe/QZtQVa2mOh+sne/NsCa08/CwSqA0i2ma3A
X-Gm-Gg: Acq92OHWEiVoqzDfKt45OzR0NycfWoGKug8MOWas0CLTkOhbXtPtnL0EaBjcsON+ZFS
	7ezwE3gLwF41mIRyBFkfhAxwDT/l06UMTfAMc+4GxnkMWpeMMGj5VJw0m4t0/tR+hqRBN1EyCr9
	+DrBkhrJ0CSzaHn0a4O2ytzpRD7gLJ5TXLEGOjc2iD3dK2b0h97NSIBx0p//Q8eJkOdNx0CVN4I
	ivqhfgVvlHV2MNKJQFdxPI01XnQCcVp5QAIFv5XPkvHf9GpL4/wwigifsRAteXaMMA5lkdbfn3d
	dJmkiLDcaH87RJ+lBG6IY80wn2I8qlNfvcEzo6EeOJhnlhI6DtSwm2Bl9MLQbQXXmr44uHhLPHL
	Sbq91Zj4KqiOfd40aHi8b1kSQhJ/p40HMRjsfq4P5hSidL8/YI/1j/y+stDWCVNUALvdPBbAHWa
	udUG//AUCBrH5IJmCPcb2i8Axw44ZC1vEOc55dPLEAG7hS/Ac8sHJ/tiKMSWcCf5dXFxrRcMJuE
	im50gYI4gfydp1/EqdOtJLHX2e8tKN6dKDTYw==
X-Received: by 2002:a17:903:983:b0:2bd:8395:fed8 with SMTP id d9443c01a7336-2bd83960609mr58212275ad.27.1778885807082;
        Fri, 15 May 2026 15:56:47 -0700 (PDT)
Received: from baver-zenith.localdomain ([124.49.88.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d0fcb10sm70438295ad.60.2026.05.15.15.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 15:56:46 -0700 (PDT)
From: Sungho Bae <baver.bae@gmail.com>
To: amit@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sungho Bae <baver.bae@lge.com>
Subject: [PATCH] virtio_console: fix race between hvc put_chars and virtqueue teardown on freeze
Date: Sat, 16 May 2026 07:52:59 +0900
Message-Id: <20260515225259.1054-1-baver.bae@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sungho Bae <baver.bae@lge.com>

With no_console_suspend enabled, hvc console output can continue while
virtio_console is freezing. In that window, put_chars can still enqueue
buffers to the output virtqueue while virtcons_freeze is tearing queues
down.

This races with virtqueue_detach_unused_buf_split, which expects all
descriptors to be reclaimed during teardown and can hit:

BUG_ON(vq->vq.num_free != vq->split.vring.num)

Root cause is concurrent virtqueue_add_outbuf activity from the console
TX path during freeze.

Add a pm_freezing flag in ports_device and set it at the beginning of
virtcons_freeze. Check the flag in put_chars and __send_to_port to drop
output while freeze is in progress, preventing new buffer enqueue before
vq teardown. Clear the flag on restore only after all port->out_vq
pointers have been reassigned to the newly allocated virtqueues, which
prevents a use-after-free window where TX paths could dereference
already-freed virtqueues.

Place the pm_freezing check inside outvq_lock in __send_to_port so that
it serializes with remove_port_data, which also takes outvq_lock during
freeze. This provides a formal guarantee: once remove_port_data returns
for a given port, no concurrent __send_to_port call can still be adding
buffers to the vq, eliminating the race window with remove_vqs.

Use smp_store_release/smp_load_acquire for the flag to guarantee correct
cross-CPU visibility on weakly ordered architectures.

Signed-off-by: Sungho Bae <baver.bae@lge.com>
---
 drivers/char/virtio_console.c | 46 +++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 9a33217c68d9..0fbe40a7f1e7 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -157,6 +157,12 @@ struct ports_device {
 
 	/* Major number for this device.  Ports will be created as minors. */
 	int chr_major;
+
+	/*
+	 * Set to true during PM freeze to block TX paths that may race
+	 * with virtqueue teardown (e.g. hvc put_chars with no_console_suspend).
+	 */
+	bool pm_freezing;
 };
 
 struct port_stats {
@@ -606,6 +612,20 @@ static ssize_t __send_to_port(struct port *port, struct scatterlist *sg,
 
 	spin_lock_irqsave(&port->outvq_lock, flags);
 
+	/*
+	 * Check freeze flag under the lock so that the flag check and
+	 * virtqueue_add_outbuf() are atomic with respect to
+	 * remove_port_data() which also takes outvq_lock.  This
+	 * guarantees that once remove_port_data() returns, no new
+	 * buffers can be added before remove_vqs() tears down the vq.
+	 * Pairs with smp_store_release() in virtcons_freeze/restore.
+	 */
+	if (!port->portdev ||
+	    smp_load_acquire(&port->portdev->pm_freezing)) { /* pairs with freeze/restore */
+		in_count = 0;
+		goto done;
+	}
+
 	reclaim_consumed_buffers(port);
 
 	err = virtqueue_add_outbuf(out_vq, sg, nents, data, GFP_ATOMIC);
@@ -1115,6 +1135,17 @@ static ssize_t put_chars(u32 vtermno, const u8 *buf, size_t count)
 	if (!port)
 		return -EPIPE;
 
+	/*
+	 * Silently drop output during freeze: the console is still active
+	 * with no_console_suspend but the virtqueues are being torn down.
+	 * This early check avoids a pointless GFP_ATOMIC allocation;
+	 * __send_to_port() rechecks under outvq_lock for correctness.
+	 * Pairs with smp_store_release() in virtcons_freeze/restore.
+	 */
+	if (!port->portdev ||
+	    smp_load_acquire(&port->portdev->pm_freezing)) /* pairs with freeze/restore */
+		return count;
+
 	data = kmemdup(buf, count, GFP_ATOMIC);
 	if (!data)
 		return -ENOMEM;
@@ -1972,6 +2003,7 @@ static int virtcons_probe(struct virtio_device *vdev)
 	/* Attach this portdev to this virtio_device, and vice-versa. */
 	portdev->vdev = vdev;
 	vdev->priv = portdev;
+	portdev->pm_freezing = false;
 
 	portdev->chr_major = register_chrdev(0, "virtio-portsdev",
 					     &portdev_fops);
@@ -2092,6 +2124,13 @@ static int virtcons_freeze(struct virtio_device *vdev)
 
 	portdev = vdev->priv;
 
+	/*
+	 * Block TX paths (put_chars, __send_to_port) before resetting the
+	 * device and tearing down virtqueues.  This prevents races with
+	 * hvc console writes that remain active under no_console_suspend.
+	 */
+	smp_store_release(&portdev->pm_freezing, true);
+
 	virtio_reset_device(vdev);
 
 	if (use_multiport(portdev))
@@ -2153,6 +2192,13 @@ static int virtcons_restore(struct virtio_device *vdev)
 		if (port->guest_connected)
 			send_control_msg(port, VIRTIO_CONSOLE_PORT_OPEN, 1);
 	}
+
+	/*
+	 * Allow TX paths only after all port->out_vq pointers have
+	 * been reassigned to the newly allocated virtqueues.
+	 */
+	smp_store_release(&portdev->pm_freezing, false);
+
 	return 0;
 }
 #endif
-- 
2.34.1

