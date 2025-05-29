Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16864C92
	for <virtualization@lists.linux.dev>; Thu, 29 May 2025 07:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748503842; cv=none; b=C8+v1TdXkoQ7UxI9sDv0B1Aoiwi4vNvGciaYz7OhWocGTej7g5Nbwr4ib+mW24La3suYLnJNqSRzDNggjtTxPga1HrGVcjVfvBt1gbqQNS5wwfRluEKLOI98FrxIXNlkjL5PoDYlE2wsYKyBPK9wXjWDynTUgpY4XPAGl64GnVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748503842; c=relaxed/simple;
	bh=c50mQ5huAqIJ9TuesG10iXacwGj3JZQrHzSFKs6ln3I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e9XV/hov43lOU55IWMv9W4I/c/Rz5ngY+vHiuCEKaoNKeMeJNw3/NAkYwyAFi78zDGqCVkcSic5qRQr7Qv1YrO8KReH7P2CKW4X/hk6gjb0vFHDiUgcN1fZ5B0rtJUJFZQND2fk+9LsgA0BxqjK7qqOt801HCDrOSYejXs9CSz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aEUkYAAs; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aEUkYAAs"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-23228b9d684so7503695ad.1
        for <virtualization@lists.linux.dev>; Thu, 29 May 2025 00:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748503840; x=1749108640; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=phRweVKzj4zCYuXKOOK9r81XusegUAwTG5l94I+5yT8=;
        b=aEUkYAAsEWGkTRCOwasbPQnSEChm7/tWeeXArtcD1cqpFBSwkgVd/HOxmMnDLk4NhI
         dfUhHjVNqQiXKZMclnfykaHvDHr+DE9YycxQ15gIcvzjuvmscuEgJLckXG9plpa76rV/
         a6ecJ2qOiUNkN+T0tMQAidhb84w1xJfU904/KB2sI+jIhMllvtqUfs5Wl5IxTHSh9Er9
         4/V2cai+gf+dfIFhFg9lInXVTghMx25XGELHsdeVaCC6Rkd4MXSQqCrhdJ0Ua7AmnAOc
         rG8Jlp4KR82vcIfGfugh6B7ITXbLZru388cH8b/1EcTiLJ0YFvHuaPrJf6iRjLMAL8Fy
         xfPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748503840; x=1749108640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=phRweVKzj4zCYuXKOOK9r81XusegUAwTG5l94I+5yT8=;
        b=r3ftkY1CsY2GrcL0wvONyQ7pM9y+H3JZk/LyL9U/xmWqh1EA59s7DsAualvWfN0IVT
         325/SuQ+Nc2rEqZ97t93JxS8ccqiVTKHe9m3petLTSnDBnm40XkHT34TIqhPN9oqOJDD
         gtSBCbXD+tkz5XjZmLxBzT7zw/lXMfRnirtOBeHvZTWrQkHlcc4bA5mndU0X0/C1p/p7
         RSWEFlQrfZb/wFrN9Lx7VI6xxWvYOGnxPUMVHfRe2KYOUE/fIKlf1NXB3vujF8LkRH23
         tWkU7ZSS+RDmN2rQL59w7LAkr3IGU/hPs/TUgqTCIb3CY4vN0n8EoAcwJjzUmIUPaCNI
         QepA==
X-Forwarded-Encrypted: i=1; AJvYcCWQTsNWoJP7hTFsH011GKrTB+sCXYO7FG88qvZh9QrNMb8vnczg4UZy4+WV6Zb0vcLxFzBCKDS9V5dB5yhreg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxvTTGLuyWxyBvcNBZKFbSxF7Jbu86B/oxhvW2YXmklSfD0iVsU
	oXRXvq8eeN5+c61ihQipBm/fJQTwPxlOXUElA8nt33yluBOHNgiAxSoF+xQfC/Zqs6s=
X-Gm-Gg: ASbGncucyaRxAW8/pVLXyRDGNubDY/DMKkId28rBMZyHxMclPNYAH6eTqC6VROK/tvz
	BBBCJmns4OgkMhg++8FDxoVKrMEBlHvU+ccv4ij+pOU158tkTvdMeNRJfTXLboOlDMXDWRGIpTA
	tScNDPS8BewlFavFFGH+xKXIRyXvuRF/2PMkGfIAD+vpXhseNMM92uQ2Ev9W/STQ4lEUjBycxBD
	yckLkwG3rCRFvqMITh8fw9JMFcydK/zeU7Ni+xQ8P+OYksLDjeXVvUlgESrvA4I/LgcdakVtc02
	AQGVj4O/bwJnFMNrNqvunSILw2wGfFc589bUnGkdrDo6YEPpXdHY
X-Google-Smtp-Source: AGHT+IHd5/KWNV9VKdQPqtItgJkEPX4zpPmZJI4+W2UWf0JOaI6dh2PDCi0poajFkldkVqQmb0PmPg==
X-Received: by 2002:a17:902:cf05:b0:235:be0:db57 with SMTP id d9443c01a7336-2350be0de2dmr13115035ad.4.1748503839760;
        Thu, 29 May 2025 00:30:39 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bd96f9sm6804415ad.98.2025.05.29.00.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 00:30:39 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] virtio-vdpa: Remove virtqueue list
Date: Thu, 29 May 2025 13:00:27 +0530
Message-Id: <7808f2f7e484987b95f172fffb6c71a5da20ed1e.1748503784.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The virtio vdpa implementation creates a list of virtqueues, while the
same is already available in the struct virtio_device.

This list is never traversed though, and only the pointer to the struct
virtio_vdpa_vq_info is used in the callback, where the virtqueue pointer
could be directly used.

Remove the unwanted code to simplify the driver.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Only build tested.
---
 drivers/virtio/virtio_vdpa.c | 44 +++---------------------------------
 1 file changed, 3 insertions(+), 41 deletions(-)

diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index 1f60c9d5cb18..e25610e3393a 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -28,19 +28,6 @@ struct virtio_vdpa_device {
 	struct virtio_device vdev;
 	struct vdpa_device *vdpa;
 	u64 features;
-
-	/* The lock to protect virtqueue list */
-	spinlock_t lock;
-	/* List of virtio_vdpa_vq_info */
-	struct list_head virtqueues;
-};
-
-struct virtio_vdpa_vq_info {
-	/* the actual virtqueue */
-	struct virtqueue *vq;
-
-	/* the list node for the virtqueues list */
-	struct list_head node;
 };
 
 static inline struct virtio_vdpa_device *
@@ -135,9 +122,9 @@ static irqreturn_t virtio_vdpa_config_cb(void *private)
 
 static irqreturn_t virtio_vdpa_virtqueue_cb(void *private)
 {
-	struct virtio_vdpa_vq_info *info = private;
+	struct virtqueue *vq = private;
 
-	return vring_interrupt(0, info->vq);
+	return vring_interrupt(0, vq);
 }
 
 static struct virtqueue *
@@ -145,18 +132,15 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 		     void (*callback)(struct virtqueue *vq),
 		     const char *name, bool ctx)
 {
-	struct virtio_vdpa_device *vd_dev = to_virtio_vdpa_device(vdev);
 	struct vdpa_device *vdpa = vd_get_vdpa(vdev);
 	struct device *dma_dev;
 	const struct vdpa_config_ops *ops = vdpa->config;
-	struct virtio_vdpa_vq_info *info;
 	bool (*notify)(struct virtqueue *vq) = virtio_vdpa_notify;
 	struct vdpa_callback cb;
 	struct virtqueue *vq;
 	u64 desc_addr, driver_addr, device_addr;
 	/* Assume split virtqueue, switch to packed if necessary */
 	struct vdpa_vq_state state = {0};
-	unsigned long flags;
 	u32 align, max_num, min_num = 1;
 	bool may_reduce_num = true;
 	int err;
@@ -179,10 +163,6 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 	if (ops->get_vq_ready(vdpa, index))
 		return ERR_PTR(-ENOENT);
 
-	/* Allocate and fill out our active queue description */
-	info = kmalloc(sizeof(*info), GFP_KERNEL);
-	if (!info)
-		return ERR_PTR(-ENOMEM);
 	if (ops->get_vq_size)
 		max_num = ops->get_vq_size(vdpa, index);
 	else
@@ -217,7 +197,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 
 	/* Setup virtqueue callback */
 	cb.callback = callback ? virtio_vdpa_virtqueue_cb : NULL;
-	cb.private = info;
+	cb.private = vq;
 	cb.trigger = NULL;
 	ops->set_vq_cb(vdpa, index, &cb);
 	ops->set_vq_num(vdpa, index, virtqueue_get_vring_size(vq));
@@ -248,13 +228,6 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 
 	ops->set_vq_ready(vdpa, index, 1);
 
-	vq->priv = info;
-	info->vq = vq;
-
-	spin_lock_irqsave(&vd_dev->lock, flags);
-	list_add(&info->node, &vd_dev->virtqueues);
-	spin_unlock_irqrestore(&vd_dev->lock, flags);
-
 	return vq;
 
 err_vq:
@@ -263,7 +236,6 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 	ops->set_vq_ready(vdpa, index, 0);
 	/* VDPA driver should make sure vq is stopeed here */
 	WARN_ON(ops->get_vq_ready(vdpa, index));
-	kfree(info);
 	return ERR_PTR(err);
 }
 
@@ -272,20 +244,12 @@ static void virtio_vdpa_del_vq(struct virtqueue *vq)
 	struct virtio_vdpa_device *vd_dev = to_virtio_vdpa_device(vq->vdev);
 	struct vdpa_device *vdpa = vd_dev->vdpa;
 	const struct vdpa_config_ops *ops = vdpa->config;
-	struct virtio_vdpa_vq_info *info = vq->priv;
 	unsigned int index = vq->index;
-	unsigned long flags;
-
-	spin_lock_irqsave(&vd_dev->lock, flags);
-	list_del(&info->node);
-	spin_unlock_irqrestore(&vd_dev->lock, flags);
 
 	/* Select and deactivate the queue (best effort) */
 	ops->set_vq_ready(vdpa, index, 0);
 
 	vring_del_virtqueue(vq);
-
-	kfree(info);
 }
 
 static void virtio_vdpa_del_vqs(struct virtio_device *vdev)
@@ -501,8 +465,6 @@ static int virtio_vdpa_probe(struct vdpa_device *vdpa)
 	vd_dev->vdev.dev.release = virtio_vdpa_release_dev;
 	vd_dev->vdev.config = &virtio_vdpa_config_ops;
 	vd_dev->vdpa = vdpa;
-	INIT_LIST_HEAD(&vd_dev->virtqueues);
-	spin_lock_init(&vd_dev->lock);
 
 	vd_dev->vdev.id.device = ops->get_device_id(vdpa);
 	if (vd_dev->vdev.id.device == 0)
-- 
2.31.1.272.g89b43f80a514

