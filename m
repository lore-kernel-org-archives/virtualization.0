Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD4E1991C6
	for <virtualization@lists.linux.dev>; Tue, 16 Jul 2024 11:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721129765; cv=none; b=ayS80r8oNq4y1lADkz2m4fhdNdXut7f5ax+EgK81jGh9B3cBt5p9cE5RdGl9g0p9Hi4b6FW8gWAyExZZtIQFR4eJBcOnNLgdgeNHf77ARpaaKQvzK2R2vbjdcGB3oy+hHO40uaB6/4hoqdCE8M4NBXzrkm58Q4iCkawJ/8YJMSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721129765; c=relaxed/simple;
	bh=Slwt6mwqsZSmtaJCt/6aEvfeOxcjMyxlhz/G4vHhWQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VbPpRexd1Wx+B9SrmbzH/J1xlQMEULdM6kSUlbNisSZVlPgoRexc0wW2cBh1w3QQV8fK+6MS3yxnYlyij3gYtF1wnE9qWzAEHCAHWYgL74wRu9AlqHu5aCT/FZgDEt6NJtnb9S/4ygJe5wXa7/kMSIYWNvjApwiKO4YbkfSeTwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=PMxebtAY; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="PMxebtAY"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-427ad8bd88eso15158435e9.2
        for <virtualization@lists.linux.dev>; Tue, 16 Jul 2024 04:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1721129760; x=1721734560; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x4i8jj5jC7bvjPYwpGO7GGf73fXdPIN83C7G6C8/crc=;
        b=PMxebtAYfKrq4MkXnkf4PG3jV8gNOoVgTd+A2yyG3WMnOYvLnJjzIuZ/7NlhBMisBI
         XJI2YFRQJ/zqFriMmj8RSdz/eLf50IDtU4EMMflUZ3tnZk3XToUZsRNUceZpfK4FPQ++
         oCn1eCNHp+LN25O36y45laqOYkiqcgBQ1kbORvKqPa0FKhmaDBDoKu1CbZdWXkKZnZ31
         nibChIeCs5u+cFPNSAsgBcKS5ZXMivbFs+UjUrRTEdHY9zv1xOUXzfFZowwirPmP68V1
         35+KTsQsP0Wx7U96pETleorCnqjQY9h24OT+E533+2gqlOVE5ik2WVR/GZYB51Dk/31x
         yMWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721129760; x=1721734560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x4i8jj5jC7bvjPYwpGO7GGf73fXdPIN83C7G6C8/crc=;
        b=GImY0g2lw5ndy64WCeIRiDlQTx3jn9kBCJ9XroJ6sGAVcA2fYKppFRSBuesoJ9R3C4
         5kct18npaiYGxgALsi/W9zBaswpK3PAd1pjB1+vQyma3CZXNxbd2Fm/CWRsXUMDPbkjZ
         tK14NhA12x4pb2dDV09bP8PUCAb3cQV2l0WDF8pevsPYaTC6ssIbNFNlzIo126INVb+O
         XN0U3O0FScn3o7nidK3XBooB0Dd5EFvUKQETWwDOUGjYTmIR3NeGoFzEGaAwCfqrPMY5
         5RzYfxrKTt5VBXVg9oanPFrSJtnzDT/GcnDYP7ftDMePB7Y7AU8YeACbr2Oo3YdHEwxH
         oFEw==
X-Gm-Message-State: AOJu0Ywdu5DRPU3QKEkwvvK8EMY4v8/eLCYAXakCS0RrdkLNxAlaNgzI
	6LfOx97a34WjgpML8wJWR7qUYLhn4gYVfCw4lDwT2+CE9sBCAyrJOcY9swtKkNue1udzZoK6FUw
	/xI0=
X-Google-Smtp-Source: AGHT+IFlvtgjM7kK4b73WbqddexlaXyFYQ9/EGrQPN7gOrqijxa+FcXKHhy/YxwSGRuUmzwQDd1NMA==
X-Received: by 2002:a05:600c:1383:b0:426:67dd:e9e9 with SMTP id 5b1f17b1804b1-427ba5f527fmr14200195e9.3.1721129760299;
        Tue, 16 Jul 2024 04:36:00 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f25942csm155645615e9.15.2024.07.16.04.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 04:35:59 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v3 01/13] virtio_pci: push out single vq find code to vp_find_one_vq_msix()
Date: Tue, 16 Jul 2024 13:35:40 +0200
Message-ID: <20240716113552.80599-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716113552.80599-1-jiri@resnulli.us>
References: <20240716113552.80599-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

In order to be reused for admin queue setup, push out common code to
setup and configure irq for one vq into a separate helper.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- removed pointless "++" from vp_find_one_vq_msix()
- rebased on top if find_vqs() arg conversion patchset
---
 drivers/virtio/virtio_pci_common.c | 68 ++++++++++++++++++------------
 1 file changed, 41 insertions(+), 27 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 7d82facafd75..277591a6ab96 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -284,6 +284,44 @@ void vp_del_vqs(struct virtio_device *vdev)
 	vp_dev->vqs = NULL;
 }
 
+static struct virtqueue *vp_find_one_vq_msix(struct virtio_device *vdev,
+					     int queue_idx,
+					     vq_callback_t *callback,
+					     const char *name, bool ctx,
+					     int *allocated_vectors)
+{
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+	struct virtqueue *vq;
+	u16 msix_vec;
+	int err;
+
+	if (!callback)
+		msix_vec = VIRTIO_MSI_NO_VECTOR;
+	else if (vp_dev->per_vq_vectors)
+		msix_vec = (*allocated_vectors)++;
+	else
+		msix_vec = VP_MSIX_VQ_VECTOR;
+	vq = vp_setup_vq(vdev, queue_idx, callback, name, ctx, msix_vec);
+	if (IS_ERR(vq))
+		return vq;
+
+	if (!vp_dev->per_vq_vectors || msix_vec == VIRTIO_MSI_NO_VECTOR)
+		return vq;
+
+	/* allocate per-vq irq if available and necessary */
+	snprintf(vp_dev->msix_names[msix_vec], sizeof(*vp_dev->msix_names),
+		 "%s-%s", dev_name(&vp_dev->vdev.dev), name);
+	err = request_irq(pci_irq_vector(vp_dev->pci_dev, msix_vec),
+			  vring_interrupt, 0,
+			  vp_dev->msix_names[msix_vec], vq);
+	if (err) {
+		vp_del_vq(vq);
+		return ERR_PTR(err);
+	}
+
+	return vq;
+}
+
 static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
 			    struct virtqueue *vqs[],
 			    struct virtqueue_info vqs_info[],
@@ -292,7 +330,6 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	struct virtqueue_info *vqi;
-	u16 msix_vec;
 	int i, err, nvectors, allocated_vectors, queue_idx = 0;
 
 	vp_dev->vqs = kcalloc(nvqs, sizeof(*vp_dev->vqs), GFP_KERNEL);
@@ -325,36 +362,13 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
 			vqs[i] = NULL;
 			continue;
 		}
-
-		if (!vqi->callback)
-			msix_vec = VIRTIO_MSI_NO_VECTOR;
-		else if (vp_dev->per_vq_vectors)
-			msix_vec = allocated_vectors++;
-		else
-			msix_vec = VP_MSIX_VQ_VECTOR;
-		vqs[i] = vp_setup_vq(vdev, queue_idx++, vqi->callback,
-				     vqi->name, vqi->ctx, msix_vec);
+		vqs[i] = vp_find_one_vq_msix(vdev, queue_idx++, vqi->callback,
+					     vqi->name, vqi->ctx,
+					     &allocated_vectors);
 		if (IS_ERR(vqs[i])) {
 			err = PTR_ERR(vqs[i]);
 			goto error_find;
 		}
-
-		if (!vp_dev->per_vq_vectors || msix_vec == VIRTIO_MSI_NO_VECTOR)
-			continue;
-
-		/* allocate per-vq irq if available and necessary */
-		snprintf(vp_dev->msix_names[msix_vec],
-			 sizeof *vp_dev->msix_names,
-			 "%s-%s",
-			 dev_name(&vp_dev->vdev.dev), vqi->name);
-		err = request_irq(pci_irq_vector(vp_dev->pci_dev, msix_vec),
-				  vring_interrupt, 0,
-				  vp_dev->msix_names[msix_vec],
-				  vqs[i]);
-		if (err) {
-			vp_del_vq(vqs[i]);
-			goto error_find;
-		}
 	}
 	return 0;
 
-- 
2.45.2

