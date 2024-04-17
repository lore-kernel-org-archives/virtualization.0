Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02F913BC18
	for <virtualization@lists.linux-foundation.org>; Wed, 17 Apr 2024 08:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713344097; cv=none; b=kTW2naPzo6yKCcnlXyE7hIfK6rXQ45KKEcottsGbta8rhHPSqcbsTmTKtyjQKBSZ4uzqFK1rCBWVGh/W/2VZjYJSDiQEN6QG41ByBQuc240qJ4kbQqnwx7epX5ozoF0Tv5lOQF+ehFrfd24PzzSG3DZMH/MFoCwGxiOukV1EmHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713344097; c=relaxed/simple;
	bh=0ycUtrSztOjzI9Q6VHwn3xtUH0mWNi0JOO2GjFmGm1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uQZhh2+wdMF7SVsNYywrJ0DXwsY3XT327pu5eIzdc3F5jpl9RqJlcJ4fsgq8ILuktuabRv2NtYSRHVojTK6UhkjKjyAK/8ii3SWsifDLis4kIPZ4JSvsQiCga3drgmqySKIDk9jv74CQIMahdFjGTDKR7sH0bU90f8mypnnAmEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SqHuemqG; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SqHuemqG"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A526A405B3
	for <virtualization@lists.linux-foundation.org>; Wed, 17 Apr 2024 08:54:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ng_XgJPoipph for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Apr 2024 08:54:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=stevensd@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E938F405B1
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=chromium.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E938F405B1
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=SqHuemqG
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E938F405B1
	for <virtualization@lists.linux-foundation.org>; Wed, 17 Apr 2024 08:54:53 +0000 (UTC)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1e6723c606dso24928875ad.1
        for <virtualization@lists.linux-foundation.org>; Wed, 17 Apr 2024 01:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713344093; x=1713948893; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jVe6fJidHiWqF1ubI92yuDtWS6IKftFO9rWVP2qn744=;
        b=SqHuemqGoUNMRbKUIz6id/YlVLyKn4xXCPv4mQHLLC4H+9XFjrQ+bciejL4BhIjiN5
         Ho6C5i2ETziSaNS6zH2nSGOPskDcOlTVVsRDMwjzxvfvfjC3UmbFYX8FE2Aar8YDTBjM
         D0yjoimqp0gKVV42cKZERh87xU3ez3gsnnb5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713344093; x=1713948893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jVe6fJidHiWqF1ubI92yuDtWS6IKftFO9rWVP2qn744=;
        b=EQiJzvKOHBzqN97X6m7Wbv47/Y5NhsXf1EpMGWrW3qk263hYrqqCYz3dWESqMggr3f
         T8NUJH2rdGgDAcTgAiUcZTSiV6r6V9xfIWQKzyWIAN2b8iue/ZuZRbc9bNIvnji5+gw9
         7Tc0zRcX6y6eH2cBhvdNU4WkPPEgrNfAPFatCovbGw71LzU5HY7VtgYQ1tULZaJ5+AFi
         13aEAgAx5OQ8mHcam3bsL0NFluGku4Djc9dJh1EYzFiZdHCXRIe1POkHpzglGNHejqak
         jrquKEkH2Ixc2D98+xX1sqzJFU9dEDaUVml+GsQ7k2sbe40KXKs/n1M2Tc7TY+1VGw28
         T8DQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQLCY1pZx0rMcwVKfYrKqYa8PKTT6p1y06wUkX2rbHscV3kZGmXj5yCWZxOkirl2D8MR4ptfO04FY9BYlaULcvXjdPXMd9aCZ5zpr68CYs/QCTUSHH54hiOw==
X-Gm-Message-State: AOJu0Yxj1XHwTESIb9VtYeQNcLAsbkzPvv0U7HccdybGbVVQ90Ra/Gm0
	l5MeXa4swFNNab0BNeS+xQgaxk4FtJnMk45DNx0HsROdUUMKV5xqQvQXHvHhrQ==
X-Google-Smtp-Source: AGHT+IHwnmxVxXYkbKiaWuH95n6UDpeU69HsZ9J/5XkmQPgDW2OBZeMIU6j8uUdiaQ0iNCv0/85HKA==
X-Received: by 2002:a17:903:2609:b0:1e2:ca65:68c2 with SMTP id jd9-20020a170903260900b001e2ca6568c2mr15746900plb.51.1713344093202;
        Wed, 17 Apr 2024 01:54:53 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:c7f8:50e7:e1ff:743b])
        by smtp.gmail.com with UTF8SMTPSA id a20-20020a170902b59400b001dddbb58d5esm11048957pls.109.2024.04.17.01.54.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 01:54:52 -0700 (PDT)
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
Subject: [PATCH 1/1] virtio: Add support for the virtio suspend feature
Date: Wed, 17 Apr 2024 17:54:39 +0900
Message-ID: <20240417085440.4036535-2-stevensd@chromium.org>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
In-Reply-To: <20240417085440.4036535-1-stevensd@chromium.org>
References: <20240417085440.4036535-1-stevensd@chromium.org>
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
 drivers/virtio/virtio.c            | 32 ++++++++++++++++++++++++++++++
 drivers/virtio/virtio_pci_common.c | 29 +++++++++++----------------
 drivers/virtio/virtio_pci_modern.c | 19 ++++++++++++++++++
 include/linux/virtio.h             |  2 ++
 include/uapi/linux/virtio_config.h | 10 +++++++++-
 5 files changed, 74 insertions(+), 18 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index f4080692b351..cd11495a5098 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/virtio.h>
+#include <linux/delay.h>
 #include <linux/spinlock.h>
 #include <linux/virtio_config.h>
 #include <linux/virtio_anchor.h>
@@ -580,6 +581,37 @@ int virtio_device_restore(struct virtio_device *dev)
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
+	dev->config->set_status(dev, target);
+
+	while ((status = dev->config->get_status(dev)) != target) {
+		if (status & VIRTIO_CONFIG_S_NEEDS_RESET)
+			return -EIO;
+		mdelay(10);
+	}
+	return 0;
+}
+
+int virtio_device_suspend(struct virtio_device *dev)
+{
+	return virtio_device_set_suspend_bit(dev, true);
+}
+EXPORT_SYMBOL_GPL(virtio_device_suspend);
+
+int virtio_device_resume(struct virtio_device *dev)
+{
+	return virtio_device_set_suspend_bit(dev, false);
+}
+EXPORT_SYMBOL_GPL(virtio_device_resume);
 #endif
 
 static int virtio_init(void)
diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index b655fccaf773..4d542de05970 100644
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
+	if (virtio_has_feature(&vp_dev->vdev, VIRTIO_F_SUSPEND))
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
+	if (virtio_has_feature(&vp_dev->vdev, VIRTIO_F_SUSPEND))
+		return virtio_device_resume(&vp_dev->vdev);
+
+	return virtio_pci_restore(dev);
 }
 
 static const struct dev_pm_ops virtio_pci_pm_ops = {
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
index b0201747a263..8e456b04114e 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -160,6 +160,8 @@ void virtio_config_changed(struct virtio_device *dev);
 #ifdef CONFIG_PM_SLEEP
 int virtio_device_freeze(struct virtio_device *dev);
 int virtio_device_restore(struct virtio_device *dev);
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
2.44.0.683.g7961c838ac-goog

