Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836C71AED57
	for <virtualization@lists.linux.dev>; Thu,  4 Jul 2024 14:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720103622; cv=none; b=Kd6d+emGE1ctboR3LieLUdFTU728KnXC+bTmxdXj7BK1NHlvnYtrybvlbbKL+eQjRy+EEX4L7HznaMB8kI4ZHcgtXmAtP0Z5hoyGK24oS0b5OoCFPLyHXQXF2YdaKi4RfcKjBmsoyO4IbysdlPfYPsOODQZiFjTozqNmreCUZL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720103622; c=relaxed/simple;
	bh=9HziQ7914i9dpXzzeobVZEptxzE4TFAhpw5F31IUujs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lLSaVoR5HnnMAdsO8Ljc+hVHC4XpFU2VkFeevK9QdfDioAsOs+NGNCy+FC36YJxxGnEZOfQezJgsqmddGO1bJ1TIBfbryOKMYBEdTFvlbTFjR5rwd6Dgr5J2fur5ovZ0e8/DK2thD40O5rZnsF3wZbDjU5H3F1oN6IBq5uzXSp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=OGsP+rkl; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="OGsP+rkl"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42648961d7aso4782105e9.0
        for <virtualization@lists.linux.dev>; Thu, 04 Jul 2024 07:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720103619; x=1720708419; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vni2pTUrtM1WzR4Zdpvy1aOe1dJ/sd4bsAJ9FxPX4Pw=;
        b=OGsP+rklP+vAAgxC3tnx9C9Hnag24zdovZOnZvO5bTHfsEb3WGTRicNf22WW5zNmhT
         QV2VjIFMJFH54u31LSfpcK24HWY05TMl3eCxwlpVp/RHlVV4BPotbYYvd2RsfiTYXYgB
         IL99lOwiJ+AuTTtklkCGJ8acyknUn7dWKqmiZwmzopbecYh8ZSbN8pATi5Y2ql4wlEzk
         xJCZdgzuULha/9Z/jbGxBZT3YkFKFnu3f5iRqEhlaXo8pkhWeaYZYIbKopnGa6mTCEpB
         zQVtLRbCX8XipKNv7hvSdbpuQzJR/oEIVAb6F0pC/MFIMSbOo8VaI05/UJV3cBTCJ6nT
         iZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720103619; x=1720708419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vni2pTUrtM1WzR4Zdpvy1aOe1dJ/sd4bsAJ9FxPX4Pw=;
        b=gEvsMkV7bKtdjjmeKaiV7eUlmQLz+5ow9GAtJEEH/noDGwaCaR9MsIszsoLFR5NBsr
         6c9nSSDiSEZnovH0TRkM7vpWV6KsVkDsGSsTHImQdbGFLeRTOj9jk29gvaDzducLkAHi
         xH1KSxXjxErG/wwqPAwA7KvvZ9chvh88c/ztWdsh0HRVrgQggb3LZWqnRmiAvR+i7ReU
         2Nnj9DSnHi6RVHi+/9wdrSOgOL29deeFCmUd7vaKVa3iWZYMf9lY+3M8k5zBRzPoJ01U
         Ot7NwmiPWdXRWJqGIe7OV+WgK9XpYViepKvWdOeOjVVvWMXqZzbl+OPxAOm+Yz/BJAyy
         KLBw==
X-Gm-Message-State: AOJu0YzRDpAzlwznFprdXe+bGhOkKqta1T130CVbnz4NeNriEBY8oOmb
	2jaBNtBJ0WtNRt9oImIpgRNq7hGXn8KzZYs3ZYELMb5OxiOXTM6VfTKQGSyiz5CnUxEP8cQvcG/
	fJJQ=
X-Google-Smtp-Source: AGHT+IHzHEVlx6t4999sDmotB2CMOGdV8en1c8+niEW2P5XbZfvVeVDqaRNr3OhDlc5PmgluwsMteg==
X-Received: by 2002:a7b:cd05:0:b0:424:a7f1:bac with SMTP id 5b1f17b1804b1-4264a44d356mr12883455e9.26.1720103618955;
        Thu, 04 Jul 2024 07:33:38 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1f2391sm27220745e9.25.2024.07.04.07.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 07:33:38 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v3 04/19] virtio: introduce virtio_queue_info struct and find_vqs_info() config op
Date: Thu,  4 Jul 2024 16:32:52 +0200
Message-ID: <20240704143307.1212454-5-jiri@resnulli.us>
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

Introduce a structure virtio_queue_info to carry name, callback and ctx
together. In order to allow config implementations to accept config op
with array of virtio_queue_info structures, introduce a new
find_vqs_info() op. Do the needed conversion in virtio_find_vqs_ctx().
Note that whole virtio_find_vqs_ctx() is going to be eventually removed
at the and of this patchset.

Suggested-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- added proper struct virtqueue_info documentation
v1->v2:
- fixed comments for struct virtqueue_info
- s/virtio_queue_info/virtqueue_info/
---
 include/linux/virtio_config.h | 55 +++++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 3 deletions(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 82a1d798b2f1..fb7a1fd00ee5 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -18,6 +18,20 @@ struct virtio_shm_region {
 
 typedef void vq_callback_t(struct virtqueue *);
 
+/**
+ * struct virtqueue_info - Info for a virtqueue passed to find_vqs().
+ * @name: virtqueue description. Used mainly for debugging, NULL for
+ *        a virtqueue unused by the driver.
+ * @callback: A callback to invoke on a used buffer notification.
+ *            NULL for a virtqueue that does not need a callback.
+ * @ctx: A flag to indicate to maintain an extra context per virtqueue.
+ */
+struct virtqueue_info {
+	const char *name;
+	vq_callback_t *callback;
+	bool ctx;
+};
+
 /**
  * struct virtio_config_ops - operations for configuring a virtio device
  * Note: Do not assume that a transport implements all of the operations
@@ -58,6 +72,12 @@ typedef void vq_callback_t(struct virtqueue *);
  *	names: array of virtqueue names (mainly for debugging)
  *		include a NULL entry for vqs unused by driver
  *	Returns 0 on success or error status
+ * @find_vqs_info: find virtqueues and instantiate them.
+ *	vdev: the virtio_device
+ *	nvqs: the number of virtqueues to find
+ *	vqs: on success, includes new virtqueues
+ *	vqs_info: array of virtqueue info structures
+ *	Returns 0 on success or error status
  * @del_vqs: free virtqueues found by find_vqs().
  * @synchronize_cbs: synchronize with the virtqueue callbacks (optional)
  *      The function guarantees that all memory operations on the
@@ -109,6 +129,10 @@ struct virtio_config_ops {
 			struct virtqueue *vqs[], vq_callback_t *callbacks[],
 			const char * const names[], const bool *ctx,
 			struct irq_affinity *desc);
+	int (*find_vqs_info)(struct virtio_device *vdev, unsigned int nvqs,
+			     struct virtqueue *vqs[],
+			     struct virtqueue_info vqs_info[],
+			     struct irq_affinity *desc);
 	void (*del_vqs)(struct virtio_device *);
 	void (*synchronize_cbs)(struct virtio_device *);
 	u64 (*get_features)(struct virtio_device *vdev);
@@ -117,7 +141,7 @@ struct virtio_config_ops {
 	int (*set_vq_affinity)(struct virtqueue *vq,
 			       const struct cpumask *cpu_mask);
 	const struct cpumask *(*get_vq_affinity)(struct virtio_device *vdev,
-			int index);
+						 int index);
 	bool (*get_shm_region)(struct virtio_device *vdev,
 			       struct virtio_shm_region *region, u8 id);
 	int (*disable_vq_and_reset)(struct virtqueue *vq);
@@ -210,14 +234,39 @@ static inline bool virtio_has_dma_quirk(const struct virtio_device *vdev)
 	return !virtio_has_feature(vdev, VIRTIO_F_ACCESS_PLATFORM);
 }
 
+static inline
+int virtio_find_vqs_info(struct virtio_device *vdev, unsigned int nvqs,
+			 struct virtqueue *vqs[],
+			 struct virtqueue_info vqs_info[],
+			 struct irq_affinity *desc)
+{
+	return vdev->config->find_vqs_info(vdev, nvqs, vqs, vqs_info, desc);
+}
+
 static inline
 int virtio_find_vqs_ctx(struct virtio_device *vdev, unsigned nvqs,
 			struct virtqueue *vqs[], vq_callback_t *callbacks[],
 			const char * const names[], const bool *ctx,
 			struct irq_affinity *desc)
 {
-	return vdev->config->find_vqs(vdev, nvqs, vqs, callbacks, names, ctx,
-				      desc);
+	struct virtqueue_info *vqs_info;
+	int err, i;
+
+	if (!vdev->config->find_vqs_info)
+		return vdev->config->find_vqs(vdev, nvqs, vqs, callbacks,
+					      names, ctx, desc);
+
+	vqs_info = kmalloc_array(nvqs, sizeof(*vqs_info), GFP_KERNEL);
+	if (!vqs_info)
+		return -ENOMEM;
+	for (i = 0; i < nvqs; i++) {
+		vqs_info[i].name = names[i];
+		vqs_info[i].callback = callbacks[i];
+		vqs_info[i].ctx = ctx ? ctx[i] : false;
+	}
+	err = virtio_find_vqs_info(vdev, nvqs, vqs, vqs_info, desc);
+	kfree(vqs_info);
+	return err;
 }
 
 static inline
-- 
2.45.2

