Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374E03C945A
	for <virtualization@lists.linux.dev>; Tue, 28 Apr 2026 15:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777388892; cv=none; b=QnSglyuuccPjzqaoR9ajVlUp6ivuP9IfmNgZcgNLmzZZcQ89uSpdgopW8FtaUzkiFH7eLuQW4FxyDCXQ7Ybh0Jkr+ufeglYveLKfhM+84gEWcpJnsA3ZL0pFLCwLg56KA1vlGLP96yXUMa5LBIM+fks1XMfic6hOD4gFRDHq9hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777388892; c=relaxed/simple;
	bh=ElyyymLN3BzEU2n3paseyXgS1oFdDA7FSr0KdZ24I/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bfwEtcfFwY9FGbuRjWbrmluvEJhB/f0LdOhaqLbFeHRwyQ+zhBt/BpJPsWxT+qWi2rgB+YYihLmetlMnszL7UcPfQSme1Dh/nAUNGxV+b19ERgAKlWpnxpxEFcJjbZDBUTAfOy+ySwP4ryMeiEUhYEqIbN01RBX2tnagjGYXX4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sbeE16Bj; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sbeE16Bj"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35fb16e56efso7549106a91.2
        for <virtualization@lists.linux.dev>; Tue, 28 Apr 2026 08:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777388890; x=1777993690; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmg393/U6YNbXTTx1LhzYWJYt4NvUfYyO+r0SFXM9Jg=;
        b=sbeE16BjAsnMlcDLUsSCa2RtcpfPl5nbmq8foKocVdgvM4MC8o8/ORu1vfFZN8vn/Q
         zM8sSYFQFBo25w4V/WefqzrCv5wiyHBcEooZE+gEXZjsBOgncz6LkUruUVxUPF7ahW8Y
         sWQnOfoWFUdBKpUVhveWEuC+rjDJ/hZyojb3ZBUwiX5oBy+xT4MMtus/3kZaG4Ve7l58
         m2EU6He/6REnJUetyp8T+NZuDC6NQU730QyDqHIZQ9XniPbsxS7OZkmSUV9sAPtFy7lW
         a6zPRxyS3IJ4MefCWtbIo93F5WS2ip9pOvyKKlRHGHhy32kOJtxFOFNH+kDhZqQpM6Bt
         Z6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777388890; x=1777993690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lmg393/U6YNbXTTx1LhzYWJYt4NvUfYyO+r0SFXM9Jg=;
        b=hDu6mKM3YECNEoCvMCYL5zIrsh8Td6dDdZgEubxJWHDrgiO4CsSBSOZ0RFa3ro0tAp
         7cF9Izpy1npm4tMmEvu81YJVl/Nho1pfQmEcoowMZ2uu/7y+iDd4lXGD62KrXyxHLZc1
         CsGB7WWx/VRGYBElS0tt5bQ5IlpssTgziIdRhp7TQ9n0C9r1V2NCZQiHg+RY2Ofw/IMq
         Li3uwMXDjl0bAUiv4IFxQn8OCvEzzUhYy/hFA7DfqzWSiCO+U6hF49+vg2h0H03s3bm/
         zQEs8YT8lmFrI7SFqdiEj7cQwsesETLu7Ynwp2A+O/nW9/+f/SsrLuhxu2js4C6OcKzz
         xgaw==
X-Forwarded-Encrypted: i=1; AFNElJ/x74zJPtMFx5F31cs8Y9MA4ZwaxNLdM8/CO+UJk5tfPo7rchJbw9J8gs9StTuDQImkJqx+cB2C/WGENTSHUg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwepmuEbhcvObnHF589A7cIjoSM0G43mOrQGqfo1PXhNcjftoCp
	B+UJXq2wiJuOJS41h3njWHKMy4DJU1HGxqlK6zDbbaIiBDuY90pxCiDT
X-Gm-Gg: AeBDietuIMXAp7il7L7gHT9NAeH39pK3Kce8efuzMTBCvYz+fFoCEO222ug1n55Q5Nj
	sc5iu7EyBJQEEYyAEvYBwloaPH0uldwt2yOgELg2xqz4VVvwCUdi9m43XfsXXTe300p3q774XHP
	4YYm4tYZuV4zLQCSoHJddFSMkzND44YtUyP+KdM7LYMR8KVsikMzVxKJREcfmYUJGh3iAXZ/gpF
	PeFzy+OZhWEsoEZ92TvCbLwLvJ2SzcIajy+BuWa3K1pQc4qK9k2FBnz0CVUCm9V3MNfUo/O0Q3I
	NaPmISgbbYAoHKrFAY7Kzwve8xDtJJICuyTAP3VYfNRAYOUWqbbVOWYVuXvhH9UjJFVge1sAA4J
	VhXObPIb2cpRdl3iIUavDRUEqoeoK9BmDrVc/oIIfbQuShM0pcEC5DW4lps7DdM3R/4NVBTXDHW
	Pw0zHE6m1VREo9VTyBfql5ign0KgInxPAiDd7bHFCj5wdz+Lna6ffTHbDgCPLL/QxT6FKLorE0l
	8zkCWgRA0Wte9LkgBrC0snBCbBVkgH4OXwE3A==
X-Received: by 2002:a17:90b:5148:b0:359:fe72:3559 with SMTP id 98e67ed59e1d1-3649202b5aemr4084196a91.21.1777388890159;
        Tue, 28 Apr 2026 08:08:10 -0700 (PDT)
Received: from baver-zenith.localdomain ([124.49.88.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36490bd66f6sm1606127a91.3.2026.04.28.08.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 08:08:09 -0700 (PDT)
From: Sungho Bae <baver.bae@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sungho Bae <baver.bae@lge.com>
Subject: [RFC PATCH v7 1/4] virtio: separate PM restore and reset_done paths
Date: Wed, 29 Apr 2026 00:07:39 +0900
Message-Id: <20260428150742.23999-2-baver.bae@gmail.com>
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

