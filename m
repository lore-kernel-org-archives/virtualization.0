Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4015547ACC7
	for <virtualization@lists.linux.dev>; Wed, 16 Sep 2026 08:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789545791; cv=none; b=M/BuJlO3HD/znaAo/V1AJCw0rfX5DubCsgjujlq7XM9izW3/ZkryLRP9DJMzCZEJnkvN/PycgcKfb+SLYEqq1WeJihXKuF+4k9PRi8JcxlDf8E5GvqpwQS7gofJwlXb+1z5fXdlhKgs2N2GPgvQycxIXs/UHmXalm4hx5zl3GvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789545791; c=relaxed/simple;
	bh=CcIl2qlidku1wORNmejVDd3cdHZwfoYAS+FezT93Vvw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=g16rSz5JJmp+ualqV+7/htfcMZ4bI2izd/xAXWQTC5Rmv1ckLMdTgeYXe5Oto4y9BV6LJ3YpmYwqFATpEepUC+YqyIQPVlMWy+SJfbaOdoKJptoJMJFQzHQIjUdmegXHbQwsuKyiQo7kgHEMdTYLRUh06pSgMcE774Q5TekBD3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/GrZvRO; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/GrZvRO"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396cccbba92so530854a91.0
        for <virtualization@lists.linux.dev>; Wed, 16 Sep 2026 01:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789545774; x=1790150574; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FLey40lV3HWVD8nlftVsp59JqFraY1nxGF/bai+O4iw=;
        b=K/GrZvRONQksdSjDSBvYuUW0FOVOdCHzZbrgIdThFAZyKiwEedGVpMgn0LIGziyzaZ
         vFwQxY0VUclqgHSWwFaAOopCcS1tM8wgHToCGQBWbbpunebYhjX3I8HG+R+MgyVe/6Db
         epL0lOvpbwZXpsDkyB9rQflvwFTdynfZApWbLc7VWwNoFhRcCOIl/h0DxOygGcRqUSjv
         ty/Lf8JDuEztP9gDTGQaQcKaPPmT5qvxLhEE836mQJLJ4wLRxVXYDjGo3R7VF43uEGci
         xFYyhzWE0dIpk2KujZcw7RIl3EBomKAAiUc5pj0ZpvB3u6e8Ddl/WLmOHX8UbFEOKxr0
         6yUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789545774; x=1790150574;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=FLey40lV3HWVD8nlftVsp59JqFraY1nxGF/bai+O4iw=;
        b=Enj72ULSQ2Zs6Db0tUVJQZqttyslqhCS1yOa9PdfQ+QGFqidlKtpo5LL/coR+okyj4
         saV3Qu4wDJ/41RhxRp2Hf1Ym69R5kTs/aWkYp++2lFpAUBKY43swGuNSyjQ8dCUBiBrv
         tgQ5QRgTP7aXIwrVQO1JUA+vvDc7aTpkrYsTmgQunqzdz3XrBfyBJcBv/9xCbBe9SEes
         OAszU8G34LWn9aFPuUPhdo+50IcnRWF12oTfmXDH8TIOoqRwj8StBaaBkNlE1zCvcO1F
         nij6hGsEJBQ4HpEBsNRFa1ofsuUefgtkJ0/gyR5tViZsGPun40FgQPytHIgFCl2nlpjL
         yg/g==
X-Gm-Message-State: AFuF++lzlDiM3bN9jeZFYgucgwMkBan/kRG0JTfVavd2uBh++WVl2nCv
	67tfEZjc9WuPgkCrfMPK3JgMJwFAC4bbVoBkFp0fdusgjjjOkWk2YKTa
X-Gm-Gg: AYBFou3A7MqUXBRUhjUhkH4UM5ODUE3Y6OnoAzmR8bKIM6QW99Mn50cZ3SyeAPjMp2K
	zVhcGJxYWZ8zckEawyM8ewJF3vagz3O5zadv13YU0ni7AZ8JdG0wi3SjlafBnk/yra9HHFfgsuo
	wZ1POc5yAS4T+9G5Ls80J1wdncKvq0KbzDRq9k5twRmIYYbZTig6uDzuustsLCV7NgdwyGbnGJB
	zYRBaoBVwJad3CLk9t2bXNYF0IsAU/y/AiFoiX1UKNZGfTtYvjXmICVHIs71/2doqfZaGl29+GS
	XOQU8bMnVWAEUHg5EfBGC8HJyQ32TkqGjjwbsXHDWKDjeFvXPtc2WlhT0BfnL1ZclBr7xrrmzMf
	b+w5/wIR4aFSSK0CA0QTr7Y8wKmDyijACE8IaA1XjVJ+v0qImXeq/EmX2WvA516br0UEIShLAnP
	kkOc9NqkU39ffiiSH3CRftkTQhZOxVvmbN64dOosYrd7T+uGVRV0E9Lfxg1qLf1sN74DOvmrRdv
	PKYjYG1KXLnSfB2SbdeGvel
X-Received: by 2002:a17:90b:2d4f:b0:39e:1b0c:4773 with SMTP id 98e67ed59e1d1-39e1df86c10mr4226243a91.0.1789545773829;
        Wed, 16 Sep 2026 01:02:53 -0700 (PDT)
Received: from [192.168.66.6] ([210.32.35.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1b90a5a0sm3270498a91.2.2026.09.16.01.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 01:02:53 -0700 (PDT)
From: Linfeng Sun <linfeng.sun.dev@gmail.com>
Date: Wed, 16 Sep 2026 16:02:44 +0800
Subject: [PATCH v2] vhost-scsi: initialize command pools for late I/O
 virtqueues
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-fix-warning-in-sbitmap_get-v2-1-e61a09047089@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NQQ7CIBAAv2I4uwb2QK0n/2EaA7ilayxtAKum6
 d+l9QMeJ5nMzCJRZEritJtFpIkTD6EA7nfCdSZ4Ar4VFihRy1oeoeU3vEwMHDxwgGQ592a8esp
 gNWJtqHVSS1ECY6Rib/FL8+P0tHdyeS2uRscpD/Gz3Se1en+NJgUKKl05dKiUQXv2veHHwQ29a
 JZl+QLegUJ01gAAAA==
X-Change-ID: 20260908-fix-warning-in-sbitmap_get-b6229aefc060
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 Mike Christie <michael.christie@oracle.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Linfeng Sun <linfeng.sun.dev@gmail.com>
X-Mailer: b4 0.16.0

vhost_scsi_set_endpoint() allocates command pools only for I/O virtqueues
that are already set up, but publishes the backend for every virtqueue. If
userspace finishes configuring a skipped queue later, a kick reaches
vhost_scsi_get_cmd() with scsi_tags uninitialized and triggers the
!sb->alloc_hint warning in sbitmap_get().

Leave skipped I/O virtqueues inactive at SET_ENDPOINT. When SET_VRING_ADDR
later completes their setup, allocate the command pools and activate only
that queues. Roll back both if access initialization fails.

Fixes: 25b98b64e284 ("vhost scsi: alloc cmds per vq instead of session")
Signed-off-by: Linfeng Sun <linfeng.sun.dev@gmail.com>
---
I checked QEMU and found no evidence it's affected. I haven't checked 
VirtualBox because I am not familiar with it. However, the virtio spec 
doesn't require a specific operation order, so a new VMM could still 
trigger this issue. 

Crash log:
[   34.698961] ------------[ cut here ]------------
[   34.699385] WARNING: lib/sbitmap.c:286 at sbitmap_get+0x227/0x270, CPU#0: vhost-82/88
[   34.700542] Modules linked in:
[   34.701309] CPU: 0 UID: 0 PID: 88 Comm: vhost-82 Not tainted 7.3.0-rc2+ #14 PREEMPT(full)
[   34.701958] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   34.702717] RIP: 0010:sbitmap_get+0x227/0x270
[   34.703247] Code: 41 8d 5d 01 89 df 44 89 fe e8 f5 3a 46 ff 31 c0 44 39 fb 0f 43 d8 e8 38 46 46 ff 65 41 89 1c 24 e9 25 ff ff ff e8 29 46 46 ff <0f> 0b eb ba e8 20 46 46 ff 44 89 fe 31 ff 45 31 e4 e8 c3 3b 46 ff
[   34.704234] RSP: 0018:ffffc90000ec3bb0 EFLAGS: 00000246
[   34.704677] RAX: 0000000000000000 RBX: ffff88800500dee8 RCX: 0000000000000000
[   34.705166] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88800500dee8
[   34.705584] RBP: ffffc90000ec3be0 R08: 0000000000000000 R09: 0000000000000000
[   34.705988] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000006
[   34.706477] R13: 0000000000000000 R14: 0000000000000000 R15: ffff8880050094d0
[   34.706955] FS:  0000000014d05380(0000) GS:ffff888099c36000(0000) knlGS:0000000000000000
[   34.707463] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   34.707854] CR2: 00007c0c3c20e000 CR3: 0000000008e47000 CR4: 00000000000006f0
[   34.708592] Call Trace:
[   34.709259]  <TASK>
[   34.709822]  vhost_scsi_handle_vq+0x4a9/0x1b20
[   34.710437]  ? update_cfs_rq_load_avg+0x2e/0x230
[   34.710874]  vhost_scsi_handle_kick+0x2c/0x40
[   34.711292]  vhost_run_work_list+0xa6/0xf0
[   34.711673]  vhost_task_fn+0x76/0x1b0
[   34.712003]  ? __sanitizer_cov_trace_const_cmp1+0x1a/0x30
[   34.712506]  ? recalc_sigpending+0xe1/0x130
[   34.712890]  ? __pfx_vhost_task_fn+0x10/0x10
[   34.713325]  ret_from_fork+0x37a/0x630
[   34.713673]  ? __pfx_vhost_task_fn+0x10/0x10
[   34.714031]  ret_from_fork_asm+0x1a/0x30
[   34.714535] RIP: 0033:0x0
[   34.715201] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[   34.715587] RSP: 002b:0000000000000000 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[   34.716158] RAX: 0000000000000000 RBX: 000000000048bb20 RCX: 000000000041ca3d
[   34.716571] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
[   34.716957] RBP: 00007ffcac47c4e0 R08: 00000000ffffffff R09: 0000000000000000
[   34.717418] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
[   34.717826] R13: 00007ffcac47c778 R14: 00000000004af868 R15: 0000000000000001
[   34.718363]  </TASK>
---
Changes in v2:
- Activate only the virtqueue specified by VHOST_SET_VRING_ADDR.
- Mask the userspace provided index before accessing the virtqueue array.
- Link to v1: https://patch.msgid.link/20260908-fix-warning-in-sbitmap_get-v1-1-767c2c211a2b@gmail.com
---
 drivers/vhost/scsi.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 4f8c0260bc9e..efca34362666 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -2008,6 +2008,41 @@ static int vhost_scsi_setup_vq_cmds(struct vhost_virtqueue *vq, int max_cmds)
 	return -ENOMEM;
 }
 
+/* Callers must hold dev mutex. */
+static int vhost_scsi_activate_vq(struct vhost_scsi *vs, unsigned int index)
+{
+	struct vhost_virtqueue *vq;
+	int ret = 0;
+
+	if (!vs->vs_tpg)
+		return 0;
+	if (index >= vs->dev.nvqs)
+		return -EINVAL;
+	index = array_index_nospec(index, vs->dev.nvqs);
+	if (index < VHOST_SCSI_VQ_IO)
+		return 0;
+
+	vq = &vs->vqs[index].vq;
+	mutex_lock(&vq->mutex);
+	if (vhost_vq_get_backend(vq) || !vhost_vq_is_setup(vq))
+		goto unlock;
+
+	ret = vhost_scsi_setup_vq_cmds(vq, vq->num);
+	if (ret)
+		goto unlock;
+
+	vhost_vq_set_backend(vq, vs->vs_tpg);
+	ret = vhost_vq_init_access(vq);
+	if (ret) {
+		vhost_vq_set_backend(vq, NULL);
+		vhost_scsi_destroy_vq_cmds(vq);
+	}
+unlock:
+	mutex_unlock(&vq->mutex);
+
+	return ret;
+}
+
 /*
  * Called from vhost_scsi_ioctl() context to walk the list of available
  * vhost_scsi_tpg with an active struct vhost_scsi_nexus
@@ -2105,6 +2140,9 @@ vhost_scsi_set_endpoint(struct vhost_scsi *vs,
 
 		for (i = 0; i < vs->dev.nvqs; i++) {
 			vq = &vs->vqs[i].vq;
+			if (i >= VHOST_SCSI_VQ_IO && !vs->vqs[i].scsi_cmds)
+				continue;
+
 			mutex_lock(&vq->mutex);
 			vhost_vq_set_backend(vq, vs_tpg);
 			vhost_vq_init_access(vq);
@@ -2409,6 +2447,7 @@ vhost_scsi_ioctl(struct file *f,
 	u64 __user *featurep = argp;
 	u32 __user *eventsp = argp;
 	u32 events_missed;
+	u32 vq_index = 0;
 	u64 features;
 	int r, abi_version = VHOST_SCSI_ABI_VERSION;
 	struct vhost_virtqueue *vq = &vs->vqs[VHOST_SCSI_VQ_EVT].vq;
@@ -2464,12 +2503,19 @@ vhost_scsi_ioctl(struct file *f,
 		mutex_unlock(&vs->dev.mutex);
 		return r;
 	default:
+		if (ioctl == VHOST_SET_VRING_ADDR &&
+		    get_user(vq_index, (u32 __user *)argp))
+			return -EFAULT;
+
 		mutex_lock(&vs->dev.mutex);
 		r = vhost_dev_ioctl(&vs->dev, ioctl, argp);
-		if (r == -ENOIOCTLCMD)
+		if (r == -ENOIOCTLCMD) {
 			r = vhost_vring_ioctl(&vs->dev, ioctl, argp);
-		else
+			if (!r && ioctl == VHOST_SET_VRING_ADDR)
+				r = vhost_scsi_activate_vq(vs, vq_index);
+		} else {
 			vhost_scsi_flush(vs);
+		}
 		mutex_unlock(&vs->dev.mutex);
 		return r;
 	}

---
base-commit: dd886653d2038a510a21bff476fa1be0422a4fb9

Best regards,
-- 
Linfeng Sun <linfeng.sun.dev@gmail.com>

