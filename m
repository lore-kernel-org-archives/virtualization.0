Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA543AFD12
	for <virtualization@lists.linux.dev>; Tue, 19 May 2026 16:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779207785; cv=none; b=D2Xf81aWEr57vjWLNbaJnmCX56poP61WGYCaAhYhimVLDOPJHk3vFPyCeAB1NDa36WOuBX+Da33O7TqgphGnyBuxyApeG3i7rzcCS2yq5RmlYHkmcMM8zt/VgLIAcyEy/X0j+3D5Wp+pVln4EJC/8jKx2mdcVCGV+qsvZnkeVRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779207785; c=relaxed/simple;
	bh=w3QOsPE5ZjAYtM2vxu4mdIyDM5kHW57SYNfPY5zms/A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fojVHWNrFWiSxoGdZXkfLFwKq3GvWNOgLvybQ7AU+R6uDv9Wwur7sUmd9GB3ETWocNVMvZJoF62XFxXGpPxgIv+N9ijvYBMjfLkPXSOeAADDL1hHePn1ERr8++xr2ysjdY6e9OLUmuuDLVH1Xw1xwqJGU7Jb+LzbK/gCJnXUqrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6XP68A9; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6XP68A9"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ba6485d219so27141895ad.3
        for <virtualization@lists.linux.dev>; Tue, 19 May 2026 09:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779207784; x=1779812584; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=51w7Om4y2lO0Q4Rbj7UCOFh1Ody3dmx8GUaGuh6fciM=;
        b=C6XP68A9mEx31mm6/Q0KIcYdBKQgZYIpmMViyrG55N2Vs2GzwmOnGXvap2XR0eENsF
         DIp2SOiPg3/1P0tSxWBnPfeNE1J4rgQLrRVp6QyucjBdbPNfFpHbVVgHYs7MwZWZ2bQ+
         77phhr380AGPYrrbo9t2e1g/vIH5WSgd4twM7ZtACTER4hdGIX2nkDp2yvhDfgzkn835
         iEz7lAsGBPqAk+FP2gWrlQTSK0eaB+iw59IUjTaQsjNjqjz8hBo3x3YR1rwjY2jK02y1
         hMGdzsxG5lBbFxtHCw7wYT1OgXLTYBED863d66vBdMA9h5JvgCUvClPQBOSCy2UhBf4P
         U2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779207784; x=1779812584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=51w7Om4y2lO0Q4Rbj7UCOFh1Ody3dmx8GUaGuh6fciM=;
        b=YgR9/O4o9I7zErsvWP3He45pTopGk8sLg/I/8gPWM6wiN/MzaME09BELRV4dm0y3Nk
         fL5ZLRum8EPZDGi2FTBK8oLweNtkYE4BWBVpV6Kfb/IfhbdRYD5d4IF3qFQGzxmG1ezf
         7WcbdD+z94Kz4/c1QqkHTNb2lyosAG4R8ls2oA4EKsdvIY6cAmzKaaqqRCcJgie3fSdh
         b7bHswdOHuzJo+tbFF1br8qdd3vb+CVoqNTSNN4MefyzZ5Znxdw+O/x0V3TaQ87uSryp
         sVKLhhJGC7eONyMCcHFxGS1JAqyvrRVzCNRwMDuL7/UL/Nnop3o8ljRWLN34rJt1T9Sx
         rG1Q==
X-Gm-Message-State: AOJu0YzQT+/l3nZYh4QMRtQrgYhHGM+zQOEK2+VY05KhBB1prTEMGoeP
	6TNKXdqzOpnMu73UgEWJ2jCXG5Jdll1eufHm3+/jMYO3TBjYGjubjTUK
X-Gm-Gg: Acq92OHKMtG+1VUuWJSePCFBo+lgEMFp+lHdcBfrLyKOGuCfNfbHZ8ln/Mh4U1L8Eng
	YZ99OGbS9JOx7J432MtapZlB0ScR9e3ItdFcOe39IKV7mpLUJydDTECM/OvSZpQOdMcGG/yFzKv
	eIoibTmOeJ32bmgLwDnJ+9I6K8R4QW8NkxThGzJ/4jQNaSwTb2jeAGZ1V4QD70y1/XAblygNuMn
	N75J9xvhhNhQ4aNtteNHZ6VHacE2H03Jo7Cxpn1M2lBvEHna0QOzj0IHOD1Qzd9iw8ngmTL5MNz
	Mq9BCh7KArbnWxl3OSHUWQx1WcbKQpw+mWdBA2JfYWSh2FOz0rqs3cnpw954BON/mvDLaNEFKW2
	Yd7B8mETePz3JgXQmb4PeGjJ+7u4INRxKKbkUBV83he9u6MtANQkXEHYCWuRB8sznjPcjXAoF8u
	Y4mQkPHkrpNXMCXKLP0284XVdsRdARV5LJJ38+uAoT8eMkdEurZl7SHHsze2uNJhcAvdIEsBNzh
	MQdFkmWacnbre9XVBl/aVbAq9E=
X-Received: by 2002:a17:903:32c5:b0:2ba:bfc:7699 with SMTP id d9443c01a7336-2bd7e8ba6b9mr226985645ad.17.1779207783522;
        Tue, 19 May 2026 09:23:03 -0700 (PDT)
Received: from baver-zenith.localdomain ([124.49.88.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5ef27sm245009025ad.8.2026.05.19.09.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 09:23:02 -0700 (PDT)
From: Sungho Bae <baver.bae@gmail.com>
To: amit@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sungho Bae <baver.bae@lge.com>
Subject: [PATCH v2] virtio_console: fix race between hvc put_chars and virtqueue teardown on freeze
Date: Wed, 20 May 2026 01:22:42 +0900
Message-Id: <20260519162242.7324-1-baver.bae@gmail.com>
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
before calling virtio_reset_device(). A TX thread that already passed
the pm_freezing check may still hold outvq_lock while spinning for host
acknowledgment (the nonblock=false hvc path); the drain loop ensures
all such threads have completed before the device is reset.

Clear pm_freezing in virtcons_restore() only after all port->out_vq
pointers have been reassigned to the newly allocated virtqueues,
preventing TX paths from dereferencing freed vqs during restore.

Also fix two races in __send_to_port() uncovered by this work: load
port->portdev via READ_ONCE() and check for NULL to guard against
concurrent hot-unplug, and move out_vq = port->out_vq inside
outvq_lock after the pm_freezing check to avoid a stale pointer.

Link: https://sashiko.dev/#/patchset/20260515225259.1054-1-baver.bae%40gmail.com
Signed-off-by: Sungho Bae <baver.bae@lge.com>
---
 drivers/char/virtio_console.c | 80 ++++++++++++++++++++++++++++++++++-
 1 file changed, 78 insertions(+), 2 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 9a33217c68d9..fad673f733a8 100644
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
@@ -601,11 +607,30 @@ static ssize_t __send_to_port(struct port *port, struct scatterlist *sg,
 	int err;
 	unsigned long flags;
 	unsigned int len;
-
-	out_vq = port->out_vq;
+	struct ports_device *portdev;
 
 	spin_lock_irqsave(&port->outvq_lock, flags);
 
+	portdev = READ_ONCE(port->portdev);
+
+	if (!portdev) {
+		in_count = 0;
+		goto done;
+	}
+
+	/*
+	 * Check freeze flag under the lock so that the flag check and
+	 * virtqueue_add_outbuf() are atomic with respect to
+	 * remove_port_data() which also takes outvq_lock.  This
+	 * guarantees that once remove_port_data() returns, no new
+	 * buffers can be added before remove_vqs() tears down the vq.
+	 * Pairs with smp_store_release() in virtcons_freeze/restore.
+	 */
+	if (smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
+		goto done;
+
+	out_vq = port->out_vq;
+
 	reclaim_consumed_buffers(port);
 
 	err = virtqueue_add_outbuf(out_vq, sg, nents, data, GFP_ATOMIC);
@@ -1110,11 +1135,36 @@ static ssize_t put_chars(u32 vtermno, const u8 *buf, size_t count)
 	struct scatterlist sg[1];
 	void *data;
 	int ret;
+	struct ports_device *portdev;
 
 	port = find_port_by_vtermno(vtermno);
 	if (!port)
 		return -EPIPE;
 
+	/*
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
+	 */
+	portdev = READ_ONCE(port->portdev);
+	if (!portdev ||
+	    smp_load_acquire(&portdev->pm_freezing)) /* pairs with freeze/restore */
+		return count;
+
 	data = kmemdup(buf, count, GFP_ATOMIC);
 	if (!data)
 		return -ENOMEM;
@@ -1972,6 +2022,7 @@ static int virtcons_probe(struct virtio_device *vdev)
 	/* Attach this portdev to this virtio_device, and vice-versa. */
 	portdev->vdev = vdev;
 	vdev->priv = portdev;
+	portdev->pm_freezing = false;
 
 	portdev->chr_major = register_chrdev(0, "virtio-portsdev",
 					     &portdev_fops);
@@ -2092,6 +2143,24 @@ static int virtcons_freeze(struct virtio_device *vdev)
 
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
+	list_for_each_entry(port, &portdev->ports, list) {
+		spin_lock_irq(&port->outvq_lock);
+		spin_unlock_irq(&port->outvq_lock);
+	}
+
 	virtio_reset_device(vdev);
 
 	if (use_multiport(portdev))
@@ -2153,6 +2222,13 @@ static int virtcons_restore(struct virtio_device *vdev)
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
2.43.0

