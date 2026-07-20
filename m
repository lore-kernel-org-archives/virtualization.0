Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9A23B7750
	for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 08:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784537605; cv=none; b=TTPlpZt6ee66QAGB/xsro10V9nj2wGzAF6kmEu89scMcu+mxBiMrmeo2dSu6zR0AEtnl7emsHExB9FpwVQ6jE9Fvt7umLNLAULibdkXp8DcIa98bAoCTDdKU2ZgLjZoNcAhs6GsvRkFAq3MCsgy2idwsc0wsUHx4RJs7yG0WhYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784537605; c=relaxed/simple;
	bh=o6QS22hcefobTL4agDYyTXy5uvYvNFggHdA5faPCDDo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=miOII4zdYcA0SqieQLAkF4ppW6optly42sk05DJBvioDGxi43oEANP++N6jORo2cz6lY0rv2dOCrbmNbgwBBNpYW0HomSb5XuqTBzvewZdqBB5pYbmIVckq+AoAVZSZJheqrUO0upwcpOSp9lQspG7jNnsWMBVhQ4UULYVJ2Dxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hg3CQhBm; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hg3CQhBm"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38df94d4dd8so4579737a91.2
        for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 01:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784537603; x=1785142403; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZyobmQNbF473X4YAV4bIq6NV92V1jhbfZhYiYWm1O2k=;
        b=hg3CQhBm9i3GYMWvlU/IKhX+j8DbobIO2HG+EqEU3xIDwNUxomnq7ANWUatwNdAmqQ
         qi4J9GEIeLEZW8RpNe+aLrwErkdj5qbWKYf7a6m5x3xw+xR2x/NHnkvmmVl8S5DGwWZB
         48BftBRXOIFcELKLFwA/gBYlGw32G7Tpn5o6UeOn3ufCMne/VFeV6ZiVUMg91VnjxmFY
         f/b8Ymxq0Bqxn2VPV/cXvOiAhn1hsrTpYL0LRasincZE3oZTefMu1qIy5VXBvYlbSONj
         WSItJqzdydsTSyrlBTRyJjO40hYugCZYXUHitW9yXsWJ6AE90lg3dM+kFoVWCu9A0dsl
         ZUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784537603; x=1785142403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZyobmQNbF473X4YAV4bIq6NV92V1jhbfZhYiYWm1O2k=;
        b=Dm/0AC6J1JiN/ne27l5Y1JjQq5zgBWd3GAFkWd9VtHhsCemYUnZrtRbYe7UXSD3H/C
         XhSqfj+POrZtvt3OdGquZ8BY3pLxwY4O5HMhG6nfg+rfNjnhuuvUIqkHIQVBRMqqnzky
         Ca8MyYzAwBkrlIJahpJKkHTO2cy5lIJOS/W0VzcRAlKMBPv6Xpy+Yy7BHu50Tl02TjJp
         my6Re/Aq/dISbajjYq3tzNLJsFT28w/s53sX+L4IVhxQw0J1XFcYKpyz4QQDMMxKLSB4
         Ac+nNcsMD+dVzo0dS638KQfaQZgZaSXwvPo5XJYeL8+wrRnp+zL9niv37IZ5dUe/mcDU
         dDoA==
X-Forwarded-Encrypted: i=1; AHgh+Roawc/tPEbAZgRuUro8ThK837txNtFM3pNPllLxIDxuZ6VYfargb5FagOtdi7VCaHG68KE9vwZdUnlxd9WxHQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyPiLkBTFu2XydLoylTFJLUD85Eonqm9hssVeZBwURZO6kZsuMa
	QXwxQkGQ+XNJJQD2jTeFV+IzoKyXWFkVf2FOXIcGlhGgfwUf6+jNQh4S
X-Gm-Gg: AfdE7cm8qRTOz8owlZjxqfMfmHvpbyjNCeF8pnnuCZvhV+QK4WzwOwOIXfbSdG+I1KH
	LeQqza6jXFinQU+vUlMcOviUd1jEWADnBJBQFhW4inozli70HHn8fCsto4qqvCcWXAVi78g3ytY
	3shwH5wTdT8xXVOkEtxE79JxzM8heiTgLB9D/CvThzcT1OEANkOACcTRjkAxRum5aI7MOXlKniA
	b8YPQIH4+8oBqr3LcAmohXpCXw6hoHeDDz0zirQgSyaZg/j7gFD/WsZ6zH0udG4q1Hdl+G72ZLh
	lApPh5G0eYOBUw+ayNwe9yHxWzRtF1/m4g/SP9dDIlwW1pwKGcPef/1tZFU1El2Urok0dW7fkmy
	805ryk1dh9Z7xED+ryjrJ0cniewrODua7LJ1mvXP3kMZry6Tv52sCadzvNJ1yegm1Pg+Nwd9XvI
	2LvQ/t
X-Received: by 2002:a17:90a:d44e:b0:38d:ddc2:7ccb with SMTP id 98e67ed59e1d1-38e4b3d0fdamr13257377a91.1.1784537602406;
        Mon, 20 Jul 2026 01:53:22 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce2cbb69bsm25224068c88.11.2026.07.20.01.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 01:53:22 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: mst@redhat.com,
	jasowangio@gmail.com,
	michael.christie@oracle.com
Cc: pbonzini@redhat.com,
	stefanha@redhat.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org
Subject:
 [RFC PATCH] vhost-scsi: Serialize completion notification with callfd updates
Date: Mon, 20 Jul 2026 16:53:06 +0800
Message-Id: <20260720085306.1519294-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During userspace stress testing on a KASAN-enabled host, a host-side
callfd replacement concurrent with ordinary SCSI completions exposed an
eventfd_ctx lifetime race. The test requires access to /dev/vhost-scsi and
a host process that can issue VHOST_SET_VRING_CALL; on the default device
permissions this normally means root or an explicitly delegated service.

The test used TUR completions while closing the old callfd and binding a
new one. The unbind form tends to produce a NULL pointer, while replacing
the callfd after closing the old file makes the old eventfd_ctx eligible
for release.

vhost_scsi_complete_cmd_work() drops vq->mutex before calling
vhost_signal(). VHOST_SET_VRING_CALL updates call_ctx under the same mutex
and puts the old eventfd_ctx before returning. vhost_signal() does not take
the mutex or hold a reference to call_ctx.ctx:

	if (vq->call_ctx.ctx && vhost_notify(dev, vq))
		eventfd_signal(vq->call_ctx.ctx);

	CPU 0 (ioctl / callfd replace)		CPU 1 (vhost worker)

						vhost_scsi_complete_cmd_work()
						mutex_unlock(&vq->mutex)
						vhost_signal()
						  /* load old ctx */
						  vhost_notify() ...

	VHOST_SET_VRING_CALL
	mutex_lock(&vq->mutex)
	swap(vq->call_ctx.ctx, new)
	eventfd_ctx_put(old)	/* free */
	mutex_unlock(&vq->mutex)

						eventfd_signal(old)
						  /* use-after-free */

On the reproducing run, the worker ran on CPU 1 and the callfd ioctl path
ran on CPU 0. KASAN reported:

	BUG: KASAN: slab-use-after-free in eventfd_signal_mask+0x6c/0x110

The use stack was:

	eventfd_signal_mask
	vhost_signal
	vhost_scsi_complete_cmd_work
	vhost_run_work_list
	vhost_task_fn

The freeing stack was:

	eventfd_ctx_put
	vhost_vring_ioctl
	vhost_scsi_ioctl
	__x64_sys_ioctl

Hold vq->mutex across vhost_signal() so SET_VRING_CALL cannot swap and
release the context while the completion worker is notifying the guest.
This gives the completion and callfd update a clear ordering without
changing the vhost API or adding a new lock. Other vhost-scsi response
paths already signal while holding the virtqueue mutex.

A private eventfd reference taken under the mutex would allow signalling
after unlock, but it needs additional reference-count plumbing. An RCU
design would require broader vhost-core changes for all call_ctx readers
and additional eventfd lifetime rules. Since callfd changes are a
control-plane operation, extending the existing per-virtqueue critical
section is the smaller complete fix.

This is an RFC because keeping vhost_notify() and eventfd_signal() inside
the virtqueue critical section extends the lock hold time slightly. I'd
appreciate feedback on whether this is acceptable or whether a
reference-pinning approach, taking the reference under the mutex and
releasing it after unlock, would be preferable.

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 9a1253b9d8c5..7f46bc0de3c2 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -735,10 +735,9 @@ static void vhost_scsi_complete_cmd_work(struct vhost_work *work)
 		vhost_scsi_release_cmd_res(se_cmd);
 	}
 
-	mutex_unlock(&svq->vq.mutex);
-
 	if (signal)
 		vhost_signal(&svq->vs->dev, &svq->vq);
+	mutex_unlock(&svq->vq.mutex);
 }
 
 static struct vhost_scsi_cmd *
-- 
2.34.1
