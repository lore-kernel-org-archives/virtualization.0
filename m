Received: from mail-pz2-f20.google.com (mail-pz2-f20.google.com [74.125.228.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A53D4052A2
	for <virtualization@lists.linux.dev>; Mon, 14 Sep 2026 13:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789392989; cv=none; b=CQ8E8XwncSOw8Vn62V6qVhdjz7uQuCngHlJd9enhYeVwSzP93+reZBeYadF8eXqt3/tf/qh57VLxLcfhC8to8qrQyAmrLna09y5b8h+YMlC7irL5O/YzsV2LSpKGmcd3HYpulfmWed2dEfsoAZtZiocA6rFQCw+dyc28IR7t4VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789392989; c=relaxed/simple;
	bh=/meGI1Tm/tBlcwjTqS5kgSZy411s5gxaStb0PgqmkWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j6CpanE1i6eWzQZrFn0LayjY0zPHzWwnfN0EJCVYpQLBOVpbbQHj9vBk+kZ0becbWsayTJT3mCgYsF2PBpvqfFafJ64mfm+EYU//TJIBwG4WrmZiuw9ULqWjrDG912jnRpr5u+wcNtoBQwx6m7H7Evy9WclMycaZCibIvhOUSng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIsgfOOg; arc=none smtp.client-ip=74.125.228.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIsgfOOg"
Received: by mail-pz2-f20.google.com with SMTP id 41be03b00d2f7-cc4ae61629fso1439370a12.2
        for <virtualization@lists.linux.dev>; Mon, 14 Sep 2026 06:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789392987; x=1789997787; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kcAESydmQLFB9r6OKjQ0xxj/qfnH2J6wLUt6Y4fcG04=;
        b=SIsgfOOgMeRIntVS92BSP/pTqCd41iIsHxz6+VshjzZhPUn6fHVPRE9NKeZhBCFcLi
         UGNWPhd5W7m5Zr0wSEwFGwAjc+hW4je6+YORBJXvhJyvVzSLqQC/1ThfpwooQ8paObEb
         mAQVevIDZ6DO078nSko41fVklTMYKWYCZ6hsPiMm8vpRIWAQRemrVDlpmIRd54DlUINI
         Vk5K4gE1WEAjA0Nom0UQtOgQk3wRIWGzS61NyZxASoaowbA+vSU1lyG70O/eA/Cr2Z2/
         6413Sv0YAxO6r4jPb7I76G6KabcNu59Zefcbw7RCLb1cc7B3KAaJQ7apEYUYeryXj4dC
         1A5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789392987; x=1789997787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kcAESydmQLFB9r6OKjQ0xxj/qfnH2J6wLUt6Y4fcG04=;
        b=hN3yXWp8u/6jXKmby1xlRG20oBnztKGDEBy/k2kH9YUrv0y2R62f+ZT3C/jmpeCTjW
         5uY4jGwleB3Rg2tIC4kFHICqXivLt6Udx4l63mg6m6Jy6ErsOZkM7zGhka0ASIetW6ay
         +NFp10/znuHKD26Dq9fcPZQrrJkL/hKMslySMV6dahKI+FElqXPSilIi4UO0dbmyGcmK
         maJ4CNYlLqEqbVZ+OgOD82WtgQ2F8s3QhklDOCTqAS8cYy57MSQQm6UJZzf/zJVLGrNL
         kzuNvUyIAz7x98zJTE3WNMVJ/TTTtKIKFgLb6kfyzr722xm8g0qFUT0wru7s2nNe8kkq
         WmpQ==
X-Forwarded-Encrypted: i=1; AKwUvBzlGBrw3GUYfb7H8D2w50gR/VXrksV5sKm5ibDY+cqgnqGy4PywQ1bCU0D8T0l92OyZfTpymX9WJ/6sPkvksg==@lists.linux.dev
X-Gm-Message-State: AFuF++mVBdwk+PChRfVWldecZOq+A1gFMb3B5lhdMb/C+2t+2MvXBMC8
	kFsyzawjUwSVT4d5PZqPNeIN2BAe/PrWuYiOE6ogM9MZjyZbWdnifRdq
X-Gm-Gg: AYBFou1fWD2Lo0IngdZhikJ1ykLPD59gF1T+PAU6TfKsmaB36QBpBB7FYlKGL0PYuwA
	4BSsVd9wnKVqpONAwSYpfU2X03IWGM38r97S14z/G4Iaa+Wr6wThUQH/QLZROLUj9DOWAw6xoZ6
	67V4MF55kdR8xk0WBgyWVDRopFbqG6BUidRljRIMqY0i9WpA1N95j03UacBhSj5l6M3vtzXvgFm
	CeGiapa3Q4q/4c3bnO6sx+KL+R1lHtIC1OHQPBCE/3BXYgpJK+DA6G5caz2X4KeBUk4lPMxw/gw
	eiFipjMTryXrJMNlh/kasu02OIGmzFn+3NxdI1sj4pnGPi3SA7THLC3iqkZSmRb9t4944i4wolC
	201r5zdfYh+gcSoNuysD7kvgpTVVTgezUyG0b557aePk78DGwwQdalyizpmkhz4plef2cFW1GDq
	qK32ThWp0SfbfwtUN7OisBftTyJ7ajIsoyWZNMZMSKSMao0Zbk4MdkY8vFQX1h0QzW7tX/fb+Tf
	Z4NVLftiAreIv8cjw==
X-Received: by 2002:a05:6a20:430f:b0:3da:6bdd:2c74 with SMTP id adf61e73a8af0-3db404bcbc1mr5150299637.10.1789392987256;
        Mon, 14 Sep 2026 06:36:27 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:1d4a:e90:380f:6f8c:214d:70f7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4c6549ec0sm5081489a12.15.2026.09.14.06.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 06:36:26 -0700 (PDT)
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
Subject: Re: [RFC PATCH] scsi: virtio_scsi: bound EH timer resets to avoid unkillable hang
Date: Mon, 14 Sep 2026 20:36:20 +0700
Message-ID: <20260914133620.15712-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <28865bba-ac60-4c6e-aec8-64b1fcdb1c8f@suse.de>
References: <20260911163509.684191F000FF@smtp.kernel.org> <20260911164417.33860-1-ngocthang2710.1999@gmail.com> <28865bba-ac60-4c6e-aec8-64b1fcdb1c8f@suse.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 9/14/26 11:17 AM, Hannes Reinecke wrote:
> So the better fix would be to implement a host_reset() callback for
> virtio-scsi which would reset the virtio setup, terminating all
> outstanding commands and reset the queues.

Thanks for the suggestion, Hannes -- that's exactly what the patch
below does (also posted separately as [PATCH v2], Message-ID
<20260914133144.15509-1-ngocthang2710.1999@gmail.com>; linking it back
into this thread since the subject changed and a couple of mail
clients won't merge the two threads on their own).

It adds eh_host_reset_handler backed by virtio_reset_device(): once
virtio_reset_device() returns, the device is guaranteed to have
stopped touching guest memory, so it's safe to let
scsi_eh_offline_sdevs() free the stuck commands' DMA buffers
afterwards -- the guarantee that was missing before (falling through
to offline with neither target, bus, nor host reset implemented).
Reuses virtscsi_remove_vqs() + virtscsi_init(), the same
teardown/rebuild sequence already used across suspend/resume.

Verified against the same QEMU virtio-scsi repro (PCI_COMMAND_MASTER
cleared mid-write): EH now runs abort -> device reset -> host reset ->
abort -> device reset -> host reset -> offline, dd's stuck fsync
returns EIO, D-state drains to 0, ~244s total.

Suggested-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
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

Thanks,
Thang
