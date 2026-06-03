Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE553F58EB
	for <virtualization@lists.linux.dev>; Wed,  3 Jun 2026 18:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780511971; cv=none; b=NZgIHvmr2C526iqd6gMmJucMuqn0OixkDXkbz9cf95KGGYPgSsY5Kf+p135Uxe18Np+zGhJh0ZuRjctSyehGEFb3kuBF1/+trSSOUj6MCTuzfS/OkoC1h7/9NR8xJ3aAkCwQlNzpTDv+mfQKqfzmZId1AqRSuL4VNqnpFKSJHnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780511971; c=relaxed/simple;
	bh=7d4lMqqrbpJJIwoCTXJC6TYfhKhdaokzHydcQwcGZ/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f3v6iuhb3VmryOT1xggySZYIeUd8f7QUKNR+gzM8W1yzUlXNsarfTe4bJtPUj6sFm9TgYKQIiASEE2VynukPsI9ctW3WkU6+30A/9qutWZ+mzhP9B+ccN5ALDDIYKxAz+Tu6CJQyWRyrz/a1m59AUgyTEbJKgbgNZQxiRkA8X7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNRwETh+; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNRwETh+"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c0c1e0b0faso29965125ad.0
        for <virtualization@lists.linux.dev>; Wed, 03 Jun 2026 11:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780511964; x=1781116764; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKSalDeTQ1VPYG6bsCXmGDB4+O5WiYaFZrQlNoC7oEY=;
        b=DNRwETh+SA1tpMgL2l+fHIP4RiulccnRslMUDPLhggLSeY7m0tPIiTa12m8yvRz2mr
         xGcL+GYFELxJxnUZQBh5WWY+Kz90PTa0joFetMJwwzzAJ0hkJq6sN4tKKyWQOHf7myB7
         FhInCHucSSh5Jh0hPYd4S5gHJpQHyfTALgSyhJhGlaUyFv+ucJVrC7ueOnxh1PLJCOCJ
         9owFe5tzGDBOZO+quy+2j5suJFsgKpBvqiHgDzOyqTbO/1bz/qkRlVuEB3fRlb18pFiP
         IJAMa0i/zedtt6p+NyHRqzU0tULzQLfMUrTfdujKx7HZyPMAYxsbR3iOprvbjJQwb4Yz
         kYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780511964; x=1781116764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FKSalDeTQ1VPYG6bsCXmGDB4+O5WiYaFZrQlNoC7oEY=;
        b=hGyEY8Wbx1Bk7djNLwi7uumrmRPynvN6BByIlKpwaAjFWArWJ7fnt8rTQsYLnpeL0U
         oNxhNDJHwQBn4v6YDzhw1JHEaG3dLRtbiK0+AiqzusM2DDd9LnrzGSVft8ufJiF6ZLPk
         FzIOMjvMBpH3ZahU+tMRPhTY2rNbfcrFhyzhthmLsikve7tgxukdRaZsONDb4ikoIzw6
         YQP0RJ9Fim3jcvH8h7tt6rwmNQ4GZACsu9fDnltYRpuXJeb2SXNFwHo+kSoAhM46EdsP
         +Wt9wJCvv7LBjo/ItEU8ZoM1PlGtKWU0AL1PdRZQn8TRLCFyY87nymyI0X7jmA2q8skb
         BLWA==
X-Gm-Message-State: AOJu0YwXLQWaUQ1b2bWP/URuYLYQ/Zg5ZWsCHBkBAJvC9xntxTVPI18d
	RgrkDzDJ2aikr5aObpDjp4JhI+gJn/B51g1IoFYBpfY9cIRc2WkZouYW
X-Gm-Gg: Acq92OE/5owRW5HgaSG68paWpO36HVAl7V2Wpi6NUglDq45RIunJzYdb+AhuWKQpYkb
	NEL+CHfWM920RNWG0nTn+xN5lPPI5S0ZYJ1Qlud4j9dhxz+MSa6ESE4eqlbBXSSTYzd2w6H0/27
	nBvA9H4PBAOuAv8FCNk8kVz2tMWNjGfpErV0P2xlbKOWofguyQOFkJLjFsR4Zyapq8MVEg6SOB7
	ypnjDWPSwJQIQyvV4SLBf6xYNXWxiO+CtHR26m8se8Wady1UowPr5J96dyR3YX/CgIvJzVqdWsz
	tX+mHmVm6Tk/nFEfO1ix1GuL48vGIcntdQk4PNCIHeLocY/Pplb2piBB7ruCovfhlGqriyZ/9FB
	NUZZW3gKIYY5h5sJvrRUPYT4gsMnwTrJRXdew4kl8VRAcd0JhMy4AXTIPYNfpAO6072wpDAPOQx
	GwNT5qH6zLdoYULJ4/dEd8uNt3nTIq4iRZDa8KMss33wwODu76h2Me1vQypuuGakeyU2YrYCYRQ
	jSct+bnOCAsmC+2bhYr7j5FfEBn1iIAON9WbA==
X-Received: by 2002:a17:903:1a83:b0:2b7:aa20:3c61 with SMTP id d9443c01a7336-2c1644b08c7mr48300865ad.33.1780511964056;
        Wed, 03 Jun 2026 11:39:24 -0700 (PDT)
Received: from baver-zenith.localdomain ([124.49.88.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16649c01asm32764915ad.74.2026.06.03.11.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 11:39:22 -0700 (PDT)
From: Sungho Bae <baver.bae@gmail.com>
To: amit@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sungho Bae <baver.bae@lge.com>
Subject: [PATCH v3 4/4] virtio_console: fix race between hvc put_chars and virtqueue teardown on freeze
Date: Thu,  4 Jun 2026 03:37:57 +0900
Message-Id: <20260603183757.21587-5-baver.bae@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260603183757.21587-1-baver.bae@gmail.com>
References: <20260603183757.21587-1-baver.bae@gmail.com>
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
down, triggering a BUG_ON in virtqueue_detach_unused_buf_split:

  BUG_ON(vq->vq.num_free != vq->split.vring.num)

Add a pm_freezing flag to ports_device. Set it via smp_store_release()
at the start of virtcons_freeze(); put_chars() and __send_to_port() drop
output while the flag is set, checked via smp_load_acquire().

The check in __send_to_port() is placed under outvq_lock, making it
atomic with remove_port_data() which also acquires outvq_lock. Once
remove_port_data() returns for a given port, no concurrent
__send_to_port() can add buffers before remove_vqs() tears down the vq.

After setting pm_freezing, acquire and release outvq_lock for each port
(protected by ports_lock to prevent list manipulation races) before
calling virtio_reset_device(). A TX thread that already passed the
pm_freezing check may still hold outvq_lock while spinning for host
acknowledgment; the drain loop ensures all such threads have completed
before the device is reset.

Clear pm_freezing in virtcons_restore() only after all port->out_vq
pointers have been reassigned to the newly allocated virtqueues,
preventing TX paths from dereferencing freed vqs during restore.

Link: https://sashiko.dev/#/patchset/20260519162242.7324-1-baver.bae%40gmail.com
Signed-off-by: Sungho Bae <baver.bae@lge.com>
---
 drivers/char/virtio_console.c | 70 ++++++++++++++++++++++++++++++++---
 1 file changed, 64 insertions(+), 6 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index dd31f7069e19..482d57a311c6 100644
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
@@ -611,6 +617,17 @@ static ssize_t __send_to_port(struct port *port, struct scatterlist *sg,
 		goto free_and_done;
 	}
 
+	/*
+	 * Check freeze flag under the lock so that the flag check and
+	 * virtqueue_add_outbuf() are atomic with respect to
+	 * remove_port_data() which also takes outvq_lock.  This
+	 * guarantees that once remove_port_data() returns, no new
+	 * buffers can be added before remove_vqs() tears down the vq.
+	 * Pairs with smp_store_release() in virtcons_freeze/restore.
+	 */
+	if (smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
+		goto free_and_done;
+
 	out_vq = port->out_vq;
 
 	reclaim_consumed_buffers(port);
@@ -1125,14 +1142,27 @@ static ssize_t put_chars(u32 vtermno, const u8 *buf, size_t count)
 		return -EPIPE;
 
 	/*
-	 * Silently drop output if device hot-unplug is in progress.
-	 * portdev was NULLed by unplug_port() after hvc_remove() was
-	 * already called, so the hvc layer will stop invoking put_chars()
-	 * very soon. Returning count avoids a pointless retry loop in the
-	 * interim.
+	 * Silently drop output in two cases, both by returning count so
+	 * that the hvc layer does not spin-retry:
+	 *
+	 *  1. Device hot-unplug (!portdev): portdev was NULLed by
+	 *     unplug_port() after hvc_remove() was already called, so
+	 *     the hvc layer will stop invoking put_chars() very soon.
+	 *     Returning count avoids a pointless retry loop in the
+	 *     interim.
+	 *
+	 *  2. PM freeze (pm_freezing): the hvc console stays active
+	 *     under no_console_suspend but virtqueues are being torn
+	 *     down.  Drop the output silently so the hvc layer does not
+	 *     stall suspend.
+	 *
+	 * This early check avoids a pointless GFP_ATOMIC allocation;
+	 * __send_to_port() rechecks under outvq_lock for correctness.
+	 * Pairs with smp_store_release() in virtcons_freeze/restore.
 	 */
 	portdev = READ_ONCE(port->portdev);
-	if (!portdev)
+	if (!portdev ||
+	    smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
 		return count;
 
 	pbuf = alloc_buf(portdev->vdev, count, 0, GFP_ATOMIC);
@@ -2002,6 +2032,7 @@ static int virtcons_probe(struct virtio_device *vdev)
 	/* Attach this portdev to this virtio_device, and vice-versa. */
 	portdev->vdev = vdev;
 	vdev->priv = portdev;
+	portdev->pm_freezing = false;
 
 	portdev->chr_major = register_chrdev(0, "virtio-portsdev",
 					     &portdev_fops);
@@ -2119,9 +2150,30 @@ static int virtcons_freeze(struct virtio_device *vdev)
 {
 	struct ports_device *portdev;
 	struct port *port;
+	unsigned long flags;
 
 	portdev = vdev->priv;
 
+	/*
+	 * Block TX paths (put_chars, __send_to_port) before resetting the
+	 * device and tearing down virtqueues.  This prevents races with
+	 * hvc console writes that remain active under no_console_suspend.
+	 */
+	smp_store_release(&portdev->pm_freezing, true);
+
+	/*
+	 * Synchronize with any concurrent __send_to_port() that may have
+	 * passed the pm_freezing check. By acquiring and releasing the
+	 * outvq_lock for each port, we ensure all active TX paths have
+	 * completed before we reset the device.
+	 */
+	spin_lock_irqsave(&portdev->ports_lock, flags);
+	list_for_each_entry(port, &portdev->ports, list) {
+		spin_lock(&port->outvq_lock);
+		spin_unlock(&port->outvq_lock);
+	}
+	spin_unlock_irqrestore(&portdev->ports_lock, flags);
+
 	virtio_reset_device(vdev);
 
 	if (use_multiport(portdev))
@@ -2192,6 +2244,12 @@ static int virtcons_restore(struct virtio_device *vdev)
 	if (use_multiport(portdev))
 		fill_queue(portdev->c_ivq, &portdev->c_ivq_lock);
 
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

