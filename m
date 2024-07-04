Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8601F1A08C5
	for <virtualization@lists.linux.dev>; Thu,  4 Jul 2024 06:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720075466; cv=none; b=UNPTXhT1zMxSdkaf6LD5WhnMOAmtbkgYppiG4Z9IyDIeetQQEqPJO1uOQYhwlmkAOCEEdZ009aQAaSHnPanLQ9iEszQzNQsQCLfBdfeGy2QmuMguuV4Z30w6rK3XuF6dPXP4VMov6XbrG4jOD9TKMYPNXhbqG2cstH3ORMwuSBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720075466; c=relaxed/simple;
	bh=U4ygZ/tFwG0s56hlxiMB2n1mk1WU1EcSSSBWZY4P5LU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ChPOoemMsqwm3VZI8u7KzNpCFCVXRctrbMMAls2EJqVMIMovzdhrx5+BauzzYLfG6sOwvUpmACwNRD1e3yMtBUV+rYJiADi0iAbtfpEhXgF7FZzFCoqIqUZdWe2GqOvCvF5IOYN3guTziuuVVEdmguf/8J3mF0dA1C8Rk//DQkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=O9F6h831; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="O9F6h831"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4264a3847b6so1858905e9.0
        for <virtualization@lists.linux.dev>; Wed, 03 Jul 2024 23:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720075464; x=1720680264; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5tCFFS5gNFbl+K6rTd58Jmf+xQIRoDva1eFtn4QlWQ=;
        b=O9F6h831IoOu99Wfm+jcfXlDuXE0O2WqLyc7c+gwLhAX3B5WkrX+acH/Ykfln6fHzt
         xYhv3jte/kKC/YeWVTdLgr1x15P5F3OCwhYaC5cp4tIa/33tKjfWtHPGVk6FKzw2iyXK
         m3XKzdGNNmsQ5qP7IhwXORv3/xKwjVJH23zOtplqGXu0gJO/+djfaAzK6mpv6vHl9N8l
         oU1CroLjWp2Avn3mWLQJ4LmXWk63z0aBoe4D+0O50a0p5yDlP/6JXkjPBA4XSILgs0Kf
         QLcWuLvuf/s5vqdv7UgDn9w0YdBlKuIsYHat55gs2DF0QgJZlAJeX+rotImebzWVFmxC
         oYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720075464; x=1720680264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N5tCFFS5gNFbl+K6rTd58Jmf+xQIRoDva1eFtn4QlWQ=;
        b=XJ2qDMSfSObr3FKOzDcgupEJvmB+aCbfJoonfAu8XBAdcDC74jKsEZCl4OaGfE3Osv
         P2Pd2YLNlxjyaUnl4DKACuXVWZ4Z9k9JsjaaBkAKpWvFdJPbLlotazcFnk125/wG4yxL
         fcPTrzDgyMcNlO9zK2cfSzwNCsYohp3MWUW3zjzCyspc+zHOrXbvI0wj5e5Db4XIL0FX
         7DJt7pxhD4+yQDDOx0xM7fEgSnSxAx5cmlaax/TIVYlz+QLRXmRdiG4akfFeUSfLxElp
         9J7Kacg5Y1Xzr6+AwLDW/U5XY7l3IShlmP1Hot7W5zVC0RNledjnkfIu6xuz/Ct7v462
         Gu3w==
X-Gm-Message-State: AOJu0YycJKC/PRva5sV7gCxzT0ZejosnQkQrCdy0Ie2l2BM7lK4ittKw
	GadzShytc7Fo+PkM58Krl7KulytLI6p+XDk/87cPRqDteJoR86dlCNbGoxLM60+vOomBroF9Fso
	q
X-Google-Smtp-Source: AGHT+IGfJlImE1SNDEIiMY82ZaibFR+Caz3gtCvzkwmRkLAakNwpxKipPSugnm2BNQJ9DFl6qpQnvw==
X-Received: by 2002:a5d:4567:0:b0:367:8a24:dd2d with SMTP id ffacd0b85a97d-3679dd739a1mr464040f8f.65.1720075464096;
        Wed, 03 Jul 2024 23:44:24 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0cd784sm17649249f8f.7.2024.07.03.23.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 23:44:23 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v2 14/19] scsi: virtio_scsi: convert to use virtio_find_vqs_info()
Date: Thu,  4 Jul 2024 08:43:45 +0200
Message-ID: <20240704064350.1097716-15-jiri@resnulli.us>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704064350.1097716-1-jiri@resnulli.us>
References: <20240704064350.1097716-1-jiri@resnulli.us>
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
v1->v2:
- s/virtio_queue_info/virtqueue_info/
---
 drivers/scsi/virtio_scsi.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 89ca26945721..bf9346a66df2 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -841,19 +841,16 @@ static int virtscsi_init(struct virtio_device *vdev,
 	int err;
 	u32 i;
 	u32 num_vqs, num_poll_vqs, num_req_vqs;
-	vq_callback_t **callbacks;
-	const char **names;
+	struct virtqueue_info *vqs_info;
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

