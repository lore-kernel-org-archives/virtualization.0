Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9A73D88FA
	for <virtualization@lists.linux.dev>; Mon, 14 Sep 2026 13:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789392714; cv=none; b=LJnPAS6uoBerlvZCD2eb+ZKxTDTJWGhzsdnS+eJeRa0akVwVk/pGUTo2pwFR166b9yyqBytohFsmVZho/VZhid9jdIZue5YAAP1j5PBL6CV1PeUHj0OJ6+vNzLeAp1Fws7nnhhmIq4re269h2+RXEnNUK24vrpm5i/34c0wFS9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789392714; c=relaxed/simple;
	bh=bMsdMvSus7U2Fs9+6bR7h1oluEPI74JhEILnfWIGtj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZDE2CGQG4yHdsx7pYW8rJio0FbFRXe/QSdr9ZNhxR5Lz88+A4kWoLHwhK1npKvfapXZzKCqESQE+t6wgYVDw02z2KbqtQx/vf2CICWrl5lrn08R34qAmUnnHhafgz8YfcnrEaPUrEiAYa2A02WassX+qzBX9hg/Nswp5XfdIFrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qacJh03g; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qacJh03g"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d8fe517774so26314495ad.0
        for <virtualization@lists.linux.dev>; Mon, 14 Sep 2026 06:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789392712; x=1789997512; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=msYkVtDkbmBFevf86iAldrO7owfuyjwEGQdpBpjsguY=;
        b=qacJh03gO9ObdEylQImFU072F0b+3F3O5IDxgiHt7qPAPG9G/oFPvhWugjTipEndBH
         V0lMi5ZChINyJiJhSawuDNd+cns47NWml2fq5R63Mk8o9Y567n7AJYMu8xG4ANCv1WN9
         Fm6cQBMinRRc8ZUZE6tE3Iv4Wj/56FD8tLmFFE2FXl18Pw4ts1NEPY0rJdpuo4YxKdQI
         X5z9c+I/8uv7eMoGQhGDbgOqVbQxzjZFGa72V04ZFkemKzivsCsit0utERFnePgxVDjY
         qQ6SXz4jt91wCmMpxsrTQFuM7ORM6ymEVL0nQnzZ3vdJgUh7Lk18LRI8ynoQf2MTEWcW
         DCPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789392712; x=1789997512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=msYkVtDkbmBFevf86iAldrO7owfuyjwEGQdpBpjsguY=;
        b=GQg9InrBjlZyWl55ZIR/tJJeKosCKWvbx1ZKZnzQeN3BZYPtdBiRL8S3SoNWtE9iH9
         6/6I5PdXMCdiaoQvsjExmarGFBiTmJSUzZjH27vcUzpLdWsOi3EVdGsjtRT6Ag7Ow9PO
         1mta0sdVJkkROpDvMHWg9fYJndhmz4PXk8t/K/Vn5audN1byQlyDfC51TR5hxCcn0nGt
         xDdODEUj+E2/waKJMZKk3Z7tQfYdp8zMu0UWscQysejP+wAOh4iesqRqRydYFS4Yys6w
         QFHILD76JT1qyLxCca3CUnySnKRN0ZDkLHOdNBZ19JTl6iNedhQoYDTpJypit9aGKzuK
         fsZw==
X-Forwarded-Encrypted: i=1; AKwUvBxBkK4nD/mRzL6B/KcU0YzvQn0sXlQvxvym3xDQ1eXV5XfsBc29R6pl+bqyZ6WSO9yH2ccHgh3QuXEuIEIoCA==@lists.linux.dev
X-Gm-Message-State: AFuF++mgILtHYNlJ0pT5d5mZx23SVA+LVaD1qLNQP7p4M0nlqXUUU/p5
	CLHNx+ggZGNRRe96jKrr+sbhs1PBgIsZmhBCiV7D5nDeuW3kXeonelIS
X-Gm-Gg: AYBFou147zIYFu3De4RhXnVd6/lkv1wJsZG9biZ7n6EoFf0TGVMfUvb4T4256G6FWl6
	wM1fEsZwkjK2s18MpLXIeL4HiFQ6JT/iaaSha6AoAa+Gklz2o5geZiHjBT73pPl5ni+5MohSfIq
	2M9gso4xt67Pd+3D/s5+CD+1H/9rdzbeZTtXYUNDjA/DMhKT/M5YaubkkCrNQzb4J87bGifPpZi
	BoEWMJTBNFH7rsGiUfgDfl5Z4dhSA6TUMSr7Eqafna+DsF9JT7HyUYoVv+ApR3RTMmm98vC76DN
	HBRVDyOPgSsoxeofHKwtsEFkYLnnemVVZiBmpywWwUwmDY2O2ANKYrJ9/w82V7IFADfzhgwVXDq
	FYpxVgOH2TllI/1iAvVkJdOvTte4OqYbGJyAPdTE6zFmguTkDU9Jhbp4XCj8ZGFKgnh6Ix7wSod
	0TRS4/zRs4wrWe127Mct/u0qH1dtjlXJ8vL/RC4o6F5/S2ABssbgaNPC7xvwda6wr31oqQOehOQ
	iRrt8W4IEV5B1rKIg==
X-Received: by 2002:a17:903:94e:b0:2db:117e:cf50 with SMTP id d9443c01a7336-2dd6c5bfe2bmr63442775ad.4.1789392712534;
        Mon, 14 Sep 2026 06:31:52 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:1d4a:e90:380f:6f8c:214d:70f7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2ceb1c94sm48433875ad.31.2026.09.14.06.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 06:31:51 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
	mst@redhat.com,
	jasowangio@gmail.com,
	mkp@kernel.org,
	James.Bottomley@HansenPartnership.com,
	pbonzini@redhat.com,
	stefanha@redhat.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: [PATCH v2] scsi: virtio_scsi: implement eh_host_reset_handler
Date: Mon, 14 Sep 2026 20:31:44 +0700
Message-ID: <20260914133144.15509-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <28865bba-ac60-4c6e-aec8-64b1fcdb1c8f@suse.de>
References: <20260911164417.33860-1-ngocthang2710.1999@gmail.com> <28865bba-ac60-4c6e-aec8-64b1fcdb1c8f@suse.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Once virtscsi_eh_timed_out() lets SCSI EH run on an unresponsive host,
abort and device reset both fail the same way (same dead ctrl vq), and
since virtio_scsi implements neither target nor bus reset, EH falls
through to scsi_eh_offline_sdevs(), which frees the stuck commands' DMA
buffers without any guarantee the device has actually stopped touching
them. If bus mastering (or whatever broke the transport) comes back
later, the device can still write into memory the kernel has already
reused.

Add a real eh_host_reset_handler instead. virtio_reset_device() is the
guarantee scsi_eh_offline_sdevs() was missing: once it returns, the
device will not touch guest memory again, so it is safe to hand
outstanding commands' buffers back. Reuse virtscsi_remove_vqs() +
virtscsi_init() -- the exact sequence already used across
suspend/resume -- to tear the virtqueues down and rebuild them.

Verified with a QEMU virtio-scsi repro (PCI_COMMAND_MASTER cleared
mid-write): EH now runs abort -> device reset -> host reset -> abort ->
device reset -> host reset -> offline, then dd's stuck fsync returns
EIO and D-state drains to 0, in ~244s total. No task remains
uninterruptibly blocked.

Suggested-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
v1 -> v2: implemented eh_host_reset_handler as suggested by Hannes
Reinecke in review of the original RFC, instead of relying solely on
the EH loop falling through to offline.
---
 drivers/scsi/virtio_scsi.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index b4f20c487718..9698f4f91cc6 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -833,6 +833,8 @@ static enum scsi_timeout_action virtscsi_eh_timed_out(struct scsi_cmnd *scmnd)
 	return SCSI_EH_NOT_HANDLED;
 }
 
+static int virtscsi_host_reset(struct scsi_cmnd *sc);
+
 static const struct scsi_host_template virtscsi_host_template = {
 	.module = THIS_MODULE,
 	.name = "Virtio SCSI HBA",
@@ -846,6 +848,7 @@ static const struct scsi_host_template virtscsi_host_template = {
 	.eh_abort_handler = virtscsi_abort,
 	.eh_device_reset_handler = virtscsi_device_reset,
 	.eh_timed_out = virtscsi_eh_timed_out,
+	.eh_host_reset_handler = virtscsi_host_reset,
 	.sdev_init = virtscsi_device_alloc,
 
 	.dma_boundary = UINT_MAX,
@@ -947,6 +950,27 @@ static int virtscsi_init(struct virtio_device *vdev,
 	return err;
 }
 
+/*
+ * No bus/target reset in virtio-scsi, so EH lands here after device
+ * reset also times out. A virtio reset guarantees the device won't
+ * touch guest memory again, so stuck commands can be freed safely.
+ * Same teardown/rebuild already used for suspend/resume.
+ */
+static int virtscsi_host_reset(struct scsi_cmnd *sc)
+{
+	struct virtio_scsi *vscsi = shost_priv(sc->device->host);
+	struct virtio_device *vdev = vscsi->vdev;
+
+	scmd_printk(KERN_INFO, sc, "host reset\n");
+
+	virtscsi_remove_vqs(vdev);
+	if (virtscsi_init(vdev, vscsi))
+		return FAILED;
+
+	virtio_device_ready(vdev);
+	return SUCCESS;
+}
+
 static int virtscsi_probe(struct virtio_device *vdev)
 {
 	struct Scsi_Host *shost;
-- 
2.43.0

