Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DFB176FA0
	for <virtualization@lists.linux.dev>; Wed,  3 Jul 2024 12:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720010378; cv=none; b=Coe4UDhiPsoPtoxdwjP0jvGy7Jxdx9wo3TMmWKtHPh0VkWY3H+ehVO/nG4UE3fcY2LrawgDXCEQ93FI2iuc0HEJFtMt4VOavqxEHNVxPJgDoO3DPmqnTZv4ZueVkOfQTO3RKzozP3gF3tgmVqqYS5Ki7fmJxuqjGaClQ4z4/qRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720010378; c=relaxed/simple;
	bh=do0M+S3gJPHqhd8fF28elnGX/fvlGceoQ2UeeOeuXpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=raBcCa3r6ae+PAdsbIMGEwbLrYY991ZG5w29F0D36CCB+2ztq+/WqXYEGYGJ/mwc1gRErKU9uHKbGc5a6iFRWp87j/2VMg2MuTv5rfiqm3CElWLCGYh5ym3tDc6pgwQ7MRlzCqAk7haeyIBGZnBm9bQo8T+IM+YeiF/6SsNnpN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=h9k0Xxj5; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="h9k0Xxj5"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-36743a79dceso397465f8f.0
        for <virtualization@lists.linux.dev>; Wed, 03 Jul 2024 05:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720010375; x=1720615175; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vktBG19nGNhOoWHlOA7NxT0PL7gycQ9JpFqT3Y9MJ10=;
        b=h9k0Xxj58cUKSSYiaFfS+Q6Uevma2QuaaWbdG/1rssc/Mr82J4pITZOJRXK5nXF9y6
         jbc61ue16lZ3HeqCwCgKlOxI2KvTknYbZPU4RJhQV7oUnsYeHwWHsbrxzQPWrrxv19rW
         eHHxZyCq2aAobe9HUeaHv+hfHBUBgqIa2/rUApUEVGtN5HjRQPbyj0vX63q42PrzGeow
         H1+f0hu56jcGhQBy37ELPMXN93N0QmlAtpBVonSIos+AdT4xuD+tr7jnTe9RkIYH2MtZ
         TiNg1MzrH0cAPXqPtu/gs7bIYJcNuwXOpKEIOi6S1t0+4ltbHaP9xWPqpDiG+uk25u1M
         4lNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720010375; x=1720615175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vktBG19nGNhOoWHlOA7NxT0PL7gycQ9JpFqT3Y9MJ10=;
        b=HLFEoMwrklIuX2wMeh/njD+bcyRCpGKMXHFxOcnPoAQX6oCJZVYzRcPhR6st+bTAuH
         isZyV/chdRQoDKqATChl4m9fa4YgDVD4EEygOGmC33yBKspqMfj+1GCDSVbWOeCE2szc
         HPOvCmQnSOvPFmaI9VnRVVjFp5UfIhDI5WyIySfYJPNL/c23t8c5YAdEM9i5Uv5dsONN
         J2SY00i8wxGN+6OMIlYfkjjOn05anNsrSVO6680b6qtW/VrM3V+jHi69rbaY7oKK26CB
         on3pATXjsuM5xKJkS0KDUtCs0uWZmb5Iem+SyuwRcccskNDPdiG7X7lrFXZiF1zWm9ob
         f9QQ==
X-Gm-Message-State: AOJu0YxEdCm5BhyXzm/KM6tR0J4MSp4CrTJifBP9bHGjHnI9laUloyTB
	CUGOW9IpJ7KQsOOUlC/X4yqP1okEqRDpGenpcfKe6ImLNU9KP+i9K6722areZ8GXa982tO53MoJ
	0
X-Google-Smtp-Source: AGHT+IELc6NbnOhEmJGEP+dde/XHh3BrQLWuT/BrDNw/or4FdhHfwdvnn/wKK4d/7WjdY99t/Uz6Hg==
X-Received: by 2002:adf:f343:0:b0:360:9d2a:fe05 with SMTP id ffacd0b85a97d-3679479a99bmr1494653f8f.13.1720010374682;
        Wed, 03 Jul 2024 05:39:34 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0cd634sm15973392f8f.9.2024.07.03.05.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 05:39:34 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio 04/19] virtio: introduce virtio_queue_info struct and find_vqs_info() config op
Date: Wed,  3 Jul 2024 14:38:58 +0200
Message-ID: <20240703123913.969202-5-jiri@resnulli.us>
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

Introduce a structure virtio_queue_info to carry name, callback and ctx
together. In order to allow config implementations to accept config op
with array of virtio_queue_info structures, introduce a new
find_vqs_info() op. Do the needed conversion in virtio_find_vqs_ctx().
Note that whole virtio_find_vqs_ctx() is going to be eventually removed
at the and of this patchset.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 include/linux/virtio_config.h | 51 ++++++++++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 3 deletions(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 82a1d798b2f1..21029afeede1 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -18,6 +18,16 @@ struct virtio_shm_region {
 
 typedef void vq_callback_t(struct virtqueue *);
 
+struct virtio_queue_info {
+	const char *name; /* mainly for debugging, may be NULL for vq
+			   * unused by driver.
+			   */
+	vq_callback_t *callback; /* May be NULL for vq that do
+				  * not need a callback.
+				  */
+	bool ctx;
+};
+
 /**
  * struct virtio_config_ops - operations for configuring a virtio device
  * Note: Do not assume that a transport implements all of the operations
@@ -58,6 +68,12 @@ typedef void vq_callback_t(struct virtqueue *);
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
@@ -109,6 +125,10 @@ struct virtio_config_ops {
 			struct virtqueue *vqs[], vq_callback_t *callbacks[],
 			const char * const names[], const bool *ctx,
 			struct irq_affinity *desc);
+	int (*find_vqs_info)(struct virtio_device *vdev, unsigned int nvqs,
+			     struct virtqueue *vqs[],
+			     struct virtio_queue_info vqs_info[],
+			     struct irq_affinity *desc);
 	void (*del_vqs)(struct virtio_device *);
 	void (*synchronize_cbs)(struct virtio_device *);
 	u64 (*get_features)(struct virtio_device *vdev);
@@ -117,7 +137,7 @@ struct virtio_config_ops {
 	int (*set_vq_affinity)(struct virtqueue *vq,
 			       const struct cpumask *cpu_mask);
 	const struct cpumask *(*get_vq_affinity)(struct virtio_device *vdev,
-			int index);
+						 int index);
 	bool (*get_shm_region)(struct virtio_device *vdev,
 			       struct virtio_shm_region *region, u8 id);
 	int (*disable_vq_and_reset)(struct virtqueue *vq);
@@ -210,14 +230,39 @@ static inline bool virtio_has_dma_quirk(const struct virtio_device *vdev)
 	return !virtio_has_feature(vdev, VIRTIO_F_ACCESS_PLATFORM);
 }
 
+static inline
+int virtio_find_vqs_info(struct virtio_device *vdev, unsigned int nvqs,
+			 struct virtqueue *vqs[],
+			 struct virtio_queue_info vqs_info[],
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
+	struct virtio_queue_info *vqs_info;
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

