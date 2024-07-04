Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195E71A08B4
	for <virtualization@lists.linux.dev>; Thu,  4 Jul 2024 06:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720075450; cv=none; b=M+jNbSF+ZIyw5YXJNxjJHXXZg+6PV8/ywfAHmf5NmF6Nh4iTKlYw7Y50mDOPiDdF5qc8PTUpHrIzwoGDWRWV0TDHtN2lT4Vzflo3OfzoAKdn9TUp2ttvPFzmvP9OUcW/PFwfLBtpFj5cjcdCJvQwrk335wuPFwKApPzEO3Zj1ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720075450; c=relaxed/simple;
	bh=e9ArcUEikiehys7Kh+7ut1NemBv1iwkIYwl2Kq/FtQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MpgxZb9D2tHyffrvUSALh0F08pMogD+STa+/D5CpHWQjFBZMDldkzUY7MV8gWnGyv+JFBrlWiXKWe2UV+I25gUkWQ78fY55Fy7Es3I24fiIxlXu7OCiHJpdT6R9Dzji7Vx5RhVRKuNl+OX5IlNfYsQQk3d6AXOHa41qQdj4m67s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=TTYOT3eK; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="TTYOT3eK"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ee794ec014so2462021fa.0
        for <virtualization@lists.linux.dev>; Wed, 03 Jul 2024 23:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720075446; x=1720680246; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aB9yPxu7/PscHAoZWfly74Sg5D174Rq7AHVKRU5EIkU=;
        b=TTYOT3eKDHll9ZHR4ozWrUtVdM9eUkMyh1PaLB/VGZ2QaoO7bvXqni9VaJkMBlqXMZ
         AXVbFa9Y18bEBkrz+AqM/Ho3EIKE1qjF9K246KmTcAKt0alYjlyVNnAP/oWUmNsLYZst
         dHLtnqWt6yBuoBRCxm+B9vZ/cqamkJzo6M5OzHgG80T7DPpSWR57E/ipXBvD8N+5fDw7
         V0B95rGFnCiLz2ZaUu7VfIWCEcuwnXgEIhvCbbYCOfhp9zMcT6VuhZSPpJYdAxtjdWgO
         Vc9gOoqYyQqdoM6YMc5yAnpaSqkZnab/ok+g+K+nXwiGQvO6H76fCPU9D0lRcRTkwjoF
         wMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720075446; x=1720680246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aB9yPxu7/PscHAoZWfly74Sg5D174Rq7AHVKRU5EIkU=;
        b=liJQdIA1QM1DzGMUfr3fKkkcuFNFjvvee2l3wCFzOFlrgwK+eiOrZ62a4Aj/haCVX0
         U7XQGUdAd4iT3G/IJKFbHAfEU+ZUvKq46fxA28rYyajlLE7G30iwGkjyOnzXpaj5RUCc
         ftWmCVDi8xMJlM+OFeSfUuFG5i6gkH+LtFgI5sx/ATU5QPjHu7Lh4jOLA2vvjUwCMBCD
         yHJN3pgz2cgGQDj4F7Gt18EzxfE0bZbXRyTHFhhC5AWeU6/X6qdBzPES6350gZFGbyCx
         qrg5fy0P97pSMXS+d0YNpeWmpyGDOq2LGzLOTfdQDCutzO1/9t0fFGxNY3g3jrASi8Zm
         9Qvw==
X-Gm-Message-State: AOJu0Yzav43tKE2HdX5YMfU9r1b96jQ5Cvq9LHhEO6Oy8VvRNWcuUVkG
	2ppqp9EJOoKApjb/ebcviPNFCcLMQqQKA2+3UjXUZSp/ewNh7CJWZaGouU/V7BZHTK+VuNQWPV2
	S
X-Google-Smtp-Source: AGHT+IEWhaMk5pgNAab4wiXxpldXuenpfM7rtawmmrLY8vJZcJNorUbTL7nm+6LzN7Ot12L2x7p83w==
X-Received: by 2002:a2e:86cd:0:b0:2ec:5073:5816 with SMTP id 38308e7fff4ca-2ee8eda803fmr3967581fa.31.1720075446286;
        Wed, 03 Jul 2024 23:44:06 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a2fc49fsm10983195e9.39.2024.07.03.23.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 23:44:05 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v2 06/19] virtio: convert find_vqs() op implementations to find_vqs_info()
Date: Thu,  4 Jul 2024 08:43:37 +0200
Message-ID: <20240704064350.1097716-7-jiri@resnulli.us>
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

Convert existing find_vqs() transport implementations
to use find_vqs_info() config op.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- s/virtio_queue_info/virtqueue_info/
---
 arch/um/drivers/virtio_uml.c             | 14 ++++++++------
 drivers/platform/mellanox/mlxbf-tmfifo.c | 12 ++++++------
 drivers/remoteproc/remoteproc_virtio.c   | 14 +++++++-------
 drivers/s390/virtio/virtio_ccw.c         | 15 +++++++--------
 drivers/virtio/virtio_mmio.c             | 14 +++++++-------
 drivers/virtio/virtio_vdpa.c             | 15 +++++++--------
 6 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index 77faa2cf3a13..c32a51017f9f 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -1014,11 +1014,12 @@ static struct virtqueue *vu_setup_vq(struct virtio_device *vdev,
 }
 
 static int vu_find_vqs(struct virtio_device *vdev, unsigned nvqs,
-		       struct virtqueue *vqs[], vq_callback_t *callbacks[],
-		       const char * const names[], const bool *ctx,
+		       struct virtqueue *vqs[],
+		       struct virtqueue_info vqs_info[],
 		       struct irq_affinity *desc)
 {
 	struct virtio_uml_device *vu_dev = to_virtio_uml_device(vdev);
+	struct virtqueue_info *vqi;
 	int i, queue_idx = 0, rc;
 	struct virtqueue *vq;
 
@@ -1031,13 +1032,14 @@ static int vu_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 		return rc;
 
 	for (i = 0; i < nvqs; ++i) {
-		if (!names[i]) {
+		vqi = &vqs_info[i];
+		if (!vqi->name) {
 			vqs[i] = NULL;
 			continue;
 		}
 
-		vqs[i] = vu_setup_vq(vdev, queue_idx++, callbacks[i], names[i],
-				     ctx ? ctx[i] : false);
+		vqs[i] = vu_setup_vq(vdev, queue_idx++, vqi->callback,
+				     vqi->name, vqi->ctx);
 		if (IS_ERR(vqs[i])) {
 			rc = PTR_ERR(vqs[i]);
 			goto error_setup;
@@ -1097,7 +1099,7 @@ static const struct virtio_config_ops virtio_uml_config_ops = {
 	.get_status = vu_get_status,
 	.set_status = vu_set_status,
 	.reset = vu_reset,
-	.find_vqs = vu_find_vqs,
+	.find_vqs_info = vu_find_vqs,
 	.del_vqs = vu_del_vqs,
 	.get_features = vu_get_features,
 	.finalize_features = vu_finalize_features,
diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
index b8d1e32e97eb..1497a5a0a68f 100644
--- a/drivers/platform/mellanox/mlxbf-tmfifo.c
+++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
@@ -1058,13 +1058,12 @@ static void mlxbf_tmfifo_virtio_del_vqs(struct virtio_device *vdev)
 static int mlxbf_tmfifo_virtio_find_vqs(struct virtio_device *vdev,
 					unsigned int nvqs,
 					struct virtqueue *vqs[],
-					vq_callback_t *callbacks[],
-					const char * const names[],
-					const bool *ctx,
+					struct virtqueue_info vqs_info[],
 					struct irq_affinity *desc)
 {
 	struct mlxbf_tmfifo_vdev *tm_vdev = mlxbf_vdev_to_tmfifo(vdev);
 	struct mlxbf_tmfifo_vring *vring;
+	struct virtqueue_info *vqi;
 	struct virtqueue *vq;
 	int i, ret, size;
 
@@ -1072,7 +1071,8 @@ static int mlxbf_tmfifo_virtio_find_vqs(struct virtio_device *vdev,
 		return -EINVAL;
 
 	for (i = 0; i < nvqs; ++i) {
-		if (!names[i]) {
+		vqi = &vqs_info[i];
+		if (!vqi->name) {
 			ret = -EINVAL;
 			goto error;
 		}
@@ -1084,7 +1084,7 @@ static int mlxbf_tmfifo_virtio_find_vqs(struct virtio_device *vdev,
 		vq = vring_new_virtqueue(i, vring->num, vring->align, vdev,
 					 false, false, vring->va,
 					 mlxbf_tmfifo_virtio_notify,
-					 callbacks[i], names[i]);
+					 vqi->callback, vqi->name);
 		if (!vq) {
 			dev_err(&vdev->dev, "vring_new_virtqueue failed\n");
 			ret = -ENOMEM;
@@ -1175,7 +1175,7 @@ static void tmfifo_virtio_dev_release(struct device *device)
 static const struct virtio_config_ops mlxbf_tmfifo_virtio_config_ops = {
 	.get_features = mlxbf_tmfifo_virtio_get_features,
 	.finalize_features = mlxbf_tmfifo_virtio_finalize_features,
-	.find_vqs = mlxbf_tmfifo_virtio_find_vqs,
+	.find_vqs_info = mlxbf_tmfifo_virtio_find_vqs,
 	.del_vqs = mlxbf_tmfifo_virtio_del_vqs,
 	.reset = mlxbf_tmfifo_virtio_reset,
 	.set_status = mlxbf_tmfifo_virtio_set_status,
diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index 25b66b113b69..a82a7c13bdc5 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -182,21 +182,21 @@ static void rproc_virtio_del_vqs(struct virtio_device *vdev)
 
 static int rproc_virtio_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 				 struct virtqueue *vqs[],
-				 vq_callback_t *callbacks[],
-				 const char * const names[],
-				 const bool * ctx,
+				 struct virtqueue_info vqs_info[],
 				 struct irq_affinity *desc)
 {
+	struct virtqueue_info *vqi;
 	int i, ret, queue_idx = 0;
 
 	for (i = 0; i < nvqs; ++i) {
-		if (!names[i]) {
+		vqi = &vqs_info[i];
+		if (!vqi->name) {
 			vqs[i] = NULL;
 			continue;
 		}
 
-		vqs[i] = rp_find_vq(vdev, queue_idx++, callbacks[i], names[i],
-				    ctx ? ctx[i] : false);
+		vqs[i] = rp_find_vq(vdev, queue_idx++, vqi->callback,
+				    vqi->name, vqi->ctx);
 		if (IS_ERR(vqs[i])) {
 			ret = PTR_ERR(vqs[i]);
 			goto error;
@@ -327,7 +327,7 @@ static void rproc_virtio_set(struct virtio_device *vdev, unsigned int offset,
 static const struct virtio_config_ops rproc_virtio_config_ops = {
 	.get_features	= rproc_virtio_get_features,
 	.finalize_features = rproc_virtio_finalize_features,
-	.find_vqs	= rproc_virtio_find_vqs,
+	.find_vqs_info	= rproc_virtio_find_vqs,
 	.del_vqs	= rproc_virtio_del_vqs,
 	.reset		= rproc_virtio_reset,
 	.set_status	= rproc_virtio_set_status,
diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index d6491fc84e8c..1f1fa70cf09d 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -689,12 +689,11 @@ static int virtio_ccw_register_adapter_ind(struct virtio_ccw_device *vcdev,
 
 static int virtio_ccw_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 			       struct virtqueue *vqs[],
-			       vq_callback_t *callbacks[],
-			       const char * const names[],
-			       const bool *ctx,
+			       struct virtqueue_info vqs_info[],
 			       struct irq_affinity *desc)
 {
 	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
+	struct virtqueue_info *vqi;
 	dma64_t *indicatorp = NULL;
 	int ret, i, queue_idx = 0;
 	struct ccw1 *ccw;
@@ -705,14 +704,14 @@ static int virtio_ccw_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 		return -ENOMEM;
 
 	for (i = 0; i < nvqs; ++i) {
-		if (!names[i]) {
+		vqi = &vqs_info[i];
+		if (!vq_info->name) {
 			vqs[i] = NULL;
 			continue;
 		}
 
-		vqs[i] = virtio_ccw_setup_vq(vdev, queue_idx++, callbacks[i],
-					     names[i], ctx ? ctx[i] : false,
-					     ccw);
+		vqs[i] = virtio_ccw_setup_vq(vdev, queue_idx++, vqi->callback,
+					     vqi->name, vqi->ctx, ccw);
 		if (IS_ERR(vqs[i])) {
 			ret = PTR_ERR(vqs[i]);
 			vqs[i] = NULL;
@@ -1079,7 +1078,7 @@ static const struct virtio_config_ops virtio_ccw_config_ops = {
 	.get_status = virtio_ccw_get_status,
 	.set_status = virtio_ccw_set_status,
 	.reset = virtio_ccw_reset,
-	.find_vqs = virtio_ccw_find_vqs,
+	.find_vqs_info = virtio_ccw_find_vqs,
 	.del_vqs = virtio_ccw_del_vqs,
 	.bus_name = virtio_ccw_bus_name,
 	.synchronize_cbs = virtio_ccw_synchronize_cbs,
diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 173596589c71..533aca85b745 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -489,13 +489,12 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned int in
 
 static int vm_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 		       struct virtqueue *vqs[],
-		       vq_callback_t *callbacks[],
-		       const char * const names[],
-		       const bool *ctx,
+		       struct virtqueue_info vqs_info[],
 		       struct irq_affinity *desc)
 {
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
 	int irq = platform_get_irq(vm_dev->pdev, 0);
+	struct virtqueue_info *vqi;
 	int i, err, queue_idx = 0;
 
 	if (irq < 0)
@@ -510,13 +509,14 @@ static int vm_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 		enable_irq_wake(irq);
 
 	for (i = 0; i < nvqs; ++i) {
-		if (!names[i]) {
+		vqi = &vqs_info[i];
+		if (!vqi->name) {
 			vqs[i] = NULL;
 			continue;
 		}
 
-		vqs[i] = vm_setup_vq(vdev, queue_idx++, callbacks[i], names[i],
-				     ctx ? ctx[i] : false);
+		vqs[i] = vm_setup_vq(vdev, queue_idx++, vqi->callback,
+				     vqi->name, vqi->ctx);
 		if (IS_ERR(vqs[i])) {
 			vm_del_vqs(vdev);
 			return PTR_ERR(vqs[i]);
@@ -570,7 +570,7 @@ static const struct virtio_config_ops virtio_mmio_config_ops = {
 	.get_status	= vm_get_status,
 	.set_status	= vm_set_status,
 	.reset		= vm_reset,
-	.find_vqs	= vm_find_vqs,
+	.find_vqs_info	= vm_find_vqs,
 	.del_vqs	= vm_del_vqs,
 	.get_features	= vm_get_features,
 	.finalize_features = vm_finalize_features,
diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index e803db0da307..dcf0c2b19a44 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -358,15 +358,14 @@ create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
 
 static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 				struct virtqueue *vqs[],
-				vq_callback_t *callbacks[],
-				const char * const names[],
-				const bool *ctx,
+				struct virtqueue_info vqs_info[],
 				struct irq_affinity *desc)
 {
 	struct virtio_vdpa_device *vd_dev = to_virtio_vdpa_device(vdev);
 	struct vdpa_device *vdpa = vd_get_vdpa(vdev);
 	const struct vdpa_config_ops *ops = vdpa->config;
 	struct irq_affinity default_affd = { 0 };
+	struct virtqueue_info *vqi;
 	struct cpumask *masks;
 	struct vdpa_callback cb;
 	bool has_affinity = desc && ops->set_vq_affinity;
@@ -379,14 +378,14 @@ static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 	}
 
 	for (i = 0; i < nvqs; ++i) {
-		if (!names[i]) {
+		vqi = &vqs_info[i];
+		if (!vqi->name) {
 			vqs[i] = NULL;
 			continue;
 		}
 
-		vqs[i] = virtio_vdpa_setup_vq(vdev, queue_idx++,
-					      callbacks[i], names[i], ctx ?
-					      ctx[i] : false);
+		vqs[i] = virtio_vdpa_setup_vq(vdev, queue_idx++, vqi->callback,
+					      vqi->name, vqi->ctx);
 		if (IS_ERR(vqs[i])) {
 			err = PTR_ERR(vqs[i]);
 			goto err_setup_vq;
@@ -470,7 +469,7 @@ static const struct virtio_config_ops virtio_vdpa_config_ops = {
 	.get_status	= virtio_vdpa_get_status,
 	.set_status	= virtio_vdpa_set_status,
 	.reset		= virtio_vdpa_reset,
-	.find_vqs	= virtio_vdpa_find_vqs,
+	.find_vqs_info	= virtio_vdpa_find_vqs,
 	.del_vqs	= virtio_vdpa_del_vqs,
 	.get_features	= virtio_vdpa_get_features,
 	.finalize_features = virtio_vdpa_finalize_features,
-- 
2.45.2

