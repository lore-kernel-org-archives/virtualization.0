Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DD147F2E9
	for <virtualization@lists.linux.dev>; Wed,  6 May 2026 16:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778084656; cv=none; b=LHpA/1A4lxvDRffgu8c3CD7zdJglRWSNB8b3xswBmt9adjSz5vhJ6zwApxd8zUE0Bsntbn+VCOxKP87LypIxVWKsJliDv7YC0oIdhl3RtPG6guB31MBGzHqV4IBW6ajLEzyo04XZLWExWdVo+Wc2W/XJTmyVSJuhQFwiqE3hEe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778084656; c=relaxed/simple;
	bh=ElyyymLN3BzEU2n3paseyXgS1oFdDA7FSr0KdZ24I/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LDYiLSy9rnbhRUuGiXM4gUGtUb7XKLV+yvMrGzFAnkxW0L2X7of3WtsT7I2IFKa36POZfMtreX0o2lqJjBe2ILgHgZdPKU39kHNcSFbbobKWtOIi8W/JvoQGoTnX0UlenZ9nR25JggxHOvEXzuc0YCtMs9wxhHM+2dJp9HyBuJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ne6aOK/P; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ne6aOK/P"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-839dc688d6cso798816b3a.2
        for <virtualization@lists.linux.dev>; Wed, 06 May 2026 09:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778084654; x=1778689454; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmg393/U6YNbXTTx1LhzYWJYt4NvUfYyO+r0SFXM9Jg=;
        b=Ne6aOK/P5sGeKZEGSait/p/XCngUcGRNUWwouE3LPoN2/7WrikXbY11DTJt05PnRW7
         XI5EgzD5pFL+hCbbad9Y5awNY9b7/9DnEwW7tLcAjeNUkcirsL6Slgn2oGJicZk1WmHa
         jpP8HD5U3vLw5AD8ieT8QMVk2vGwLz6FrY23oMrtdUw9xb2TJI8SwW4XZwJXOcXd5ytr
         ZW/uAmd/KSvK0oSVoUHWZNRJ8hD8ouunZQNOe6oNfDO6v+EQzzGnwUarl1c6Sx1MoXX1
         YE2lqDdG85srpfFSZz2kTD0oVb0r9W9W0kfzER/WoDXnKtSlCd+mt+Xyy1f/+7HDf7BP
         2WiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778084654; x=1778689454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lmg393/U6YNbXTTx1LhzYWJYt4NvUfYyO+r0SFXM9Jg=;
        b=g1s+nMNQbwizL9eo57STtbfIVg2MJOHcEqVe6T+F+07oUUx0B3jya2XqHXoLpvH8yK
         9vo4DcEdTArz4l+aOS9cW2bmRosksBCOa1+2rlfC3lIweruGwMY+9awL8HNQZPZQQ66Z
         3EIROkgsEjDUTeKLWTdR71g9YL3EHdhukVtYCLcULvWdRz8p1WDiUZ73ibOnL+p/IkrZ
         4uNyMy1hTgExqTBOKe/NWEOxRblfLtf5Cvtwourt4nBCyiqIq4VGbJhB7coXWkOx1MKN
         gG7w0MmgGtwDiI2F+n3Wr+SGXP9KhhsFerR0aZBtwMGJcHDQroOVi0Zjbwgc0nirlH7u
         dd7A==
X-Forwarded-Encrypted: i=1; AFNElJ8uoZpF0e3XtIClfox3SKWkD2vcqPq/WDN53mUyboQF4broSFri/UxywwYFFvVCPK8bGQfmOf1XsoDwkN8raA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxEd1NC7KcwbjDz+at6X6Yv4oP2khE/yJku+szEsA5VIFxpG0BO
	8+9NdAM43lq+hjwHXVHowlOMvupZ1n53Qks9lEW/DUFuzljZNuIXFTeZ
X-Gm-Gg: AeBDievtxRzrlxhI4QirsqVTDyaJvUVjwIrE8Q1Z5jm6wu8hKfIWmhQw7KwXIR32wWz
	HugKOjTqfXYrwJmqIvJflMj6CDJbiCWvztcVAxk5khT/hv9wr0Jn8RtOWUBmkfXdrTjJOpTaqr4
	UGdnUkfV0MzasmtD/7CMb83MAjiCSnIchpPf1ILkyT9A3/xCCDKvM267T1jMPCd3R1Fc5H45Qjn
	7wajBRHKVryRAFNGWMAZxPIFN4pMkd6hsZ1Vd/ErYnaLJ8OqLVYFakpsSRV6XfTD3YFqmKE9Apw
	c4WCZTpqjljJGrR9yHTRu5J7fcVLVbGBUI5vwEmWOYaxkqXm6EwrpgOoWJaymqJV5fdW5xEJI5C
	6DSUcrp71hdKbVjVBL2aj1T3MicB91eWMXLWrClXGMFE0gFsqlpWtndBgGK0zKtAkfG6JtO4lwR
	taH9/OLDfgqw7hmEf33qlv6p4GgnnvSYOfUoLwazXiHFwkrXTyY5P6IXmYPPfwGUqX9NNiiRorZ
	+Gh8j08kun/kzx4IYJQ0C/w6Iq1foDuQOpXkQ==
X-Received: by 2002:a05:6a00:4616:b0:824:3bd9:aac6 with SMTP id d2e1a72fcca58-83a5b9d824bmr3948577b3a.16.1778084654372;
        Wed, 06 May 2026 09:24:14 -0700 (PDT)
Received: from baver-zenith.localdomain ([124.49.88.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839679c8629sm5980337b3a.36.2026.05.06.09.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 09:24:14 -0700 (PDT)
From: Sungho Bae <baver.bae@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sungho Bae <baver.bae@lge.com>
Subject: [RFC PATCH v8 1/4] virtio: separate PM restore and reset_done paths
Date: Thu,  7 May 2026 01:22:51 +0900
Message-Id: <20260506162254.25576-2-baver.bae@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260506162254.25576-1-baver.bae@gmail.com>
References: <20260506162254.25576-1-baver.bae@gmail.com>
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

