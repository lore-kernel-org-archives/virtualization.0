Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370AE48781
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Apr 2024 07:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713769309; cv=none; b=Gc5FBIKCFwa4WUU3R3fwhdD+rSx9S/ORm6TNaiVpRPQrQwU04kfDMXVEd5HGCZxctGYuvEFRlj2oxZvcbg8utHu2pRX/eIr5F1gvovJOGh3qK8Td2mTiTCjTBUgJrG1aiArztkU63s5ScBayE9drn4Ch5Yf8UzSk+Wyv0Pa6i3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713769309; c=relaxed/simple;
	bh=Xy32KSqRdhIN0Ie4e4eGrUBUj+fNig2wgvtR1UXLyD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=blG0Hy72WZbBw11dulq1L9nRNZ3cYuAFP7E2l239z+Pfbjx1Dk4Eq4CZHj+ESj8r5dL3owD874FvEyf700/l0PoXZtjFHJgXwBRclgZuKNGUEMSlqehjn4wfCy2LxZId2GuKzk33xSTQUfySnPytG2E+n6pVb1u6+vP+ScESbsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gTKkknfa; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gTKkknfa"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DA35B4069D
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Apr 2024 07:01:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zFF-y7vopIkH for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Apr 2024 07:01:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=stevensd@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B710140719
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=chromium.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B710140719
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=gTKkknfa
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B710140719
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Apr 2024 07:01:44 +0000 (UTC)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6ee12766586so3094525b3a.0
        for <virtualization@lists.linux-foundation.org>; Mon, 22 Apr 2024 00:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713769304; x=1714374104; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vwTDCi4263bvZbgRL3BQ9EFcpy+4L1K3NItwzBfyC88=;
        b=gTKkknfa3penwlXTOBtsxmjbR1fAu/Y8sd8qEpyHX1BY3SI75stNsXNb24oAZXkIYG
         Hwe7a7pzR3P9YOuxZcqfptwiPr2NJo3vnHN5x2rBIwrrOL1VtAoGsTk2X7JFHz7hfqqD
         0gZLBYwe9flnqBezLyTn0X/H8Gbcl4XX5rQnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713769304; x=1714374104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vwTDCi4263bvZbgRL3BQ9EFcpy+4L1K3NItwzBfyC88=;
        b=cZQio3e1bhU6cpx01M3k33oMyLgmcCqfcq/j13Wv9khgLsD3I6Lkpp12bfGGXTkIZC
         pq+p8UxMGitQqduBZNuGnktS0dWoWPsna1XXDqglnaw5k/EHBmO8/C4I6r66VYeNC1FR
         MHgXLT5+puQsxkDas201PTr6iHxttg+zVvcz5JQkO9dZXa6MNx1qBtCr8VY1frvnGLTx
         wrcABlcO/+VwYAbfnKkEWrbSDH4xfsdKiWPRgGfGgt5dwJiCGuMSr+h9M3rbcULveTLx
         Kc7ZWYoaWxQiLQ4ulkVHywzqYmsf9Bemjs0IdmPq77DkHFeidRdQVNkcxL4x1SlzcfJ3
         0BGw==
X-Forwarded-Encrypted: i=1; AJvYcCWLk9qgxJGRjzvh5x8sbI/lsZK23TglLU0IoN/MhO9cMspKWFvo8jbm5r5Ff+2NGb9Wt0QKr0D/Ljsrz5q5thjPgmASlGE4CbIHqyNlbXt30LzJV5Wzh2UMNg==
X-Gm-Message-State: AOJu0YzHwEgihBm7EEOpMZLFJTXVqwWkzRcKeafxTkuFNUGa8rghbv/6
	FrDX7IGOhwKCohScMUsAJ//Bi6nDERwG6rvq4uvZZQYqdNdYIwMUNDtzdYstNA==
X-Google-Smtp-Source: AGHT+IE6pWrWTUKPGep0x/4yve610F/NLl6S35jJwaxFabOo8IE6X1d9cVSVAIr+Sv95VTHeeAe5eg==
X-Received: by 2002:a05:6a00:847:b0:6ea:dfc1:b86 with SMTP id q7-20020a056a00084700b006eadfc10b86mr13138750pfk.12.1713769303768;
        Mon, 22 Apr 2024 00:01:43 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:abfb:1876:7a20:8e16])
        by smtp.gmail.com with UTF8SMTPSA id x23-20020a056a00189700b006edadf8058asm7159767pfh.23.2024.04.22.00.01.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 00:01:42 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Eugenio Perez <eperezma@redhat.com>,
	Zhu Lingshan <lingshan.zhu@intel.com>,
	virtio-dev@lists.oasis-open.org,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	David Stevens <stevensd@chromium.org>
Subject: [PATCH v2 1/1] virtio: Add support for the virtio suspend feature
Date: Mon, 22 Apr 2024 16:01:28 +0900
Message-ID: <20240422070128.1980027-2-stevensd@chromium.org>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
In-Reply-To: <20240422070128.1980027-1-stevensd@chromium.org>
References: <20240422070128.1980027-1-stevensd@chromium.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the VIRTIO_F_SUSPEND feature. When this feature is
negotiated, power management can use it to suspend virtio devices
instead of resorting to resetting the devices entirely.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/virtio/virtio.c            | 60 ++++++++++++++++++++++++++++++
 drivers/virtio/virtio_pci_common.c | 34 ++++++++---------
 drivers/virtio/virtio_pci_modern.c | 19 ++++++++++
 include/linux/virtio.h             |  8 ++++
 include/uapi/linux/virtio_config.h | 10 ++++-
 5 files changed, 112 insertions(+), 19 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index f4080692b351..c7685a0dc995 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/virtio.h>
+#include <linux/delay.h>
 #include <linux/spinlock.h>
 #include <linux/virtio_config.h>
 #include <linux/virtio_anchor.h>
@@ -498,6 +499,13 @@ void unregister_virtio_device(struct virtio_device *dev)
 }
 EXPORT_SYMBOL_GPL(unregister_virtio_device);
 
+void virtio_device_mark_removed(struct virtio_device *dev)
+{
+	/* Pairs with READ_ONCE() in virtio_device_set_suspend_bit(). */
+	WRITE_ONCE(dev->removed, true);
+}
+EXPORT_SYMBOL_GPL(virtio_device_mark_removed);
+
 #ifdef CONFIG_PM_SLEEP
 int virtio_device_freeze(struct virtio_device *dev)
 {
@@ -580,6 +588,58 @@ int virtio_device_restore(struct virtio_device *dev)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(virtio_device_restore);
+
+static int virtio_device_set_suspend_bit(struct virtio_device *dev, bool enabled)
+{
+	u8 status, target;
+
+	status = dev->config->get_status(dev);
+	if (enabled)
+		target = status | VIRTIO_CONFIG_S_SUSPEND;
+	else
+		target = status & ~VIRTIO_CONFIG_S_SUSPEND;
+
+	if (target == status)
+		return 0;
+
+	dev->config->set_status(dev, target);
+
+	while ((status = dev->config->get_status(dev)) != target) {
+		if (status & VIRTIO_CONFIG_S_NEEDS_RESET)
+			return -EIO;
+		/* Pairs with WRITE_ONCE() in virtio_device_mark_removed(). */
+		if (READ_ONCE(dev->removed))
+			return -EIO;
+		msleep(10);
+	}
+	return 0;
+}
+
+bool virtio_device_can_suspend(struct virtio_device *dev)
+{
+	return virtio_has_feature(dev, VIRTIO_F_SUSPEND) &&
+	       (dev->config->get_status(dev) & VIRTIO_CONFIG_S_FEATURES_OK);
+}
+EXPORT_SYMBOL_GPL(virtio_device_can_suspend);
+
+int virtio_device_suspend(struct virtio_device *dev)
+{
+	return virtio_device_set_suspend_bit(dev, true);
+}
+EXPORT_SYMBOL_GPL(virtio_device_suspend);
+
+bool virtio_device_can_resume(struct virtio_device *dev)
+{
+	return virtio_has_feature(dev, VIRTIO_F_SUSPEND) &&
+	       (dev->config->get_status(dev) & VIRTIO_CONFIG_S_SUSPEND);
+}
+EXPORT_SYMBOL_GPL(virtio_device_can_resume);
+
+int virtio_device_resume(struct virtio_device *dev)
+{
+	return virtio_device_set_suspend_bit(dev, false);
+}
+EXPORT_SYMBOL_GPL(virtio_device_resume);
 #endif
 
 static int virtio_init(void)
diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index b655fccaf773..a6ca7718b5dc 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -495,31 +495,26 @@ static int virtio_pci_restore(struct device *dev)
 	return virtio_device_restore(&vp_dev->vdev);
 }
 
-static bool vp_supports_pm_no_reset(struct device *dev)
+static int virtio_pci_suspend(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
-	u16 pmcsr;
-
-	if (!pci_dev->pm_cap)
-		return false;
-
-	pci_read_config_word(pci_dev, pci_dev->pm_cap + PCI_PM_CTRL, &pmcsr);
-	if (PCI_POSSIBLE_ERROR(pmcsr)) {
-		dev_err(dev, "Unable to query pmcsr");
-		return false;
-	}
+	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
 
-	return pmcsr & PCI_PM_CTRL_NO_SOFT_RESET;
-}
+	if (virtio_device_can_suspend(&vp_dev->vdev))
+		return virtio_device_suspend(&vp_dev->vdev);
 
-static int virtio_pci_suspend(struct device *dev)
-{
-	return vp_supports_pm_no_reset(dev) ? 0 : virtio_pci_freeze(dev);
+	return virtio_pci_freeze(dev);
 }
 
 static int virtio_pci_resume(struct device *dev)
 {
-	return vp_supports_pm_no_reset(dev) ? 0 : virtio_pci_restore(dev);
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
+
+	if (virtio_device_can_resume(&vp_dev->vdev))
+		return virtio_device_resume(&vp_dev->vdev);
+
+	return virtio_pci_restore(dev);
 }
 
 static const struct dev_pm_ops virtio_pci_pm_ops = {
@@ -623,9 +618,12 @@ static void virtio_pci_remove(struct pci_dev *pci_dev)
 	 * Device is marked broken on surprise removal so that virtio upper
 	 * layers can abort any ongoing operation.
 	 */
-	if (!pci_device_is_present(pci_dev))
+	if (!pci_device_is_present(pci_dev)) {
 		virtio_break_device(&vp_dev->vdev);
 
+		virtio_device_mark_removed(&vp_dev->vdev);
+	}
+
 	pci_disable_sriov(pci_dev);
 
 	unregister_virtio_device(&vp_dev->vdev);
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index f62b530aa3b5..ac8734526b8d 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -209,6 +209,22 @@ static void vp_modern_avq_deactivate(struct virtio_device *vdev)
 	__virtqueue_break(admin_vq->info.vq);
 }
 
+static bool vp_supports_pm_no_reset(struct pci_dev *pci_dev)
+{
+	u16 pmcsr;
+
+	if (!pci_dev->pm_cap)
+		return false;
+
+	pci_read_config_word(pci_dev, pci_dev->pm_cap + PCI_PM_CTRL, &pmcsr);
+	if (PCI_POSSIBLE_ERROR(pmcsr)) {
+		dev_err(&pci_dev->dev, "Unable to query pmcsr");
+		return false;
+	}
+
+	return pmcsr & PCI_PM_CTRL_NO_SOFT_RESET;
+}
+
 static void vp_transport_features(struct virtio_device *vdev, u64 features)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
@@ -223,6 +239,9 @@ static void vp_transport_features(struct virtio_device *vdev, u64 features)
 
 	if (features & BIT_ULL(VIRTIO_F_ADMIN_VQ))
 		__virtio_set_bit(vdev, VIRTIO_F_ADMIN_VQ);
+
+	if (features & BIT_ULL(VIRTIO_F_SUSPEND) && vp_supports_pm_no_reset(pci_dev))
+		__virtio_set_bit(vdev, VIRTIO_F_SUSPEND);
 }
 
 static int __vp_check_common_size_one_feature(struct virtio_device *vdev, u32 fbit,
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index b0201747a263..2ca2ae290d4f 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -115,6 +115,7 @@ struct virtio_admin_cmd {
  * struct virtio_device - representation of a device using virtio
  * @index: unique position on the virtio bus
  * @failed: saved value for VIRTIO_CONFIG_S_FAILED bit (for restore)
+ * @removed: whether or not the device was removed from under us
  * @config_enabled: configuration change reporting enabled
  * @config_change_pending: configuration change reported while disabled
  * @config_lock: protects configuration change reporting
@@ -130,6 +131,7 @@ struct virtio_admin_cmd {
 struct virtio_device {
 	int index;
 	bool failed;
+	bool removed;
 	bool config_enabled;
 	bool config_change_pending;
 	spinlock_t config_lock;
@@ -156,10 +158,16 @@ void __virtio_unbreak_device(struct virtio_device *dev);
 void __virtqueue_break(struct virtqueue *_vq);
 void __virtqueue_unbreak(struct virtqueue *_vq);
 
+void virtio_device_mark_removed(struct virtio_device *dev);
+
 void virtio_config_changed(struct virtio_device *dev);
 #ifdef CONFIG_PM_SLEEP
 int virtio_device_freeze(struct virtio_device *dev);
 int virtio_device_restore(struct virtio_device *dev);
+bool virtio_device_can_suspend(struct virtio_device *dev);
+bool virtio_device_can_resume(struct virtio_device *dev);
+int virtio_device_suspend(struct virtio_device *dev);
+int virtio_device_resume(struct virtio_device *dev);
 #endif
 void virtio_reset_device(struct virtio_device *dev);
 
diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
index 2445f365bce7..4a6e2c28ea76 100644
--- a/include/uapi/linux/virtio_config.h
+++ b/include/uapi/linux/virtio_config.h
@@ -40,6 +40,8 @@
 #define VIRTIO_CONFIG_S_DRIVER_OK	4
 /* Driver has finished configuring features */
 #define VIRTIO_CONFIG_S_FEATURES_OK	8
+/* Driver has suspended the device */
+#define VIRTIO_CONFIG_S_SUSPEND		0x10
 /* Device entered invalid state, driver must reset it */
 #define VIRTIO_CONFIG_S_NEEDS_RESET	0x40
 /* We've given up on this device. */
@@ -52,7 +54,7 @@
  * rest are per-device feature bits.
  */
 #define VIRTIO_TRANSPORT_F_START	28
-#define VIRTIO_TRANSPORT_F_END		42
+#define VIRTIO_TRANSPORT_F_END		43
 
 #ifndef VIRTIO_CONFIG_NO_LEGACY
 /* Do we get callbacks when the ring is completely used, even if we've
@@ -120,4 +122,10 @@
  */
 #define VIRTIO_F_ADMIN_VQ		41
 
+/*
+ * This feature indicates that the driver can suspend the device via the
+ * suspend bit in the device status byte.
+ */
+#define VIRTIO_F_SUSPEND		42
+
 #endif /* _UAPI_LINUX_VIRTIO_CONFIG_H */
-- 
2.44.0.769.g3c40516874-goog

