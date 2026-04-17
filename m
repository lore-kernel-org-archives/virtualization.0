Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047D2375AA1
	for <virtualization@lists.linux.dev>; Fri, 17 Apr 2026 13:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776432942; cv=none; b=p0W71HwmRW7lSiUnVH6ot9cFXNRoeP4JgQM9eh3Rn7OuTdWy+wo5r1DEcq+oVG1hxjrCnB71KEqcMYK4gxqj72gzt5+N9sNoCK5u8YlDcYC4MlYoEEx2KGWYHZ63fBZd8QEpoXPn8ZlbdUPN9bkSs4amnGaA1Xd/0D5xMqvUKLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776432942; c=relaxed/simple;
	bh=Lc9ZuZRMssPJ6LdhNV62mIiuc51WiGNvfhGCMgaLY2A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E1Y8c+IbvUfUIy09aTkBqH1ikJSoczZ60nAIrNCACXzwVK5AxTOtCPdDf96kOJjSMvWT4QHYL1RDlpJ7T1z90y4AfKpVCapJp+W0JVPrBCRWVnBqsEZ8G7ZYfA0AFD5FMvJzrBubt8JWeVqEItVpeJDToHK7PU7PMH1NfyLwyy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jdMlS9FO; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdMlS9FO"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82748257f5fso1028776b3a.1
        for <virtualization@lists.linux.dev>; Fri, 17 Apr 2026 06:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776432940; x=1777037740; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdDAtCg/5gWiORhKSpZnqdKkvEwJP2sVvd/SKqDyQdQ=;
        b=jdMlS9FOGfEKEfVu+yJHBOJHFzETp613FBlPEmvtBuXCx4UeIrAa/KSzzjPQDmW53Y
         dsEFDB17IL59UJ0rmK9UiFtqe4LvIXzO3N98rvYfYpBdV9EWW5WiwyPjsHaAVHJzaWNx
         +mEp4BfcdJzqQlF7joQcwyo9y3XtrOWebT+AR/TuSBYjRkHUK9XZxoDIkJpKFaeG9Umk
         Cx03NY6FdHjLTAcg330P8eq5j7H09oYBuA3RSDo+3bw0Uz+Gzs2oVqAtirXIKYJNq3p7
         9K4w8yOGFI+zL4UmRySesNE9wc/BCRy75Q53eVYriWagNMXbYOnErhveOGG+W26h4qJh
         LPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776432940; x=1777037740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fdDAtCg/5gWiORhKSpZnqdKkvEwJP2sVvd/SKqDyQdQ=;
        b=bHbmfuDXDsia/rpEweeUYC3IywLIPQBKBnUBJJNPhd2lp6jU15O4vG2JM5teTzVPiw
         d/YYRRop8tcAGyQNLxy5gRFn3HhtdtSblOGgEITUv82QvwfJauhSapMLJPPF5skIFSSE
         bfY7TsHxZ1+xGuaKnM2QcYWzGeycrhwgK+Iot8P3q9O/dO0/pFJB7i0eU41v8OwSCjS1
         tKsb3Yny6/+heDylR11s/vBkuw5pUzRWhB3mHRvzkSyIooU4svA/q4kVlMZaXOxLe6+f
         //XSkcjt2msz/dTfWgov3Aj62jWc55nD8zhkeKOiPf6x9tAhVHhC+BssA1urM0xZ3Rqb
         Tp+A==
X-Forwarded-Encrypted: i=1; AFNElJ+WwbFr8WLzUmWUkOczCL+8lPPP6+hf8v4aYZGwLzQOuWoA6a2IvlC/EgSR6HMHd4MOQ3rKDD63GVIGkZWZrw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwAo72moZ85HHtgkIBr3HiiWydN75fczdp9bSQkAINz9YSKd/sr
	rVUVG+KplgVchjFNdTY3PE98XECq9xf9GTupmICLeXlQNiHlmDrCom3e
X-Gm-Gg: AeBDiet05iSQAcZqXaK9pFZhiZRl4nuz9KzRi90hymQoj0ZvlR7WhOXjNsre7nPr0bl
	7PUjoEqT/wD/u37zAPHtXqsFMf6sC95KL73rxqEGuswCWHFtChvcY1d/8UWtirb6BllODZFG4wB
	rOsn1fOCKU9m/EPft04BxgAVmKWQfdrpKGzhY+6cLZ1uoEIeNDSAwS4Fhl6ld15jA5afyt1BOCp
	N+HH/SvDt/CPU/vxKFLj6zWS6BaKoEUSFIuGnW4UX8mFv6vc1Ns3f8AjaZOMLXYdO/VFFqaVj38
	hlhYd3qZb8UtPcKByTqEZHlcNvqZtvRoT3ADxRU2h55znLi4kGf/YiFe97aoMcszLWbSZAbmksT
	zkcB3j1qfEbrWdoIrxmsUfuaraCzXGcPHb6JC0Kkm1JHqQlECW/ujrNSZ8tGnahqatC204xr/Et
	Vq+UxG5/FfR2sLZTEODSwTw5DWrTo+aqys44dqiA+C5rc92iLP+ua9Ki7f4a1DQLUDrNzxzuXWJ
	+t4+vtk3hwM/46giJhgiMRjcMx2bs7rdwPb7Q==
X-Received: by 2002:a05:6a20:729c:b0:39f:582c:aa8a with SMTP id adf61e73a8af0-3a08ca73cf4mr2590496637.19.1776432940119;
        Fri, 17 Apr 2026 06:35:40 -0700 (PDT)
Received: from baver-zenith.localdomain ([124.49.88.131])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976fa3604sm1421272a12.14.2026.04.17.06.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 06:35:39 -0700 (PDT)
From: Sungho Bae <baver.bae@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sungho Bae <baver.bae@lge.com>
Subject: [RFC PATCH v2 1/4] virtio: separate PM restore and reset_done paths
Date: Fri, 17 Apr 2026 22:34:27 +0900
Message-Id: <20260417133430.507-2-baver.bae@gmail.com>
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

Refactor virtio_device_restore_priv() by extracting the common device
re-initialization sequence into virtio_device_reinit(). This helper
performs the full bring-up sequence: reset, status acknowledgment,
feature finalization, and feature negotiation.

virtio_device_restore() and virtio_device_reset_done() now each call
virtio_device_reinit() directly instead of going through a boolean-
dispatched wrapper. This makes each path independently readable and
extensible without further complicating the dispatch logic.

A follow-up series will add noirq PM callbacks that only affect the
restore path; having the two paths separated avoids adding more
conditionals to a shared function.

No functional change.

Signed-off-by: Sungho Bae <baver.bae@lge.com>
---
 drivers/virtio/virtio.c | 78 +++++++++++++++++++++++++----------------
 1 file changed, 47 insertions(+), 31 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 5bdc6b82b30b..b0668434ac21 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -588,7 +588,7 @@ void unregister_virtio_device(struct virtio_device *dev)
 }
 EXPORT_SYMBOL_GPL(unregister_virtio_device);
 
-static int virtio_device_restore_priv(struct virtio_device *dev, bool restore)
+static int virtio_device_reinit(struct virtio_device *dev)
 {
 	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
 	int ret;
@@ -613,35 +613,9 @@ static int virtio_device_restore_priv(struct virtio_device *dev, bool restore)
 
 	ret = dev->config->finalize_features(dev);
 	if (ret)
-		goto err;
-
-	ret = virtio_features_ok(dev);
-	if (ret)
-		goto err;
-
-	if (restore) {
-		if (drv->restore) {
-			ret = drv->restore(dev);
-			if (ret)
-				goto err;
-		}
-	} else {
-		ret = drv->reset_done(dev);
-		if (ret)
-			goto err;
-	}
-
-	/* If restore didn't do it, mark device DRIVER_OK ourselves. */
-	if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK))
-		virtio_device_ready(dev);
-
-	virtio_config_core_enable(dev);
-
-	return 0;
+		return ret;
 
-err:
-	virtio_add_status(dev, VIRTIO_CONFIG_S_FAILED);
-	return ret;
+	return virtio_features_ok(dev);
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -668,7 +642,30 @@ EXPORT_SYMBOL_GPL(virtio_device_freeze);
 
 int virtio_device_restore(struct virtio_device *dev)
 {
-	return virtio_device_restore_priv(dev, true);
+	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
+	int ret;
+
+	ret = virtio_device_reinit(dev);
+	if (ret)
+		goto err;
+
+	if (drv && drv->restore) {
+		ret = drv->restore(dev);
+		if (ret)
+			goto err;
+	}
+
+	/* If restore didn't do it, mark device DRIVER_OK ourselves. */
+	if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK))
+		virtio_device_ready(dev);
+
+	virtio_config_core_enable(dev);
+
+	return 0;
+
+err:
+	virtio_add_status(dev, VIRTIO_CONFIG_S_FAILED);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(virtio_device_restore);
 #endif
@@ -698,11 +695,30 @@ EXPORT_SYMBOL_GPL(virtio_device_reset_prepare);
 int virtio_device_reset_done(struct virtio_device *dev)
 {
 	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
+	int ret;
 
 	if (!drv || !drv->reset_done)
 		return -EOPNOTSUPP;
 
-	return virtio_device_restore_priv(dev, false);
+	ret = virtio_device_reinit(dev);
+	if (ret)
+		goto err;
+
+	ret = drv->reset_done(dev);
+	if (ret)
+		goto err;
+
+	/* If reset_done didn't do it, mark device DRIVER_OK ourselves. */
+	if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK))
+		virtio_device_ready(dev);
+
+	virtio_config_core_enable(dev);
+
+	return 0;
+
+err:
+	virtio_add_status(dev, VIRTIO_CONFIG_S_FAILED);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(virtio_device_reset_done);
 
-- 
2.43.0

