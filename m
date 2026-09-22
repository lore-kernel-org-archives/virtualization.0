Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B4E565111
	for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 17:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790097423; cv=none; b=NZfOMU/pKe0z/ipI6JO6uTsbIswsZQh+McfCh5hMdT7PNVBlY01qMd9zwvh/LOdT4+6rWPy0F6w0jJlHWZ8CiAs9pv4FjVv1G2XkjQg9n53f8WHa6ff/vr4S/dYRcsWGxwy5Biw/hWVhNRouYqo4mhtqC4m4PV558wLsTA/G7WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790097423; c=relaxed/simple;
	bh=B+rFwWBDA/3MGrtYnR6VaIzmZ5dtBML4X3N5+GW8s6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rR5423sY3cXB6vd+5bCumd8oz4J7erQwX2ciZ1Iq5mJ8nc4KrkWiPl6UEIwNhwzU5HPYrn9nyAnilLp3oX1x/g1mPddNCmEWuYXQzsgGBp8vUJyNs9DT5uO0GvoTQ+QoXGyt9IDX+O+hbljl1/XM5YpDQPksPgpl69vFTBxEC2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YvVqIJrd; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvVqIJrd"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33e652b7178so18032eec.1
        for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 10:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790097421; x=1790702221; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zdkopeEhdVPiVywAYlu3szNf41bUlu4QoiIzTh5w9l4=;
        b=YvVqIJrd7Ho6KcaIHKEgVp/Pwn7ATqjpVhyxEi0SxHmaJQWXA/BPJ3Cq06R+X/Ah59
         r0/PFEs9o0fgJnGKGja7p/ka6N6ws558ECJQjYCcnQBEdXXOFXgCvTBTiGbd3aXl/XXQ
         pVW+Wqn3Pk83Y/M3HBdXOCwlYs8CP0QTQRROIG8p4eJznYZuMgNSsPzVgaGxE3NjK10e
         yNLpQ0dJtfeW+Li2ncGxJtye3FZhyLF+ztavDe3mz5Y4OLYdFFeaDDlX/qL6JrBP6kL4
         RkCVfp+eb+yTa1ba9dnxyw5vN8BI6lMvlvDhR42WvLnZI+7Pzx9I+md00dggemlx0TEz
         95HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790097421; x=1790702221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zdkopeEhdVPiVywAYlu3szNf41bUlu4QoiIzTh5w9l4=;
        b=hiRVQ7XUQLEZ75gg2/5cIiu8VEyUx8B8ZOnAcqqzZsqeOO/UnyojLo2/7yXhNJV1dw
         tdCaLQPR0Bc10SvWUjLUpd6hrD4IsJdyhbb7WnqV6G8xVTAyh1YPwOhF54FGXqtc1diK
         11myrBXjHIbsW/3GVO9RMJZ0EQZM7F0iDVygj7WLQZ4UMLm6IyO2NitDJLO2yyYsYH91
         InGuE1D00N17amke3WWX1wYFKZoI8cjO4pQ0CVMImArvevPvClpXKF942w97MwB0si+G
         uvAGVGSZt0l8YIYWmkRAkmG620Oaz4ERVTNj9rdUOaGuqlHQxVHoFWlQ/qckvBWKsZus
         BfhA==
X-Gm-Message-State: AFuF++kr/8/1VVTKJIu3npqZ15zuHd7jSxeC9k3MhEc7ynzHxWveI7vB
	+62jtmj8xSHbOZytivtBsKurps86DOHAy6HWFFEVFnA6V0oLGVip/zM/
X-Gm-Gg: AYBFou1yDvv5CKkua2cA2yBaUgqeJhMM3ISLQFkBgUCv0ZwWblAc7mALqYGnNMSFOQg
	IUgR1xBpyzrdERkX5CCNuHW6RkYyIDePf4He1f0WZXz3BhQJeMVZlc1yE0+7u7N1H7FAsfKwOX+
	8L5rzH0y5ltpCZlnFInCeLuL+3Wd7bCv2n+ycqQscg11aUYqJVjlSxhfca7DG2sGC/HwtZRBMHH
	lawkoTOIGGBFQA941kwg4KRgxoDVzHs5Kxo5f1ayTzBWXZkbNxtTsC2B4rXLAWK8EF7B77eWyOf
	TDBOI4MTnRAtRPGZw9AIiMY0iZ/ZQEZf/XNvfGhZscji5z+pBkBPp9QBicKpMIEr0+ts7S88gpS
	KowyuchtMRbmTzNmRHuMHoDBpulpsq2fJXGu0QuuYox6QCbQoAnemoKz6xw7fYHfHMISWp1GRDE
	tN4OeOKa0s3Ktyffn0Tu4nSZz1Cj0CF69ve42xWsfDHdr6mM06vm4KD2oiZmg5ImWG9mekrkrse
	B8mbEx9Yg==
X-Received: by 2002:a05:693c:8942:10b0:33e:6c89:abe7 with SMTP id 5a478bee46e88-33e6c89c06cmr76936eec.3.1790097411255;
        Tue, 22 Sep 2026 10:16:51 -0700 (PDT)
Received: from nevers1dd ([118.95.161.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e6129b3a9sm6589192eec.13.2026.09.22.10.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 10:16:50 -0700 (PDT)
From: Siddharth Karanam <sid9.karanam@gmail.com>
To: mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Siddharth Karanam <sid9.karanam@gmail.com>
Subject: [PATCH] virtio: update multi-line comments to the preferred style
Date: Tue, 22 Sep 2026 22:46:36 +0530
Message-ID: <20260922171636.201408-1-sid9.karanam@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some multi-line comments were not in the kernel coding style.

Signed-off-by: Siddharth Karanam <sid9.karanam@gmail.com>
---
 drivers/virtio/virtio.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index b6c9e927bef5..c6dffced864a 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -51,8 +51,10 @@ static ssize_t features_show(struct device *_d,
 	unsigned int i;
 	ssize_t len = 0;
 
-	/* We actually represent this as a bitstring, as it could be
-	 * arbitrary length in future. */
+	/*
+	 * We actually represent this as a bitstring, as it could be
+	 * arbitrary length in future.
+	 */
 	for (i = 0; i < VIRTIO_FEATURES_BITS; i++)
 		len += sysfs_emit_at(buf, len, "%c",
 			       __virtio_test_bit(dev, i) ? '1' : '0');
@@ -80,8 +82,10 @@ static inline int virtio_id_match(const struct virtio_device *dev,
 	return id->vendor == VIRTIO_DEV_ANY_ID || id->vendor == dev->id.vendor;
 }
 
-/* This looks through all the IDs a driver claims to support.  If any of them
- * match, we return 1 and the kernel will call virtio_dev_probe(). */
+/*
+ * This looks through all the IDs a driver claims to support.
+ * If any of them match, we return 1 and the kernel will call virtio_dev_probe().
+ */
 static int virtio_dev_match(struct device *_dv, const struct device_driver *_dr)
 {
 	unsigned int i;
@@ -565,8 +569,12 @@ int register_virtio_device(struct virtio_device *dev)
 	INIT_LIST_HEAD(&dev->vqs);
 	spin_lock_init(&dev->vqs_list_lock);
 
-	/* We always start by resetting the device, in case a previous
-	 * driver messed it up.  This also tests that code path a little. */
+	/*
+	 * We always start by resetting the device, in case a previous
+	 * driver messed it up.
+	 *
+	 * This also tests that code path a little.
+	 */
 	virtio_reset_device(dev);
 
 	/* Acknowledge that we've seen the device. */
@@ -615,15 +623,19 @@ static int virtio_device_restore_priv(struct virtio_device *dev, bool restore)
 	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
 	int ret;
 
-	/* We always start by resetting the device, in case a previous
-	 * driver messed it up. */
+	/*
+	 * We always start by resetting the device, in case a previous
+	 * driver messed it up.
+	 */
 	virtio_reset_device(dev);
 
 	/* Acknowledge that we've seen the device. */
 	virtio_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
 
-	/* Maybe driver failed before freeze.
-	 * Restore the failed status, for debugging. */
+	/*
+	 * Maybe driver failed before freeze.
+	 * Restore the failed status, for debugging.
+	 */
 	if (dev->failed)
 		virtio_add_status(dev, VIRTIO_CONFIG_S_FAILED);
 
-- 
2.55.0

