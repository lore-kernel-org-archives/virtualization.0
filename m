Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE42249F13A
	for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 16:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789143689; cv=none; b=I/qGfCDByejG79ZhCmF2mrmf04dmVt4sFlwYy8ALukqJLrLY3myZc9asE40JLrm3XkYnvqH7hAm+CQVaic4N/oqWz8eUpN9G/BDKQfVAW7dOG+vOjx5VzU9I0DPltTx55P6UHHdHWooUdPXw4HyomuJ8yC50p6GMXINhA8LHM88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789143689; c=relaxed/simple;
	bh=S1ENme052wMNFkY0+NQvj/AsSy0pVsRnb9curA5kdsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R9TwovK7Qq75Fnm2mUQlTiWmtfmo48gc/fu9SlvL+CBa39Z1TEWoQcH6GW4KB6NPOHvHfRlo34ObBXcQFbOGaCCZ6np9WsdfUS/f6yBrGxULTF/wHHFWCJQXREk5wB9OhK4uAw3eVYnjpqWuKfDk1fuCWx11SV9nqZ+PXfYfxw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9tg1N16; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9tg1N16"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8557c3f270eso1125926b3a.3
        for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 09:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789143687; x=1789748487; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OWiuSXnfujaiQ1izanqTrt5xnxdwldQIkKoLEBQrQ6U=;
        b=a9tg1N168rDG4hecYZQKRFre3SBtDbwmQC+D9GwN9KCyDJ6wvDYOeoSnvi/7PifmFd
         dLjS0A3UseT+WCwG5ZPoMMhagdhle7BVMVNKFqHtmqQ8fmDgYafozplyJlNouXZ7aZp7
         BNOS8tiXammBw5CD2yWli80AA8n/d9HQTOPrr0PUW8rizbhdczNd/ENbq1qYF94OKnKP
         WBDNYReYYChPut3k2Cv0RB6bFYnUnQIoEeR+Z/gU3g5kSyj7E6SzX4X1fBsf44+Gye16
         AT2YPetzFY/AU9EpRgReHrwGpa+1J2hQQAFhGnUHSI4AT0LkZioJcYAIQv1LXsvY6hai
         VtGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789143687; x=1789748487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OWiuSXnfujaiQ1izanqTrt5xnxdwldQIkKoLEBQrQ6U=;
        b=cvNc89n7P0gvyMJKgQ3YH/1umoLBH/i2AKA1YbM3S3Q8W1uKH6Bq/lZjaUAKtRrQ7K
         24rRg98S+Nv8c3T8Tb2mzt8coLmTSOHMWpVpUMVl8gG4fdfT1ORKEzSnNrQ5CCBCgXRh
         Nh84A7i7sbRvEguO3w8VkfU/OupSQa1kpb1WbD/U1zMniOZGSp5SKU8ti6kZzsx9gU0I
         g40g7oLnbD8gJsCplnRRipjL0WsmQGFBcIHHVEjS/0t8KTe0eIYkhOgJ2r2zYZ3HcsGm
         x487tMxfrpsu/RLVpe+FCdvDuxY82VanbmFwTqKhrBFY8d/yjDzodG+/QFxk0m80Tnhm
         isKA==
X-Forwarded-Encrypted: i=1; AKwUvBwjndRsyyg3cKeZVF0HNYpfzO3MYRbCWNh8ikOgtRRQz+2GXQt0JJstzAsCdZNKCa71Tw9xwuxyX79UmrIgRw==@lists.linux.dev
X-Gm-Message-State: AFuF++nEZSR31nNH+GAx1MaMS0Ma2vurNGBi/hfSSsCToRPChvb/CGIe
	huCWE8xak88mpBHp2REF8LiaoHnhL7wAyiatXUxEJUY6IHjeLXQja14j
X-Gm-Gg: AYBFou2v5B1He3Etc9Zu58yeWQwfUMI1h85JjTpLUrKZwJDvqoQazINPxMQ/OLgo+mj
	ZUGg0J/Q0kQ6YxyXtlDqRZCj8B8QGZaI8y/oo0jhPf3AnEYRyJGBkZQbwO5WzXZB9ReMCNxonxO
	UIpL3pOLEf2sxgzcbh6un/7oBMIRH16IIUy6un6/eHYpIN7bhI+5n05We+8UoCwoOkSl+qTomwS
	Q1VY5GpzIUTM5HA/NNdoOCDdzBdchCT2asxs0RfwXRCx0/uEFP3ABvp5CgbYtr2N2dPRgiFR86l
	l9W0Uj5UDZe/vF10jJXhqWypidAaVrFB5GHBI/fqfSrTB6TcnHwyv7RC/X1DUKP0/l/LW3OEKD4
	CqlSEB45N9MiDBh0fvWp8p6ObrLFWHFTEwzZG2VMFqvxrxpvEhiYLdByqs+3q3kyScdK/tcrKZb
	JcYyRsjRj2+inipJUNM1Q8X7yT44lceOH/tZGz3jjqBzKIQJHwzLHHV/QZXI5OOp4+r4PEGunN2
	vyvYFdWvcU1PuKEmQ==
X-Received: by 2002:a05:6a00:4103:b0:857:4dea:e2fe with SMTP id d2e1a72fcca58-86b32dea8e5mr8235798b3a.13.1789143687007;
        Fri, 11 Sep 2026 09:21:27 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:1d38:5c70:b928:dcab:35a4:adf0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b2a2b5c72sm1337539b3a.52.2026.09.11.09.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 09:21:25 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: mst@redhat.com,
	jasowangio@gmail.com,
	mkp@kernel.org,
	James.Bottomley@HansenPartnership.com
Cc: pbonzini@redhat.com,
	stefanha@redhat.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
	syzbot+53706c567afab5131044@syzkaller.appspotmail.com
Subject: [RFC PATCH] scsi: virtio_scsi: bound EH timer resets to avoid unkillable hang
Date: Fri, 11 Sep 2026 23:21:18 +0700
Message-ID: <20260911162118.32414-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reported-by: syzbot+53706c567afab5131044@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=53706c567afab5131044
("INFO: task hung in __rq_qos_throttle (2)", still open upstream, no
fix, bisection failed, 97 crashes since 2026-08-08)

virtscsi_eh_timed_out() always returns SCSI_EH_RESET_TIMER, trusting
the host to eventually answer every command. A privileged raw write
to /sys/bus/pci/devices/*/config that clears PCI_COMMAND_MASTER on
the disk breaks that assumption: the device can no longer DMA, so no
completion -- real or error -- ever arrives, and the reset loop runs
forever. Any submitter that then hits wbt's inflight limit blocks
uninterruptibly in wbt_wait() with no way to recover.

The syzbot C reproducer does exactly this: it opens the disk's PCI
config sysfs file and pwrite()s the two bytes 02 00 at offset 4
(PCI_COMMAND), clearing PCI_COMMAND_MASTER while keeping
PCI_COMMAND_MEMORY set. The hung task is a writeback worker stuck in
wbt_wait() <- __rq_qos_throttle() <- blk_mq_get_new_requests(), on a
disk named sdaN -- i.e. a SCSI-model disk, consistent with
virtio_scsi rather than virtio-blk.

Bound the resets: after VIRTSCSI_EH_RESET_LIMIT tries (~150s), let
real SCSI EH run (abort -> device reset -> offline), which fails the
command and unblocks rq_qos waiters. A host that is merely slow for
longer than that now gets its commands aborted/offlined instead of
waited on indefinitely -- a deliberate tradeoff.

virtscsi_tmf(), used by both abort and device-reset handlers, waited
on the same broken ctrl virtqueue unboundedly, which would just move
the hang into the EH thread. Bound it too. On timeout the command is
left queued on the ctrl vq (a device that answers late must still be
able to find it), so it is not freed. Clearing cmd->comp so a late
completion doesn't write through the now-invalid on-stack completion
has to be serialized against virtscsi_complete_free(), which reads
cmd->comp and calls complete() on it under ctrl_vq.vq_lock -- taking
that same lock around the check-and-clear (and re-checking
completion_done() inside it) closes the race instead of just
shrinking it. The leak is one virtio_scsi_cmd per timed-out TMF,
bounded by queue depth, on a path where the device is being offlined
anyway.

Verified with a QEMU virtio-scsi repro that reproduces the syzbot
mechanism above (pwrite of 02 00 at PCI config offset 4 on the sda
backing device, mid-writeback, via /sys/bus/pci/devices/*/config):
unpatched, a request sits stuck past its own 30s timeout with zero EH
activity even after 100+s; patched, eh_resets increments
deterministically, SCSI EH aborts/resets/offlines the device at the
expected ~150-190s mark, and both previously-stuck writers come back
with -EIO instead of hanging. Full dmesg from the patched run was
checked for WARN/BUG/lockdep output around the new ctrl_vq.vq_lock
critical section in virtscsi_tmf(); none appeared.

Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
 drivers/scsi/virtio_scsi.c | 51 ++++++++++++++++++++++++++++++++++----
 1 file changed, 46 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 35731b18c519..b4f20c487718 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -37,6 +37,11 @@
 #define VIRTIO_SCSI_EVENT_LEN 8
 #define VIRTIO_SCSI_VQ_BASE 2
 
+/* Max timer resets in virtscsi_eh_timed_out() before letting real EH run. */
+#define VIRTSCSI_EH_RESET_LIMIT 5
+/* How long to let the host answer an abort/reset TMF before giving up. */
+#define VIRTSCSI_TMF_TIMEOUT (10 * HZ)
+
 static unsigned int virtscsi_poll_queues;
 module_param(virtscsi_poll_queues, uint, 0644);
 MODULE_PARM_DESC(virtscsi_poll_queues,
@@ -46,6 +51,7 @@ MODULE_PARM_DESC(virtscsi_poll_queues,
 struct virtio_scsi_cmd {
 	struct scsi_cmnd *sc;
 	struct completion *comp;
+	unsigned int eh_resets;
 	union {
 		struct virtio_scsi_cmd_req       cmd;
 		struct virtio_scsi_cmd_req_pi    cmd_pi;
@@ -586,6 +592,7 @@ static enum scsi_qc_status virtscsi_queuecommand(struct Scsi_Host *shost,
 		"cmd %p CDB: %#02x\n", sc, sc->cmnd[0]);
 
 	cmd->sc = sc;
+	cmd->eh_resets = 0;
 
 	BUG_ON(sc->cmd_len > VIRTIO_SCSI_CDB_SIZE);
 
@@ -625,7 +632,35 @@ static int virtscsi_tmf(struct virtio_scsi *vscsi, struct virtio_scsi_cmd *cmd)
 			      sizeof cmd->req.tmf, sizeof cmd->resp.tmf, true) < 0)
 		goto out;
 
-	wait_for_completion(&comp);
+	if (!wait_for_completion_timeout(&comp, VIRTSCSI_TMF_TIMEOUT)) {
+		unsigned long flags;
+		bool completed;
+
+		/*
+		 * No answer within the timeout. virtscsi_complete_free()
+		 * reads cmd->comp and calls complete() on it under
+		 * ctrl_vq.vq_lock, so take the same lock to decide, atomically
+		 * with that path, whether the completion already happened.
+		 *
+		 * If it hasn't: clear cmd->comp so a completion that arrives
+		 * after we drop the lock finds NULL and leaves this
+		 * soon-to-be-invalid stack frame alone. cmd stays queued on
+		 * the ctrl vq (a device that answers late must still be able
+		 * to find it), so it is not freed here.
+		 *
+		 * If it has: the response landed (and complete() already ran)
+		 * right as we timed out, so fall through and read it as if
+		 * wait_for_completion_timeout() had succeeded.
+		 */
+		spin_lock_irqsave(&vscsi->ctrl_vq.vq_lock, flags);
+		completed = completion_done(&comp);
+		if (!completed)
+			cmd->comp = NULL;
+		spin_unlock_irqrestore(&vscsi->ctrl_vq.vq_lock, flags);
+
+		if (!completed)
+			return FAILED;
+	}
 	if (cmd->resp.tmf.response == VIRTIO_SCSI_S_OK ||
 	    cmd->resp.tmf.response == VIRTIO_SCSI_S_FUNCTION_SUCCEEDED)
 		ret = SUCCESS;
@@ -783,13 +818,19 @@ static void virtscsi_commit_rqs(struct Scsi_Host *shost, u16 hwq)
 }
 
 /*
- * The host guarantees to respond to each command, although I/O
- * latencies might be higher than on bare metal.  Reset the timer
- * unconditionally to give the host a chance to perform EH.
+ * The host normally answers every command, so reset the timer and keep
+ * waiting. But if the transport is broken (e.g. bus mastering was turned
+ * off), no completion can ever arrive: give up after a few resets so SCSI
+ * EH fails the command instead of blocking its submitter forever.
  */
 static enum scsi_timeout_action virtscsi_eh_timed_out(struct scsi_cmnd *scmnd)
 {
-	return SCSI_EH_RESET_TIMER;
+	struct virtio_scsi_cmd *cmd = scsi_cmd_priv(scmnd);
+
+	if (++cmd->eh_resets < VIRTSCSI_EH_RESET_LIMIT)
+		return SCSI_EH_RESET_TIMER;
+
+	return SCSI_EH_NOT_HANDLED;
 }
 
 static const struct scsi_host_template virtscsi_host_template = {
-- 
2.43.0

