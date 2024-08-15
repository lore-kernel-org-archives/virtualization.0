Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848BC15C3
	for <virtualization@lists.linux.dev>; Thu, 15 Aug 2024 00:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723682785; cv=none; b=uRlyAyWMxYuNf7eQ7F/1IgeBoXTFJLmEORE5iKWFf1IDmUDhDmvHkXVVxgkVQibvPaNMpmUMaq2TZKdoWraFjGjKnRTZkdKfxpm7i5RuLCovftQd51/qjsmOYRRC8LH/G7XOBKTd/atZKxn0mtOJIyog4OmNSYo+wENgk7I6aU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723682785; c=relaxed/simple;
	bh=MFpYAqAur2CBTuwezZFu2fjaPugZ2gH2Pu9bI39ap9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SAEmJDuWH0BhxuW/S6UHhoMRs/Gy/soDPi5hyOAjaKBoAaEaD+31UEWQWmuTq1osdiHplEMZV6QcKmcyGqYb1NQrGpfscQ7G5fuV3stN1XXijllLN+6ftVEDidCKgk53l+rBFwPoyXQRf0q00vnOSliHaaNbUJVzdpdjPUPkngU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=McfBG8y6; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="McfBG8y6"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7093890e133so30921a34.3
        for <virtualization@lists.linux.dev>; Wed, 14 Aug 2024 17:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723682782; x=1724287582; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C7eQNG3qJiwvs9MNyrho4kKV2vMWG5TUUcItl6qZj48=;
        b=McfBG8y696vy+wnsrl7kwWU0ZTLpJLZsQQRltgYGMYZQMnr6Wp74l+zcG58Sb2fgse
         DqYZsnu1xKNDIgL/0oNDy7g0tESmjTmGpCcprw+rPqlRm984IGaLcOrv1diMsxi3EXLH
         oL8xfxbVo0dllXNqBcMD352ZUs3rb8B6wwZE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723682782; x=1724287582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C7eQNG3qJiwvs9MNyrho4kKV2vMWG5TUUcItl6qZj48=;
        b=pQkfIXdR+27Gbb3DZS+xOFikKHuIBP24GEDpuxx+umJVzGqfkJIf/uWEH8SmNTBTt1
         IQaKhHiNHYZCMjgQmGljXPBp6XQpEPXIY/y5sIjNi54C1WmjOqpltl5w2vyRQqV3Ym/e
         Bc2qcrgj215QKwyYxGhmcxBJgbf3tXiqLyNrhJW2hi2lmSc5YEl/DS1MKH0A+KdS8FRL
         mDHZKP7UWuLesZnuf05fVk5IM8CCWvXa+e+khwXU/CZbq8jnWcsc7/9wiGQOidOL+XJf
         19DwzoiyUQ+Za92M+JLv5JzEWMhvAZYIyITMRVqjL/oqJ+QOeN6+M/lZ/V+g1QAetToc
         bBKA==
X-Gm-Message-State: AOJu0YxM5jBX+Jd+3QizBkYAd4EuOJbVtR0UFwxXzXfWE/pHDIFB7IBt
	3Tz/s8yGNBRqtoKiXHTWePUHg+RygEi2BXhONG6KDtYY1GvsF/pe7c3BkDwX+w==
X-Google-Smtp-Source: AGHT+IHSVf2Ro3Z8JmcPhwCQkLbT2k7ksoTCsp6QSWAbLA5ZEaTIF51XkrLoFFWSu23YtxtemeDyEg==
X-Received: by 2002:a05:6358:569f:b0:1ac:efb0:fb3a with SMTP id e5c5f4694b2df-1b385aeced1mr85394055d.2.1723682782595;
        Wed, 14 Aug 2024 17:46:22 -0700 (PDT)
Received: from philipchen.c.googlers.com.com (140.248.236.35.bc.googleusercontent.com. [35.236.248.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fdd9072sm2165626d6.15.2024.08.14.17.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 17:46:22 -0700 (PDT)
From: Philip Chen <philipchen@chromium.org>
To: Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Ira Weiny <ira.weiny@intel.com>
Cc: virtualization@lists.linux.dev,
	nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Philip Chen <philipchen@chromium.org>
Subject: [PATCH] virtio_pmem: Add freeze/restore callbacks
Date: Thu, 15 Aug 2024 00:46:17 +0000
Message-ID: <20240815004617.2325269-1-philipchen@chromium.org>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add basic freeze/restore PM callbacks to support hibernation (S4):
- On freeze, delete vq and quiesce the device to prepare for
  snapshotting.
- On restore, re-init vq and mark DRIVER_OK.

Signed-off-by: Philip Chen <philipchen@chromium.org>
---
 drivers/nvdimm/virtio_pmem.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
index c9b97aeabf85..2396d19ce549 100644
--- a/drivers/nvdimm/virtio_pmem.c
+++ b/drivers/nvdimm/virtio_pmem.c
@@ -143,6 +143,28 @@ static void virtio_pmem_remove(struct virtio_device *vdev)
 	virtio_reset_device(vdev);
 }
 
+static int virtio_pmem_freeze(struct virtio_device *vdev)
+{
+	vdev->config->del_vqs(vdev);
+	virtio_reset_device(vdev);
+
+	return 0;
+}
+
+static int virtio_pmem_restore(struct virtio_device *vdev)
+{
+	int ret;
+
+	ret = init_vq(vdev->priv);
+	if (ret) {
+		dev_err(&vdev->dev, "failed to initialize virtio pmem's vq\n");
+		return ret;
+	}
+	virtio_device_ready(vdev);
+
+	return 0;
+}
+
 static unsigned int features[] = {
 	VIRTIO_PMEM_F_SHMEM_REGION,
 };
@@ -155,6 +177,8 @@ static struct virtio_driver virtio_pmem_driver = {
 	.validate		= virtio_pmem_validate,
 	.probe			= virtio_pmem_probe,
 	.remove			= virtio_pmem_remove,
+	.freeze			= virtio_pmem_freeze,
+	.restore		= virtio_pmem_restore,
 };
 
 module_virtio_driver(virtio_pmem_driver);
-- 
2.46.0.76.ge559c4bf1a-goog

