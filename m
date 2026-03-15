Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B1D219A7A
	for <virtualization@lists.linux.dev>; Sun, 15 Mar 2026 15:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773588295; cv=none; b=XqzTaeM1jsnVjgoI+3tJjLijbMOrtRIFiX0C/L/IhxZglGg7xIY7M/bTSxEN+GPDiSiF001aPzlozZ4/UjmGl/2VWPDRjFKQVdHm3e9/3iMy6DO00T+PzTTKIirI8pmTTJHAPJAY0h0MmYAC0h5R/+X0/n1UJ7SKpFXHARJS/cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773588295; c=relaxed/simple;
	bh=SNop8XUPK6Hgfe4O2UI2bOnOLb9LGUujLa9UjCVo5U0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SR1PjlhHxc4DQ2B/1lyYM6YQPwCqOPaDvTThk8QXYmZyX8LV9HqZkVLgWPxOtywheh+31qKx1sf6m6ntDasZgXlTBK2hGCy7ytWE9RoIITv/ZVQtxNi13EO6iHjYpzYT6zy3xUNY7czf+blM1L79QkeQQTdx9K3gV9vqb0weLXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYdAh/cw; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYdAh/cw"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-354a18c48b5so3663780a91.1
        for <virtualization@lists.linux.dev>; Sun, 15 Mar 2026 08:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773588293; x=1774193093; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7MtjS8bH1E8z5wp3WLVz/oCa3p3s0LxEuaeiXaVAd1M=;
        b=XYdAh/cwZnkFkiqUU7/pnhu54bi9NxVwyfVRsrXu4xzt2y0LoM70zCDeTGhak04Bd3
         Eo/f8w/uyQugf5S54+mF96xhztGtP7f7p2J9t0VR1/GSKBjUThg/YgBt2WrX7fEHuZSB
         2KzteMaQYott82E13C4WwQIRSeunnlIw72zypJ+YtPiEtX+8eKmy0FiWFODPAByUphjx
         TL0Zkllrh3FLByX7FQlX3+eFTJkxbEEuXf0btBt7pqwiAa5VXwCf1tYmeFVYD8Q1ndSU
         1kWHBGiegmwOCmu1l0BN5VNtz6uai1Lp2/z6j8TOu+QiBexzqfmKmsUGCncVckzpT+xX
         B8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773588293; x=1774193093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7MtjS8bH1E8z5wp3WLVz/oCa3p3s0LxEuaeiXaVAd1M=;
        b=FRPELcCmyftGuBjLdtxsDobaP3hkhW8UkQcFIPSxGAUc8oGFJ6hf6zcoN59tHbgqyV
         XbnBjSfR3O4l7FVrMICd21umBE39WyT3kHH9y8VQbVdrx4sQipMQTIxMeneQa7iykrl/
         41B6SP0Sx51ANHheUq1zM+jECJVd2w6C93aPasNtAekUCO4icN3crvg/LQrYA6V15nAq
         fbMufgDPmQ5OL4PG7ja4NRM6gmnTrQjhQoXR0VHa7NzTwPuSb6O6WzfA+yfv8HM9aXLb
         3RV7eM7qo/14kmHcs5Iil6pobquRWDhLKyROFOF0T7u5LP67CJ8SGC632SusM2wZS4qm
         KABw==
X-Forwarded-Encrypted: i=1; AJvYcCXXhQ1Uk3CJKt1wU/Q2Zao4qeKQmPQ5uhjOCcAInw0BIo1yOPnDB1mjreTwwtb93ZfSuXdttjfe7cTx9KDWUg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzDhTpTkBoRjjXTW4LLFNouxISeiWvLv6E+3WqYuHhff7QXxtFI
	ODF17kUwpbXlZBpwLE6ZsJtZow3M4U99RM9sQhSsVHoxPOiS5WfaGZ/5
X-Gm-Gg: ATEYQzy+zJc1HyiH479aF6R9OMqotyeGeaKSbmOZd/Ewl0b3m+QGtGkVcy5wTXHRWnb
	LVWnZnEKnva5gZUa76K1ppVchyNb2YF2Bko0sNK5jKB6LL4JSCBh3/rBb3VHnoBS84K5yX3hLrW
	JPRxmtBGrVbCXrdYWQJeYagzbK/PYrQ5bdv+5tV4F7fp4YiuO8rebMW8M6pCguWPw4DWvsM2557
	gDzOIsqKIMppFtxbWASUr6KseL6kXqjt6ruz8+ydgtq2L8YYHKqx6st6MsHGQNZXACQPYyros3e
	ycYYDqA4zUdqZY0w+Man/7bNqy8+h4hUDPQDleMxouOngcFeeYmNTSyBWPwZPUPn/ByZt+GBOrN
	xTPpOvc2e1L8on9EhQPry7jTIeB+qX+X1a+DqGSoTzxUTjxRiEff2Nz0VoT1A76ql0+W1RnC99S
	mHG6ZsHNtsnBvhlN7Ivez1brnQY0nlvYEZ/uoUrO7sJ5HfF0Lr5dU0gHw5ZVk=
X-Received: by 2002:a17:90b:3dc7:b0:35b:9ab6:1d4b with SMTP id 98e67ed59e1d1-35b9ab61eb1mr1172866a91.20.1773588292890;
        Sun, 15 Mar 2026 08:24:52 -0700 (PDT)
Received: from pop-os.. (118-163-201-9.hinet-ip.hinet.net. [118.163.201.9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a22d0c854sm2932933a91.2.2026.03.15.08.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 08:24:52 -0700 (PDT)
From: Shengwen Cheng <shengwen1997.tw@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Shengwen Cheng <shengwen1997.tw@gmail.com>
Subject: [PATCH] virtio_ring: reject NULL recycle callback in reset/resize helpers
Date: Sun, 15 Mar 2026 23:24:03 +0800
Message-Id: <20260315152403.127645-1-shengwen1997.tw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtqueue_reset() and virtqueue_resize() rely on the recycle callback
to release each detached unused buffer after disable_vq_and_reset().

As a defensive change, reject a NULL recycle callback explicitly to make
this requirement clear. Update virtqueue_disable_and_recycle() to warn
and return -EINVAL when @recycle is NULL, and update the descriptions
for virtqueue_reset() and virtqueue_resize() to document that @recycle
must not be %NULL.
---
 drivers/virtio/virtio_ring.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 335692d41617..563cee634426 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2698,6 +2698,9 @@ static int virtqueue_disable_and_recycle(struct virtqueue *_vq,
 	void *buf;
 	int err;
 
+	if (WARN_ON_ONCE(!recycle))
+		return -EINVAL;
+
 	if (!vq->we_own_ring)
 		return -EPERM;
 
@@ -3311,7 +3314,7 @@ EXPORT_SYMBOL_GPL(vring_create_virtqueue_map);
  * virtqueue_resize - resize the vring of vq
  * @_vq: the struct virtqueue we're talking about.
  * @num: new ring num
- * @recycle: callback to recycle unused buffers
+ * @recycle: callback to recycle unused buffers, must not be %NULL
  * @recycle_done: callback to be invoked when recycle for all unused buffers done
  *
  * When it is really necessary to create a new vring, it will set the current vq
@@ -3367,7 +3370,7 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
 /**
  * virtqueue_reset - detach and recycle all unused buffers
  * @_vq: the struct virtqueue we're talking about.
- * @recycle: callback to recycle unused buffers
+ * @recycle: callback to recycle unused buffers, must not be %NULL
  * @recycle_done: callback to be invoked when recycle for all unused buffers done
  *
  * Caller must ensure we don't call this with other virtqueue operations
-- 
2.34.1

