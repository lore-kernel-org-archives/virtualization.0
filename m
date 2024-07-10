Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C166A64CEC
	for <virtualization@lists.linux.dev>; Wed, 10 Jul 2024 06:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720593369; cv=none; b=qo2rJp3WPHsdfLAyZhGvkbFKoefDoHaabD3M/APkeaye7vdiI74JKwR4movGYsZtDI4pKtq19SenS3AVFKlv2TZC5bBcW2tFejh+tE2ZABRJfWkX6lRjXb6bQoPIrwCdh4TbXojt77CQo+5tHWp3rSsdQ/wktDr67xU+cnMClco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720593369; c=relaxed/simple;
	bh=Slwt6mwqsZSmtaJCt/6aEvfeOxcjMyxlhz/G4vHhWQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H5k29G6yAgNKQRzF02tUiB/GfAPs09fTfm4NqTw1tL3CJ5AIGACqVWq3lWfvul0LVZU5CwmjBfedymA6m+IkrelMgTQHmB7J9kwwa6sCOrGH5WIpR8cFdnuDmdExNpPUoloe4OK9q080IHGxEq/br1n3rWsVjk+VFnLLOd2S0gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=FKyK6cYA; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="FKyK6cYA"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ee92f7137bso52186411fa.1
        for <virtualization@lists.linux.dev>; Tue, 09 Jul 2024 23:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720593365; x=1721198165; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x4i8jj5jC7bvjPYwpGO7GGf73fXdPIN83C7G6C8/crc=;
        b=FKyK6cYAeEdqFBpBPJ1Qv6/pC2+v6wLzU9QcsXNmmec5EcG3Za2Hl4Hr5xjk7G8HVN
         vCx0VpFj6BK2G19YXJSpASkO86esAs5JGNQ+fj3VJE6PgkJN1iAXXjGb/fnlv21gJFgL
         xWLVi2i4eg8kLXhFYqQPSwq1U6USSkaRxFYnqhK8g6WM/HOZRBE/q3Cm4u9R8mJxxXR+
         MxfuXpwlwLuSqITFSmly7p7a0aYuDZvNatfZMJpAG2ShrjGfmzwIH1f/o0ri9EA0Ojp8
         8tbtKb+e38V+04HcYdmuUkByshNoaJF6380W3SiQK8piR+NkPJ2GJW47cLoP1EvqAhlS
         UCsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720593365; x=1721198165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x4i8jj5jC7bvjPYwpGO7GGf73fXdPIN83C7G6C8/crc=;
        b=shMgTspyXxhnyNMnzOegBI2HL4gS6zprryE5WStUPGGYP167V0XBFmJU2GyhGryHxI
         49aw+9dC1XlnGMMYYAowjkk5KB4wo+gFGLukCRc6/8DoplTmWuA0toBNeMtZkgfiCjo9
         EhrLHx/ZsxngU6diLGTFf9akoCMby7UsoeHcIKpPFdBO+YRHQydsAk0lden0iRZC/kc7
         oYreJ6iYKft5oaUFq0Jj2iH7qdSxS2qUqFPC8FittxbwMLtD5zD7cXL7Rt97XeLWmJmc
         3oljuBk6kmLrwlEhfaiuD0qX8yOb0+feB5HKBHAYhrWxtsvzP1vn7WPGitA28Har8u8V
         X5LA==
X-Gm-Message-State: AOJu0Yy5U1x7pX+0pYC/RRPFD6zvKa9VeKAmH57ZF7y7MntG7Ksk7Br1
	XbCAw5UlEGX34PNfm0ga8y1AENXdKlzi7ZVHAV17UlbBFrx0F+F6pBJhYGPl7jBoV7RD/K2dG6W
	l
X-Google-Smtp-Source: AGHT+IErTyy5dnuRJeK6LpI82Gp5GY7xTp/TqaIBKLiccopnv6Laa78HTEwkDQRr/mVxe9yoXQGHYQ==
X-Received: by 2002:a2e:9847:0:b0:2ee:5c0d:42e4 with SMTP id 38308e7fff4ca-2eeb30fcf9fmr35834511fa.25.1720593364777;
        Tue, 09 Jul 2024 23:36:04 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a2fc9desm238212875e9.45.2024.07.09.23.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 23:36:04 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v2 01/13] virtio_pci: push out single vq find code to vp_find_one_vq_msix()
Date: Wed, 10 Jul 2024 08:35:49 +0200
Message-ID: <20240710063601.2000149-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240710063601.2000149-1-jiri@resnulli.us>
References: <20240710063601.2000149-1-jiri@resnulli.us>
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

