Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDD71304BA
	for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 09:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719219922; cv=none; b=teGpnX6V3AoUX6wyZcSGxnM18IeqnfjjPi0+kz1hWpphgKNvkfp/2W4JvBSDfR+cm36YexHvYTREf396zE9kXpd+DSU6nOGbWeJiiR07a4G16Fn97z4eY+bTKkmIdYcDKVh0+fW/Rcf9bYg6EYYs6rEaBpm0pBP6ACZyr3xqmr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719219922; c=relaxed/simple;
	bh=yfiRRMyXrrkacMUpZwP20aePjPR0ayBzwkHHrURVxoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tWkT68Mz3DQGw7mBvzkkd4N5ftQ16X76uv92j09hxNn2RKd7DaG05tz1442KcmFN0mhpMZkPxVQHHg3CvdlxDgkUecAkq2HYrCUJIGRo9tNfogm76a0GujNZGGfzM2FqqBb5Pq73i4bv46KAmWht4OCCNFpffbMQNIEVTJs1ehw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=VPB/uQuO; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="VPB/uQuO"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so23393765e9.1
        for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 02:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1719219918; x=1719824718; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PwD4mBa4kcRfm4fp7beARWNZUn+83oNChi6g7vknBF4=;
        b=VPB/uQuOEFadc1xDNQKvd7VLhDzoIwwbQcUV0Tipico1bcO97icVndkQjHvDPuKl0n
         XfhODMj8XJ9NRq1p/zo5SVRP5PFbQeIfxxg4vRhZdBciHBwZGH8mHsRMj1MZaqYLL3UU
         4u0jZ0hhuOQ8h8NUp/ebEN1gLM3Iy9LCY410cRFhv0VtyKfz3TaRea4BLVzv2V2R/HUs
         fiXwrg1dwsGZtzXXTV5OpxURrIN1d6XoafoFQYL6RjdIUJ7qhlOsht0bCA4OpQgw+MCT
         +RWRYxPEOxR4OBQEuZ5jeEh+AkjMdhMVZ4mPrC7v6glnmPLO2Uua8pUPkHdYKLn4gzEM
         dZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719219918; x=1719824718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PwD4mBa4kcRfm4fp7beARWNZUn+83oNChi6g7vknBF4=;
        b=CVySrdvf/hJ2+neledXfnlIEEf3G99fbXoeQzhHehgb2Y4Fw/HjucUe41nz57QS9eX
         f3NmGWFzf5oL4sKMbdoS1P7pyY7qFctylkENQWzqxIMAEA5ss43R/y0tUCGyJ8NVaMi8
         yjqQcp2Ti/IFZfjJs5RqV8xvznH8AExcnF/T/KjEXfbkFMLaYwIXHs35srng2f7eAif9
         UaUraPIuofA6vlS1n7K31X5D3rZW5qq5siP5UNWYp3bzSbzAlowV0/rcJMbac5d7l9cO
         KRlYhVZszRj+m6ZPF1kj2yRrY8vJY3hKtljB3KFcj22piGzy3VbFvZw+NJLiSaRX04TN
         fiLA==
X-Gm-Message-State: AOJu0YyNfut1fzoyQUWzsTO3FUFHn12CKqff5ShGfuxABmtHsBUo/+Qx
	aIrHut/3+aClePqDMnfWO6tHwB0lslduGKJ9UBytcIeBDdHjV15k+mk79tLQ55FTEBoXhhzGaCe
	ZjJc=
X-Google-Smtp-Source: AGHT+IGdzNGWR5RXOFbzUVnSla54dRSIkNIGkYQLbm1IYhK7yNvdDBFkMYJlxsM1OSV6j3S5jU4Y6A==
X-Received: by 2002:a05:600c:56cd:b0:424:8a34:9890 with SMTP id 5b1f17b1804b1-4248a349975mr36720445e9.7.1719219918416;
        Mon, 24 Jun 2024 02:05:18 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424817a8ed3sm131347995e9.13.2024.06.24.02.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 02:05:17 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com
Subject: [PATCH virtio 7/8] virtio_pci_modern: use completion instead of busy loop to wait on admin cmd result
Date: Mon, 24 Jun 2024 11:04:50 +0200
Message-ID: <20240624090451.2683976-8-jiri@resnulli.us>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240624090451.2683976-1-jiri@resnulli.us>
References: <20240624090451.2683976-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Currently, the code waits in a busy loop on every admin virtqueue issued
command to get a reply. That prevents callers from issuing multiple
commands in parallel.

To overcome this limitation, introduce a virtqueue event callback for
admin virtqueue. For every issued command, use completion mechanism
to wait on a reply. In the event callback, trigger the completion
is done for every incoming reply.

Alongside with that, introduce a spin lock to protect the admin
virtqueue operations.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/virtio/virtio_pci_common.c | 10 +++---
 drivers/virtio/virtio_pci_common.h |  3 ++
 drivers/virtio/virtio_pci_modern.c | 52 +++++++++++++++++++++++-------
 include/linux/virtio.h             |  2 ++
 4 files changed, 51 insertions(+), 16 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 07c0511f170a..5ff7304c7a2a 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -346,6 +346,8 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
 		for (i = 0; i < nvqs; ++i)
 			if (names[i] && callbacks[i])
 				++nvectors;
+		if (avq_num)
+			++nvectors;
 	} else {
 		/* Second best: one for change, shared for all vqs. */
 		nvectors = 2;
@@ -375,8 +377,8 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
 	if (!avq_num)
 		return 0;
 	sprintf(avq->name, "avq.%u", avq->vq_index);
-	vqs[i] = vp_find_one_vq_msix(vdev, avq->vq_index, NULL, avq->name,
-				     false, &allocated_vectors);
+	vqs[i] = vp_find_one_vq_msix(vdev, avq->vq_index, vp_modern_avq_done,
+				     avq->name, false, &allocated_vectors);
 	if (IS_ERR(vqs[i])) {
 		err = PTR_ERR(vqs[i]);
 		goto error_find;
@@ -432,8 +434,8 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
 	if (!avq_num)
 		return 0;
 	sprintf(avq->name, "avq.%u", avq->vq_index);
-	vqs[i] = vp_setup_vq(vdev, queue_idx++, NULL, avq->name,
-			     false, VIRTIO_MSI_NO_VECTOR);
+	vqs[i] = vp_setup_vq(vdev, queue_idx++, vp_modern_avq_done,
+			     avq->name, false, VIRTIO_MSI_NO_VECTOR);
 	if (IS_ERR(vqs[i])) {
 		err = PTR_ERR(vqs[i]);
 		goto out_del_vqs;
diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index b3ef76287b43..38a0b6df0844 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -45,6 +45,8 @@ struct virtio_pci_vq_info {
 struct virtio_pci_admin_vq {
 	/* serializing admin commands execution. */
 	struct mutex cmd_lock;
+	/* Protects virtqueue access. */
+	spinlock_t lock;
 	u64 supported_cmds;
 	/* Name of the admin queue: avq.$vq_index. */
 	char name[10];
@@ -174,6 +176,7 @@ struct virtio_device *virtio_pci_vf_get_pf_dev(struct pci_dev *pdev);
 #define VIRTIO_ADMIN_CMD_BITMAP 0
 #endif
 
+void vp_modern_avq_done(struct virtqueue *vq);
 int vp_modern_admin_cmd_exec(struct virtio_device *vdev,
 			     struct virtio_admin_cmd *cmd);
 
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index b4041e541fc3..b9937e4b8a69 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -53,6 +53,23 @@ static bool vp_is_avq(struct virtio_device *vdev, unsigned int index)
 	return index == vp_dev->admin_vq.vq_index;
 }
 
+void vp_modern_avq_done(struct virtqueue *vq)
+{
+	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
+	struct virtio_pci_admin_vq *admin_vq = &vp_dev->admin_vq;
+	struct virtio_admin_cmd *cmd;
+	unsigned long flags;
+	unsigned int len;
+
+	spin_lock_irqsave(&admin_vq->lock, flags);
+	do {
+		virtqueue_disable_cb(vq);
+		while ((cmd = virtqueue_get_buf(vq, &len)))
+			complete(&cmd->completion);
+	} while (!virtqueue_enable_cb(vq));
+	spin_unlock_irqrestore(&admin_vq->lock, flags);
+}
+
 static int virtqueue_exec_admin_cmd(struct virtio_pci_device *vp_dev,
 				    struct virtio_pci_admin_vq *admin_vq,
 				    u16 opcode,
@@ -62,7 +79,8 @@ static int virtqueue_exec_admin_cmd(struct virtio_pci_device *vp_dev,
 				    struct virtio_admin_cmd *cmd)
 {
 	struct virtqueue *vq;
-	int ret, len;
+	unsigned long flags;
+	int ret;
 
 	vq = vp_dev->vqs[admin_vq->vq_index]->vq;
 	if (!vq)
@@ -73,21 +91,30 @@ static int virtqueue_exec_admin_cmd(struct virtio_pci_device *vp_dev,
 	    !((1ULL << opcode) & admin_vq->supported_cmds))
 		return -EOPNOTSUPP;
 
-	ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_KERNEL);
-	if (ret < 0)
-		return -EIO;
-
-	if (unlikely(!virtqueue_kick(vq)))
-		return -EIO;
+	init_completion(&cmd->completion);
 
-	while (!virtqueue_get_buf(vq, &len) &&
-	       !virtqueue_is_broken(vq))
-		cpu_relax();
+again:
+	spin_lock_irqsave(&admin_vq->lock, flags);
+	ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_KERNEL);
+	if (ret < 0) {
+		if (ret == -ENOSPC) {
+			spin_unlock_irqrestore(&admin_vq->lock, flags);
+			cpu_relax();
+			goto again;
+		}
+		goto unlock_err;
+	}
+	if (WARN_ON_ONCE(!virtqueue_kick(vq)))
+		goto unlock_err;
+	spin_unlock_irqrestore(&admin_vq->lock, flags);
 
-	if (virtqueue_is_broken(vq))
-		return -EIO;
+	wait_for_completion(&cmd->completion);
 
 	return 0;
+
+unlock_err:
+	spin_unlock_irqrestore(&admin_vq->lock, flags);
+	return -EIO;
 }
 
 int vp_modern_admin_cmd_exec(struct virtio_device *vdev,
@@ -787,6 +814,7 @@ int virtio_pci_modern_probe(struct virtio_pci_device *vp_dev)
 	vp_dev->isr = mdev->isr;
 	vp_dev->vdev.id = mdev->id;
 
+	spin_lock_init(&vp_dev->admin_vq.lock);
 	mutex_init(&vp_dev->admin_vq.cmd_lock);
 	return 0;
 }
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 26c4325aa373..5db8ee175e71 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -10,6 +10,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/gfp.h>
 #include <linux/dma-mapping.h>
+#include <linux/completion.h>
 
 /**
  * struct virtqueue - a queue to register buffers for sending or receiving.
@@ -109,6 +110,7 @@ struct virtio_admin_cmd {
 	__le64 group_member_id;
 	struct scatterlist *data_sg;
 	struct scatterlist *result_sg;
+	struct completion completion;
 };
 
 /**
-- 
2.45.1

