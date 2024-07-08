Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF63747A7C
	for <virtualization@lists.linux.dev>; Mon,  8 Jul 2024 07:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720424906; cv=none; b=T0rQ01Z3aI+yh0VkEtNmfU4uFmZittRZl3MiHu7HVlAHw2vBfBBW9WTOCgwqSMQFM7GSRTmIR33Ncf3iJNGwZ5FEan79zogvvQ9UteWoUnO9UeOEZ9pf+7RKGvVsoaooznIQw8izkXZR2DXMJp3kYr4fxjSH7QpgSgOeuQphSeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720424906; c=relaxed/simple;
	bh=9HziQ7914i9dpXzzeobVZEptxzE4TFAhpw5F31IUujs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GvVO0amXYMkWrotJqx4apMiUTo6ApwCkVJYOFh4FKsfj+ZD1yE1go5oq3QQ/3GcJTmlSnMT8ADuvt6TnkhnghkvvalAjiR++bvFWFoAMz1hz1PtUWFI3ZRf5euum+FvXnLFDk/z6N+jsXR53/XFJifVEiEMm9BrrxUbRPACy/fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=SpgxNNiX; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="SpgxNNiX"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-36798779d75so3147021f8f.3
        for <virtualization@lists.linux.dev>; Mon, 08 Jul 2024 00:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720424903; x=1721029703; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vni2pTUrtM1WzR4Zdpvy1aOe1dJ/sd4bsAJ9FxPX4Pw=;
        b=SpgxNNiXfe9VmiBlQ1PNHhCuVQt/sNt7B8wqzziSpCNgooZLbZ0uKDNaFkkJjQWgjS
         j5zm/PS2tUvAetnM1ddxZjyrPSVaB4hNrmsR0wujdtltde2m8vllDX4B9NanALVn4Eoz
         sVxjo9X3DVGsKaL3DXoFGeKfnxLZHZJJGkegmhE1QvcaPR8nFtsQXfXIByd8HrWBAxem
         RMB1Q8hyTLTbXTOCG8PHTv5QKRO1ForBN3C0r6iZ3ZAXlEzc1038ITBqXREX4c3rB1bD
         5pHknJ5FUypWpZQHxbKqVptCdRRYB2qQhtsC7pgsSPCOP686qBElK+AdsLzhuhfCJLzH
         y/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720424903; x=1721029703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vni2pTUrtM1WzR4Zdpvy1aOe1dJ/sd4bsAJ9FxPX4Pw=;
        b=aEKu8lWQxujKLjixoHgnB3foKXYgvfMcLaipbmoqApW8rhhmaUdTj3n9x2YY9EgnzE
         7fVGWMtE/b0d2vsG9pCNaQlkuiWyoehCmCTkberAB7FW+JdfFv3U3gMeX2UTzmn/Bk9x
         oASuftSf2Enh4pcu1eWeUfVaq5dKI7lEy3zygy99ijDTOd55F+/+C9eo8myU3M87AG++
         CMbuqI54WFi7TzjP1UkzXmOqVWN8IoD/OSqShdXNzHT/yMQ86EyNq+otHx5+O51ah8nF
         UXxb9FT+nIoXYf9S7zHx6sNEheB5nzEoLqtDc0C3knmAfP5C1sEdVJ5i9jZaW4PRvW/v
         9rzw==
X-Gm-Message-State: AOJu0YycK42uz+ZkmjCtMNkLatf4m+eviH/cTDtqyUgvEo83oMTTwfzt
	6mguulYPY/GjfaB9sodhnsvumJmZoGo9QkEY5nFwWFM1IgPdJatXZhfNYVWrr58Y1EXUpdLSW5y
	pi9o=
X-Google-Smtp-Source: AGHT+IHu+04iPN5tg6tIjQk1HVskQPKzhviuP97h2XbACDormB4aDvdzaTlJ8sXsfgUxAe3zzL+bbQ==
X-Received: by 2002:a5d:68cf:0:b0:366:f50a:2061 with SMTP id ffacd0b85a97d-3679dd65891mr8471238f8f.50.1720424903309;
        Mon, 08 Jul 2024 00:48:23 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3678fefc01dsm13680333f8f.26.2024.07.08.00.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 00:48:22 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v4 04/19] virtio: introduce virtio_queue_info struct and find_vqs_info() config op
Date: Mon,  8 Jul 2024 09:47:59 +0200
Message-ID: <20240708074814.1739223-5-jiri@resnulli.us>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240708074814.1739223-1-jiri@resnulli.us>
References: <20240708074814.1739223-1-jiri@resnulli.us>
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

