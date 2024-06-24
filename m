Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF181805E
	for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 09:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719219912; cv=none; b=imp0XpYpLFVnXnsDgWBdehuJUWtBfWgjN5NBpNyXp141dHg6aVzzWS2fbQh7VrP8rv01l6c7f45OA6YSddZukPdF+KREPfobfhe1sf6ePY2Xk6shVRzpTXHK+Thep+1fSo3XaH6Jt8Ys1eXZTU8zgIDF9YExf77QGybbjS6sgvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719219912; c=relaxed/simple;
	bh=uanMmf7ARJXdhd4WiaNi/StyKuoDuk7/4fUMfhSOXL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c8rcf0+d7UC0dmC3Xs3/9h4UAYZHP69Nj5Npc6UNU4AanYGnxBjtSwj+wvwNmfE7nLFwMTTcxBgudh26+F7wnYq1xtJbkch4/0eGG8xybqUyX8H/dSL2T1ItbxZtTqRHwkkmRXkB/yTysXlETv2z5K/9J49FP1yZayUM5cKADc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=TlrWMUY2; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="TlrWMUY2"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52caebc6137so3884652e87.0
        for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 02:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1719219908; x=1719824708; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0gN+3hoxxG6+HdPOo87GGU68Ol0peMezjLUq3ihcFI=;
        b=TlrWMUY2mhl1j3+L+/os5Jnn1rBDQryj1j6LPGemQ+EARIy1dXNmlNnIgH6nazP7j6
         pYIQUExNPvodS6ReodmeBTvonQ/ZL2RSt3ZK4o5QIMFNmvmiV0c5A+bSqOPO0T3sTi/B
         Do5WE3bY1Wk7Gk0oq/LIrHC8Juic6XLrQYzdkJvwrRZmn5IhbJwGnTwSi4qVKDSU4puD
         vcIfBLLc0IbaSigBwOFwd3pg19SUv9E6sKtpLHkqd25VH2gw/HN/cKQdeuiYZEvB5/eu
         eAIdxCquHLbOz+SdUQwAgzeAZaOsPmN9/BX/yD22sValCZwKzsky7McPzXCQCZZmPZfm
         Jvgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719219908; x=1719824708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q0gN+3hoxxG6+HdPOo87GGU68Ol0peMezjLUq3ihcFI=;
        b=PPSwTL+nRmt/8KRoo0asxvEqKEBIcHC/h1h3Z7fbeW9cEuWVtBrgrW+GPS7Hct3fj/
         lhEFdvxX8xu6L/TVkA7nTwmfMKMVBECCN8jx/NMotuW7FPhwn8ZSO5mzojSq3f2ROJol
         W8IOTZviVB0Vol19cXa5t8JOARdNVn070kQGTy1g85rFfDn9mPFzczAiu90x7vOx+Lnc
         7kwY5D/lg6KyBsF2CuLqsN816DBOT3nDuxFEfshWrRLO1DAyVGarOycQw4KXzD9MIplY
         1z1ls0FwJfBBpJEbbsJ+Bhf+ZDmaj4GiXve12XfNGQfGh9+4wD2lHG/mxUzVX2JpCUbP
         FN1A==
X-Gm-Message-State: AOJu0YxB1INxEa1zGR8pIeIsRqNp0Yrid1kB0T5c+289cZ88M0tIjCSs
	pYNu9BfptK5SXrCgppB8Qpl71wU29Uu1P2xwP5oOsDy7R4V0w9IfaiI9RniBdVPmpUG3NBKhEqf
	YkYA=
X-Google-Smtp-Source: AGHT+IFHPANxgRKLZ/4LEcDX8eKxvjNcXXinBKY4JzZhX9ii03Je5dQ8NiRsmdwou2f5K0GYBoKzAw==
X-Received: by 2002:ac2:54a8:0:b0:52c:999b:52f9 with SMTP id 2adb3069b0e04-52ce186457cmr2192824e87.57.1719219908484;
        Mon, 24 Jun 2024 02:05:08 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366388c41b0sm9401418f8f.44.2024.06.24.02.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 02:05:08 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com
Subject: [PATCH virtio 4/8] virtio: create admin queues alongside other virtqueues
Date: Mon, 24 Jun 2024 11:04:47 +0200
Message-ID: <20240624090451.2683976-5-jiri@resnulli.us>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240624090451.2683976-1-jiri@resnulli.us>
References: <20240624090451.2683976-1-jiri@resnulli.us>
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

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/virtio/virtio.c            | 28 +-----------
 drivers/virtio/virtio_pci_common.c | 40 ++++++++++++++++--
 drivers/virtio/virtio_pci_common.h |  4 +-
 drivers/virtio/virtio_pci_modern.c | 68 +++---------------------------
 include/linux/virtio_config.h      |  2 -
 5 files changed, 45 insertions(+), 97 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 9510c551dce8..315bc2a42f1e 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -302,15 +302,9 @@ static int virtio_dev_probe(struct device *_d)
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
@@ -323,9 +317,6 @@ static int virtio_dev_probe(struct device *_d)
 
 	return 0;
 
-err_probe:
-	if (dev->config->destroy_avq)
-		dev->config->destroy_avq(dev);
 err:
 	virtio_add_status(dev, VIRTIO_CONFIG_S_FAILED);
 	return err;
@@ -341,9 +332,6 @@ static void virtio_dev_remove(struct device *_d)
 
 	drv->remove(dev);
 
-	if (dev->config->destroy_avq)
-		dev->config->destroy_avq(dev);
-
 	/* Driver should have reset device. */
 	WARN_ON_ONCE(dev->config->get_status(dev));
 
@@ -518,9 +506,6 @@ int virtio_device_freeze(struct virtio_device *dev)
 		}
 	}
 
-	if (dev->config->destroy_avq)
-		dev->config->destroy_avq(dev);
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(virtio_device_freeze);
@@ -556,16 +541,10 @@ int virtio_device_restore(struct virtio_device *dev)
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
@@ -576,9 +555,6 @@ int virtio_device_restore(struct virtio_device *dev)
 
 	return 0;
 
-err_restore:
-	if (dev->config->destroy_avq)
-		dev->config->destroy_avq(dev);
 err:
 	virtio_add_status(dev, VIRTIO_CONFIG_S_FAILED);
 	return ret;
diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 1fb2183e409b..07c0511f170a 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -236,9 +236,6 @@ void vp_del_vqs(struct virtio_device *vdev)
 	int i;
 
 	list_for_each_entry_safe(vq, n, &vdev->vqs, list) {
-		if (vp_dev->is_avq && vp_dev->is_avq(vdev, vq->index))
-			continue;
-
 		if (vp_dev->per_vq_vectors) {
 			int v = vp_dev->vqs[vq->index]->msix_vector;
 
@@ -329,12 +326,20 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
 		struct irq_affinity *desc)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+	struct virtio_pci_admin_vq *avq = &vp_dev->admin_vq;
 	int i, err, nvectors, allocated_vectors, queue_idx = 0;
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
 	if (per_vq_vectors) {
 		/* Best option: one for change interrupt, one per vq. */
 		nvectors = 1;
@@ -366,6 +371,17 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
 			goto error_find;
 		}
 	}
+
+	if (!avq_num)
+		return 0;
+	sprintf(avq->name, "avq.%u", avq->vq_index);
+	vqs[i] = vp_find_one_vq_msix(vdev, avq->vq_index, NULL, avq->name,
+				     false, &allocated_vectors);
+	if (IS_ERR(vqs[i])) {
+		err = PTR_ERR(vqs[i]);
+		goto error_find;
+	}
+
 	return 0;
 
 error_find:
@@ -378,12 +394,20 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
 		const char * const names[], const bool *ctx)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+	struct virtio_pci_admin_vq *avq = &vp_dev->admin_vq;
 	int i, err, queue_idx = 0;
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
@@ -405,6 +429,16 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
 		}
 	}
 
+	if (!avq_num)
+		return 0;
+	sprintf(avq->name, "avq.%u", avq->vq_index);
+	vqs[i] = vp_setup_vq(vdev, queue_idx++, NULL, avq->name,
+			     false, VIRTIO_MSI_NO_VECTOR);
+	if (IS_ERR(vqs[i])) {
+		err = PTR_ERR(vqs[i]);
+		goto out_del_vqs;
+	}
+
 	return 0;
 out_del_vqs:
 	vp_del_vqs(vdev);
diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index 148d1ab01a69..b3ef76287b43 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -43,8 +43,6 @@ struct virtio_pci_vq_info {
 };
 
 struct virtio_pci_admin_vq {
-	/* Virtqueue info associated with this admin queue. */
-	struct virtio_pci_vq_info info;
 	/* serializing admin commands execution. */
 	struct mutex cmd_lock;
 	u64 supported_cmds;
@@ -102,7 +100,7 @@ struct virtio_pci_device {
 	void (*del_vq)(struct virtio_pci_vq_info *info);
 
 	u16 (*config_vector)(struct virtio_pci_device *vp_dev, u16 vector);
-	bool (*is_avq)(struct virtio_device *vdev, unsigned int index);
+	int (*avq_index)(struct virtio_device *vdev, u16 *index, u16 *num);
 };
 
 /* Constants for MSI-X */
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index ee8fb7a23d55..adbaf1ac168e 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -53,7 +53,8 @@ static bool vp_is_avq(struct virtio_device *vdev, unsigned int index)
 	return index == vp_dev->admin_vq.vq_index;
 }
 
-static int virtqueue_exec_admin_cmd(struct virtio_pci_admin_vq *admin_vq,
+static int virtqueue_exec_admin_cmd(struct virtio_pci_device *vp_dev,
+				    struct virtio_pci_admin_vq *admin_vq,
 				    u16 opcode,
 				    struct scatterlist **sgs,
 				    unsigned int out_num,
@@ -63,7 +64,7 @@ static int virtqueue_exec_admin_cmd(struct virtio_pci_admin_vq *admin_vq,
 	struct virtqueue *vq;
 	int ret, len;
 
-	vq = admin_vq->info.vq;
+	vq = vp_dev->vqs[admin_vq->vq_index]->vq;
 	if (!vq)
 		return -EIO;
 
@@ -138,7 +139,7 @@ int vp_modern_admin_cmd_exec(struct virtio_device *vdev,
 	}
 
 	mutex_lock(&vp_dev->admin_vq.cmd_lock);
-	ret = virtqueue_exec_admin_cmd(&vp_dev->admin_vq,
+	ret = virtqueue_exec_admin_cmd(vp_dev, &vp_dev->admin_vq,
 				       le16_to_cpu(cmd->opcode),
 				       sgs, out_num, in_num, sgs);
 	mutex_unlock(&vp_dev->admin_vq.cmd_lock);
@@ -203,27 +204,12 @@ static void virtio_pci_admin_cmd_list_init(struct virtio_device *virtio_dev)
 
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
@@ -418,8 +404,6 @@ static void vp_reset(struct virtio_device *vdev)
 	while (vp_modern_get_status(mdev))
 		msleep(1);
 
-	vp_modern_avq_deactivate(vdev);
-
 	/* Flush pending VQ/configuration callbacks. */
 	vp_synchronize_vectors(vdev);
 }
@@ -595,9 +579,6 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 		goto err;
 	}
 
-	if (is_avq)
-		vp_dev->admin_vq.info.vq = vq;
-
 	return vq;
 
 err:
@@ -742,41 +723,6 @@ static bool vp_get_shm_region(struct virtio_device *vdev,
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
@@ -795,8 +741,6 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
 	.get_shm_region  = vp_get_shm_region,
 	.disable_vq_and_reset = vp_modern_disable_vq_and_reset,
 	.enable_vq_after_reset = vp_modern_enable_vq_after_reset,
-	.create_avq = vp_modern_create_avq,
-	.destroy_avq = vp_modern_destroy_avq,
 };
 
 static const struct virtio_config_ops virtio_pci_config_ops = {
@@ -817,8 +761,6 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
 	.get_shm_region  = vp_get_shm_region,
 	.disable_vq_and_reset = vp_modern_disable_vq_and_reset,
 	.enable_vq_after_reset = vp_modern_enable_vq_after_reset,
-	.create_avq = vp_modern_create_avq,
-	.destroy_avq = vp_modern_destroy_avq,
 };
 
 /* the PCI probing function */
@@ -842,7 +784,7 @@ int virtio_pci_modern_probe(struct virtio_pci_device *vp_dev)
 	vp_dev->config_vector = vp_config_vector;
 	vp_dev->setup_vq = setup_vq;
 	vp_dev->del_vq = del_vq;
-	vp_dev->is_avq = vp_is_avq;
+	vp_dev->avq_index = vp_avq_index;
 	vp_dev->isr = mdev->isr;
 	vp_dev->vdev.id = mdev->id;
 
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index da9b271b54db..dfa05a3cc0a0 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -122,8 +122,6 @@ struct virtio_config_ops {
 			       struct virtio_shm_region *region, u8 id);
 	int (*disable_vq_and_reset)(struct virtqueue *vq);
 	int (*enable_vq_after_reset)(struct virtqueue *vq);
-	int (*create_avq)(struct virtio_device *vdev);
-	void (*destroy_avq)(struct virtio_device *vdev);
 };
 
 /* If driver didn't advertise the feature, it will never appear. */
-- 
2.45.1

