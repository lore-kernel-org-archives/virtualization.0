Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621D138FAD
	for <virtualization@lists.linux.dev>; Mon,  8 Jul 2024 07:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720424910; cv=none; b=IbJpUN+9stxcONOCxTJPMxzaCr7BfcOWwNVDlRz0XKBEqeq+0PZPH6IslVRnxVbijRkoqpMJssPCUaho07r2YajdcZWOBGueLrRkldPO4E1GGEBSw0K08uonIEOV/B9Ha01NW8x00oDxEZhovkKFdI/TUOcIWFPdSsJJ10C37hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720424910; c=relaxed/simple;
	bh=rB2pZnAV4wfOk34GkgGvGfp8m0r0zmOgfyHdCeskA00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nMChw8TyBZuAwJccyTOWUQPJwG1YfURtJBsoPRsKdNiT11NH1gmo/ejhuN5x9fo4hL13zbT3xSUYJXFw3KpjJw/ppgza7G/KXJoT+/3AVXfwTR5AdbgaSejJ1xx85GyifnKzf+f4wpr0FvG7BkPNKSi78DZg/KGi2qalB5mGSoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=dkZalpUf; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="dkZalpUf"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42573d3f7e4so24759445e9.0
        for <virtualization@lists.linux.dev>; Mon, 08 Jul 2024 00:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720424907; x=1721029707; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pF5oi83nDHMBLbIQ3aVCidxKZhmoVj2ScVL2+zylzXE=;
        b=dkZalpUf7dZrFQkkdVBGWTSukUpcLS2hvyVzvO/rUNXG2RGXKOg0doj2ZG1hrDuYNy
         LdD9PONNK2i5cee4/OnfNwO3Hve1oHt+XvUHuf0OKVBa3Mxy+MyoLomGHcs5llRGUH5A
         hKLhSgAOwdpOylm5O9p3mlYOJEA+gt4bh4hJX3YLnp9IFv+tQHPTziKxsDlW+E2RgC+f
         GBssV3AhNk4LY0/gt79kzoj3rFRpkHNyYbrLLMNPKIBLkrNs7T7C5MC3Lx2vqKMBD20t
         3lUbDktpO0j/EmYXccWE/cA0b5odP9xtN5p6O2hWBN2sdISIKAQbI8dzhJHugZhd+FWS
         4J8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720424907; x=1721029707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pF5oi83nDHMBLbIQ3aVCidxKZhmoVj2ScVL2+zylzXE=;
        b=MEAKaKT0Q4JtkIiYHJgkJqlurPL6AGvQ0RSDCLjWi/EoThQZ5TccoDFrLM6B/Vk258
         sDohFgI5bcU12cfaIDsLM/GyPGiuUrscTUhb4AIU7+n6J8En9bPjwKnpZnpM2lIPQKEo
         ri1yPoVfmktTFi2+SzX60x4j/f7D1Si7v59RLH6Ag7anqUvVp/lUjHj8cP9WzP97NYo4
         zlqOGQEjnKo9dsKiyZ7dkSAk9uGAgHnxOWDaFdq2uLiqaY6BhbwDtyjI6ikw5Y54NFAV
         0KEabHKeuznd0tG2wlQVrXT36ACeNl82qNzu8DkHto/qcJhPD91tGkbxGos/M0ujBnh7
         3NFg==
X-Gm-Message-State: AOJu0Yxfw1In14Rd/FMwP3cJrbVfLJ52X1nY/9p2P8IngDlaImow94/h
	bXj6NJp3jTvGfQ/6497/iiZUdXgGHbSM/rvKD5Z2/oJcqUvrOoB/YHrwgiYfN6gT0KP1TsMKCDx
	AuPo=
X-Google-Smtp-Source: AGHT+IGR26OkDh0AthfgNVfnf6c9NKpXqGnmirRIkccidgD0TJ3vS/fF08x5pynO/PqzLNgX0SGisA==
X-Received: by 2002:a05:600c:3798:b0:426:597c:7d4d with SMTP id 5b1f17b1804b1-426597c7eeamr49597055e9.18.1720424906910;
        Mon, 08 Jul 2024 00:48:26 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a2fc942sm153879855e9.42.2024.07.08.00.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 00:48:26 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v4 06/19] virtio: convert find_vqs() op implementations to find_vqs_info()
Date: Mon,  8 Jul 2024 09:48:01 +0200
Message-ID: <20240708074814.1739223-7-jiri@resnulli.us>
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

Convert existing find_vqs() transport implementations
to use find_vqs_info() config op.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v3->v4:
- moved vqi decralation into loop
- fixed typo in virtio_ccw.c
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
index 77faa2cf3a13..4cc393e903fc 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -1014,8 +1014,8 @@ static struct virtqueue *vu_setup_vq(struct virtio_device *vdev,
 }
 
 static int vu_find_vqs(struct virtio_device *vdev, unsigned nvqs,
-		       struct virtqueue *vqs[], vq_callback_t *callbacks[],
-		       const char * const names[], const bool *ctx,
+		       struct virtqueue *vqs[],
+		       struct virtqueue_info vqs_info[],
 		       struct irq_affinity *desc)
 {
 	struct virtio_uml_device *vu_dev = to_virtio_uml_device(vdev);
@@ -1031,13 +1031,15 @@ static int vu_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 		return rc;
 
 	for (i = 0; i < nvqs; ++i) {
-		if (!names[i]) {
+		struct virtqueue_info *vqi = &vqs_info[i];
+
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
index b8d1e32e97eb..3dc895cfdc4a 100644
--- a/drivers/platform/mellanox/mlxbf-tmfifo.c
+++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
@@ -1058,9 +1058,7 @@ static void mlxbf_tmfifo_virtio_del_vqs(struct virtio_device *vdev)
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
@@ -1072,7 +1070,9 @@ static int mlxbf_tmfifo_virtio_find_vqs(struct virtio_device *vdev,
 		return -EINVAL;
 
 	for (i = 0; i < nvqs; ++i) {
-		if (!names[i]) {
+		struct virtqueue_info *vqi = &vqs_info[i];
+
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
index 25b66b113b69..870764c0ad9f 100644
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
 	int i, ret, queue_idx = 0;
 
 	for (i = 0; i < nvqs; ++i) {
-		if (!names[i]) {
+		struct virtqueue_info *vqi = &vqs_info[i];
+
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
index d6491fc84e8c..fa884afff777 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -689,9 +689,7 @@ static int virtio_ccw_register_adapter_ind(struct virtio_ccw_device *vcdev,
 
 static int virtio_ccw_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 			       struct virtqueue *vqs[],
-			       vq_callback_t *callbacks[],
-			       const char * const names[],
-			       const bool *ctx,
+			       struct virtqueue_info vqs_info[],
 			       struct irq_affinity *desc)
 {
 	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
@@ -705,14 +703,15 @@ static int virtio_ccw_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 		return -ENOMEM;
 
 	for (i = 0; i < nvqs; ++i) {
-		if (!names[i]) {
+		struct virtqueue_info *vqi = &vqs_info[i];
+
+		if (!vqi->name) {
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
index 173596589c71..57903685d505 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -489,9 +489,7 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned int in
 
 static int vm_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 		       struct virtqueue *vqs[],
-		       vq_callback_t *callbacks[],
-		       const char * const names[],
-		       const bool *ctx,
+		       struct virtqueue_info vqs_info[],
 		       struct irq_affinity *desc)
 {
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
@@ -510,13 +508,15 @@ static int vm_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 		enable_irq_wake(irq);
 
 	for (i = 0; i < nvqs; ++i) {
-		if (!names[i]) {
+		struct virtqueue_info *vqi = &vqs_info[i];
+
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
index e803db0da307..bc86d81c7cd2 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -358,9 +358,7 @@ create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
 
 static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 				struct virtqueue *vqs[],
-				vq_callback_t *callbacks[],
-				const char * const names[],
-				const bool *ctx,
+				struct virtqueue_info vqs_info[],
 				struct irq_affinity *desc)
 {
 	struct virtio_vdpa_device *vd_dev = to_virtio_vdpa_device(vdev);
@@ -379,14 +377,15 @@ static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 	}
 
 	for (i = 0; i < nvqs; ++i) {
-		if (!names[i]) {
+		struct virtqueue_info *vqi = &vqs_info[i];
+
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

