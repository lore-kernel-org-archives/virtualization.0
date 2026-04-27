Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE253E3C5B
	for <virtualization@lists.linux.dev>; Mon, 27 Apr 2026 17:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777311126; cv=none; b=axj9Q+91XcvRl6pRuBhUHYSNrxp0vYU43yKG1hmQO4RBVGZqOetysglg3Lqvk7IV1sY+h5+TJxqhRllZGR+v725LeJKF11XnqeyfNyJVeKhljjH0Juce53q3T5P/DZ5mShrZMqP9NkWiCEjyeYxMgw4yAdFYHdBtGFNCvAC/jAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777311126; c=relaxed/simple;
	bh=ElyyymLN3BzEU2n3paseyXgS1oFdDA7FSr0KdZ24I/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d8hg422GqSpSewyLBlOD3i/2vH9EbQn7KgJWlC1z3dAc2x4d9XIZ+PV8S2xySWS3xviBpHQLLZn7QgHdRpc4mfFRUWZ5AKFsLM1GMCJycE6dQxXMpIK1yGb5p+oSKRmXAR08/ugPpFSb6pGw8yFm8swwuHvuV91CnqBZWHu0+UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZVXNwVbj; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVXNwVbj"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c798fc1a28cso3307155a12.3
        for <virtualization@lists.linux.dev>; Mon, 27 Apr 2026 10:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777311125; x=1777915925; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmg393/U6YNbXTTx1LhzYWJYt4NvUfYyO+r0SFXM9Jg=;
        b=ZVXNwVbjlMe560YF5ETSyuDwZjChX+ChOrDEJOzPfG748ZfpScZJTtETxlULV0mdZj
         dcqlkl5KDNEhFMEHLz8/jlyM+5b0VABP+2ENzw4OkVrcAcudTFT1ndR+pEJslV+O9P+j
         tDyWPWvNlIPnl7zOOHlUnad3NaIhk6wOFyZ3IIxJ/8qHqD/CMZlLSkD4RmYmtmaUlOm4
         sMgomGLFcidwuX0DcVKj/14uZmcFso4AlBoPw6BfjzR/uU/jatS5VI55vehrbjWXOITm
         fM11vDQ83YHSFcp1J2GvXJbKrlN7sREYrLvPBvK4Ym6QitHerI9XQjcBJkSxLDCB1vhR
         /jFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777311125; x=1777915925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lmg393/U6YNbXTTx1LhzYWJYt4NvUfYyO+r0SFXM9Jg=;
        b=XoT4WVxrx0heO1ZkuVs06QmzlAupq8wL0PjC7GuWLKamUWuVd+q/kkp9zZE780Rx0Y
         jF8Y49IMDtKObBrkHOSbZBwF/ZPIkN2/lZO5oroONXZ9dVOwTh56xp94tSfknR7UTkG6
         dAQeQDC1xHCwCYYX+nuBdOweKgX7Zm0GgCdeEecXCEW/x9QrJsiWAwGPQ9M1hlZQ8I7+
         oANg9m0RzSV20fq5wvje3iY4YPBRQY/QUvmhdt5iFfrkEIreNM2lHPdzCtw8Pb4zN5wX
         Uwd6NTmz7OQN2zWCXTTXrtPxi4rQsFhI3iQn2oay0aGlj4Vrtg2SFuR05lTt0n0/P+9k
         CIGQ==
X-Forwarded-Encrypted: i=1; AFNElJ/BUSkKEfcl7Hr/WKwozGb8ygopeYRxBkCnhrayleYw1KMaKdpPN+KBNYAPSGOEhhoBLlsVzOxxrGuUM6UOeg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyMt5qV1GNfaT6HY1afKToltzcWh+0iM89WCKOgxC+YawSDtiZv
	qFPEiPqNrgfHaPXidGLLD7yKkhmBvBjIzFxg/ZlFskyEwCJ8DTjus6BA
X-Gm-Gg: AeBDieuiPdFTl+oW1PEGgWkFCKRFrmdr6pv2FQs3grs+x2LGvqK4rm87JNjyQ0s0S99
	vGihhohzuo61IQZ5Y8r+/h1VLtimYBTQQqwr/xr41stLSWG3pGYuMGgLXMOKwXiTGMDLqtnDUuu
	maL/YNhJg9NmnYXeSS4ZJ1ic1DeEdQzD7dPf+tSsojK2IzEpv/wqat8Gp4mWgkVx4eEJTVdWWRn
	ivNqyOYNwzFJ77CKL2s+aqKI5D4Lrs8I4jRObaYUih687UsSo9vdYPk9KdnxW7FZl8zCfxlNcom
	BQR3RSfKS+hWksRvyIbga6WX4gYOeMfxA3YTrOycsV+U3/x39WncWXgoM1xDbd789eCyurV/jkT
	nEEnafZaKZKgcdvSh/Ejwq6rypAyyA3pAMlXi3hRIMUWNuzAil0xUxmvugOGzQvsHGUdmkm2kII
	v1QH9I83Twrd/NR2YLaaJyFghH4GtD/nxJGBfs1P3TTLwhWcB4n0n2LAnR5vaR34rWJuiBCHQuj
	Vg/5vb4HmtZg7m4B8g5iCgyWUw/ZxkkC+D23Q==
X-Received: by 2002:a05:6300:2713:10b0:3a3:1f85:645f with SMTP id adf61e73a8af0-3a398c968f4mr251771637.18.1777311124796;
        Mon, 27 Apr 2026 10:32:04 -0700 (PDT)
Received: from baver-zenith.localdomain ([124.49.88.131])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7977031729sm26246246a12.25.2026.04.27.10.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 10:32:04 -0700 (PDT)
From: Sungho Bae <baver.bae@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sungho Bae <baver.bae@lge.com>
Subject: [RFC PATCH v6 1/4] virtio: separate PM restore and reset_done paths
Date: Tue, 28 Apr 2026 02:30:42 +0900
Message-Id: <20260427173045.28652-2-baver.bae@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260427173045.28652-1-baver.bae@gmail.com>
References: <20260427173045.28652-1-baver.bae@gmail.com>
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

