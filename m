Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EC5178367
	for <virtualization@lists.linux.dev>; Wed,  3 Jul 2024 12:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720010398; cv=none; b=BkjlDHzfi+Z9eAIvGE/CI6iy4eKOjFrStCNfMMqagq9NqXPmD+lsn43ThB8IfzJTgYpyIyfTmCnzx6IJnvh0NfVSoyx5A7RZ1bLp/sUq9hoPQ2GHUnCKj2L7Y0/nutR+WnBw4+Z9F7ByfFzP37rPJl/bOqKjugRK0/uaX27DG+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720010398; c=relaxed/simple;
	bh=ch4fM0LPEhhKbk8Zr1Z5yXU5RX27v4ssLFG8UrsKFj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=djOBd7kF16vVAHKL1MTTFdH5QI60A5MMHLBsHqf4HK32IBQe6q7Sc/7+IDaKVyWwoNppXR2ST53p6HK/kdKZ33GW+PWz7CsdFT43UaqmWUYZ0LM+6Dt9L36BrmmePZPNqGz4gBa06CEhb1XDY06vCfQsT5jNG1PtX/QTbabhepE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=hCFMbPSg; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="hCFMbPSg"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42579b60af1so31217715e9.2
        for <virtualization@lists.linux.dev>; Wed, 03 Jul 2024 05:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720010395; x=1720615195; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WR765p0dtwKNmX56hPQrnHk3MMdea8+L2qy90DiaX9s=;
        b=hCFMbPSgduXXIkIJNuoLflgUIwFR+YfUB5XQZ+ngyfEWpKZrVitdtYiarsCsaT/XQ2
         UlAAPb29hvOeyHIZEQIizAXfXG1dbE8/9EhVuLLRh6HdT4we+Z/1szBAlanb1CU5TYwd
         g3gUO3OUq87y2oMWK4Pw0fqqFXDhzOV62M/8w/aVdWJGH+YQ3FCtQE1c5casSeRC/8Y+
         Nw3BPIhY4ebYUOTZS/fT/Pu8ZqkOh+w5yh5M5Vi2BDw8TxYjklPN4loSsQ0Zc6fHN4//
         eTq7GpwCi73TMJMt2b7i/tAxDsJZ5ifopXU5jydDUb+B0GwwrbF8ncAo8Bf2ksVyHnnd
         QUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720010395; x=1720615195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WR765p0dtwKNmX56hPQrnHk3MMdea8+L2qy90DiaX9s=;
        b=FNkAknb1SiFp10dKeOw2IudMOXkrBunWoTMMuAMCja782D0d4YVA2KFKyr7LgXKGHf
         K/BzVGXo02XAnGFrpOuh31ZdhWjhypuuSwskvHSfxA1/ky5Ke7Ff+Ei1i22nimVT4jhq
         voB8p0L7AEmUKdWvNDu3WW18NmD6NVdYD5H5tB6oRNaAA6LxpFHq4gQ/Dcy3Plv0jMXF
         CMtk9bPoaB9t0TXasD2IWAUYgoxYZz3Xjje4jdiNqAzRwSGWqWgmAK4XP7mAtDASboGK
         Yi2TiVHNqnsNzVf/C1jKhDUZL4SNvmpF3jZLg6GIrIfqRQS7462WBJMh3TIoD+j0gMBI
         SRGA==
X-Gm-Message-State: AOJu0YyPXOQpLd3cV13We9+vlZca+daUi/uAycePxwXgNT0+X5s/DjMk
	J+pLdyzLhQU/daPr/CUUEeX9KI1pjB+gL9SzHidn8R/0UiCtVK3XyxbMJaeZddRSHuh+8FnRMZj
	N
X-Google-Smtp-Source: AGHT+IGHNH4O3x896GIV/SOqNOjbU7TTKQeqL9b1iSFiY6gdBpGiOD/EXYJbuStH+g0msY8RYumYMw==
X-Received: by 2002:a05:600c:4f4f:b0:424:a6ac:f274 with SMTP id 5b1f17b1804b1-4257a06dad9mr75332125e9.38.1720010395128;
        Wed, 03 Jul 2024 05:39:55 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b099c72sm236966205e9.37.2024.07.03.05.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 05:39:54 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio 14/19] scsi: virtio_scsi: convert to use virtio_find_vqs_info()
Date: Wed,  3 Jul 2024 14:39:08 +0200
Message-ID: <20240703123913.969202-15-jiri@resnulli.us>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703123913.969202-1-jiri@resnulli.us>
References: <20240703123913.969202-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Instead of passing separate names and callbacks arrays
to virtio_find_vqs(), allocate one of virtual_queue_info structs and
pass it to virtio_find_vqs_info().

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/scsi/virtio_scsi.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 89ca26945721..416c6820b537 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -841,19 +841,16 @@ static int virtscsi_init(struct virtio_device *vdev,
 	int err;
 	u32 i;
 	u32 num_vqs, num_poll_vqs, num_req_vqs;
-	vq_callback_t **callbacks;
-	const char **names;
+	struct virtio_queue_info *vqs_info;
 	struct virtqueue **vqs;
 	struct irq_affinity desc = { .pre_vectors = 2 };
 
 	num_req_vqs = vscsi->num_queues;
 	num_vqs = num_req_vqs + VIRTIO_SCSI_VQ_BASE;
 	vqs = kmalloc_array(num_vqs, sizeof(struct virtqueue *), GFP_KERNEL);
-	callbacks = kmalloc_array(num_vqs, sizeof(vq_callback_t *),
-				  GFP_KERNEL);
-	names = kmalloc_array(num_vqs, sizeof(char *), GFP_KERNEL);
+	vqs_info = kcalloc(num_vqs, sizeof(*vqs_info), GFP_KERNEL);
 
-	if (!callbacks || !vqs || !names) {
+	if (!vqs || !vqs_info) {
 		err = -ENOMEM;
 		goto out;
 	}
@@ -869,22 +866,20 @@ static int virtscsi_init(struct virtio_device *vdev,
 		 vscsi->io_queues[HCTX_TYPE_READ],
 		 vscsi->io_queues[HCTX_TYPE_POLL]);
 
-	callbacks[0] = virtscsi_ctrl_done;
-	callbacks[1] = virtscsi_event_done;
-	names[0] = "control";
-	names[1] = "event";
+	vqs_info[0].callback = virtscsi_ctrl_done;
+	vqs_info[0].name = "control";
+	vqs_info[1].callback = virtscsi_event_done;
+	vqs_info[1].name = "event";
 	for (i = VIRTIO_SCSI_VQ_BASE; i < num_vqs - num_poll_vqs; i++) {
-		callbacks[i] = virtscsi_req_done;
-		names[i] = "request";
+		vqs_info[i].callback = virtscsi_req_done;
+		vqs_info[i].name = "request";
 	}
 
-	for (; i < num_vqs; i++) {
-		callbacks[i] = NULL;
-		names[i] = "request_poll";
-	}
+	for (; i < num_vqs; i++)
+		vqs_info[i].name = "request_poll";
 
 	/* Discover virtqueues and write information to configuration.  */
-	err = virtio_find_vqs(vdev, num_vqs, vqs, callbacks, names, &desc);
+	err = virtio_find_vqs_info(vdev, num_vqs, vqs, vqs_info, &desc);
 	if (err)
 		goto out;
 
@@ -900,8 +895,7 @@ static int virtscsi_init(struct virtio_device *vdev,
 	err = 0;
 
 out:
-	kfree(names);
-	kfree(callbacks);
+	kfree(vqs_info);
 	kfree(vqs);
 	if (err)
 		virtscsi_remove_vqs(vdev);
-- 
2.45.2

