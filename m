Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C63F39936E
	for <virtualization@lists.linux.dev>; Fri, 17 Apr 2026 13:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776432949; cv=none; b=LlE7lnxEKJ1MPYjhE2N3wCE1xJ7l6TX72UL6NPg6poC8gkrBjFf9i9LDrqQUn0QXuU50lczk87HlJ/iRIjllXPj/FMKu+VyJBZcY4+VTZWxJjYqlZgV7IV/wDWBxnY9b1RZkqcLsM2mzBb7cqNxcOo2andauUj5WNQ9TcirAg2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776432949; c=relaxed/simple;
	bh=0Tte3gLrWHNsIUgPgTgCELoAaeW5T9C34WqXQLOJDkw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dyewDpFxybeivSXocNrWpQABMPHsx2y2VmrP18JXcuKauzPUCyY4O+yN0KCioSqmnL1RSrDW3cc+SNxGz32Egdf0puNDtgsf37WkYrEKAbmxgeBc+cxKSy7G3o9RCsBsB6/N2oXUDYvYg3zVFswzzNTGg52ChpufVdQv8bU0/6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rEaOXfFm; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rEaOXfFm"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82f943870baso91560b3a.1
        for <virtualization@lists.linux.dev>; Fri, 17 Apr 2026 06:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776432948; x=1777037748; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F39AWoSIXRQDMzqtsZNiaPIoubFbCGy2F/eLbM+PPPY=;
        b=rEaOXfFmMVP12/2/GEirEAMuRZTO07NFJJgZ9ZNAQv1ZDkDlZTNUWCuVvDpbzrtXbK
         RQHjgppbTYP1xRMrpmx5QJvnaYqUjDVHLaMlrsv+1XurRDoZa+X3WYlgvxWNgXKBCyYo
         v1R/OwEB12/Kf6H+/QYdFNJd1zLf2WfsnEGUxqx0IStgaSph77GtXywNUYo3pWZJ8wef
         N8y6+fswK/jD9qpO8CAnrhZrRM91z5BhIIKKIzcRLbtz3lmEkZXT9tN/fFaZj6C5jD46
         qIABGQE2QavgYpkywPv7KvNesYJlFiEuTLyDQ8X+3V1vEiWLYZNXvwx25IEH9LocjH/r
         huVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776432948; x=1777037748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F39AWoSIXRQDMzqtsZNiaPIoubFbCGy2F/eLbM+PPPY=;
        b=po/BIU/XTT6Wr5OtwPjyZXYSPe+YdU2Sfpt2F94gI34tnzo6xs7PjzP3yeYUSWp75U
         WwWNF+3ugbiJM16lI4CYSwpXYJZK2rKPNjtTMdcKcFNt/xmJ9E/ieRe6lPMvnMHwsCuJ
         i9U0G3XTT2wWj+faSqyoY9jN77PDXLD7nuuXypyrZ9ps1au+oQScaPl7BZ1Q7QNvWXKD
         fuTYrBwK6RtinWDunZHFc61mwWR2f6dkvY5c/jTxhkPyNcLm3PJuSq4xLTf4GDS2qp4n
         6zzKWkcQ4Pj1xY6X57VdE/ArCuYJXohHGlLJlKp+HABvSA60xg57NnzWDj+CbfhCDHp4
         O0dg==
X-Forwarded-Encrypted: i=1; AFNElJ/NQj86JiLrzLfY6u5fk5jTw4XPf5UHsweXbG3avHrrNiFL/nZmIrFQ1QRzMlOy/1PxpCgEUnoNIgfdPL3d+A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyXbpYiT8ebBbXxGRejVECpZaC6sJolxGDi1q3Hm0eTtZ+qaqqj
	MIwmo/1+CBHrSYVYX4S675lMnvZ/WrykiwSj7v0ecLCkedWXef3TIweh
X-Gm-Gg: AeBDietfbVsPGOQx5VeHB3QvVIjCVubS1N3759oaO755alVPxg8M1yT1jSvDyiBJoAm
	zp7EY21WWHg/4PiOWWYLVwDeCdPnn6wt+9P/lSzZPBX4FK5/glozcujC9N6lJojaBJ8zWJ25def
	Z+8aZ4XoDVJGXwLlioDvZLW4gRigNg8HRZ/Ftwc3T47yFL3wtMUAtIAKzyM7hFwKpm/fwx5naAe
	OpWY05d44iYJmRAq3NUh9jmmvfj+tbBASQ3Hw9i8ghZaceAd2AmS71BmShC98vbzrSsN4qACDaG
	48C9heMMOKRZsFCXXv4boIGyMdTahsGtO8d063aoUb2LKNc2HLhslESoyodRjlo3RGyqyTHWOQL
	kJbIkDFSJb7JIkTto0GtxsmD0K3VJXcxPQNVccnd98imPaVdI17nORtlDLZ5i4085R4bXt2xLXX
	Li5gjCs1E+Fvyi1LO6oyNYK5/cMiAis1L5k/pK1tGQl4MuMyr1OtnGJLHvOD3vqS276dTs6ZTF2
	CaYpxZAeXlQpg1JxTGrd2/M0fGsBX/oCBDDdLUVZFN1aBK4
X-Received: by 2002:a05:6300:6d82:20b0:398:aea8:a9c0 with SMTP id adf61e73a8af0-3a08d6f258dmr1972814637.19.1776432947550;
        Fri, 17 Apr 2026 06:35:47 -0700 (PDT)
Received: from baver-zenith.localdomain ([124.49.88.131])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976fa3604sm1421272a12.14.2026.04.17.06.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 06:35:47 -0700 (PDT)
From: Sungho Bae <baver.bae@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sungho Bae <baver.bae@lge.com>
Subject: [RFC PATCH v2 3/4] virtio: add noirq system sleep PM infrastructure
Date: Fri, 17 Apr 2026 22:34:29 +0900
Message-Id: <20260417133430.507-4-baver.bae@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417133430.507-1-baver.bae@gmail.com>
References: <20260417133430.507-1-baver.bae@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sungho Bae <baver.bae@lge.com>

Some virtio-mmio devices, such as virtio-clock or virtio-regulator,
must become operational before the regular PM restore callback runs
because other devices may depend on them.

Add the core infrastructure needed to support noirq system-sleep PM
callbacks for virtio transports:

 - virtio_add_status_noirq(): status helper without might_sleep().
 - virtio_features_ok_noirq(): feature negotiation without might_sleep().
 - virtio_reset_device_noirq(): device reset that skips
   virtio_synchronize_cbs() (IRQ handlers are already quiesced in the
   noirq phase).
 - virtio_device_reinit_noirq(): full noirq bring-up sequence using the
   above helpers.
 - virtio_config_core_enable_noirq(): config enable with irqsave
   locking.
 - virtio_device_ready_noirq(): marks DRIVER_OK without
   virtio_synchronize_cbs().

Add freeze_noirq/restore_noirq callbacks to struct virtio_driver and
provide matching helper wrappers in the virtio core:

 - virtio_device_freeze_noirq(): forwards to drv->freeze_noirq().
 - virtio_device_restore_noirq(): runs the noirq bring-up sequence,
   resets existing vrings via the new config_ops->reset_vqs() hook,
   then calls drv->restore_noirq().

Modify virtio_device_restore() so that when a driver provides
restore_noirq, the normal-phase restore skips the re-initialization
that was already done in the noirq phase.

Signed-off-by: Sungho Bae <baver.bae@lge.com>
---
 drivers/virtio/virtio.c       | 172 +++++++++++++++++++++++++++++++++-
 include/linux/virtio.h        |   8 ++
 include/linux/virtio_config.h |  29 ++++++
 3 files changed, 206 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index b0668434ac21..4fcb6b8c797f 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -193,6 +193,17 @@ static void virtio_config_core_enable(struct virtio_device *dev)
 	spin_unlock_irq(&dev->config_lock);
 }
 
+static void virtio_config_core_enable_noirq(struct virtio_device *dev)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->config_lock, flags);
+	dev->config_core_enabled = true;
+	if (dev->config_change_pending)
+		__virtio_config_changed(dev);
+	spin_unlock_irqrestore(&dev->config_lock, flags);
+}
+
 void virtio_add_status(struct virtio_device *dev, unsigned int status)
 {
 	might_sleep();
@@ -200,6 +211,20 @@ void virtio_add_status(struct virtio_device *dev, unsigned int status)
 }
 EXPORT_SYMBOL_GPL(virtio_add_status);
 
+/*
+ * Same as virtio_add_status() but without the might_sleep() assertion,
+ * so it is safe to call from noirq context.
+ *
+ * This assumes that the device's get_status and set_status operations are
+ * also noirq-safe. Therefore, the device must garantee that get_status and
+ * set_status can be called from noirq context.
+ */
+void virtio_add_status_noirq(struct virtio_device *dev, unsigned int status)
+{
+	dev->config->set_status(dev, dev->config->get_status(dev) | status);
+}
+EXPORT_SYMBOL_GPL(virtio_add_status_noirq);
+
 /* Do some validation, then set FEATURES_OK */
 static int virtio_features_ok(struct virtio_device *dev)
 {
@@ -234,6 +259,38 @@ static int virtio_features_ok(struct virtio_device *dev)
 	return 0;
 }
 
+/* noirq-safe variant: no might_sleep(), uses virtio_add_status_noirq() */
+static int virtio_features_ok_noirq(struct virtio_device *dev)
+{
+	unsigned int status;
+
+	if (virtio_check_mem_acc_cb(dev)) {
+		if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1)) {
+			dev_warn(&dev->dev,
+				 "device must provide VIRTIO_F_VERSION_1\n");
+			return -ENODEV;
+		}
+
+		if (!virtio_has_feature(dev, VIRTIO_F_ACCESS_PLATFORM)) {
+			dev_warn(&dev->dev,
+				 "device must provide VIRTIO_F_ACCESS_PLATFORM\n");
+			return -ENODEV;
+		}
+	}
+
+	if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1))
+		return 0;
+
+	virtio_add_status_noirq(dev, VIRTIO_CONFIG_S_FEATURES_OK);
+	status = dev->config->get_status(dev);
+	if (!(status & VIRTIO_CONFIG_S_FEATURES_OK)) {
+		dev_err(&dev->dev, "virtio: device refuses features: %x\n",
+			status);
+		return -ENODEV;
+	}
+	return 0;
+}
+
 /**
  * virtio_reset_device - quiesce device for removal
  * @dev: the device to reset
@@ -267,6 +324,24 @@ void virtio_reset_device(struct virtio_device *dev)
 }
 EXPORT_SYMBOL_GPL(virtio_reset_device);
 
+/**
+ * virtio_reset_device_noirq - noirq-safe variant of virtio_reset_device()
+ * @dev: the device to reset
+ */
+void virtio_reset_device_noirq(struct virtio_device *dev)
+{
+#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
+	/*
+	 * The noirq stage runs with device IRQ handlers disabled, so
+	 * virtio_synchronize_cbs() must not be called here.
+	 */
+	virtio_break_device(dev);
+#endif
+
+	dev->config->reset(dev);
+}
+EXPORT_SYMBOL_GPL(virtio_reset_device_noirq);
+
 static int virtio_dev_probe(struct device *_d)
 {
 	int err, i;
@@ -618,6 +693,41 @@ static int virtio_device_reinit(struct virtio_device *dev)
 	return virtio_features_ok(dev);
 }
 
+/* noirq-safe variant of virtio_device_reinit() */
+static int virtio_device_reinit_noirq(struct virtio_device *dev)
+{
+	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
+	int ret;
+
+	/*
+	 * We always start by resetting the device, in case a previous
+	 * driver messed it up.
+	 */
+	virtio_reset_device_noirq(dev);
+
+	/* Acknowledge that we've seen the device. */
+	virtio_add_status_noirq(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
+
+	/*
+	 * Maybe driver failed before freeze.
+	 * Restore the failed status, for debugging.
+	 */
+	if (dev->failed)
+		virtio_add_status_noirq(dev, VIRTIO_CONFIG_S_FAILED);
+
+	if (!drv)
+		return 0;
+
+	/* We have a driver! */
+	virtio_add_status_noirq(dev, VIRTIO_CONFIG_S_DRIVER);
+
+	ret = dev->config->finalize_features(dev);
+	if (ret)
+		return ret;
+
+	return virtio_features_ok_noirq(dev);
+}
+
 #ifdef CONFIG_PM_SLEEP
 int virtio_device_freeze(struct virtio_device *dev)
 {
@@ -645,9 +755,15 @@ int virtio_device_restore(struct virtio_device *dev)
 	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
 	int ret;
 
-	ret = virtio_device_reinit(dev);
-	if (ret)
-		goto err;
+	/*
+	 * If this device was already brought up in the noirq phase,
+	 * skip the re-initialization here.
+	 */
+	if (!drv || !drv->restore_noirq) {
+		ret = virtio_device_reinit(dev);
+		if (ret)
+			goto err;
+	}
 
 	if (drv && drv->restore) {
 		ret = drv->restore(dev);
@@ -668,6 +784,56 @@ int virtio_device_restore(struct virtio_device *dev)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(virtio_device_restore);
+
+int virtio_device_freeze_noirq(struct virtio_device *dev)
+{
+	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
+
+	if (drv && drv->freeze_noirq)
+		return drv->freeze_noirq(dev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(virtio_device_freeze_noirq);
+
+int virtio_device_restore_noirq(struct virtio_device *dev)
+{
+	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
+	int ret;
+
+	if (!drv || !drv->restore_noirq)
+		return 0;
+
+	ret = virtio_device_reinit_noirq(dev);
+	if (ret)
+		goto err;
+
+	if (!list_empty(&dev->vqs)) {
+		if (!dev->config->reset_vqs) {
+			ret = -EOPNOTSUPP;
+			goto err;
+		}
+
+		ret = dev->config->reset_vqs(dev);
+		if (ret)
+			goto err;
+	}
+
+	ret = drv->restore_noirq(dev);
+	if (ret)
+		goto err;
+
+	/* If restore_noirq set DRIVER_OK, enable config now. */
+	if (dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK)
+		virtio_config_core_enable_noirq(dev);
+
+	return 0;
+
+err:
+	virtio_add_status_noirq(dev, VIRTIO_CONFIG_S_FAILED);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(virtio_device_restore_noirq);
 #endif
 
 int virtio_device_reset_prepare(struct virtio_device *dev)
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 3bbc4cb6a672..31267334e4de 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -209,8 +209,12 @@ void virtio_config_driver_enable(struct virtio_device *dev);
 #ifdef CONFIG_PM_SLEEP
 int virtio_device_freeze(struct virtio_device *dev);
 int virtio_device_restore(struct virtio_device *dev);
+int virtio_device_freeze_noirq(struct virtio_device *dev);
+int virtio_device_restore_noirq(struct virtio_device *dev);
 #endif
 void virtio_reset_device(struct virtio_device *dev);
+void virtio_reset_device_noirq(struct virtio_device *dev);
+void virtio_add_status_noirq(struct virtio_device *dev, unsigned int status);
 int virtio_device_reset_prepare(struct virtio_device *dev);
 int virtio_device_reset_done(struct virtio_device *dev);
 
@@ -237,6 +241,8 @@ size_t virtio_max_dma_size(const struct virtio_device *vdev);
  *    changes; may be called in interrupt context.
  * @freeze: optional function to call during suspend/hibernation.
  * @restore: optional function to call on resume.
+ * @freeze_noirq: optional function to call during noirq suspend/hibernation.
+ * @restore_noirq: optional function to call on noirq resume.
  * @reset_prepare: optional function to call when a transport specific reset
  *    occurs.
  * @reset_done: optional function to call after transport specific reset
@@ -258,6 +264,8 @@ struct virtio_driver {
 	void (*config_changed)(struct virtio_device *dev);
 	int (*freeze)(struct virtio_device *dev);
 	int (*restore)(struct virtio_device *dev);
+	int (*freeze_noirq)(struct virtio_device *dev);
+	int (*restore_noirq)(struct virtio_device *dev);
 	int (*reset_prepare)(struct virtio_device *dev);
 	int (*reset_done)(struct virtio_device *dev);
 	void (*shutdown)(struct virtio_device *dev);
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 69f84ea85d71..496897bc417e 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -70,6 +70,9 @@ struct virtqueue_info {
  *	vqs_info: array of virtqueue info structures
  *	Returns 0 on success or error status
  * @del_vqs: free virtqueues found by find_vqs().
+ * @reset_vqs: reinitialize existing virtqueues without allocating or
+ *	freeing them (optional).  Used during noirq restore.
+ *	Returns 0 on success or error status.
  * @synchronize_cbs: synchronize with the virtqueue callbacks (optional)
  *      The function guarantees that all memory operations on the
  *      queue before it are visible to the vring_interrupt() that is
@@ -123,6 +126,7 @@ struct virtio_config_ops {
 			struct virtqueue_info vqs_info[],
 			struct irq_affinity *desc);
 	void (*del_vqs)(struct virtio_device *);
+	int (*reset_vqs)(struct virtio_device *vdev);
 	void (*synchronize_cbs)(struct virtio_device *);
 	u64 (*get_features)(struct virtio_device *vdev);
 	void (*get_extended_features)(struct virtio_device *vdev,
@@ -371,6 +375,31 @@ void virtio_device_ready(struct virtio_device *dev)
 	dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
 }
 
+/**
+ * virtio_device_ready_noirq - noirq-safe variant of virtio_device_ready()
+ * @dev: the virtio device
+ *
+ * This assumes that the device's get_status and set_status operations are
+ * noirq-safe.
+ */
+static inline
+void virtio_device_ready_noirq(struct virtio_device *dev)
+{
+	unsigned int status = dev->config->get_status(dev);
+
+	WARN_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
+
+#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
+	/*
+	 * The noirq stage runs with device IRQ handlers disabled, so
+	 * virtio_synchronize_cbs() must not be called here.
+	 */
+	__virtio_unbreak_device(dev);
+#endif
+
+	dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
+}
+
 static inline
 const char *virtio_bus_name(struct virtio_device *vdev)
 {
-- 
2.43.0

