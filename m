Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB231AC247
	for <virtualization@lists.linux.dev>; Thu,  4 Jul 2024 14:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720103647; cv=none; b=jq5P1j1/CmkunSgSmt8RPDH0RLsYQYmni9VFoHiWrhfNDrcomZEKgO7YbdGX9U6quPs3DLuwsSyfDCXgXpZ3dEilzL9FkI5f8FjVEhYW/uXx3dqV5WDnNrx+U4eQfOwsYvNQAv+bwpnKNluFOvpOz98XxhbeBwFETtQHKsxUHD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720103647; c=relaxed/simple;
	bh=OsHOSjbBetalG8WJg5DDuNnP20MALt3FUFZpwboDrp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kjc9ejFLqq8iTGj9mm2c5kzDwj3o1ibsZR4LnnySAfLFIrkbFvzVKjjJdfI6Nz6H6xgPCowoiTK1BmuPd1NQvwbqGCNqdzbxFx9fj0X8F5QtBLKnELEw7fugIFoCRlbJkigvNOD60WpYLkUnkPDEsmzHw/o4nalhFfnthMEYpGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=1vGQ+t+N; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="1vGQ+t+N"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52e98087e32so765321e87.2
        for <virtualization@lists.linux.dev>; Thu, 04 Jul 2024 07:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720103645; x=1720708445; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPT5Hgo9SLTsM1shRXhn6Lbcy8HuJsLRl1eK9IiELb4=;
        b=1vGQ+t+NOR9usuIW0cp6kZ9bWjHChOPwSgOds7EwFoBm8kHQvyDgM0Mi/U56ZsRz8x
         BpdHm0wdH8dHpnacj2OqZpA+bPuoYajwMousWVTNDmP2ySdx2gF4YHkhfaZBbAekwViD
         gNOitK+eoUVmCBkl+xeh2RRHatsopWZrABpRuTd0X+0h20Jxkr6SSur5q24BZO4j43Uh
         6CsxM8K00n48BDSxLHjB73rJBo9vTDAUMEI9JqTl9PzrEJN08ZpiIruOPm1H4+kskOtH
         N86Puo75oWClCsCPIJlpj3beDe7t5qsKQ4ZQcroL/Ik3B4VWT1VZmBi5+qjx/U/zWmaF
         8RBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720103645; x=1720708445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JPT5Hgo9SLTsM1shRXhn6Lbcy8HuJsLRl1eK9IiELb4=;
        b=ohP5t3Irzj2la6b1ZeJlU8b8t32zxpgf85q5OGFZCl5kP33KvEzlH82ssOavHDDlWR
         0+qDyXzzJ3cLkDF42CFQ/XjnyCYqVjhFY9gCgKwVYmmlUdeRDPSDI1VbXvWCuDmAam6y
         3FDS2mfl6Xby6+zrQCOHfDVx37in7cE7Bj5qnGVUV+I2eTNAti1VW6Yp3i05E0kfJdv3
         Jv2OKRlxTRMy8g8DSLl9zF8VmRcGZv+AeZNnISdqYF7AOI0k8JqlFkMWHthc6hvl7Bzp
         7gq2MQIG8iMp0er6rStdKwIbqaOl24sW7TkYdvUoKchLM5OARPLZZsICqvYL/SXLNwh/
         pKQw==
X-Gm-Message-State: AOJu0YzYNJelNcIVBfIiPoYdBU4Sz96Xd6VK+KXd6fZ1HbnxFBoqdwLN
	zQn4h3FlZKEmj7Aj4IfOxubTjEzfxBVn2ptWjyB6gFEeBZcCMngZp81qweunYNoYcduIwaT0WfC
	xJlE=
X-Google-Smtp-Source: AGHT+IHm7duGtgrcxAaJZ5qCg4kC2oXOPyh0lFaEGcME+A4LB9yK68QVrJzXjq7Bw4zZcRFP8cdS3g==
X-Received: by 2002:a05:6512:238a:b0:52c:9f24:a253 with SMTP id 2adb3069b0e04-52ea06e3fdcmr1335754e87.64.1720103642816;
        Thu, 04 Jul 2024 07:34:02 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367a494e7a1sm223348f8f.112.2024.07.04.07.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 07:34:02 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v3 08/19] virtio: remove the original find_vqs() op
Date: Thu,  4 Jul 2024 16:32:56 +0200
Message-ID: <20240704143307.1212454-9-jiri@resnulli.us>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704143307.1212454-1-jiri@resnulli.us>
References: <20240704143307.1212454-1-jiri@resnulli.us>
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
index 23ce1aec54e8..1ae346bd2dbd 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -63,15 +63,6 @@ struct virtqueue_info {
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
@@ -125,10 +116,6 @@ struct virtio_config_ops {
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
@@ -252,10 +239,6 @@ int virtio_find_vqs_ctx(struct virtio_device *vdev, unsigned nvqs,
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

