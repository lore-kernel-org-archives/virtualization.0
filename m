Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6521A0AE4
	for <virtualization@lists.linux.dev>; Thu,  4 Jul 2024 06:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720075453; cv=none; b=kW3mRd2a92zfTIjmlcMzLo+ato79MpMJLGeR0uzFsLoV6azuJiiHJLEFEK3mNVLXmWsvKdHHhRZPotuYy4JNvTCC2zUhc/9h49x579u0qJ5IFdfdBQFZVk+6vRIHwbAW14iXL6Qqua8s/Jtrgmy2EiNfm5SgvOGAUUSavzc3KBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720075453; c=relaxed/simple;
	bh=udyE3MRYx0rbsDPmeRs+4PI9MU+3O8EBS34bTqcXA5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OZx+20Py054KsvK0irNMlfWil59nO71MTrqJDZF5Fy94QT6EsD0jPuCWZXK7KsB4HBULQE18kbh7DqEnkGvl51HlAnuLxQrPG+tuBSZKHii1qMGL5O/8sMB5tWBDXbqWMAzyAxWaORLACRkcevQbwQMe2qIwj+Rx+OBdQDrUT8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=3IyaZBEC; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="3IyaZBEC"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-424acf3226fso1850285e9.1
        for <virtualization@lists.linux.dev>; Wed, 03 Jul 2024 23:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720075450; x=1720680250; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9rsyFpkoJUSMpYUquCiPeRL9taQ5dwYVkUlWNVdXdGM=;
        b=3IyaZBECm4FZnljBHYd/j9FE20UfJ6E6WcuP6vrsmc3gUQHdPafMfCt+amjeAcB7h+
         ee6jMZ0CIYHWZKP3ADBRfxB928Gnn2Jjeui4WiUySNPFesjfQ6XLkuT8G+XHH890mER1
         dkO6PZJGT/KdE7TJVIuwUhPBqS8SWGMDaFMQeH8CsvrvGaS/fhFRVgLpfUK4nb4pbJ1l
         SotQQFwegI6IFLcDvp2/y36R/rz49SBQQIp3CIFVvdokTkF6tJmJrKtQ6MMb8xcByyCu
         mqEuFs6kESDI7+cyy6QYOZ5c/LxfOGovHXrWAo6VSQsX8keEtSc1I+dd5emE132FmPnp
         UYjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720075450; x=1720680250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9rsyFpkoJUSMpYUquCiPeRL9taQ5dwYVkUlWNVdXdGM=;
        b=QLJqxJnZnNVrqHLoBu/qm7tGAS/FKlf/P8IEXKC1lT97DU0pKHkl0XKhhBxKY3Q3u4
         SL0hTd7ljtKCuT/0xoStP8gTBm6nl+/WFXhxJsSL+aiK+q7ntS8watJ6GGD7VmyjvI0A
         zMAgVN0uVU+IqFc6M38G4uGA87UMTgaX/RWZUzcFb7+tG4M9jvTx1C/fZHvpYtAS+PNC
         x1bnLQOkQJc6hVjHeUde0A9959kLC4PfmG+d06PMHjOgNwPHgKTQvwfsT3jwrkDDtNwK
         Bu3CduEbvar1mRumj6nwFxrPLbdr1Py/6XwK+czumEXQQnxSJZjiv8YfHgeJXeF0y91e
         rJGQ==
X-Gm-Message-State: AOJu0YwpTNntALNOmBrwSpm3LpBPXKl53hHbMYlSrHxppRlmS9XkVWDd
	mKEyrz2V/zA19zcObfiVwU/BYZ+Hy8i8NiNNVCf0WmRiGLWJVqyfWI5/bRM0agV+w3RBkbAExgS
	n
X-Google-Smtp-Source: AGHT+IHVXA2EaQjulIEOpyw93bR1IWTR8c59NIL1MJ5DF4i6e2QbRmlU8e1QtVfDWeVc1+pssVDw6Q==
X-Received: by 2002:a05:600c:4f94:b0:425:7835:4382 with SMTP id 5b1f17b1804b1-4264a4691f7mr4928855e9.34.1720075450411;
        Wed, 03 Jul 2024 23:44:10 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a28327fsm10913145e9.39.2024.07.03.23.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 23:44:09 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v2 08/19] virtio: remove the original find_vqs() op
Date: Thu,  4 Jul 2024 08:43:39 +0200
Message-ID: <20240704064350.1097716-9-jiri@resnulli.us>
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

As it is no longer used, remove it.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 include/linux/virtio_config.h | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index eabbc28cdd0f..ad6ac5cf4bd7 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -59,15 +59,6 @@ struct virtqueue_info {
  *	After this, status and feature negotiation must be done again
  *	Device must not be reset from its vq/config callbacks, or in
  *	parallel with being added/removed.
- * @find_vqs: find virtqueues and instantiate them.
- *	vdev: the virtio_device
- *	nvqs: the number of virtqueues to find
- *	vqs: on success, includes new virtqueues
- *	callbacks: array of callbacks, for each virtqueue
- *		include a NULL entry for vqs that do not need a callback
- *	names: array of virtqueue names (mainly for debugging)
- *		include a NULL entry for vqs unused by driver
- *	Returns 0 on success or error status
  * @find_vqs_info: find virtqueues and instantiate them.
  *	vdev: the virtio_device
  *	nvqs: the number of virtqueues to find
@@ -121,10 +112,6 @@ struct virtio_config_ops {
 	u8 (*get_status)(struct virtio_device *vdev);
 	void (*set_status)(struct virtio_device *vdev, u8 status);
 	void (*reset)(struct virtio_device *vdev);
-	int (*find_vqs)(struct virtio_device *, unsigned nvqs,
-			struct virtqueue *vqs[], vq_callback_t *callbacks[],
-			const char * const names[], const bool *ctx,
-			struct irq_affinity *desc);
 	int (*find_vqs_info)(struct virtio_device *vdev, unsigned int nvqs,
 			     struct virtqueue *vqs[],
 			     struct virtqueue_info vqs_info[],
@@ -248,10 +235,6 @@ int virtio_find_vqs_ctx(struct virtio_device *vdev, unsigned nvqs,
 	struct virtqueue_info *vqs_info;
 	int err, i;
 
-	if (!vdev->config->find_vqs_info)
-		return vdev->config->find_vqs(vdev, nvqs, vqs, callbacks,
-					      names, ctx, desc);
-
 	vqs_info = kmalloc_array(nvqs, sizeof(*vqs_info), GFP_KERNEL);
 	if (!vqs_info)
 		return -ENOMEM;
-- 
2.45.2

