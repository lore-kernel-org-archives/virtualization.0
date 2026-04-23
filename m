Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974B73A9612
	for <virtualization@lists.linux.dev>; Thu, 23 Apr 2026 17:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776966056; cv=none; b=WgtOjWZKDX2t9GNal5a8QlFpn8beSirc70AgfQzmPYYmj55hIXkTjaVKRPL7xRjhul+bSMjFmCbRYiq71c/hGV14olvCLlE5CYK0ZPCf3yKojYP2y2xFuCJ6S2tmgUXTEtwQR0fS88Y5OdwcmjYaittDqzH/iYu7gDN3wV4yhmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776966056; c=relaxed/simple;
	bh=ElyyymLN3BzEU2n3paseyXgS1oFdDA7FSr0KdZ24I/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kXX39IP6Cz7Okp6kjFZVm9uMXk+kmaU6SmlAT/QAXPiSsqvE8Z+wpI7N6Frb2SBE7QK7MTO+rLiI4NqhIRuCkmpGgIT2vVntYNjvq8BHff1daPEJg6BFTNZBp96C4EmVODIpwXyZNoDFyj+JcG42NzBFBtwBHQtFhv/7Kx9ewKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pTDUmT+y; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pTDUmT+y"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82d0b68837aso4452608b3a.2
        for <virtualization@lists.linux.dev>; Thu, 23 Apr 2026 10:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776966055; x=1777570855; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmg393/U6YNbXTTx1LhzYWJYt4NvUfYyO+r0SFXM9Jg=;
        b=pTDUmT+yjUMDxeUAtnJk+sssvSc8VD02216ViOnMjaqASJbP5n6K8xma0I0N6GHI5O
         hkcL5DQSgGjeF+03n1CF20vihLPqq6aJrme0EOAvggcQWa7p8+RsN8cPLRmCPownvOy6
         j+asCUVfm2rm2cii3V45XPqko5/d6+RFVTIPfQ9lMYZCCCAqL67ggx9NJzBlrX6nhd8K
         QoJoDgeiEEWBYB40U7ZCxizfV8c1QB/wRDl7Zov23uP0ye8ObrPRRPRy9EPNaYKwDu/7
         EWfYXdmFD/3pBgtL0Jkr0lmCWP4KGlweFwXbEO1QUzpmmAZknO47wDfQgnGxOlr9gUiw
         HRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776966055; x=1777570855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lmg393/U6YNbXTTx1LhzYWJYt4NvUfYyO+r0SFXM9Jg=;
        b=QrkOaHRFJgIeXUW9/v6zLGBHb+lkLlpT9auXoNwM/XDguKNugzd96Nbik2ra254pbV
         nffx/h+Lm177zhoi3S/ge5japA8NgK5j4ytAkfxj2KXvrF/cYMmrWnna3RviIavzO2Lw
         2yGCnMcfQNsWA5Mj9GzOuaBYnRTdF66jzE5mBts4S3KokpnbUB+VIqJ+6n2qDubMOtk+
         vWS3SZlO8LmrjfXm49Eixwsiu5AoqVNNP5vj/AF33nYh3NU6kVpM+7eLgbdh2F5gmCih
         gKjjAlG1MF0v383nB6QZy+uBfFS0F+2fDCCvoXz1OBg/yLEqjST7lMKc+8TyriNgb4Jz
         I7dg==
X-Forwarded-Encrypted: i=1; AFNElJ8VUZhkGdjgTtrQYoOqAvmA+h0WIUt2ajB41MoiLAAhAWwFL9YOFKkvii+6JpZUKBjToN8i405ccphK/6EwuA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx4chj0XFt3HUaGGXQoHFnunnXcl0qX9VaItadLeUPhSczOFEZQ
	UB39whpT16sXtfTICtwwVl56/nc8W9Ijnzifvbke95LyD92CRM5ULmRH
X-Gm-Gg: AeBDietQvK0UAelEfemEfPkVVQWEYNtbHPgYkDeAcvyziAXvBDuL+9AT45gXPEGMugm
	R9/0XpELBsEujGunQRllM0jEqiASaVq9Xi7L8KxW+xDNWbZsAE/bJDxjJ2JRACmSN+6L3Dk4ows
	hPxPxUjMdHBA+O9/JN2HO28mCCd57V0TnIkIXUhtyT1tJtLZHmUPyysXRR31EKx4ajIWxu27Csk
	hqISb3UAZS06Jyw0/MxBVMhZRqR1IDiXEJcygS0o+EhaXAjJKTdDBtOgNhy8PYz73QAjkxNSRSg
	E2wP/TvuRb6WfmTGzy/Bb3KH7os3xDPidTzH6vju9pSlehVO7w9r/E6+crlBdBZzelvaDWMxbcE
	o7NseteLEb1GhHrIESntrmKDypiTu3cHHDHPVPijzvTac5XtuRZ+IPQWJljmVSR2zCqgbKs+TUp
	BowjYUlL58QteGRrXIfSZCaaOVM6c3qNxvCcCyuHO+OnG+DEormbyNoeUZvk18p71bnzcocvbvJ
	Ms6YjVWCvvHF1QR7/F5shI2wv60O/d8oXkwZg==
X-Received: by 2002:a05:6a00:1ac6:b0:829:8041:83f with SMTP id d2e1a72fcca58-82f8c7df387mr27720535b3a.7.1776966054769;
        Thu, 23 Apr 2026 10:40:54 -0700 (PDT)
Received: from baver-zenith.localdomain ([124.49.88.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebcc9easm27014498b3a.39.2026.04.23.10.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 10:40:54 -0700 (PDT)
From: Sungho Bae <baver.bae@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sungho Bae <baver.bae@lge.com>
Subject: [RFC PATCH v4 1/4] virtio: separate PM restore and reset_done paths
Date: Fri, 24 Apr 2026 02:40:36 +0900
Message-Id: <20260423174039.276-2-baver.bae@gmail.com>
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

