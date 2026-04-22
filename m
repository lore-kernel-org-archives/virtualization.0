Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B723E9F60
	for <virtualization@lists.linux.dev>; Wed, 22 Apr 2026 13:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776863463; cv=none; b=MuLZts1BY2wfJXtd/31x8NwqLiIazfN4/McoRTocsODpqEFlFCioNysg2LBLuhe11QcCnoZsWPBDN4jGHUgagYuXAFYOCkfn9bb7uJRO4A5zVp9vtW/lIwLSUWrXCTEo3cM3Jw37NKPao9ZbLP1guYhQPvw7cU1s120sycts/2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776863463; c=relaxed/simple;
	bh=ElyyymLN3BzEU2n3paseyXgS1oFdDA7FSr0KdZ24I/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fJiLeaLHrarPcP7kza8d+JgMh4Jyxl1WR693LqK+a5CUkOy7czr2bVeqpRFSXYJZ5NSHiWAR+LP9a3SgU+YtsIfJvYOllTP3apvw1QnJqqfCM7vnWtn90K9ov6596Ko3geuJCuMUMJ/67zbUtBStk0GeLz4MdH+L1BGrZLnU+4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QoSRikx4; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QoSRikx4"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2aaf59c4f7cso25039145ad.1
        for <virtualization@lists.linux.dev>; Wed, 22 Apr 2026 06:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776863461; x=1777468261; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmg393/U6YNbXTTx1LhzYWJYt4NvUfYyO+r0SFXM9Jg=;
        b=QoSRikx4vqRu6ga7U1raaulWMCNTlBvYBVNDctudpPWY0rqqB4jdSsmo5mJVqA2hiP
         NK6mhKo+gKM38yUZleyvEJaCmS/oJsOBVtB4lPIQWX9RmJ4C+aC1O10gquryHLvUvl4A
         8DRyPth2ayNnHNTJkp5uhKBUE7ElbeJe3OGBDPryzXlM2RFB4m/Anhu0w8BksIyUghqH
         LqB2eHmFW0Ivo5+pRpXVsVAgybM41FcbFCVGm4YU0Uqo1UApturotz0KHDsoBWhtE8yr
         POwmlCpWTc56j/TlmbFdE7g/yRMOnpRMsdo4X5uW+pq3GwEMFBYXGvb4k8KmIKwDRwfQ
         6Lpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776863461; x=1777468261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lmg393/U6YNbXTTx1LhzYWJYt4NvUfYyO+r0SFXM9Jg=;
        b=HimWIFiDEQo/0vbkGjeweearIBTF1faI6zyTUi6o5a7Qc+A/JV1zWExNtjqR7QizTJ
         lE7OzjrMNC5RrIYQVUgFusgVS59oXXlfOhDYz5GemxV/2CGjYjG16yxPcVfgOdxnssk2
         7mRDCz+CMZx5FdUkWYuhS9KeniWWRqI/aP+O+pfkR/IozbmfyRg2Jzm+APGX9gqW821E
         22Y7SPnmrg4WCrRdbZFnHMud9uK5yM/pSUeY6xa26C3gLogsurC7PyiC1ky8zDyQdJG4
         WK0ZUkS56WmmoX2l7yQcP4FBl0mPA/lsDc8npGHGIBCzQ+jI3L1AFZlfI/1pde7SGTw5
         n3jQ==
X-Forwarded-Encrypted: i=1; AFNElJ91HIr4keVtlpLvDHy3YAhewvwl3fcSlo/t2dt4ZlRqe7pplyZhyOA4APqlkYgiiYOkk7IWM9GnzOe92hfL4A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy7t8s95W4tOUsVUH4nbX2fbuOmOZxZv683M/5f+kncHZi1qya9
	hH41d+gw7h5pk0qIsK1qLySFFgOmfA6UNqEhdiwPqRwDLcX/E4gNoiRZ
X-Gm-Gg: AeBDietDHX6ZbDcsxQh0yXbC4vo01IrUE3E8gB3SJNjeueOMgkEudGLI3epHICyfkeq
	3HjgqAn8qTdGxQoudToSwrPdSIyyeMiirrhcU1djVcTi8P44UOV2GzP9YCfQMsIAxg+FO85L8BW
	xptufPS1Zuu2MfDDyJBWlLgj50ZNY3+EDZQ2APxx/rTDaxloNOVt/Lmpwat4kwJhaxCQkl2qFwF
	S8nEV7oWxO2JnSe162W0hENaPmJqNHOfxpv0/080Bc/ppwaCZIJ6BTyFRYhBHo1yesD3+nYwMen
	IYzwK7xwL2VJsM1W5M3XAp5OizYCFUUmNuiij5jiXFhL7OhXUs2cX7/xvzcp7RzGrTmD6P7gw/Q
	9b2Big5tRLV5bEMOukF2wopEcPwI/oYiomczL+hfbI75jH/BZpXrczariDrCOCBGUyXPIyiF9hE
	io2s5172CQ0WfCZRrC/l/sWzVEJSzgIIoCfKwNY463Mze58Q4+zKFcbE5TVxsjEOyzIve6KpcPC
	7hjF5FcH5H0SrDoNod+7hhIAnjqtbS6Z2YjuA==
X-Received: by 2002:a17:903:3204:b0:2b7:895f:407b with SMTP id d9443c01a7336-2b7895f4214mr64124515ad.21.1776863460366;
        Wed, 22 Apr 2026 06:11:00 -0700 (PDT)
Received: from baver-zenith.localdomain ([124.49.88.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b606ce9891sm127892235ad.83.2026.04.22.06.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 06:11:00 -0700 (PDT)
From: Sungho Bae <baver.bae@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sungho Bae <baver.bae@lge.com>
Subject: [RFC PATCH v3 1/4] virtio: separate PM restore and reset_done paths
Date: Wed, 22 Apr 2026 22:10:11 +0900
Message-Id: <20260422131014.956-2-baver.bae@gmail.com>
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
 drivers/virtio/virtio.c | 81 +++++++++++++++++++++++++----------------
 1 file changed, 50 insertions(+), 31 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 5bdc6b82b30b..98f1875f8df1 100644
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
@@ -668,7 +642,33 @@ EXPORT_SYMBOL_GPL(virtio_device_freeze);
 
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
+	if (!drv)
+		return 0;
+
+	if (drv->restore) {
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
@@ -698,11 +698,30 @@ EXPORT_SYMBOL_GPL(virtio_device_reset_prepare);
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

