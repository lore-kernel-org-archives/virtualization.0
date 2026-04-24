Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007D83CAE87
	for <virtualization@lists.linux.dev>; Fri, 24 Apr 2026 12:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777033820; cv=none; b=Z+GZSGzqTY60EVXcAASjyz8mZSqYhkM9PfWriPLkqaTYcM1efVqk3kAkfU7TmRLZpRBvkZIXs/sRiTfuoQW06eCHxRhvai2FEsyohqQ+9IQG3p6PudTbF4WC4ZPdu2p+/xCrNozzGmgLeOER/iLiDsn0eIJq43ct2raYcCOD56c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777033820; c=relaxed/simple;
	bh=ElyyymLN3BzEU2n3paseyXgS1oFdDA7FSr0KdZ24I/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a/9v+57tI2yc+LzFVccGoEvUcq8r3sSMpGG5q4o7ckWM+J0ltnX9caWuzx3EfGDTJoYzk9nk6RKSu7HsIH4UtharZq0qvu2eTGRs0Utsia/5n1aTJpZDCfD17kzGA2RtjjwLfIjugD09TNGpwebXg6dEHxHdjKGpDNgWHRwajow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgQPg0qN; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgQPg0qN"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b24fdac394so75541445ad.3
        for <virtualization@lists.linux.dev>; Fri, 24 Apr 2026 05:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777033818; x=1777638618; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmg393/U6YNbXTTx1LhzYWJYt4NvUfYyO+r0SFXM9Jg=;
        b=hgQPg0qN1PfCgS2YgVo71x+eWZx++7ell0fL+z29aoty3G5vq2p8e6bjJtl7ODTEhc
         WPCbdhdM7ZJ3e/Pip5/I3+xWS1XpNLIqnh46c0t0ZUnDWODJVXH8GtDJhQUZv27oicIZ
         UUjyhq6lmfYWUB9dMRjMt6wyDV2bPsGGJPqPAPQzdq9hPIvOSzB3KfodJ4oqlQr4tji2
         HopiGREcXL4PyKc0bFU5buYNR0thTHEMctQ7H7B4sBS4gtVauuIpKIPQotQHjEE24y12
         VARgIfCvCQ317OMMv51xPBPMx77g2pFaEEW79k39Y2xV8xzklQg0B2UiAMdPekpvf2PL
         9iwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777033818; x=1777638618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lmg393/U6YNbXTTx1LhzYWJYt4NvUfYyO+r0SFXM9Jg=;
        b=bGhTnAXwd0841RGj9zPxkzMPg1BnW5vhcoD9xkqGX6noMYvQx/RZPgLDVhcInw+CPn
         mEGfEZLvqsqOYdO/km7RtjRfIrkKx9+IeuuZb79Y6CcVVhCLpiQpsJdyfRhhlsbELxW3
         Gnvkw5VAQ1LzXrqCHrkTKl4hd618GAE0JY/q6tE0dJ+kbjuPEJACpw8cnl/gPDXzBXw/
         oNp25S2YbDA8xt1s13cgdFf030tTi5LnMd9vH/FNRRKqVmh+u8dC3yM9EGWdFBhQBp/y
         5E3O45ClMZ+biNpha9ODMR2wYQwnU+QQBPWFojx7XkOndurPPxNjmeu2vW9JKYcByTGT
         AzAg==
X-Forwarded-Encrypted: i=1; AFNElJ/KOEM3Ox8ILwOzCDcCCceKDH0/51O4+xE/cBMo/Eq9APMrRv3mlv4TE9x8ced8tTZ/JmESSCxpxiyGS2EKrA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyHuwHZ+pAXExA1ijYwjs/mQJ2y7hG/fAwUBnsWC4e/2+enQLP2
	V+wb/58KrTZdR8r2saEd5NvFag5LAibVId7018I1U97SyiXKYdVGfUU3rciTriJn
X-Gm-Gg: AeBDiesn7aQ7/N0tuVgzmi3LlOAV153WZkSVPASogVM7ktDknVZD+Mmyqkn1i79ur7o
	qR7VU5hOsi8nzgr+GNo++RQ2EyChqdJHxr5vUAoHgJJdclI47mkcUPP0Um0fWR4d+hgyLYpugJz
	2xIifMaYzzbSIPbxPq5Mdv+DcAs49on9lAsg+fPNOqk3bjcjshqAjUGASLXkUTadJP6YHqei/5b
	/QIYjRzop+YereXNRDwTR0QtYb42vlkEP5ZwdTp3BIJ/WPYA+06ndUa119oMGDUbEjtxSJ/Wu3x
	H3TuuDZK8LEYEU7WAK57rXEEjFbFPn7eEDpS4u3gmC9/wUyFgWkqrDOOPcmrf9cMKvJ/gVG8vt9
	oYcStHShOfC1vluDPkHthEQUKWCtk5Au+Tj3vI+7cCKoQDhOauGUNsuHYRJYJSWfmXHn6U1yhY+
	+WCvbeTFfDLfh30S16Hv29NQXIqyltbPXAYPrH0GfR/XygOW32T8/FOUUoEtkhSa/JBx5TGyNtF
	prIsn2w9pVGo576K9j75fpdJV5oTmJAvWee6Q==
X-Received: by 2002:a17:903:3c24:b0:2b7:a3bf:b2a0 with SMTP id d9443c01a7336-2b7a3bfb415mr82719095ad.5.1777033817771;
        Fri, 24 Apr 2026 05:30:17 -0700 (PDT)
Received: from baver-zenith.localdomain ([124.49.88.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff734sm218006415ad.10.2026.04.24.05.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 05:30:17 -0700 (PDT)
From: Sungho Bae <baver.bae@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sungho Bae <baver.bae@lge.com>
Subject: [RFC PATCH v5 1/4] virtio: separate PM restore and reset_done paths
Date: Fri, 24 Apr 2026 21:29:51 +0900
Message-Id: <20260424122954.273-2-baver.bae@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260424122954.273-1-baver.bae@gmail.com>
References: <20260424122954.273-1-baver.bae@gmail.com>
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

