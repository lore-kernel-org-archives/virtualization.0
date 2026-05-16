Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A4127FD49
	for <virtualization@lists.linux.dev>; Sat, 16 May 2026 01:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778896750; cv=none; b=J5K3oJ/oCGiBjcrOxfEGUDwhH6ikljnMbb6EuMpRbDi03p8luwucJdExi04sAzSn6WvRkySvI8hcw1hXjJbeUfKNIrbMOA6m86hsHRrlb+iYXPGupkorCdUcMVzlzhNzdfO8P2unU2RHDYAUAXUno+XmLcdT07JqJUzkEIiOlEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778896750; c=relaxed/simple;
	bh=ulMWHrhAYz3XNtX+i0GVY0P4shlVGl/ceK8i2vNkHzc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FOJAta8YnACkIHHPwE5POEQkmOqu1rjyTHKYd9po9DBarPUjGd2k5D3o/ALYKTf0BmF0zv84gSqwjkmXG660IRBsZq5e7z++/R+tA3fKjqAj0JUvxqx6CEBYl4hZe4FGihhKrvi0A98HIU39RJulVYxEHZ1kvdOwOlzFx5kWCWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XFdZ7sz3; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFdZ7sz3"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c802803ac17so159417a12.1
        for <virtualization@lists.linux.dev>; Fri, 15 May 2026 18:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778896748; x=1779501548; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xmq5Cc6TQnVHvbEbh+VotFn9s+ga18ZxyIwreXpUesE=;
        b=XFdZ7sz3NjNrJlEHXp++FxhwnDJVIzCgSBvfnP255MoUuR8Ra5Y1thlMAU7lSt7nFv
         vamGTiFdpVZAK8NXHdsJUwXagmz4EcxPw0dfA+RDuf31z38l65+ZtHf4lzzMJqEXvf/B
         Fy5/LgCsebHLaTlvkrKO09ag0aFePsLIYyl0w5Ed/ToH/7EmCIwG4EHBEsVM6sndI3or
         DLBtDzK9rwdqnjUo3DWIrQ5tw9DFCDTP8p7Fv/9xVyUTB0zqPpBPMMuVDNI2LG0CnxjV
         2W0LrIsA97/KO9sZ6qFq09FwUKJFooQ+rGhSzEZ722Y/kxbPTvQzDajnrpdkSgSmN1Y/
         xBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778896748; x=1779501548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xmq5Cc6TQnVHvbEbh+VotFn9s+ga18ZxyIwreXpUesE=;
        b=lBy2cxzO0g7OQIT8TfNi1qdC5vkE4Leu2wqNQSrIfQIjMZfmpUdi9I6IuRUcZtUiiA
         VlhSmCEim9EsG0V6U85lgGJ68gsp3ZX8gywOrbSqPNLawFhJLhOZS/1I0+pqEGvpbj0X
         94b3UEB5Su98tCAYDgFBiGBONNSxc6s8oGptUDuunH9mY/7F6h1nGDEbb+yzOzxxQqTo
         Udv2fvvsqXUvuN2Cqb8qOmXmibE+3yCqkxh6w7V8KjzXc8YrK4tvbg9GHf9vkcyO9p7t
         ksrL1TbecgdtgpkV88TNbChsyFWbfDVqSp0CNz9nEfNkiUieLGPz8GES5R9dlamC8K1T
         o3bg==
X-Forwarded-Encrypted: i=1; AFNElJ93qs9fVGTHjZHkqvu/x1K8sRtN1iV1sjmE28EQBryL0CJ04vyL3IhGUE2+2xsLLpe99GYOs7HMqhhsVaXGrg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxOKGnmwGWcutNzc/v9Jd2JE/tGSr+fT0ZyVvkMiMDCNWOkH/Iv
	Upulc8KcdV2Id6NZtrCfk4jYEHhDIuJaEntrIWiSk7Uz5tqxvUoQoVC9
X-Gm-Gg: Acq92OEnW3BweGJfglD4BFOYHoWnxRkxNLQ7HsSueXmR/68RbdDEjdtDQp2LTxpwJnT
	DM7DEOKLTC4a7GyiWQ1BquXJSlGdlAq++LR6oZN4is/Hh6dsbasP3ZRJLhuIOm7ExIXmopOUVSJ
	zUpPteXb/Tl2CI2H4ubGWcPetlRudYdB2QtP+6xM69GziqOteWvCsdJQPb6yE32fDUZQ5cGZE8X
	gCi4zF3VVgFW4uAcRLb549q+4+ftFrLO4BDMn7IvxBmh5CKaakVNCYBUic0pV7pzSeZz0T9yDGA
	MfXrDmIBe3gvTjwkiNKlnOhkSJyIG1VS2ChzQvHUof/TJvthFsEImLWCmewCluXGWwXPY2Zf12f
	zuv3PJAaaPGoy7wPDaKBwlgoaWlTxXmUmMBykvcPBcRRlqpWPBzTPpHBgDbEkH4ZAanW55pi214
	9dhc7qsj2zt9u034mHzpDh8MCLmeStZRTK66wHHsyj1cMQ9yhj+PbDndiXASnD1xRpwbJ1lXLdg
	M4WXF92bXtWpvxO5nzD7lGgTneM2qIhk3XxkQ==
X-Received: by 2002:a05:6a20:6a04:b0:3ae:b670:6d35 with SMTP id adf61e73a8af0-3b22ecab6f5mr7688061637.24.1778896748145;
        Fri, 15 May 2026 18:59:08 -0700 (PDT)
Received: from baver-zenith.localdomain ([124.49.88.131])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb07b007sm6605080a12.11.2026.05.15.18.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 18:59:07 -0700 (PDT)
From: Sungho Bae <baver.bae@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	stephan.gerhold@kernkonzept.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sungho Bae <baver.bae@lge.com>
Subject: [RFC PATCH v9 2/5] virtio: separate PM restore and reset_done paths
Date: Sat, 16 May 2026 10:57:53 +0900
Message-Id: <20260516015756.20948-3-baver.bae@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260516015756.20948-1-baver.bae@gmail.com>
References: <20260516015756.20948-1-baver.bae@gmail.com>
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
2.34.1

