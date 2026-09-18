Received: from mail-pj2-f25.google.com (mail-pj2-f25.google.com [74.125.227.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC3D22A7F6
	for <virtualization@lists.linux.dev>; Fri, 18 Sep 2026 04:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789704315; cv=none; b=gY553Zhd0d5bzSp00LinAwhxYNVs77T3O+jcPAZoLUjdWvcR0NVcdaFPcdIikZn7JF8dJciUbpW/ySPteroynK7gBr9zuvqUIjjP774f+WNLbWS13jRlfOQ7bHAQrPZ4EVbK2sdGh67/ZbJG7cOrkyBlHJvSJ500A7ftxRIDqSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789704315; c=relaxed/simple;
	bh=DbHpwwZHwcETFHq7bJfxk4QzBcPRR3fpqfQprJCF1z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jSzOkro8vNEkLjH8O3RkvM/X4ccfbIOgHOEVGn0CJZw4tKKYrQyPf3yq27XQ+qdTxUM/pkhJ3ogRycBG8oQvn59Hi+gIxtFlA633Nq7D9LtYwYsQinAZWdF3DxRxQk3128fg41b+hsyMWn0IDe0T7/dycCgotOittVlyGGzRvR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amzf8ees; arc=none smtp.client-ip=74.125.227.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amzf8ees"
Received: by mail-pj2-f25.google.com with SMTP id d9443c01a7336-2dd4b43b20bso1901155ad.1
        for <virtualization@lists.linux.dev>; Thu, 17 Sep 2026 21:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789704313; x=1790309113; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ugi6RUPBClqMIR7An2++qau8YtbA8aE1nyg7UAqNky4=;
        b=amzf8eesdyRAfMkSOBzgR8D2oXCq8682mkNm2kbxmhp23RjEGkTnlMeE0BltzF8BY3
         KpBD6d7XY5QZQ/zxURnMeNtcvGF+3ZBykiiXAkbQcLG1p1G2wLh6H2IJkvyQ/X4K0XoW
         Wu2HJ9IOgSOjZasEQ5SXuPlzbMQO9ajZ90zbi9yafAo3IiWetevPEYnwJaq2vQBdzXv1
         83cX7qZoMywcTeSKBuJKYDw15qp8mWlmbB7koBoW9nNXmC5PDx8fpBtvtqtD2zfcR6sW
         Xf72SW3piXkXuuvdTp/5k/ZFsMK9TIO318vGBRa5kUvBmvWp2Fpjv2gBM9b/p7W/+PR2
         6feg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789704313; x=1790309113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ugi6RUPBClqMIR7An2++qau8YtbA8aE1nyg7UAqNky4=;
        b=W7yxUEefhXp565ZcE3g2RT6ysIrpslELgOrJlzeCQIqXESoO/J1YSdwI+pkiJ+wS+V
         ZRQ2FVNB3XUSi+Rkh8kmfhf8cA7wxLCFt9r2Xa8IMOqUE45Jptxe4oEUabb0kkZ3fPE1
         kCaAo9UQ0hFJGjz6KgZ7VPbM48igPiuC+GVCYUbQ4lHn2XTYkTX+MMAbLCrutyABEDOt
         ZUvupaq6QjMVgkFpkGSKd4KPjWGwAl1MwGMWl16LfzQunNSwKTUtll1ODGIzVjiPbZAV
         mP/SmVdGlNG52uz/tx6aV6bU8FzokBxbeYdqY+XHDFBnON3HDyrErLG0zGNhYpVPPHRl
         Pjjw==
X-Forwarded-Encrypted: i=1; AKwUvBxVmL42ZcXXKdpCNwUOFhYXwINZTIdOWD5S0FVDx7/HVgsb+6jlKDlyjv9hC7GjcwzzxE8tUrXe8dI5AGTpjg==@lists.linux.dev
X-Gm-Message-State: AFuF++l5W0vRMv8W+bk0k2sCQy0JoIm2DZMkQ+LH67jKgqeBmW9mEYwh
	yn/jY2xezom+l77N70Z3whbMGGtXKuG9LzpA7FEw81XjpreTEEx0xblH
X-Gm-Gg: AYBFou1sVnuaRCtIaGsZGqTNyEkGdlwHMGHGNToBwMBS6r59GgjkYB1rkK+hQQMh2ER
	U0QGOOymM3KleK+FWPN6tD6OXQcXTKSupLcxtitw/I7qBLJdS5/2R/Y/jDDiZx9zwW7/FCU5dRY
	5woe0Vi7jH8pG7TmfuxZjKE03PWzjukKTJUfTOhwQlFtCT1hHvuqQrvGEPjFkhMAK0KIOPHEP2F
	ABM/XIYpVtZ4xQ6acv/2EeMV0BlEDcfWbkbRBiFzQ31nbZPDN237E8mJGWJpZpGiZ1oiA1eRGmt
	qoKYCJ3jLYlrGq7+9I0k6xcJ8F+BYSHtEb5oEs866GSZ35Y5TIqZ/GA/WSrzoh56tcieGjcI+kx
	DmFJvQOWzU/c5k52ggBn+8Y4m2x8R/lxXtjWkl5gLtVJT/TLX5K/3nCUHk38uJ+fBo5PcOEQhDz
	W+4pXM69iaO3YkScYnzz/0gZ8Pgoa3GXg4Kz5emKOUDHay4dkxjB3MmONoGkVdlNUAQbN1f39Qd
	V2z+wYbSZ6KCwLBNM8yVUf3NLKZPlT0kEgL8eJ7rAJMjZuMxojIGzgu4DOWL7tn7W/0XL1VWHv/
	3CdbqvKz7zyAXkxVTmf5SEqiL7rRRJMjoCnI7wubqZ8XOm8=
X-Received: by 2002:a17:90b:518c:b0:38e:9ef9:eb97 with SMTP id 98e67ed59e1d1-39e54e3f439mr2781326a91.16.1789704313097;
        Thu, 17 Sep 2026 21:05:13 -0700 (PDT)
Received: from EAIT-H54D9Q2FJQ.eait.uq.edu.au ([130.102.10.59])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144ce065314sm1155861c88.14.2026.09.17.21.05.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Sep 2026 21:05:12 -0700 (PDT)
From: Yu Zhang <yuz08559@gmail.com>
To: mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com
Cc: sashiko-reviews@lists.linux.dev,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yu Zhang <yuz08559@gmail.com>
Subject: [PATCH v2] vhost-vdpa: drop the parent's vq callback before the call fd is released
Date: Fri, 18 Sep 2026 14:04:36 +1000
Message-ID: <20260918040436.47982-1-yuz08559@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907173931-mutt-send-email-mst@kernel.org>
References: <20260907173931-mutt-send-email-mst@kernel.org>
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

Clearing the callback only stops a parent from starting to use the
context; a handler that already loaded it can still be running. For
parents with a real interrupt, wait for it with synchronize_irq() on
the vq's irq. VDUSE does not implement get_vq_irq, so that case stays
covered by the teardown above.

Fixes: 5e68470f4e80 ("vdpa: Add eventfd for the vdpa callback")
Signed-off-by: Yu Zhang <yuz08559@gmail.com>
---
v2, addressing the review on v1:

 - synchronize_irq(): valid, fixed.  Clearing the callback only stops a
   parent from starting to use the context; a handler that already
   loaded it can still be running.  The teardown now ends with a
   synchronize_irq() on ops->get_vq_irq() where the parent has one.
   VDUSE does not implement get_vq_irq, so it is a no-op there and that
   case stays covered by the teardown alone.

 - torn read of the callback struct yielding a NULL cb.private: I do not
   think it applies here.  cb.trigger has exactly one consumer -- apart
   from vhost/vdpa.c assigning it, the only reads are in
   drivers/vdpa/vdpa_user/vduse_dev.c -- and VDUSE serialises both
   sides: vduse_vdpa_set_vq_cb() takes vq->irq_lock around the stores,
   and vduse_vq_irq_inject() and vduse_vq_signal_irqfd() take the same
   lock before using the fields, so VDUSE cannot observe a torn update.
   For parents that do a bare struct copy (vp_vdpa_set_vq_cb() is
   vring->cb = *cb) the hazard is real, but it is not introduced here:
   this function already performs the identical three NULL stores
   through ops->set_vq_cb() in the existing else branch below, which
   userspace reaches with VHOST_FILE_UNBIND.  Defining the store order
   and the matching loads has to happen on the parent side, which this
   caller cannot do; happy to send that separately if you want it.

 - retested on v7.1.6 with KASAN: no reports in 5 out of 5 runs with the
   patch, 3 out of 3 runs report the UAF without it, and the workload is
   not slowed down -- 16k-19k call fd swaps and 1.5M-1.9M injections per
   30s run, against 10k/0.9M measured for v1, with 48k-89k interrupts
   still delivered into live eventfds.

 - rebased on the config_ctx fixes now in mainline.

 drivers/vhost/vdpa.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index a317867..e1def23 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -767,13 +767,46 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
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
+
+			/*
+			 * A parent interrupt handler that loaded the callback
+			 * before that store can still be running, so wait for
+			 * it to finish with the context too.
+			 */
+			if (ops->get_vq_irq) {
+				int irq = ops->get_vq_irq(vdpa, idx);
+
+				if (irq >= 0)
+					synchronize_irq(irq);
+			}
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

