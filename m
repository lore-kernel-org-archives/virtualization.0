Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E42142911
	for <virtualization@lists.linux.dev>; Tue, 16 Jul 2024 11:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721129795; cv=none; b=pG25vRYFUSe11a99B48TwbrD4pVM4EEvixBNXRYuw6fBq0MoaJev+uwzYkmSHtwm9DKodNgdnGmP1qxBWzXQN4yHdyFxkhK0jm1UdQL8qBgkzjYT/NP9ZCYK0mITn6DxFEsfFoacjKHOlkUxWYub3vcXd7FQScVO+7GioJTfXms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721129795; c=relaxed/simple;
	bh=ZTw6Jj8+q4WGfrtYqJCIOm7DB8CIUfvAsZIosxQ+SlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IcRA2v23JiNY688NAWJ75ahTzgYJENX1/ZhvVqbdrjQmV70O/mUkyk5AQOL55kh8iEuDoGc3d9TPJn3n6vwfegv56fUCQeehfxfyil0yG6qBUUTrNFBHemdlBOe1a2TnlS8wuzoxLV71S01kCm7JzXtrw89Y7QRijc/zcmmSJgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=udgwm1G1; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="udgwm1G1"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4266eda81c5so42491215e9.0
        for <virtualization@lists.linux.dev>; Tue, 16 Jul 2024 04:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1721129792; x=1721734592; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pNqwrHMHGlcQ9ALyVbbHI6/+Tp/GQZo7UcP7/ZWcJeA=;
        b=udgwm1G1F5dzrdgzI7iTzYDJb4cY+4arsW3bhYsZMKtkFs8T5exa2VDw11n5xwHNg4
         bYbh7LjtnC605OL8cZi2vIReeBBs97pp6sfRafxnJ4av7Y7Xyt/GPJ7tPMlebcP1uKfi
         MnXcEILuRg3jcBou4L+TKnCPP7QFvB+Z8GjgAFKrct6vNAqREHXolbDzm0DNZol4e8cq
         CGz8bA77FdsWqx2pwnuKrbgP9j8Iukd1HjsgiO/D5YR+9Bce8rr+6FoSoDznvhPpX6OM
         t9bRuQhlM8swRZtxGoDS808Z+ikSbgW9Odge8cpNujNsjIlam6K1nyeOXvMaiJ/x59Yf
         2Aeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721129792; x=1721734592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pNqwrHMHGlcQ9ALyVbbHI6/+Tp/GQZo7UcP7/ZWcJeA=;
        b=eFCI4fCpnZm/HtGwf9aPHOCOW2l040rHQrPgZojainNLIJwnZXui73JgjggFhsgshi
         +rD58Lo/Hhf0uijGiDqmPWMhG4KSAtdyavUAXr7VY9CBxsb9an5i6a7jl2Y4aok17wdl
         07rejXR/RdpFXn+m8JI6hk+rS+pXeIhx6n9Wj5JvNdODrLzhc6eBDz6rw1CFJldMze7M
         Zw7wd47bCwbc7MkRdNx6TxGdT9fvoEbcX9liKhJyTe73gxL1lRYtCaniyuF9f3G0gXMp
         Rw1kYP+cmJYwlmZiSkHxzQMOR0QkNJJWkdztc2KqOqb+SdDpOVWSJf1wVSZVEAxjQHo2
         ZydQ==
X-Gm-Message-State: AOJu0YwyV52YyFiTR74l+PmYKuK5pd1C6SbiSJEz2s5PjMTVHDXRB/W6
	pVndfbmS6TuSEcGc7LHFjzFed0ypnwe/tBJIaJote7LEOGbODzSp0tQkG+88vtzV2qHgbEpjPFm
	LvHo=
X-Google-Smtp-Source: AGHT+IHuy9Pd69ToF7ESqClhjEdk+okXH8PXyADrEhFJ3YaplcWDkBxaJ7AsfA4gmGO9ihFLs3d2fA==
X-Received: by 2002:a05:600c:4f8a:b0:426:6fd2:e14b with SMTP id 5b1f17b1804b1-427ba66c4efmr13918945e9.11.1721129791667;
        Tue, 16 Jul 2024 04:36:31 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f239876sm157425835e9.3.2024.07.16.04.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 04:36:31 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v3 09/13] virtio: create admin queues alongside other virtqueues
Date: Tue, 16 Jul 2024 13:35:48 +0200
Message-ID: <20240716113552.80599-10-jiri@resnulli.us>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716113552.80599-1-jiri@resnulli.us>
References: <20240716113552.80599-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Admin virtqueue is just another virtqueue nothing that special about it.
The current implementation treats it somehow separate though in terms
of creation and deletion. Unify the admin virtqueue creation and
deletion flows to be aligned with the rest of virtqueues, creating
it from vp_find_vqs_*() helpers. Let the admin virtqueue to be deleted
by vp_del_vqs() as the rest.

Call vp_find_one_vq_msix() with slow_path argument being "true" to make
sure that in case of limited interrupt vectors the config vector is used
for admin queue.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- removed create_avq() and destroy_avq() struct member docs
v1->v2:
- rebased vp_find_one_vq_msix() code on top of newly added patches
- extended patch description a bit
- store vq info pointer in struct virtio_pci_admin_vq, as admin queue
  index does not have to be last+1 so vp_dev->vqs array is not really
  suitable.
- let virtqueue_exec_admin_cmd() to use the info to get the vq
- don't store admin vq in vqs array
---
 drivers/virtio/virtio.c            | 28 +------------
 drivers/virtio/virtio_pci_common.c | 43 ++++++++++++++++++--
 drivers/virtio/virtio_pci_common.h |  4 +-
 drivers/virtio/virtio_pci_modern.c | 63 +-----------------------------
 include/linux/virtio_config.h      |  4 --
 5 files changed, 46 insertions(+), 96 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 396d3cd49a1b..835cfbcb59c8 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -305,15 +305,9 @@ static int virtio_dev_probe(struct device *_d)
 	if (err)
 		goto err;
 
-	if (dev->config->create_avq) {
-		err = dev->config->create_avq(dev);
-		if (err)
-			goto err;
-	}
-
 	err = drv->probe(dev);
 	if (err)
-		goto err_probe;
+		goto err;
 
 	/* If probe didn't do it, mark device DRIVER_OK ourselves. */
 	if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK))
@@ -326,9 +320,6 @@ static int virtio_dev_probe(struct device *_d)
 
 	return 0;
 
-err_probe:
-	if (dev->config->destroy_avq)
-		dev->config->destroy_avq(dev);
 err:
 	virtio_add_status(dev, VIRTIO_CONFIG_S_FAILED);
 	return err;
@@ -344,9 +335,6 @@ static void virtio_dev_remove(struct device *_d)
 
 	drv->remove(dev);
 
-	if (dev->config->destroy_avq)
-		dev->config->destroy_avq(dev);
-
 	/* Driver should have reset device. */
 	WARN_ON_ONCE(dev->config->get_status(dev));
 
@@ -524,9 +512,6 @@ int virtio_device_freeze(struct virtio_device *dev)
 		}
 	}
 
-	if (dev->config->destroy_avq)
-		dev->config->destroy_avq(dev);
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(virtio_device_freeze);
@@ -562,16 +547,10 @@ int virtio_device_restore(struct virtio_device *dev)
 	if (ret)
 		goto err;
 
-	if (dev->config->create_avq) {
-		ret = dev->config->create_avq(dev);
-		if (ret)
-			goto err;
-	}
-
 	if (drv->restore) {
 		ret = drv->restore(dev);
 		if (ret)
-			goto err_restore;
+			goto err;
 	}
 
 	/* If restore didn't do it, mark device DRIVER_OK ourselves. */
@@ -582,9 +561,6 @@ int virtio_device_restore(struct virtio_device *dev)
 
 	return 0;
 
-err_restore:
-	if (dev->config->destroy_avq)
-		dev->config->destroy_avq(dev);
 err:
 	virtio_add_status(dev, VIRTIO_CONFIG_S_FAILED);
 	return ret;
diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 7c5516ae1f8a..267643bb1cd5 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -262,9 +262,6 @@ void vp_del_vqs(struct virtio_device *vdev)
 	int i;
 
 	list_for_each_entry_safe(vq, n, &vdev->vqs, list) {
-		if (vp_dev->is_avq && vp_dev->is_avq(vdev, vq->index))
-			continue;
-
 		if (vp_dev->per_vq_vectors) {
 			int v = vp_dev->vqs[vq->index]->msix_vector;
 
@@ -371,14 +368,23 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
 			    struct irq_affinity *desc)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+	struct virtio_pci_admin_vq *avq = &vp_dev->admin_vq;
 	struct virtqueue_info *vqi;
 	int i, err, nvectors, allocated_vectors, queue_idx = 0;
+	struct virtqueue *vq;
 	bool per_vq_vectors;
+	u16 avq_num = 0;
 
 	vp_dev->vqs = kcalloc(nvqs, sizeof(*vp_dev->vqs), GFP_KERNEL);
 	if (!vp_dev->vqs)
 		return -ENOMEM;
 
+	if (vp_dev->avq_index) {
+		err = vp_dev->avq_index(vdev, &avq->vq_index, &avq_num);
+		if (err)
+			goto error_find;
+	}
+
 	per_vq_vectors = vector_policy != VP_VQ_VECTOR_POLICY_SHARED;
 
 	if (per_vq_vectors) {
@@ -415,6 +421,18 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
 			goto error_find;
 		}
 	}
+
+	if (!avq_num)
+		return 0;
+	sprintf(avq->name, "avq.%u", avq->vq_index);
+	vq = vp_find_one_vq_msix(vdev, avq->vq_index, NULL, avq->name, false,
+				 true, &allocated_vectors, vector_policy,
+				 &vp_dev->admin_vq.info);
+	if (IS_ERR(vq)) {
+		err = PTR_ERR(vq);
+		goto error_find;
+	}
+
 	return 0;
 
 error_find:
@@ -427,12 +445,21 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
 			    struct virtqueue_info vqs_info[])
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+	struct virtio_pci_admin_vq *avq = &vp_dev->admin_vq;
 	int i, err, queue_idx = 0;
+	struct virtqueue *vq;
+	u16 avq_num = 0;
 
 	vp_dev->vqs = kcalloc(nvqs, sizeof(*vp_dev->vqs), GFP_KERNEL);
 	if (!vp_dev->vqs)
 		return -ENOMEM;
 
+	if (vp_dev->avq_index) {
+		err = vp_dev->avq_index(vdev, &avq->vq_index, &avq_num);
+		if (err)
+			goto out_del_vqs;
+	}
+
 	err = request_irq(vp_dev->pci_dev->irq, vp_interrupt, IRQF_SHARED,
 			dev_name(&vdev->dev), vp_dev);
 	if (err)
@@ -456,6 +483,16 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
 		}
 	}
 
+	if (!avq_num)
+		return 0;
+	sprintf(avq->name, "avq.%u", avq->vq_index);
+	vq = vp_setup_vq(vdev, queue_idx++, NULL, avq->name, false,
+			 VIRTIO_MSI_NO_VECTOR, &vp_dev->admin_vq.info);
+	if (IS_ERR(vq)) {
+		err = PTR_ERR(vq);
+		goto out_del_vqs;
+	}
+
 	return 0;
 out_del_vqs:
 	vp_del_vqs(vdev);
diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index aa43875b6353..de59bb06ec3c 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -44,7 +44,7 @@ struct virtio_pci_vq_info {
 
 struct virtio_pci_admin_vq {
 	/* Virtqueue info associated with this admin queue. */
-	struct virtio_pci_vq_info info;
+	struct virtio_pci_vq_info *info;
 	/* serializing admin commands execution. */
 	struct mutex cmd_lock;
 	u64 supported_cmds;
@@ -105,7 +105,7 @@ struct virtio_pci_device {
 	void (*del_vq)(struct virtio_pci_vq_info *info);
 
 	u16 (*config_vector)(struct virtio_pci_device *vp_dev, u16 vector);
-	bool (*is_avq)(struct virtio_device *vdev, unsigned int index);
+	int (*avq_index)(struct virtio_device *vdev, u16 *index, u16 *num);
 };
 
 /* Constants for MSI-X */
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index d704947b1aec..5ceb4b2c18df 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -63,7 +63,7 @@ static int virtqueue_exec_admin_cmd(struct virtio_pci_admin_vq *admin_vq,
 	struct virtqueue *vq;
 	int ret, len;
 
-	vq = admin_vq->info.vq;
+	vq = admin_vq->info->vq;
 	if (!vq)
 		return -EIO;
 
@@ -203,27 +203,12 @@ static void virtio_pci_admin_cmd_list_init(struct virtio_device *virtio_dev)
 
 static void vp_modern_avq_activate(struct virtio_device *vdev)
 {
-	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	struct virtio_pci_admin_vq *admin_vq = &vp_dev->admin_vq;
-
 	if (!virtio_has_feature(vdev, VIRTIO_F_ADMIN_VQ))
 		return;
 
-	__virtqueue_unbreak(admin_vq->info.vq);
 	virtio_pci_admin_cmd_list_init(vdev);
 }
 
-static void vp_modern_avq_deactivate(struct virtio_device *vdev)
-{
-	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	struct virtio_pci_admin_vq *admin_vq = &vp_dev->admin_vq;
-
-	if (!virtio_has_feature(vdev, VIRTIO_F_ADMIN_VQ))
-		return;
-
-	__virtqueue_break(admin_vq->info.vq);
-}
-
 static void vp_transport_features(struct virtio_device *vdev, u64 features)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
@@ -418,8 +403,6 @@ static void vp_reset(struct virtio_device *vdev)
 	while (vp_modern_get_status(mdev))
 		msleep(1);
 
-	vp_modern_avq_deactivate(vdev);
-
 	/* Flush pending VQ/configuration callbacks. */
 	vp_synchronize_vectors(vdev);
 }
@@ -595,9 +578,6 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 		goto err;
 	}
 
-	if (is_avq)
-		vp_dev->admin_vq.info.vq = vq;
-
 	return vq;
 
 err:
@@ -741,41 +721,6 @@ static bool vp_get_shm_region(struct virtio_device *vdev,
 	return true;
 }
 
-static int vp_modern_create_avq(struct virtio_device *vdev)
-{
-	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	struct virtio_pci_admin_vq *avq = &vp_dev->admin_vq;
-	struct virtqueue *vq;
-	u16 num;
-	int err;
-
-	err = vp_avq_index(vdev, &avq->vq_index, &num);
-	if (err || !num)
-		return err;
-
-	sprintf(avq->name, "avq.%u", avq->vq_index);
-	vq = vp_dev->setup_vq(vp_dev, &vp_dev->admin_vq.info, avq->vq_index, NULL,
-			      avq->name, NULL, VIRTIO_MSI_NO_VECTOR);
-	if (IS_ERR(vq)) {
-		dev_err(&vdev->dev, "failed to setup admin virtqueue, err=%ld",
-			PTR_ERR(vq));
-		return PTR_ERR(vq);
-	}
-
-	vp_modern_set_queue_enable(&vp_dev->mdev, avq->info.vq->index, true);
-	return 0;
-}
-
-static void vp_modern_destroy_avq(struct virtio_device *vdev)
-{
-	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-
-	if (!virtio_has_feature(vdev, VIRTIO_F_ADMIN_VQ))
-		return;
-
-	vp_dev->del_vq(&vp_dev->admin_vq.info);
-}
-
 static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
 	.get		= NULL,
 	.set		= NULL,
@@ -794,8 +739,6 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
 	.get_shm_region  = vp_get_shm_region,
 	.disable_vq_and_reset = vp_modern_disable_vq_and_reset,
 	.enable_vq_after_reset = vp_modern_enable_vq_after_reset,
-	.create_avq = vp_modern_create_avq,
-	.destroy_avq = vp_modern_destroy_avq,
 };
 
 static const struct virtio_config_ops virtio_pci_config_ops = {
@@ -816,8 +759,6 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
 	.get_shm_region  = vp_get_shm_region,
 	.disable_vq_and_reset = vp_modern_disable_vq_and_reset,
 	.enable_vq_after_reset = vp_modern_enable_vq_after_reset,
-	.create_avq = vp_modern_create_avq,
-	.destroy_avq = vp_modern_destroy_avq,
 };
 
 /* the PCI probing function */
@@ -841,7 +782,7 @@ int virtio_pci_modern_probe(struct virtio_pci_device *vp_dev)
 	vp_dev->config_vector = vp_config_vector;
 	vp_dev->setup_vq = setup_vq;
 	vp_dev->del_vq = del_vq;
-	vp_dev->is_avq = vp_is_avq;
+	vp_dev->avq_index = vp_avq_index;
 	vp_dev->isr = mdev->isr;
 	vp_dev->vdev.id = mdev->id;
 
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index ab4b9a3fef6b..169c7d367fac 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -104,8 +104,6 @@ struct virtqueue_info {
  *	Returns 0 on success or error status
  *	If disable_vq_and_reset is set, then enable_vq_after_reset must also be
  *	set.
- * @create_avq: create admin virtqueue resource.
- * @destroy_avq: destroy admin virtqueue resource.
  */
 struct virtio_config_ops {
 	void (*get)(struct virtio_device *vdev, unsigned offset,
@@ -133,8 +131,6 @@ struct virtio_config_ops {
 			       struct virtio_shm_region *region, u8 id);
 	int (*disable_vq_and_reset)(struct virtqueue *vq);
 	int (*enable_vq_after_reset)(struct virtqueue *vq);
-	int (*create_avq)(struct virtio_device *vdev);
-	void (*destroy_avq)(struct virtio_device *vdev);
 };
 
 /* If driver didn't advertise the feature, it will never appear. */
-- 
2.45.2

