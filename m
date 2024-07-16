Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A8715491
	for <virtualization@lists.linux.dev>; Tue, 16 Jul 2024 11:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721129779; cv=none; b=gWfYHyMCLVwCTuMBDRjR8yEzlufCbdsRfiB7pGDKx10GB/AhQ7iwTxFv5R3dy1Hfetsl61VSzdUnBGYc2jaCFgzpURcEF+K7qq0aeiojqKbUkRRCIc7RC+xM/0RVG4jUoHSblQ4NxPu0E6ytaWfThSnvLN2b+RZr0HkoBgAdRi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721129779; c=relaxed/simple;
	bh=l9UwLBhildOoBuY5KRYqc2BDA/EDGR/7i1OHOPuYDFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hdG5unYzL1GIGS3Or1W2N3DV5cdub+01pxt9PAMkPc8aIOqIyoehvXjHY9pkZzrJNhpRx43BMREh9qn2mlpJeER3YEJ6+dJ/vRb8HyJZeiE5/52H70awl02OaGwreaL9mTBPgo3llqRIzsacbfQAv6vozEA9UcbQriTH8Ip7EJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=XrVKbLxf; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="XrVKbLxf"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3679f806223so3755376f8f.0
        for <virtualization@lists.linux.dev>; Tue, 16 Jul 2024 04:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1721129776; x=1721734576; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4NKa7Gl943UHlo1VjLtOfPEs+ZBMkPhsfnci4A3iK4=;
        b=XrVKbLxfr6IsVkvGU9Wk6AaWQkS/zY3RWDjqzYxx3bOHekigsjNWX5u+szEadRMgSl
         0hijAxc80BkEy7soX2PlJESwEe6SDam5aZ3UnKueCdTn2a7W4bBgiUAuw+Q6SujDfMQD
         5X0Mh3YkiVBaHiBRbGHpDmeP79aA1RvpBO9bU3k3AZ3geweWGbp3tw1BFVBtS1N87Eaz
         vCpsxwddYtMNm0/u7SWvkAVMng7lntHodefK/4+ps7uueVjL2SQUWggVT/zWSlO5c4Es
         Kj4TSsTJCXVC/lEMd6IwPP+KuBs/7JP0ulN3n/nqtc45a2LuoM8YdpSUDljtSBN86Ce9
         gXoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721129776; x=1721734576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E4NKa7Gl943UHlo1VjLtOfPEs+ZBMkPhsfnci4A3iK4=;
        b=aEFPsmqrnCUaeEzQRlD2F8cpRiV10umznx4t5Lc1sDXy9F+KnYbCQtSV+V8gspNIGg
         jWyry/orvTp2lSCrmYCQFFKhe22BAh0EaIDht6OVaJc75ISL7cwkHEWjVgDRI1JnEzFl
         8Ioq+NWrt6FMKAfu6gjKnT4jMV7yqRR84ZgaIBDMvCJr9/7bvlUEq7fjfqLsTgwh44bS
         uwSYevCp9iyIydIcAH6JKPwR15tOqBM3utouYUOpQf4GUTYsAGRYjPcVwZpPTT8dlR3k
         DqJJccrX7CLd8sGYU5tZwilHl0fyv1uUjMfCueXzr19jkr5MEJ8k4P8vWDx2HCgjTUYS
         MJCg==
X-Gm-Message-State: AOJu0Yy2jjM3QU6mLE8f89HPrbctohxPrtl1eftYxUxLvNLrGNn8b1iS
	nBLmtLBYI0nNkErfKTU/QWqjHKA0nnmL/30dAPc3zzO6UFpibTV2k4cN0P89hIokPW8ThuU8Aqr
	WXF4=
X-Google-Smtp-Source: AGHT+IFrOlk1feHGxpmH0KNgl4wTBD3CPL/93OXhROKGajaBZADXOUOhVeBjXl7HTDDqB6bvAY16/Q==
X-Received: by 2002:a5d:56c4:0:b0:362:4679:b5a with SMTP id ffacd0b85a97d-3682742d229mr1062101f8f.16.1721129775734;
        Tue, 16 Jul 2024 04:36:15 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dabf151sm8758733f8f.29.2024.07.16.04.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 04:36:15 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v3 05/13] virtio_pci: introduce vector allocation fallback for slow path virtqueues
Date: Tue, 16 Jul 2024 13:35:44 +0200
Message-ID: <20240716113552.80599-6-jiri@resnulli.us>
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

If there is not enough vectors to satisfy all virtqueues, currently
the fallback is to use one vector for all virtqueues.

That may be unnecessary in some cases, when there is enough vectors per
data queues.

Introduce another fallback policy that tries to allocate vector for all
data queues, however for slow path queues (control/admin) it shares
config vector.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- new patch
---
 drivers/virtio/virtio_pci_common.c | 53 ++++++++++++++++++++++++++----
 drivers/virtio/virtio_pci_common.h |  7 ++--
 2 files changed, 51 insertions(+), 9 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 628f003db79b..cb8bbe6c1a9f 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -46,12 +46,26 @@ bool vp_notify(struct virtqueue *vq)
 	return true;
 }
 
+/* Notify all slow path virtqueues on an interrupt. */
+static void vp_vring_slow_path_interrupt(int irq,
+					 struct virtio_pci_device *vp_dev)
+{
+	struct virtio_pci_vq_info *info;
+	unsigned long flags;
+
+	spin_lock_irqsave(&vp_dev->lock, flags);
+	list_for_each_entry(info, &vp_dev->slow_virtqueues, node)
+		vring_interrupt(irq, info->vq);
+	spin_unlock_irqrestore(&vp_dev->lock, flags);
+}
+
 /* Handle a configuration change: Tell driver if it wants to know. */
 static irqreturn_t vp_config_changed(int irq, void *opaque)
 {
 	struct virtio_pci_device *vp_dev = opaque;
 
 	virtio_config_changed(&vp_dev->vdev);
+	vp_vring_slow_path_interrupt(irq, vp_dev);
 	return IRQ_HANDLED;
 }
 
@@ -174,6 +188,11 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
 	return err;
 }
 
+static bool vp_is_slow_path_vector(u16 msix_vec)
+{
+	return msix_vec == VP_MSIX_CONFIG_VECTOR;
+}
+
 static struct virtqueue *vp_setup_vq(struct virtio_device *vdev, unsigned int index,
 				     void (*callback)(struct virtqueue *vq),
 				     const char *name,
@@ -197,7 +216,10 @@ static struct virtqueue *vp_setup_vq(struct virtio_device *vdev, unsigned int in
 	info->vq = vq;
 	if (callback) {
 		spin_lock_irqsave(&vp_dev->lock, flags);
-		list_add(&info->node, &vp_dev->virtqueues);
+		if (!vp_is_slow_path_vector(msix_vec))
+			list_add(&info->node, &vp_dev->virtqueues);
+		else
+			list_add(&info->node, &vp_dev->slow_virtqueues);
 		spin_unlock_irqrestore(&vp_dev->lock, flags);
 	} else {
 		INIT_LIST_HEAD(&info->node);
@@ -245,7 +267,8 @@ void vp_del_vqs(struct virtio_device *vdev)
 		if (vp_dev->per_vq_vectors) {
 			int v = vp_dev->vqs[vq->index]->msix_vector;
 
-			if (v != VIRTIO_MSI_NO_VECTOR) {
+			if (v != VIRTIO_MSI_NO_VECTOR &&
+			    !vp_is_slow_path_vector(v)) {
 				int irq = pci_irq_vector(vp_dev->pci_dev, v);
 
 				irq_update_affinity_hint(irq, NULL);
@@ -289,13 +312,14 @@ void vp_del_vqs(struct virtio_device *vdev)
 
 enum vp_vq_vector_policy {
 	VP_VQ_VECTOR_POLICY_EACH,
+	VP_VQ_VECTOR_POLICY_SHARED_SLOW,
 	VP_VQ_VECTOR_POLICY_SHARED,
 };
 
 static struct virtqueue *
 vp_find_one_vq_msix(struct virtio_device *vdev, int queue_idx,
 		    vq_callback_t *callback, const char *name, bool ctx,
-		    int *allocated_vectors,
+		    bool slow_path, int *allocated_vectors,
 		    enum vp_vq_vector_policy vector_policy)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
@@ -305,8 +329,13 @@ vp_find_one_vq_msix(struct virtio_device *vdev, int queue_idx,
 
 	if (!callback)
 		msix_vec = VIRTIO_MSI_NO_VECTOR;
-	else if (vector_policy == VP_VQ_VECTOR_POLICY_EACH)
+	else if (vector_policy == VP_VQ_VECTOR_POLICY_EACH ||
+		 (vector_policy == VP_VQ_VECTOR_POLICY_SHARED_SLOW &&
+		 !slow_path))
 		msix_vec = (*allocated_vectors)++;
+	else if (vector_policy != VP_VQ_VECTOR_POLICY_EACH &&
+		 slow_path)
+		msix_vec = VP_MSIX_CONFIG_VECTOR;
 	else
 		msix_vec = VP_MSIX_VQ_VECTOR;
 	vq = vp_setup_vq(vdev, queue_idx, callback, name, ctx, msix_vec);
@@ -314,7 +343,8 @@ vp_find_one_vq_msix(struct virtio_device *vdev, int queue_idx,
 		return vq;
 
 	if (vector_policy == VP_VQ_VECTOR_POLICY_SHARED ||
-	    msix_vec == VIRTIO_MSI_NO_VECTOR)
+	    msix_vec == VIRTIO_MSI_NO_VECTOR ||
+	    vp_is_slow_path_vector(msix_vec))
 		return vq;
 
 	/* allocate per-vq irq if available and necessary */
@@ -374,7 +404,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
 			continue;
 		}
 		vqs[i] = vp_find_one_vq_msix(vdev, queue_idx++, vqi->callback,
-					     vqi->name, vqi->ctx,
+					     vqi->name, vqi->ctx, false,
 					     &allocated_vectors, vector_policy);
 		if (IS_ERR(vqs[i])) {
 			err = PTR_ERR(vqs[i]);
@@ -440,6 +470,13 @@ int vp_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 			       VP_VQ_VECTOR_POLICY_EACH, desc);
 	if (!err)
 		return 0;
+	/* Fallback: MSI-X with one shared vector for config and
+	 * slow path queues, one vector per queue for the rest.
+	 */
+	err = vp_find_vqs_msix(vdev, nvqs, vqs, vqs_info,
+			       VP_VQ_VECTOR_POLICY_SHARED_SLOW, desc);
+	if (!err)
+		return 0;
 	/* Fallback: MSI-X with one vector for config, one shared for queues. */
 	err = vp_find_vqs_msix(vdev, nvqs, vqs, vqs_info,
 			       VP_VQ_VECTOR_POLICY_SHARED, desc);
@@ -493,7 +530,8 @@ const struct cpumask *vp_get_vq_affinity(struct virtio_device *vdev, int index)
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 
 	if (!vp_dev->per_vq_vectors ||
-	    vp_dev->vqs[index]->msix_vector == VIRTIO_MSI_NO_VECTOR)
+	    vp_dev->vqs[index]->msix_vector == VIRTIO_MSI_NO_VECTOR ||
+	    vp_is_slow_path_vector(vp_dev->vqs[index]->msix_vector))
 		return NULL;
 
 	return pci_irq_get_affinity(vp_dev->pci_dev,
@@ -601,6 +639,7 @@ static int virtio_pci_probe(struct pci_dev *pci_dev,
 	vp_dev->vdev.dev.release = virtio_pci_release_dev;
 	vp_dev->pci_dev = pci_dev;
 	INIT_LIST_HEAD(&vp_dev->virtqueues);
+	INIT_LIST_HEAD(&vp_dev->slow_virtqueues);
 	spin_lock_init(&vp_dev->lock);
 
 	/* enable the device */
diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index 3c4bb2d6163a..0cb6fdc8c354 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -35,7 +35,7 @@ struct virtio_pci_vq_info {
 	/* the actual virtqueue */
 	struct virtqueue *vq;
 
-	/* the list node for the virtqueues list */
+	/* the list node for the virtqueues or slow_virtqueues list */
 	struct list_head node;
 
 	/* MSI-X vector (or none) */
@@ -66,9 +66,12 @@ struct virtio_pci_device {
 	/* Where to read and clear interrupt */
 	u8 __iomem *isr;
 
-	/* a list of queues so we can dispatch IRQs */
+	/* Lists of queues and potentially slow path queues
+	 * so we can dispatch IRQs.
+	 */
 	spinlock_t lock;
 	struct list_head virtqueues;
+	struct list_head slow_virtqueues;
 
 	/* Array of all virtqueues reported in the
 	 * PCI common config num_queues field
-- 
2.45.2

