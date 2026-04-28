Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C1042E01F
	for <virtualization@lists.linux.dev>; Tue, 28 Apr 2026 15:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777388899; cv=none; b=CSDiecMsr4SGdbizo0UWgenfsCdEv2vUPZJLiH0e6kd6I3Qvb0GWPP0bhekVf5VCxTx51tuFHnw9Y9zC/zaIe32Q2Iwn4ytUAIbtX4a2eSmfKV0dSwkJop9m6TY7dRl2RLTbAzNJqAsMSc/hNO3vB8nxme5+vm6rssN/iawEIQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777388899; c=relaxed/simple;
	bh=kUL17ow9gatkJ5Q2fTN0VXTszcyTDQg4H2ZFw0+QBWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AFgysqCxoSSEKWhW0FV2UMNd/+d1XvRIQVv50X59BuBO3iypCgjyRUI/3wY1FHNJvxaNAgJ2MTctALDSly/aVwEyBaZhTUyMtn3p4cNiF3+qjQWkqd+iuBmNSW5BIv0PXpR6Mo+Eb2GYv4XuYtqyffbpY+eot0ib1uKemskMmK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A626Qk89; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A626Qk89"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35fb0bb27e7so7726321a91.1
        for <virtualization@lists.linux.dev>; Tue, 28 Apr 2026 08:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777388896; x=1777993696; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tsLVv1y3HuEkiecFQkNxqEahLsQhYdFU08TfdQwzyxY=;
        b=A626Qk89F8bwrL+7YzK33fxggOITxyWQ6ZYEbjfIkamJKvG/wEgD0X4BUau1x3ni4J
         JhPi186suVaLFBSx+CKl95EE7wmxX4InC4k763hxEyo1MENFp54gzXw4m6TFze7oZpub
         BHU75WFQYty8nBWX/spqd7qCTVT3UAKf/OdbFLEwmSfX5yIdnJlpi5fuu/tXFwdaKFqa
         wWOgCjSRNnY/rI4Yo5q56MY8X4YXUG0AGnfbGLjKHAxissvejwgTTt1e9SXCQW3A2VeO
         8+mtOrsEXmBAqyPh1GMsyWA0zpWT5+AIwzl/m1kByt8C6jviEUWqXiZI8upXLy2+66pD
         badw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777388896; x=1777993696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tsLVv1y3HuEkiecFQkNxqEahLsQhYdFU08TfdQwzyxY=;
        b=pSlWp8Rte6sXcrmLe2jaffaAhuupsSQOm+GB929NR2ectGYrJb0Y8ZrW/20Cl9PN3t
         coAgkUlvkrXrfnf4Kike2IBezUSwJOI9E8F21/VkjC19NGr7J4g/V7DxpMvaBYYvITbQ
         Bm6CVPL+zZIUfjuiZs3UA3R2Mq/oyM0UT9EPbkwcmwC1NH69uladIA1FxXSNz8x0jPsJ
         yEfcsnthP10L2TF3iVGSsBptfnjhzZoLRTTemUhuf41IEfJu5hxNHcqVIvXFQS6fTSt3
         CdiaRuLUWNBy9Z8UVmUjZMSXievnUTQ0VwFg2PZTY2E9NE2JXLV7dNhTAjBPm0v4Fv3w
         88FQ==
X-Forwarded-Encrypted: i=1; AFNElJ+mF8kEBnrebZtEzqVffql/ANO7qhSUOJXhFqwuj1sHP4CqtKE9EgUwVzqxbQqD9MnqL05VaAFdV2ksWW5cbw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxc9ZYksMTh53rP1L3CCqeuYbWWEdy2KDDZ2eTACpP3TyZIIOhd
	9YG8qO0dvgtYNu5obxOjwJpbRMtC2zxYxh5oIBb42NH125q6TUhQu+Tp
X-Gm-Gg: AeBDiev8Cf+om/O0TCh+H0ssqEAQzHOTegx+zVMuubasJMxzbi8ZyRrVUjO2OBdFVxM
	kLsHjfqxPVlSFRkjrDqGwUnuwoJH8NEPPib8WMrgPC0EmqMYKEC7AGWBkODVBMH7DuaeF9WUu5k
	aOyEhGTXI/eVcR7YdMLYhzmc/ALSwQc0kzIpPnULIectie1cAkH3nT1e8BcUcMtWOWwrZQBo8b+
	qXebjw7WOjf8RHHtVGqHkkhavxiNfIBIu0PHwu70Udiqa2R8aGgfJa7hgviEwKzgOJN3a65mB7D
	tJBy2KeJEqn/WSkKE/6wgz6tbei9WupW3iHYXWEIDn2iiRdHGajOehKCIH2LP8QpPoHZOc+tSF/
	dMCFoKXwOM6ZEYDcCTGtQjy9KPPRJuBDwuLIrAeEAIgZrqonk0aiD3r6khvaeKnEd0uWk29jgTv
	23kVMX9n4xQNqRGAJ+QkQyqMUwnGa2hvB+8kEAjEA4YQNN4aVdrlzDmdscrf3Oq8abcF2PNSqjL
	mY//bS+6NKz0rauCUzhpDmHSuG+SSZ+sduisw==
X-Received: by 2002:a17:90b:1802:b0:359:15c8:e8e1 with SMTP id 98e67ed59e1d1-36492078018mr3654631a91.25.1777388895658;
        Tue, 28 Apr 2026 08:08:15 -0700 (PDT)
Received: from baver-zenith.localdomain ([124.49.88.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36490bd66f6sm1606127a91.3.2026.04.28.08.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 08:08:15 -0700 (PDT)
From: Sungho Bae <baver.bae@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sungho Bae <baver.bae@lge.com>
Subject: [RFC PATCH v7 3/4] virtio: add noirq system sleep PM infrastructure
Date: Wed, 29 Apr 2026 00:07:41 +0900
Message-Id: <20260428150742.23999-4-baver.bae@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260428150742.23999-1-baver.bae@gmail.com>
References: <20260428150742.23999-1-baver.bae@gmail.com>
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

Not all transports can safely call reset, get_status, set_status, or
finalize_features during the noirq phase: transports like virtio-ccw
issue channel commands and wait for a completion interrupt, which will
never be delivered because device interrupts are masked at the interrupt
controller during noirq suspend/resume.  To address this, introduce a
boolean field noirq_safe in struct virtio_config_ops.  Transports that
implement the above operations via simple MMIO reads/writes (e.g.
virtio-mmio) set this flag; all others leave it at the default false.

The noirq helpers assert noirq_safe via WARN_ON at runtime.
virtio_device_freeze_noirq() enforces the contract at freeze time,
returning -EOPNOTSUPP early if the driver provides restore_noirq but
the transport does not meet the requirements, to prevent a deadlock on
resume. virtio_device_restore_noirq() performs a second check as a
safety net in case freeze_noirq was not called.

Add freeze_noirq/restore_noirq callbacks to struct virtio_driver and
provide matching helper wrappers in the virtio core:

 - virtio_device_freeze_noirq(): validates noirq_safe and reset_vqs
   requirements, then forwards to drv->freeze_noirq().
 - virtio_device_restore_noirq(): guards against unsafe transports,
   runs the noirq bring-up sequence, resets existing vrings via the
   new config_ops->reset_vqs() hook, then calls drv->restore_noirq().

Modify virtio_device_restore() so that when a driver provides
restore_noirq, the normal-phase restore skips the re-initialization
that was already done in the noirq phase.

Signed-off-by: Sungho Bae <baver.bae@lge.com>
---
 drivers/virtio/virtio.c       | 262 +++++++++++++++++++++++++++++++++-
 include/linux/virtio.h        |  42 ++++++
 include/linux/virtio_config.h |  39 +++++
 3 files changed, 339 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 98f1875f8df1..50e23f10be40 100644
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
@@ -200,6 +211,21 @@ void virtio_add_status(struct virtio_device *dev, unsigned int status)
 }
 EXPORT_SYMBOL_GPL(virtio_add_status);
 
+/*
+ * Same as virtio_add_status() but without the might_sleep() assertion,
+ * so it is safe to call from noirq context.
+ *
+ * Requires the transport to have set config_ops->noirq_safe, which declares
+ * that reset, get_status, and set_status do not wait for a completion
+ * interrupt and are therefore safe during the noirq PM phase.
+ */
+void virtio_add_status_noirq(struct virtio_device *dev, unsigned int status)
+{
+	WARN_ON(!dev->config->noirq_safe);
+	dev->config->set_status(dev, dev->config->get_status(dev) | status);
+}
+EXPORT_SYMBOL_GPL(virtio_add_status_noirq);
+
 /* Do some validation, then set FEATURES_OK */
 static int virtio_features_ok(struct virtio_device *dev)
 {
@@ -234,6 +260,38 @@ static int virtio_features_ok(struct virtio_device *dev)
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
@@ -267,6 +325,28 @@ void virtio_reset_device(struct virtio_device *dev)
 }
 EXPORT_SYMBOL_GPL(virtio_reset_device);
 
+/**
+ * virtio_reset_device_noirq - noirq-safe variant of virtio_reset_device()
+ * @dev: the device to reset
+ *
+ * Requires the transport to have set config_ops->noirq_safe.
+ */
+void virtio_reset_device_noirq(struct virtio_device *dev)
+{
+	WARN_ON(!dev->config->noirq_safe);
+
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
@@ -539,6 +619,7 @@ int register_virtio_device(struct virtio_device *dev)
 	dev->config_driver_disabled = false;
 	dev->config_core_enabled = false;
 	dev->config_change_pending = false;
+	dev->noirq_state = VIRTIO_NOIRQ_NONE;
 
 	INIT_LIST_HEAD(&dev->vqs);
 	spin_lock_init(&dev->vqs_list_lock);
@@ -618,6 +699,47 @@ static int virtio_device_reinit(struct virtio_device *dev)
 	return virtio_features_ok(dev);
 }
 
+/*
+ * noirq-safe variant of virtio_device_reinit().
+ *
+ * Requires the transport to declare config_ops->noirq_safe, which means
+ * reset, get_status, set_status, and finalize_features are safe to call
+ * during the noirq PM phase.
+ */
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
@@ -627,6 +749,20 @@ int virtio_device_freeze(struct virtio_device *dev)
 	virtio_config_core_disable(dev);
 
 	dev->failed = dev->config->get_status(dev) & VIRTIO_CONFIG_S_FAILED;
+	dev->noirq_state = VIRTIO_NOIRQ_NONE;
+
+	/*
+	 * If the driver provides restore_noirq, verify that the transport
+	 * supports noirq PM. It will fail early so the PM core can abort
+	 * the transition gracefully, rather than silently skipping noirq
+	 * restore and then failing in the normal restore path.
+	 */
+	if (drv && drv->restore_noirq && !dev->config->noirq_safe) {
+		dev_warn(&dev->dev,
+			 "transport does not support noirq PM\n");
+		virtio_config_core_enable(dev);
+		return -EOPNOTSUPP;
+	}
 
 	if (drv && drv->freeze) {
 		ret = drv->freeze(dev);
@@ -645,12 +781,35 @@ int virtio_device_restore(struct virtio_device *dev)
 	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
 	int ret;
 
-	ret = virtio_device_reinit(dev);
-	if (ret)
+	/*
+	 * If the driver implements restore_noirq and the noirq phase was
+	 * actually entered (freeze_noirq ran), but restore_noirq did not
+	 * complete successfully, the noirq phase must have failed. PM core
+	 * may continue later resume phases for global recovery, but virtio
+	 * does not use the normal restore path as an implicit same-device
+	 * fallback.
+	 */
+	if (drv && drv->restore_noirq &&
+	    dev->noirq_state == VIRTIO_NOIRQ_ENTERED) {
+		ret = -EIO;
 		goto err;
+	}
 
-	if (!drv)
-		return 0;
+	/*
+	 * Re-initialization is needed only for drivers that do not
+	 * implement restore_noirq. When restore_noirq exists, either:
+	 *  - NOIRQ_NONE: noirq phase was never entered, so no noirq-specific
+	 *    teardown occurred and the device is still live.
+	 *  - NOIRQ_RESTORED: noirq phase already performed reinit.
+	 * (NOIRQ_ENTERED is caught above as -EIO.)
+	 */
+	if (!drv || !drv->restore_noirq) {
+		ret = virtio_device_reinit(dev);
+		if (ret)
+			goto err;
+		if (!drv)
+			return 0;
+	}
 
 	if (drv->restore) {
 		ret = drv->restore(dev);
@@ -671,6 +830,101 @@ int virtio_device_restore(struct virtio_device *dev)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(virtio_device_restore);
+
+int virtio_device_freeze_noirq(struct virtio_device *dev)
+{
+	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
+
+	if (!drv)
+		return 0;
+
+	/*
+	 * restore_noirq requires that the transport's config ops
+	 * (reset, get_status, set_status) are safe to call during the noirq
+	 * PM phase. Catch the mismatch early at freeze time so the PM core
+	 * can abort cleanly rather than deadlocking on resume.
+	 */
+	if (drv->restore_noirq && !dev->config->noirq_safe) {
+		dev_warn(&dev->dev,
+			 "transport does not support noirq PM\n");
+		return -EOPNOTSUPP;
+	}
+
+	/*
+	 * If the driver provides restore_noirq and has active vqs,
+	 * the transport must support reset_vqs to restore them.
+	 * Fail here so the PM core can abort the transition gracefully,
+	 * rather than hitting -EOPNOTSUPP on resume.
+	 */
+	if (drv->restore_noirq && !list_empty(&dev->vqs) &&
+	    !dev->config->reset_vqs) {
+		dev_warn(&dev->dev,
+			 "transport does not support noirq PM restore with active vqs (missing reset_vqs)\n");
+		return -EOPNOTSUPP;
+	}
+
+	/* Mark that the noirq phase has been entered. */
+	dev->noirq_state = VIRTIO_NOIRQ_ENTERED;
+
+	if (drv->freeze_noirq)
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
+	/*
+	 * All transport ops called below (reset, get_status, set_status) must
+	 * be noirq-safe. Return early if not - this should normally have
+	 * been caught at freeze_noirq time.
+	 */
+	if (!dev->config->noirq_safe) {
+		dev_warn(&dev->dev,
+			 "transport does not support noirq PM; skipping restore\n");
+		return -EOPNOTSUPP;
+	}
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
+	/* Mark that noirq restore has completed successfully. */
+	dev->noirq_state = VIRTIO_NOIRQ_RESTORED;
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
index 3bbc4cb6a672..937bc3c56bb8 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -143,6 +143,18 @@ struct virtio_admin_cmd {
 	int ret;
 };
 
+/**
+ * enum virtio_noirq_state - tracks noirq PM phase progress
+ * @VIRTIO_NOIRQ_NONE: noirq phase was not entered (only freeze ran)
+ * @VIRTIO_NOIRQ_ENTERED: freeze_noirq ran; restore_noirq is expected
+ * @VIRTIO_NOIRQ_RESTORED: restore_noirq completed successfully
+ */
+enum virtio_noirq_state {
+	VIRTIO_NOIRQ_NONE,
+	VIRTIO_NOIRQ_ENTERED,
+	VIRTIO_NOIRQ_RESTORED,
+};
+
 /**
  * struct virtio_device - representation of a device using virtio
  * @index: unique position on the virtio bus
@@ -151,6 +163,7 @@ struct virtio_admin_cmd {
  * @config_driver_disabled: configuration change reporting disabled by
  *                          a driver
  * @config_change_pending: configuration change reported while disabled
+ * @noirq_state: tracks noirq PM phase progress for restore coordination
  * @config_lock: protects configuration change reporting
  * @vqs_list_lock: protects @vqs.
  * @dev: underlying device.
@@ -171,6 +184,7 @@ struct virtio_device {
 	bool config_core_enabled;
 	bool config_driver_disabled;
 	bool config_change_pending;
+	enum virtio_noirq_state noirq_state;
 	spinlock_t config_lock;
 	spinlock_t vqs_list_lock;
 	struct device dev;
@@ -209,8 +223,12 @@ void virtio_config_driver_enable(struct virtio_device *dev);
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
 
@@ -237,6 +255,28 @@ size_t virtio_max_dma_size(const struct virtio_device *vdev);
  *    changes; may be called in interrupt context.
  * @freeze: optional function to call during suspend/hibernation.
  * @restore: optional function to call on resume.
+ *    When @restore_noirq is not implemented, core resets and reinitializes
+ *    the device before calling this. When @restore_noirq succeeded, core
+ *    skips reinitialization; drivers should avoid calling virtio_device_ready()
+ *    if DRIVER_OK was already set in the noirq phase.
+ *    When @restore_noirq failed, this callback is not invoked for same-device
+ *    recovery; the saved noirq error is propagated instead.
+ *    When the noirq phase was entirely skipped (e.g. suspend aborted before
+ *    suspend_noirq), core skips reinitialization for drivers that implement
+ *    @restore_noirq and calls @restore (if provided) to undo the freeze()
+ *    quiesce. Drivers without @restore_noirq follow the normal reinit +
+ *    restore path.
+ * @freeze_noirq: optional function to call during noirq suspend/hibernation.
+ * @restore_noirq: optional function to call on noirq resume.
+ *    If this callback fails, PM core may still continue later resume phases
+ *    for global system recovery. Virtio does not treat @restore as an
+ *    implicit same-device fallback for @restore_noirq failure; drivers should
+ *    only implement @restore_noirq when noirq resume is their required
+ *    recovery point.
+ *    A noirq restore failure is detected by the normal restore path
+ *    (noirq_state == VIRTIO_NOIRQ_ENTERED, meaning freeze_noirq ran but
+ *    restore_noirq did not complete) and returns -EIO instead of attempting
+ *    same-device recovery.
  * @reset_prepare: optional function to call when a transport specific reset
  *    occurs.
  * @reset_done: optional function to call after transport specific reset
@@ -258,6 +298,8 @@ struct virtio_driver {
 	void (*config_changed)(struct virtio_device *dev);
 	int (*freeze)(struct virtio_device *dev);
 	int (*restore)(struct virtio_device *dev);
+	int (*freeze_noirq)(struct virtio_device *dev);
+	int (*restore_noirq)(struct virtio_device *dev);
 	int (*reset_prepare)(struct virtio_device *dev);
 	int (*reset_done)(struct virtio_device *dev);
 	void (*shutdown)(struct virtio_device *dev);
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 69f84ea85d71..0110b091f634 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -70,6 +70,9 @@ struct virtqueue_info {
  *	vqs_info: array of virtqueue info structures
  *	Returns 0 on success or error status
  * @del_vqs: free virtqueues found by find_vqs().
+ * @reset_vqs: reinitialize existing virtqueues without allocating or
+ *	freeing them (optional). Used during noirq restore.
+ *	Returns 0 on success or error status.
  * @synchronize_cbs: synchronize with the virtqueue callbacks (optional)
  *      The function guarantees that all memory operations on the
  *      queue before it are visible to the vring_interrupt() that is
@@ -108,6 +111,14 @@ struct virtqueue_info {
  *	Returns 0 on success or error status
  *	If disable_vq_and_reset is set, then enable_vq_after_reset must also be
  *	set.
+ * @noirq_safe: set to true if @reset, @get_status, @set_status, and
+ *	@finalize_features are safe to call during the noirq phase of system
+ *	suspend/resume. Transports that implement these operations via simple
+ *	MMIO reads/writes (e.g. virtio-mmio) can set this flag. Transports
+ *	that issue channel commands and wait for a completion interrupt (e.g.
+ *	virtio-ccw) must NOT set it, because device interrupts are masked at
+ *	the interrupt controller during the noirq phase, which would cause the
+ *	wait to hang.
  */
 struct virtio_config_ops {
 	void (*get)(struct virtio_device *vdev, unsigned offset,
@@ -123,6 +134,7 @@ struct virtio_config_ops {
 			struct virtqueue_info vqs_info[],
 			struct irq_affinity *desc);
 	void (*del_vqs)(struct virtio_device *);
+	int (*reset_vqs)(struct virtio_device *vdev);
 	void (*synchronize_cbs)(struct virtio_device *);
 	u64 (*get_features)(struct virtio_device *vdev);
 	void (*get_extended_features)(struct virtio_device *vdev,
@@ -137,6 +149,7 @@ struct virtio_config_ops {
 			       struct virtio_shm_region *region, u8 id);
 	int (*disable_vq_and_reset)(struct virtqueue *vq);
 	int (*enable_vq_after_reset)(struct virtqueue *vq);
+	bool noirq_safe;
 };
 
 /**
@@ -371,6 +384,32 @@ void virtio_device_ready(struct virtio_device *dev)
 	dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
 }
 
+/**
+ * virtio_device_ready_noirq - noirq-safe variant of virtio_device_ready()
+ * @dev: the virtio device
+ *
+ * Requires the transport to have set config_ops->noirq_safe, which declares
+ * that get_status and set_status do not wait for a completion interrupt.
+ */
+static inline
+void virtio_device_ready_noirq(struct virtio_device *dev)
+{
+	unsigned int status = dev->config->get_status(dev);
+
+	WARN_ON(!dev->config->noirq_safe);
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

