Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB3F1A070E
	for <virtualization@lists.linux.dev>; Thu,  4 Jul 2024 06:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720075445; cv=none; b=QyNG0YH6nLpw1x9yTzQ124RQdWlL6ZFvSkvg27jYUF12Do62/NlL8Mkktu6tuVRGO6vJ2WO6F5bqkOv1pLrPmb/fZlRGRNF1GHDXDP1/XcWyq3YFg4iVMAuQCrkxRPh42roia0YDMoesxtJ14TEFVh9wM1NKAuyQRtKjibAnQ/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720075445; c=relaxed/simple;
	bh=7uProIdkp+GwxUM7EvKgW81xUttZRtSoikRQdnXXoag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lRyu21rOJsCqhQfOUSEuGqeIWTkQswNFHxw1i/Bc+7yLddtfDVR+KAWV37m+I4ojBA/a2B656VxlrNAhedQ/NTO/P6rpFOmaw1A5Skt/iwdc27p2NFHLIKMpDJCq062My5v4pzo4uaHBUjShDN924pIMJY1LKXPGxcEJpBZMRyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Vf7FUuxb; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Vf7FUuxb"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-425814992aeso1805195e9.1
        for <virtualization@lists.linux.dev>; Wed, 03 Jul 2024 23:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720075442; x=1720680242; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wg/86A9OsTgOazRE9ce35tA0P/JztWuqN04XNrQwJ7I=;
        b=Vf7FUuxbzhKGNoGGS3cv3nhl/XhVH6vXrKKsa0ljg3oNuuLnCFd4SB+Dqsd7HZbBby
         1SetJ0fkLVrfR22m288jUKJ0zfMy2cPauvMZodrU5OUTubV3wVuoeoNmFzEMKDZm2yiR
         d5H+9wyVT4TjNaIFYUeX3WhWS/TBqhiqNkvOrycNUAdn/cDhMJ2O4A8FcnR3JvPXSaRH
         w+JZzLfGQNqn+ydS2osZI30QPDgVvgouniGLvN2bhmry1SJVysZKgCzGGm6bcmyVskAL
         YvA8V3v4f5aVZnCOQVl+myCiL0MuyCnro8WhO01J39jybn5LNvmnlM6Rue1IujNlsZbK
         JhQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720075442; x=1720680242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wg/86A9OsTgOazRE9ce35tA0P/JztWuqN04XNrQwJ7I=;
        b=NR+dcyrk4UCFezW7VxFi4n2GQrRsW+sx0o2fccrlVA6foog9st+Qoc4c6Yez4nSRMD
         g9NPdhS1+KMwv6hg2WS/WaJh5Fj6uWEryhUW0pR9dTIoK+TfmJTQUDdqTFwUpxdYSIiH
         kNpeiojUaf1wxtwftu4Co+wD6Mr+Mjr/OhHoW94zogszY1c66e1OJMdMprK5cq70acRn
         I5EwppUnULKU5LnzOSJCXF2dF5E7+nwzEhjVNEIkMaM8sovcpN43n5koRsn3rJQ/2j2C
         hPDMbLVbmzVR4ZfpyEbc2iCNavwNYiAmjI1fuTF3SC5OGPaPJikpToBYxAKOLLCxooAl
         iWLg==
X-Gm-Message-State: AOJu0YwQ6FOSNfCxm65X3VdBm4IeC3q9P0P0RqC/XQM4wHTKKKRr3vuk
	Zimasq+PTzHfGvdX0LFsG8Dd1VCX0v5TjiXmWeUqXbK5yOmXLjnSPEvVULopmmBCcIN+w7QMW3l
	T
X-Google-Smtp-Source: AGHT+IHF9cHpLsO6DmJ6Nb1L19P37+AEjXTDJSw/Yuc0GYfUWao2Y2omE4B+NudsuNymRanIzVq6aA==
X-Received: by 2002:a05:600c:2319:b0:424:a3c7:4710 with SMTP id 5b1f17b1804b1-4264a42858fmr4738945e9.34.1720075442121;
        Wed, 03 Jul 2024 23:44:02 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a2fc49fsm10980715e9.39.2024.07.03.23.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 23:44:01 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v2 04/19] virtio: introduce virtio_queue_info struct and find_vqs_info() config op
Date: Thu,  4 Jul 2024 08:43:35 +0200
Message-ID: <20240704064350.1097716-5-jiri@resnulli.us>
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

Introduce a structure virtio_queue_info to carry name, callback and ctx
together. In order to allow config implementations to accept config op
with array of virtio_queue_info structures, introduce a new
find_vqs_info() op. Do the needed conversion in virtio_find_vqs_ctx().
Note that whole virtio_find_vqs_ctx() is going to be eventually removed
at the and of this patchset.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- fixed comments for struct virtqueue_info
- s/virtio_queue_info/virtqueue_info/
---
 include/linux/virtio_config.h | 51 ++++++++++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 3 deletions(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 82a1d798b2f1..9b975c2830f6 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -18,6 +18,16 @@ struct virtio_shm_region {
 
 typedef void vq_callback_t(struct virtqueue *);
 
+struct virtqueue_info {
+	const char *name; /* Mainly for debugging, may be NULL for a virtqueue
+			   * unused by driver.
+			   */
+	vq_callback_t *callback; /* May be NULL for vq that does
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
+			     struct virtqueue_info vqs_info[],
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

