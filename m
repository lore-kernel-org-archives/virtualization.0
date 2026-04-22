Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63453E9F60
	for <virtualization@lists.linux.dev>; Wed, 22 Apr 2026 13:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776863467; cv=none; b=EMV+w2+aRqFUXtCGW+EkunutJxG6Y8NAE/JssY0woX7iqEsii0EODjqY0HLH4xP1Cxw806MHsdeP9GjdctmDadrotg6n7S4sozGPWcQPdkbGXrNnxlmIlW9XFmzetxDLelOSZUXVeJHFqmhDjVl+8bwtwib1v/QHx0orWbRQ2c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776863467; c=relaxed/simple;
	bh=03lkltZM33ly/Y1bi8+MQwlUOAdudcrWYo3uPRrj2Pw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e/oSCHclRmR1EGITQ6k34MRg5I3ikw2gAuMPOYnFj+o9c70AtVj4Oexmp86eUmppAZL1PHMpQ2rSVbtby221ooIizxkGoxadx1rkE/nEFLN2gbMTTsAXOLxCJWdZrgfFdi5LnaLKRKUY+KWZ82mtfKZUqlOEKaWYiAgQhMWp6j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pcr6bInq; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pcr6bInq"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ab077e3f32so23029025ad.3
        for <virtualization@lists.linux.dev>; Wed, 22 Apr 2026 06:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776863465; x=1777468265; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BfTqY76zyVDHAOhHLjOsF+fg1eNIaQE5Yd8/TQ9BvSE=;
        b=Pcr6bInqRsFr7Q8sspnk/Fm/0CHgkTR+74QnEJEsyPeD/gzSC/g4K8Q6gFlynWHOWx
         GrGuBs2f3shmH1wT2eS2M5YDzXsorlcLAR7fqXGEAXgUIF5dlWN4i8F/QD2P6A52bxIJ
         L4JYiAO3ddT9rg1yuwQ4YOTRqJpi/aECSUkVSbV3BWoqXMsNA1+mvg872gFaAzSYjKgq
         nhQGDwAInwIwqoX+90SH5g1k3wWu3TnFOrOdi50n8Eqe6hbLXwo52skJEGYyMGe8WBew
         Eyf6GY9sRkodwU+DwaTnMR0RpOYVk2ghlMW7kc3WUfQfR1oj87ChhC3T2lQbiVFdVSb/
         E3FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776863465; x=1777468265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BfTqY76zyVDHAOhHLjOsF+fg1eNIaQE5Yd8/TQ9BvSE=;
        b=sDbiyvnGHy/UeLIvhbnvxGFBg5TQPLlGJWAZ+eSiOqpmRxA8IMCESHCPV5WzJfeYiu
         Q8QarZvkPR87r+W3U1ak+CD0NrzxmDm+SoaIU2WJ/NGr3ZzXS6VRzIhmA48+Q2S+OUy2
         MUdI7pg6ctJV3loEhpITcjPJVFR5VJda5XJf+Cpce9OL5rHE9aTStK5OKA6gROj0qbw6
         Qx1jJ56VlPWEfIHpKTEyH4O/1W0rXp0fGQs39ml27hz52kKEb/q8DRBYBvt7N7basSv9
         Uh8BBTFFl53X7YiufRUstWFB38alo9KKePgUbQqT7KWTn30Pv3MCMkIgyrD547AN2T7J
         PEpg==
X-Forwarded-Encrypted: i=1; AFNElJ+GgV2DtMiRHtg2aUG9psp2f3vzXTxO7Q80Z0Kr6K/e5OiC2brGoUfcKBR8VON2mNh0GzwgFXsFvxdrnbW0ZA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzZAFELH8EImawD6M4a29nXpd/U4UFzpHKzlmcMhE7TOa3qwK5d
	oRk5ZP6jQNWVwCmloQIymEkC6f44tHcfMo9mmQnQU6NicQTyWu7w4DUkgB8N/+6/
X-Gm-Gg: AeBDievpqvcwlO63GzkVAhfdXubn1deiBxMf+y7oBX1+wLflJpO/X86xhv/pMb0gWOw
	3uOtLRP4dDUytiZNmjqfbqlO/kxnPmiNjHXleKCzczPJK6KAO8YEMSAGAR4cSEsjAwSwK/sLErv
	9rSoaojyzQMX4an85ZeLaTvc71mLIf7LCkOANS9uwIs/RCaRgnniYs3iP2e13By7i+s0kPEv+mm
	xW0SVK15nmyLkaG30V6qk6doeL9tYiBVF2KwyPv3XXs2/u+Ilr5HEW9q/M/CQeELUgzslntag/k
	CHzVGfIheu263hepyL41D+U8vADBDc1dDC5tM7z64eGk5n4xc875MUIMqLzlJfJy+qy5kTKOWFk
	Q/pe/cvNC/5YNuE/FDZXK54ayS1fi0Vr2lE7T3yYHn/MbAfPnC9RlQHp4uSWTvhxJY55HePxBDl
	3lMUJvjV6+NCbOJ/UIHZTNay3iGj/6mgR8I0+2P1rrQXpjsEOipDT0mVbBNdvRsT0NhC+XRRs49
	XXRWZ3mUZcr7+pMCratHMJnCaRQ42ekKk30pA==
X-Received: by 2002:a17:903:246:b0:2b6:309:9f72 with SMTP id d9443c01a7336-2b603099feamr202064555ad.21.1776863465116;
        Wed, 22 Apr 2026 06:11:05 -0700 (PDT)
Received: from baver-zenith.localdomain ([124.49.88.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b606ce9891sm127892235ad.83.2026.04.22.06.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 06:11:04 -0700 (PDT)
From: Sungho Bae <baver.bae@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sungho Bae <baver.bae@lge.com>
Subject: [RFC PATCH v3 3/4] virtio: add noirq system sleep PM infrastructure
Date: Wed, 22 Apr 2026 22:10:13 +0900
Message-Id: <20260422131014.956-4-baver.bae@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260422131014.956-1-baver.bae@gmail.com>
References: <20260422131014.956-1-baver.bae@gmail.com>
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
 drivers/virtio/virtio.c       | 193 ++++++++++++++++++++++++++++++++--
 include/linux/virtio.h        |  10 ++
 include/linux/virtio_config.h |  29 +++++
 3 files changed, 226 insertions(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 98f1875f8df1..124ada693f5f 100644
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
@@ -539,6 +614,7 @@ int register_virtio_device(struct virtio_device *dev)
 	dev->config_driver_disabled = false;
 	dev->config_core_enabled = false;
 	dev->config_change_pending = false;
+	dev->noirq_restore_done = false;
 
 	INIT_LIST_HEAD(&dev->vqs);
 	spin_lock_init(&dev->vqs_list_lock);
@@ -618,6 +694,41 @@ static int virtio_device_reinit(struct virtio_device *dev)
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
@@ -627,6 +738,7 @@ int virtio_device_freeze(struct virtio_device *dev)
 	virtio_config_core_disable(dev);
 
 	dev->failed = dev->config->get_status(dev) & VIRTIO_CONFIG_S_FAILED;
+	dev->noirq_restore_done = false;
 
 	if (drv && drv->freeze) {
 		ret = drv->freeze(dev);
@@ -645,12 +757,17 @@ int virtio_device_restore(struct virtio_device *dev)
 	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
 	int ret;
 
-	ret = virtio_device_reinit(dev);
-	if (ret)
-		goto err;
-
-	if (!drv)
-		return 0;
+	/*
+	 * If this device was already brought up in the noirq phase,
+	 * skip the re-initialization here.
+	 */
+	if (!drv || !dev->noirq_restore_done) {
+		ret = virtio_device_reinit(dev);
+		if (ret)
+			goto err;
+		if (!drv)
+			return 0;
+	}
 
 	if (drv->restore) {
 		ret = drv->restore(dev);
@@ -671,6 +788,70 @@ int virtio_device_restore(struct virtio_device *dev)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(virtio_device_restore);
+
+int virtio_device_freeze_noirq(struct virtio_device *dev)
+{
+	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
+
+	if (drv && drv->freeze_noirq) {
+		/*
+		 * If the driver provides restore_noirq and has active vqs,
+		 * the transport must support reset_vqs to restore them.
+		 * Fail here so the PM core can abort the transition
+		 * gracefully, rather than hitting -EOPNOTSUPP on resume.
+		 */
+		if (drv->restore_noirq && !list_empty(&dev->vqs) &&
+		    !dev->config->reset_vqs)
+			return -EOPNOTSUPP;
+
+		return drv->freeze_noirq(dev);
+	}
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
+	/* Mark that noirq restore has completed. */
+	dev->noirq_restore_done = true;
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
index 3bbc4cb6a672..ab66a3799310 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -151,6 +151,7 @@ struct virtio_admin_cmd {
  * @config_driver_disabled: configuration change reporting disabled by
  *                          a driver
  * @config_change_pending: configuration change reported while disabled
+ * @noirq_restore_done: set if the noirq restore phase completed successfully
  * @config_lock: protects configuration change reporting
  * @vqs_list_lock: protects @vqs.
  * @dev: underlying device.
@@ -171,6 +172,7 @@ struct virtio_device {
 	bool config_core_enabled;
 	bool config_driver_disabled;
 	bool config_change_pending;
+	bool noirq_restore_done;
 	spinlock_t config_lock;
 	spinlock_t vqs_list_lock;
 	struct device dev;
@@ -209,8 +211,12 @@ void virtio_config_driver_enable(struct virtio_device *dev);
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
 
@@ -237,6 +243,8 @@ size_t virtio_max_dma_size(const struct virtio_device *vdev);
  *    changes; may be called in interrupt context.
  * @freeze: optional function to call during suspend/hibernation.
  * @restore: optional function to call on resume.
+ * @freeze_noirq: optional function to call during noirq suspend/hibernation.
+ * @restore_noirq: optional function to call on noirq resume.
  * @reset_prepare: optional function to call when a transport specific reset
  *    occurs.
  * @reset_done: optional function to call after transport specific reset
@@ -258,6 +266,8 @@ struct virtio_driver {
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

