Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F113DFC98
	for <virtualization@lists.linux.dev>; Wed, 15 Apr 2026 17:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776274842; cv=none; b=VPqNBJhL/N4cowK1ZJGe5qfonaossqSOR+AL5x505Sut89CMZdlFe7OlMbeyNeFVpQcbtNhyZDFqMTksrRm1ePIJC1izMyg3nKlTEcjoIXCidL+Vgl0xFY/hNs0TF4HA2v8ZUJU6/YdVM0M2nYkglAocYbRoO+6HmbJRyghpT+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776274842; c=relaxed/simple;
	bh=+pHt1PdX1ZX2M9ksmMWjbdl6LSzaUGO1nZKoaNMIRv4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m7PMB2fvi7Vxjye8XfnI2X0UgesZebKPpy06aJ05k9nIjwZMPOXVPyhUPbV+qHCbRPQ0SFm9IwUDqa+pgS4shJdikFFUYXrGyH9XetpmU2/+iHH+ZSt7galP02I2O8yTsCnrkoUwgxhRXX0n1kzb3EOBAUNLMgCOVlVzOQ9NhRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HR4zUI/a; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HR4zUI/a"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-35e576110adso2598691a91.0
        for <virtualization@lists.linux.dev>; Wed, 15 Apr 2026 10:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776274841; x=1776879641; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qk8GKpbjud7iZDAxYS6mtLV1J/SUvTNFEIEfpQruf8s=;
        b=HR4zUI/aLupmuVJA2FpmPowF4C4Tt/Be1+dEmCxEUVURjJoeOK78U46FjAzPQoZAT7
         E1QU/9POmEH5LgIZAlH30S8hUaMuBZXAis9RVF2/sPeKkdpfIQawGVVFulAhckEcTQvU
         +sc6d6K79hl7e+qYPVEEd3KCMMnEeYRF0ddVCA1LMSBD1nJNz0rwCOHdkPh83BDVcGeo
         B7+s2XKKJxZtrjEMOrkr4vzMQ0U0kpJC2bp906ehGRY7/eNJ2+RMWOhcNeQ4QhiDxA0p
         Ok7viv+czUTJ70PdXtFr+gqdBS27bowvTQGfeHh1U67chea1d89jby4+jWqNkpGoRWxG
         TcHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776274841; x=1776879641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qk8GKpbjud7iZDAxYS6mtLV1J/SUvTNFEIEfpQruf8s=;
        b=BMX9uKHR/MSHCLC14pQ2f1Qb8wySFkCgrJr+yjGmRlXX9YG3KRh/Bwksr0ALY0vjhD
         N+qmhbzrIlJwySGF2Rtka5H/FeAODbdPfDTFsGnzgB8p3oSyJWrxNEAs6V/4s9d4lREK
         rTO0m/iao9iPTux0Ah00VfSZWGLp60Nl/Cjn3oqlnnSP2WECjuCOU5GPmJwMHw0s0bam
         GbTdtkcvLtGPOc6Ghhn+Mr9O5NDX3zmkV/3yjBJPLkQSyU8QL8BQwzjuHr6GHhSrScBJ
         7KQSXQ/89KlyFZ3ZfklCYFuJTLmS2IRqvgoLYvp6NnP1nqMgrPbr6pO9BJm9ghn1Nsi9
         6CLg==
X-Forwarded-Encrypted: i=1; AFNElJ8WmXrPjvAkw2yc0RWGwrrOek4EO/e8pnUSPqY79fc2rnkdNwnE168f8vuQKsFMwgLW5er2cLqcaAgR6PKrBw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyIaEiDytyasgc6XRH9Uvb5tGpGZWiIMlLTdccwXLlT6t8CcjpT
	ebk/CT91agP2t/P40LcjJGkxcX8cVW8ZZIWoyduRFAsu5nXRspoKuMpCp1sdaYO6
X-Gm-Gg: AeBDieuktxZFgdAGySNAeDX5EJx0tcsgrKWIVPcxDHnJXv2dmutR4M2kakReIlsPJOs
	VORt9k3l+xnlK2K5tjykcSCvJoWSPj7+qDuitbGqeaFZ6Vh2nHVtTYRvLSlbEGz8M4Dd+pH5Mik
	2sawbp762qb/CtOqM5Ad8a/yJvg/5E5jTSleXBtrwx1jtq5sPv8O2VUHbsEsg8+2LFizKSazd64
	K6wXk97EvNwGT2xNzhitNCcvO4jJtCoSqsQUyfptTM35RSL+uYJfy4X+cEZIyo6eG9StBSqOPsI
	84A9Gg/5CYTWfRTACTcSoj4x6fMiXVTSWYyiQ9bWU6v36t4s5eGlOBy2LfjXm6QP3WrQGtmnoE8
	K0G8jtn9WMJFgCfV/cQybrKMc017gjxPEhGDAOeatVXb0wo9MJ2388nOaYgNhtTc9du5P/YAADT
	FyhmdhPOj2YCuyvCBfXfXK7VD+kOblP4WAcxC05nUhMEPk1w6WBYp1h/FYYdgFLQY/H6BzAJ0Tg
	P/yc2WpjSGg75W+3NQWsSGLQvvSlucup+ISOw==
X-Received: by 2002:a17:90b:4e86:b0:35b:952c:43ab with SMTP id 98e67ed59e1d1-3612f2ab68cmr375051a91.4.1776274840928;
        Wed, 15 Apr 2026 10:40:40 -0700 (PDT)
Received: from baver-zenith.localdomain ([124.49.88.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fd1fe9b50sm2891026a91.3.2026.04.15.10.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 10:40:40 -0700 (PDT)
From: Sungho Bae <baver.bae@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sungho Bae <baver.bae@lge.com>
Subject: [RFC PATCH v1 1/4] virtio: separate PM restore and reset_done paths
Date: Thu, 16 Apr 2026 02:38:30 +0900
Message-Id: <20260415173833.6319-2-baver.bae@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260415173833.6319-1-baver.bae@gmail.com>
References: <20260415173833.6319-1-baver.bae@gmail.com>
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
2.34.1

