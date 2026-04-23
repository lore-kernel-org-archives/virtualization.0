Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9E93AC0C7
	for <virtualization@lists.linux.dev>; Thu, 23 Apr 2026 17:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776966063; cv=none; b=g/c4/9ZuK+af7HF4g92IpJkxri+R3NT5LV09wPhiGWPpOesxRQZ5HnEnVPGd/FCpP9lnbsuj92ETtBFx6FLJU0Md6VxZj+4D3kfdY11kGMsCR6oWr2Ebv35tmQGkpkNIocFbwlGQtBURCTIyYTveGZWMs6SSbl7+mpZy4/cftkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776966063; c=relaxed/simple;
	bh=ywihiWi5sgNV4rv0+p62fq6OahFHuO8mK0kqZSBO/hM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B7cHx2VOyfKC5qdJv3GamoTM8LmO7UphD7RWopyzOHEmKR5Al1ryf/Lkpxp1gKOrv0pZR2vpLstLha6b4BSsAZkXhCirz4lVPaYBjdWFfdjfzhBdKZ4Z3CQ3mb2i45DNiFMEzf4YSFEjSehtJ/jQF+WZOjk26UcioKBvfIgPYSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o+6/eAHJ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+6/eAHJ"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82fa8d6425bso2490640b3a.0
        for <virtualization@lists.linux.dev>; Thu, 23 Apr 2026 10:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776966060; x=1777570860; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qoHwCYhkOoOoCVpFvAAtjl8akaFWmoh5EGgeHJdhgck=;
        b=o+6/eAHJgPrRb7KrMTc7Ak54JsCfj4oCYcmZjsHjttFqG58SnlDUTI/C6SeBRwQfLx
         ghT/Fcs6/e9+byxY5AYVbd4AWGiX+S/JNlIlIlS+MAjw5HKVsFdYVvb9lWcrAn91k1iQ
         UETcTJn3V7bxxXyB/s8CRSGX6siuS+WmBOahvpgb4DvjPHAQhf4GbppogjlJGy3vnqbf
         qzhxRe4yy3cXYDJORz7XbmB1V8tYQPf6uf/bLlmBar0QpUIz+joTcKWWiFNWnuhztlUU
         R2h63AafYTn1bA2HVjQjlK6xwLNGKWq/M84ZoGgs4Lkt4CimBjjDi5aI1P52aBp9PU0x
         Xx9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776966060; x=1777570860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qoHwCYhkOoOoCVpFvAAtjl8akaFWmoh5EGgeHJdhgck=;
        b=dG7oXJ5G5w/fHGz07NP4Hl+7kSva4UcYLYsczEjyTQUvyN8cFVfMlSk/ZokBmidPbI
         r8J3GApXEDsaiORMYORcQ3t1/X4IYsnHOz6M88S5B/vXNjLnNAU/pg2K0szIVwZvPz+c
         YJ9VNo8mCmB/sglgh1KHZC8MG/yRP+vGPaE1LZdsosKlulyNlDzl8yx2btjbolbB1GpI
         HljovVKHgoeTRFOkhDSvSSEydUz6FZgiFClhAmwblHTNpfYQtoSVNYKS1r08sOZjcXQq
         Uvo+CTAyC9HFc0wZEminb+1S4vCdUfNIWBccolTfqKWG4UVvlqiQxYRsXXijYYCE5nCe
         Ojnw==
X-Forwarded-Encrypted: i=1; AFNElJ/PBAcjhlONyjOI0IFEKuIUGwgwJOMwPmLhfe/+EOawJaMMusnJ48gSTmCdBXSBofllgI7lvkTRSAYJ8vvUNw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzcYpalJzadN2SMM1l+R1xFeRi9ZQRwbvYI//wuvRbdYntn/arx
	YIhdmnsnTUKrJ+U5NfReeAx139GOtPQHtNFsHfdKCqilE7LGMDs9nL8N
X-Gm-Gg: AeBDiesb2wyJswOGgIok2KsuIEMHIOd0C4NuvuzQvx/psUufBJ0f6x5tbQMN4gVpXq8
	0GO6X5cO/JvdVClcm2QvZz/Q4JiR26P/pRKAY9+dJ/Jbstty6Lu6YopTTFaXxaPYYid7ZKPU1r5
	E+YOEmdDeHnaeoFle/AszqJZ5k66SsXvD8a0kJAdqQed2/mzLML6VFR2wBV5/EY9Qk3LnMJVoGg
	zxAMx+OpfZaXsOW/jxaRxWyNxgKjbB5Jjlg7fDgY5ktUa720cASYBnCcD/tK6k44zRD2asWddoS
	rRpEe4smpnYFx7TFlNubK5ywm6iBUlKjnfTv0R0jNAEJj3snKYply8JY78p1VWXB+WR+VTkbBxK
	nU1cTgDRZC2Glpj0sVMfwMEAtJN1Xlg5D43coXDDGYo0txw1DIfEkYlT41ngLwjCV45IZIpDLMU
	Y36RsRLRe96d2+jM3SHUZCAaprAWtOHREqHhWr1ylnGKxIRBiM6YjpxsorY1y7uMPv4y9nGrGQx
	oABOyr2TFe3vjyh9MUuCTHVOaZWFJMwoLSsog==
X-Received: by 2002:a05:6a00:4b56:b0:82f:5154:d1d9 with SMTP id d2e1a72fcca58-82f8c82e20dmr26770681b3a.6.1776966059513;
        Thu, 23 Apr 2026 10:40:59 -0700 (PDT)
Received: from baver-zenith.localdomain ([124.49.88.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebcc9easm27014498b3a.39.2026.04.23.10.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 10:40:59 -0700 (PDT)
From: Sungho Bae <baver.bae@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sungho Bae <baver.bae@lge.com>
Subject: [RFC PATCH v4 3/4] virtio: add noirq system sleep PM infrastructure
Date: Fri, 24 Apr 2026 02:40:38 +0900
Message-Id: <20260423174039.276-4-baver.bae@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260423174039.276-1-baver.bae@gmail.com>
References: <20260423174039.276-1-baver.bae@gmail.com>
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
 drivers/virtio/virtio.c       | 232 +++++++++++++++++++++++++++++++++-
 include/linux/virtio.h        |  10 ++
 include/linux/virtio_config.h |  39 ++++++
 3 files changed, 275 insertions(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 98f1875f8df1..5a46685f5ef9 100644
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
+	dev->noirq_restore_done = false;
 
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
@@ -627,6 +749,7 @@ int virtio_device_freeze(struct virtio_device *dev)
 	virtio_config_core_disable(dev);
 
 	dev->failed = dev->config->get_status(dev) & VIRTIO_CONFIG_S_FAILED;
+	dev->noirq_restore_done = false;
 
 	if (drv && drv->freeze) {
 		ret = drv->freeze(dev);
@@ -645,12 +768,17 @@ int virtio_device_restore(struct virtio_device *dev)
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
@@ -671,6 +799,98 @@ int virtio_device_restore(struct virtio_device *dev)
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
+	 * be noirq-safe.  Return early if not - this should normally have
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
index 69f84ea85d71..81af2ad6a7c3 100644
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
@@ -108,6 +111,14 @@ struct virtqueue_info {
  *	Returns 0 on success or error status
  *	If disable_vq_and_reset is set, then enable_vq_after_reset must also be
  *	set.
+ * @noirq_safe: set to true if @reset, @get_status, @set_status, and
+ *	@finalize_features are safe to call during the noirq phase of system
+ *	suspend/resume.  Transports that implement these operations via simple
+ *	MMIO reads/writes (e.g. virtio-mmio) can set this flag.  Transports
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

