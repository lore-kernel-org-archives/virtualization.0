Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D54B44CF4A
	for <virtualization@lists.linux.dev>; Thu,  6 Aug 2026 15:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786028635; cv=none; b=n4eMlvNPfR7AXLgWVVOs15e4Vurlq3xuJyIcqrUkTw6qVN0cGyyUXisfnPE7FHRS7Kzm9FQVjPpirHDemXuc53aC4fsP5mqZnRNewsR1LKNSDSzBmcWlom6Lma17xIu1zIZeK87vrgpOAj+MsneHqzM5C3DS0MxjelrQYDV95kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786028635; c=relaxed/simple;
	bh=cYbc1CQoQc5pfYhgLv/MYSip5jRcSrSImN64FkQfEWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kifswnt18XzTgPnk+4qkHMz3xzVdB/zAQSfAFFwbaJTaJckC/pu0pRLkJkn7P5JsBKXol2Z1+w9cWRICCIYUhLDWpmZeIMK/f4X5lWY+63Wdxv+LsyBl2slIMS0hW87b/9NfHNPsotFj0nIQI6FnHUJLFpuayRBQmLG63wrcedY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3dOxaGL; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3dOxaGL"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8453427d3f4so2713733b3a.3
        for <virtualization@lists.linux.dev>; Thu, 06 Aug 2026 08:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786028634; x=1786633434; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uJS+V1CTVjT7mHslf1lQhCi1CZlnPDrIe8kNgbgFr+I=;
        b=O3dOxaGLhvBwAbUlPH7Zy7x2Ypj4WuZO6GVMRShci2lQd3+IHl+7qc1T8rcfNwk5R4
         VjFuNbcwlWDDqRnCr9rr6QhxpysyIu/CnIG1f7AYBPY96MpEm/S2mabsN/hRuL+N3Qqr
         P7Ec4WQKwdg1k81JOxLI8Lnx1CsL9STdcThBGrgQEDmgCEGaO7zYcpLnFF/WuYY82Y9k
         eLnGv9FvlDLFbp62SkQVW5z0+cAYbfczzzYp82IcPBI4HvvrBcLaiqUiANUuqlgSrfYc
         6yA5MlDIwIpF0sOkZjEbFVIxqNnwxSoDDkevI4hX8HG6lJ6UHoeU1rSypi7rHy8S0ll8
         WM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786028634; x=1786633434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uJS+V1CTVjT7mHslf1lQhCi1CZlnPDrIe8kNgbgFr+I=;
        b=HLzot9t18frF/4mrZ/JKvrJiCllvCopjWCrPCdF32OeBmYZX1Keggk4cSHKSq8saAT
         BuLDW4S0i3qgmuqmLleyrTCGdS55IXzqQnO6hn8G+hwnDaXh5di+9cHy6tMvT/sl96qJ
         t9dcNx7tIJNo/sr1n/jTlDSlfv9O9Ok67P0TBAmDhFw1qq8Qz56p8KHVNJfn7BDj9mLF
         Jc43A0nv9yVAlWPtGAqNJEr5D7+oMOV4ndM8k78YpZjfZuhlR+Vno3h2CUVHerXllph6
         waNls1Yzw5+nguXbUhwrcauea6V+w4KLk/LBE9h3pY0o/i8Zz27w3DGuyGyuJW/rwtLu
         Uygg==
X-Gm-Message-State: AOJu0Yz/mtqsz48IHvV6mea0T1TP5Q3oYTiYMP0PKc+gKCByc4NgEaig
	U1lKSqc9iTrlNoxiteZCcGCqnK7CsE0ZVffih5LkNFwZA6+KVbT1ublx
X-Gm-Gg: AR+sD13As4vCWVNAqsuuP4oxA3xBcceIA6LiQyaGjw+x2mVFFMvj40PTMbBmrKoUj0V
	3naxNQViYRaq+W4bAtBp2XKrUPIbC38jJEejsetC6J3d/rcZYtA/o2lNrt7Qz6DMurOx6w4m2iD
	lkEPAjgXTWE8fnqkXT6Jc5qaUKh7KEqNjp2GTtTcXOUxkHlINw4F+nNN8ns/OfX5OatHn1iKuJE
	S5yy6hf3alKR+y/XoGkeqqi/2mTlS2Yl8i04cQe67w3eZNnOrJUcFELe1oh+Z7Ri6uQPSfMeymQ
	og10KsZ08iKn3BF7DzK0u9itOf41XVWClSd3QXKdZDx8bOJlPL/LIL9qWC1Efzgl2/xJz+yvYBI
	8cizGcJSlwKvTHugNvclrYLAxn7rkp7Xwlu8wj2IWh9E4hWJihTBKlhMuENmaqZiUN6KbX4JEp3
	BjOEOOSh+ZJ6cL5X/YRtdZ7QmeIHPje5tbJz/0otbZ1TxB87EW96huTXfTy8YLOIcwDcKHi90qO
	VZOLl/7HayXM1pLbOsFnyvKO/HcrLPbU062RwEoM67BwiYvZeqdpabzwp93V+U4uQ==
X-Received: by 2002:a05:6a00:2383:b0:848:44d2:72a2 with SMTP id d2e1a72fcca58-84f2e009b49mr13219705b3a.27.1786028633604;
        Thu, 06 Aug 2026 08:03:53 -0700 (PDT)
Received: from EAIT-H54D9Q2FJQ.eait.uq.edu.au ([130.102.10.60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f456ba8b7sm1573356b3a.29.2026.08.06.08.03.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 06 Aug 2026 08:03:53 -0700 (PDT)
From: Yu Zhang <yuz08559@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Cc: virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yu Zhang <yuz08559@gmail.com>
Subject: [PATCH] vhost-vdpa: drop the parent's vq callback before the call fd is released
Date: Fri,  7 Aug 2026 01:03:23 +1000
Message-ID: <20260806150323.2154-1-yuz08559@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VHOST_SET_VRING_CALL releases the previous call eventfd inside
vhost_vring_ioctl() -- it swaps the new context into vq->call_ctx.ctx
and then eventfd_ctx_put()s the old one, which is a synchronous
kfree(). The parent vdpa device is only told about the change
afterwards, when vhost_vdpa_vring_ioctl() reaches ops->set_vq_cb().

Parent drivers cache the pointer handed to them in
vdpa_callback::trigger and do not take a reference on it, so
throughout that window the parent holds a dangling eventfd_ctx and may
signal it. The documentation added with the field describes what
signalling it means but says nothing about how long it stays valid.

This is the same hazard that "vhost_vdpa: assign irq bypass producer
token correctly" addressed for the irq bypass producer token, by
moving vhost_vdpa_unsetup_vq_irq() ahead of the vhost_vring_ioctl()
call. The producer token was only one of the two consumers of that
pointer; the one the parent keeps via ->set_vq_cb() was left behind
the free.

With VDUSE the window is directly reachable from userspace, because
the device emulation daemon can inject an interrupt at any time from a
different fd, and neither side shares a lock with the other: VDUSE
takes vq->irq_lock, vhost takes vhost_dev.mutex + vq->mutex.

  BUG: KASAN: slab-use-after-free in _raw_spin_lock_irqsave+0x76/0xe0
  Write of size 4 at addr ffff8881084e8788 by task vduse_uaf/2987

  _raw_spin_lock_irqsave+0x76/0xe0
  eventfd_signal_mask+0x69/0x120
  vduse_dev_ioctl+0x337/0x1a60     <- vduse_vq_signal_irqfd(), inlined
  __x64_sys_ioctl+0x120/0x170      <- VDUSE_VQ_INJECT_IRQ

  Allocated by task 2986:
   do_eventfd+0x50/0x200
   __x64_sys_eventfd2+0x2e/0x40

  kmalloc-64, freed 64-byte region [ffff8881084e8780, ffff8881084e87c0)

One thread loops VHOST_SET_VRING_CALL on /dev/vhost-vdpa-N with a
fresh eventfd and then unbinds it, while another loops
VDUSE_VQ_INJECT_IRQ on /dev/vduse/<name>. This reproduces in 5 out of
5 ten-second runs on v7.1.6 and 3 out of 3 on v7.2-rc6. With the patch
there are no reports in 3 out of 3 runs on either, while the same
workload still gets ~30000 interrupts per run delivered into live
eventfds, so the path is still being exercised.

Tell the parent to drop the callback before vhost_vring_ioctl() can
free the eventfd, mirroring what is already done for the bypass
producer, and restore it if the ioctl fails -- on failure the swap
never happened, the old context is still installed, and leaving the
parent without a callback would silently drop that vq's interrupts.

Fixes: 5e68470f4e80 ("vdpa: Add eventfd for the vdpa callback")
Signed-off-by: Yu Zhang <yuz08559@gmail.com>
---
 drivers/vhost/vdpa.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index ac55275..b7833bd 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -714,13 +714,34 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 			if (ops->get_status(vdpa) &
 			    VIRTIO_CONFIG_S_DRIVER_OK)
 				vhost_vdpa_unsetup_vq_irq(v, idx);
+			/*
+			 * The parent caches call_ctx.ctx in cb.trigger without
+			 * holding a reference, so it has to stop using it
+			 * before vhost_vring_ioctl() drops the last one.
+			 */
+			cb.callback = NULL;
+			cb.private = NULL;
+			cb.trigger = NULL;
+			ops->set_vq_cb(vdpa, idx, &cb);
 		}
 		break;
 	}
 
 	r = vhost_vring_ioctl(&v->vdev, cmd, argp);
-	if (r)
+	if (r) {
+		/*
+		 * A failure here means the swap never happened and the old
+		 * context is still installed, so give the parent back the
+		 * callback that was torn down above.
+		 */
+		if (cmd == VHOST_SET_VRING_CALL && vq->call_ctx.ctx) {
+			cb.callback = vhost_vdpa_virtqueue_cb;
+			cb.private = vq;
+			cb.trigger = vq->call_ctx.ctx;
+			ops->set_vq_cb(vdpa, idx, &cb);
+		}
 		return r;
+	}
 
 	switch (cmd) {
 	case VHOST_SET_VRING_ADDR:
-- 
2.43.0

