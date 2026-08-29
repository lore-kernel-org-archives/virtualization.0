Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906DC432BCD
	for <virtualization@lists.linux.dev>; Sat, 29 Aug 2026 22:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788044130; cv=none; b=MnQ1slDA4jia3XHV8CP+UQ3Ozcm3HNfF6K8NUjEqnH0TgXIhaET67vfvhAyrBZQDDRA84GRZBRtlcHsfGJdIJ0AxQqzw3OVw31jDa8Ub9Hmy3b8OseVeUmVEAsmIkzMpzYzHjLQ8PEsR059O1RWWZ1yxCAfMyolXtCfLSVfpXsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788044130; c=relaxed/simple;
	bh=qBN+DWx96hbQZQ9lNws+rysHWnkANX3wt4SsBuvYulk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XNf7XlyXJsUbuuerIMSsJoHqy0ZbIla5HWgnHk8t+8sZIU3kZtDGi5O5lbFPYdU3CFrt57K3PbpwHRVCjEaKL6B77zbMmHg9Iu7d96LbBvsRl5qDKWR3LrPKIxEGfCnrYJ00IezHXc+U+mbR0GsHl4bBxJpSdsMbFWjWPLDimGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o/9yJ6FZ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o/9yJ6FZ"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d6e954afbdso15239615ad.2
        for <virtualization@lists.linux.dev>; Sat, 29 Aug 2026 15:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788044125; x=1788648925; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ma80YmNRqQi3IMfqK57hZ7nOz1u3fXlwt1Ge7kNJdZE=;
        b=o/9yJ6FZJCq324xDzBwlHZlcc2FbqYnJpWMalTEaC1TuqhNjc/X5/yDZ9uQ0l7wzBt
         zGzt2M0AmCbFZWcky/a+q7fiMA/K8xoyit7Ja1mcOsCEYSMuJ+GW2J+DYaHgQPMTZZJW
         UKQInrQ940DSCoU3YrGb/7jCkCrfn2F4p0XkvkKw5T5nUrwqeDDBRYSkvj0bXYuhX3+P
         GdtJZ0aIyaJLCn7kjw2EcexDlz3atvtxmPkjf10BzmxkR+4RG8ZG4EYhetcWJcvJi9pw
         jkGJlfBPjXlt3bJjll0iauSpd7L8BYtYX+l4VqIqyYMiJy3t7384eDRaBjCEhcCw4Sls
         FaGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788044125; x=1788648925;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ma80YmNRqQi3IMfqK57hZ7nOz1u3fXlwt1Ge7kNJdZE=;
        b=HzV01wwmez5kRfWINVTP10dHhjn4ZSsLxyl/2HrXCrfWfdFlStQEXyckxrEGtWYajh
         Lc94nGJG/hLk3sSgztk+zGMshdEVWCigdWx+DJ7ylOuBLhRzwUhL70HL3c40NidNX4El
         NOrg+T92mUs+cbUYZT5QnU2Kj7BITqC9rchB5YevfSXA4Nb9y/KLnQPxmzL+ey/HfS17
         T+gAowp6LwcgOLb26DauPYe2DSrxD5dxf1+R4teCOQozTfk5U8snUOBXfqv18NGVi+DY
         sT7CcHwIDlQBWHHRNEXPT+oHi8DB3Kl20TiKt4ZCsG9HY35byvOaXTJpTeSGOCGSls24
         ef3A==
X-Forwarded-Encrypted: i=1; AKwUvBz8thJ9x0c8EzbWg7OHLJPG8a4PqqzG2DX93JocPdk36r7I/NMhHv+aD4sXi0fsyS86WfvMefOOOpyOyyxHmg==@lists.linux.dev
X-Gm-Message-State: AFuF++lZi+rZ++exQgWTPf6cI1MOp2NjepgcO+HpDrrQvYFQtN86MpOM
	uhqzPaom+d03gSqMtIJcTCec3wizmpssFZ6lxu97WMXOqx/nS5RgBnjf
X-Gm-Gg: AYBFou2W6W/gPppRzgVDjG6hcWPzeGL8kgxdYdlJUamPunkPiSIFuZgFHRYfQseM29g
	H/7CQm6WA/Vc+4JF2wH6zwEfu4I2vBzWguKsMMh3Ft2PHJmDa9xHpRByz19P5IMMSbfCNH5QdSB
	a7uz8/AeOPKwPnWzCf8MuttmpIGm2GhkuSQvunQcrqKkLFyIE6jbAtBgE8w1zEVKRjZD75zVM//
	Dw5P08bMg+6n7pmjnYH5hQ5BTvCte/kP9Ab1unMLIJOIc7YQ+yMoTaKmbPe9/XVBqCSO7PAY/LV
	BZzuRlNF/sxW5n/iyEQaISar7jwicI5LE2c2Z5gdIA0Jn1WgPZ0o6noWjgFg2NlGBKpCkl+KnKg
	ftbG5Vci12N6LOpMboQs1X1t9y2Ahk4UBq1UtxB/kF5EKQaA38E9D50SDpzAmSaycpmyC8lNqjl
	X5/lRJ0S6/g2Aryfen7kGuj/wZrom8HekAZpH43qcDpY8Vbj7l56gWwf0P0NqgarkaB/nFyMrgk
	vtRxe+AQFLmMWVy1mTtHgiukpOztw6zqUeDWBgmgVxg9v7k0jifySx6jTyGCMiUB/oinqrLEM2M
	tMnsRCdYspK5Fk76gDU=
X-Received: by 2002:a17:903:388e:b0:2d7:44c5:1a13 with SMTP id d9443c01a7336-2d74df17b06mr307385625ad.8.1788044125345;
        Sat, 29 Aug 2026 15:55:25 -0700 (PDT)
Received: from bad.. ([43.227.227.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d759869afasm16958265ad.42.2026.08.29.15.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 15:55:25 -0700 (PDT)
From: Nikhil <nikhilljatt@gmail.com>
To: mst@redhat.com,
	jasowangio@gmail.com
Cc: eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	xieyongji@bytedance.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] vduse: do not take dev->rwsem in the virtqueue kick path
Date: Sun, 30 Aug 2026 04:24:57 +0530
Message-ID: <20260829225457.1037867-1-nikhilljatt@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vduse_vq_kick() runs in the context of the vdpa .kick_vq callback. With
the virtio_vdpa bus driver that callback is invoked by virtqueue_notify()
from the virtio device driver, which may be an atomic context: virtio-blk
kicks from ->queue_rq(), which blk-mq dispatches under rcu_read_lock()
(the tag set does not use BLK_MQ_F_BLOCKING), and virtio-net kicks from
its xmit path with the tx queue lock held.

Commit b282418bc366 ("vduse: Add suspend") made vduse_vq_kick() take
dev->rwsem for reading in order to check dev->suspended. down_read() may
sleep, so with CONFIG_DEBUG_ATOMIC_SLEEP the first I/O on a VDUSE-backed
virtio-blk device bound to virtio_vdpa now triggers:

  BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1573
  in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 27, name: kworker/1:0H
  preempt_count: 0, expected: 0
  RCU nest depth: 1, expected: 0
  3 locks held by kworker/1:0H/27:
   #0: ((wq_completion)kblockd){+.+.}-{0:0}, at: process_one_work+0xac7/0xcf0
   #1: ((work_completion)(&(&hctx->run_work)->work)){+.+.}-{0:0}, at: process_one_work+0x51f/0xcf0
   #2: (rcu_read_lock){....}-{1:3}, at: blk_mq_run_work_fn+0x119/0x220
  Workqueue: kblockd blk_mq_run_work_fn
  Call Trace:
   <TASK>
   dump_stack_lvl+0x80/0xa0
   __might_resched+0x231/0x370
   down_read+0x73/0x330
   vduse_vq_kick+0x30/0x120
   virtio_vdpa_notify+0x63/0x80
   virtqueue_notify+0x45/0x70
   virtio_queue_rq+0x19d/0x300
   blk_mq_dispatch_rq_list+0x269/0xe20
   __blk_mq_sched_dispatch_requests+0x761/0xa60
   blk_mq_sched_dispatch_requests+0x6b/0xc0
   blk_mq_run_work_fn+0x143/0x220
   process_one_work+0x581/0xcf0
   worker_thread+0x2fc/0x5a0
   kthread+0x1cc/0x210
   ret_from_fork+0x3c4/0x540
   ret_from_fork_asm+0x1a/0x30
   </TASK>

Without CONFIG_DEBUG_ATOMIC_SLEEP, a kick that finds the rwsem
write-locked by vduse_dev_reset() or vduse_vdpa_suspend() blocks inside
an RCU read-side critical section. The vhost_vdpa path kicks from the
vhost worker, i.e. process context, which is why this went unnoticed.

Check dev->suspended under vq->kick_lock instead, which the kick path
already takes, and have vduse_vdpa_suspend() cycle every virtqueue's
kick_lock after setting the flag. A kick that observed suspended == false
has thus finished signalling before suspend returns, which is the
guarantee the rwsem used to provide. The flag is now also read outside
the rwsem, so access it with READ_ONCE()/WRITE_ONCE().

Fixes: b282418bc366 ("vduse: Add suspend")
Signed-off-by: Nikhil <nikhilljatt@gmail.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 9891cd2cf712..766789a7bbfa 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -506,7 +506,7 @@ static void vduse_dev_reset(struct vduse_dev *dev)
 	}
 
 	scoped_guard(rwsem_write, &dev->rwsem) {
-		dev->suspended = false;
+		WRITE_ONCE(dev->suspended, false);
 		dev->status = 0;
 		dev->driver_features = 0;
 		dev->generation++;
@@ -567,11 +567,17 @@ static int vduse_vdpa_set_vq_address(struct vdpa_device *vdpa, u16 idx,
 
 static void vduse_vq_kick(struct vduse_virtqueue *vq)
 {
-	guard(rwsem_read)(&vq->dev->rwsem);
-	if (vq->dev->suspended)
+	/*
+	 * This runs in the context of the vdpa kick_vq op, which may be
+	 * atomic (e.g. virtio-blk kicks from blk-mq dispatch under
+	 * rcu_read_lock()), so dev->rwsem must not be taken here.
+	 * dev->suspended is checked under kick_lock instead and
+	 * vduse_vdpa_suspend() cycles every kick_lock after setting it.
+	 */
+	guard(spinlock)(&vq->kick_lock);
+	if (READ_ONCE(vq->dev->suspended))
 		return;
 
-	guard(spinlock)(&vq->kick_lock);
 	scoped_guard(spinlock_bh, &vq->ready_lock)
 		if (!vq->ready)
 			return;
@@ -946,7 +952,17 @@ static int vduse_vdpa_suspend(struct vdpa_device *vdpa)
 	ret = vduse_dev_msg_sync(dev, &msg);
 	if (ret == 0) {
 		scoped_guard(rwsem_write, &dev->rwsem)
-			dev->suspended = true;
+			WRITE_ONCE(dev->suspended, true);
+
+		/*
+		 * Kicks check dev->suspended under kick_lock without taking
+		 * the rwsem: cycle each kick_lock so that no kick that has
+		 * already passed the check is still in flight after this.
+		 */
+		for (u32 i = 0; i < dev->vq_num; i++) {
+			spin_lock(&dev->vqs[i]->kick_lock);
+			spin_unlock(&dev->vqs[i]->kick_lock);
+		}
 
 		cancel_work_sync(&dev->inject);
 		for (u32 i = 0; i < dev->vq_num; i++)
-- 
2.43.0

