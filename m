Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF6B7CF39
	for <virtualization@lists.linux.dev>; Wed, 10 Jul 2024 06:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720593376; cv=none; b=dWbLVjPLLCBMgpqJuiSr6bKuUQayFBSj/pM3MzFLZl3ywMppjH1ceMf+OOWT5iUlNDQmRCrEa+/zMiZjuDXTNukmvn+hsAu6COdh7pVeduetJqX1BtBrpjor5qDDIhjgEh7KkeGtgL2eTTcH58S4IEyvat2HkkvLJVoNnrBZl2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720593376; c=relaxed/simple;
	bh=l9UwLBhildOoBuY5KRYqc2BDA/EDGR/7i1OHOPuYDFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q2+hQJzTKbg45lUsDEMVRAk61910G9Z66m2WaFocigNe+5o72wC/MR3IzCjbPeqBjy/0KpXtlb6J19t9YzHTNhRrRzSwrvrHdRBtFBH+7lmKU1oo5mTwufz2G63IMRw1ASVTWfPM5ivXysELEunz8Fpqx1RyZIg7j73L+n6oclY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=tA47aWej; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="tA47aWej"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52e9c55febcso7705165e87.2
        for <virtualization@lists.linux.dev>; Tue, 09 Jul 2024 23:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720593372; x=1721198172; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4NKa7Gl943UHlo1VjLtOfPEs+ZBMkPhsfnci4A3iK4=;
        b=tA47aWej4DsSkfOviVc2pJtmuTd8ib4xtDdq/r5WDDA1LtL4OyFD/rK9MalZTIl48N
         fG+Tf+7hDANnc72CQjYFrb/9Rl3+s2hIqSyCSu9L3Llr92ILmn8S5q5qtW+65m3bdgYK
         sMUaeQsRh/NXRzNAtPHRVWcuy2ga5wQ2ZCvCKXevPtHIMmIafZiXYTrc5PQ4D9MJ5Sp3
         qDa4Q/3CyzxCQ67LMYwoQX1W94PCyQA6vwVo5Dol7P/R0Ks3xAy1eRaAdqsvXn1uDTnU
         X27yN0+GVYq3WQpsgH+M2K51BGDXzCQsQM6FOiSvu3bNBEnBCehAFDdGag3qfXxeJ7ZO
         NUXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720593372; x=1721198172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E4NKa7Gl943UHlo1VjLtOfPEs+ZBMkPhsfnci4A3iK4=;
        b=HauONyluQGxd4wsfY2RFy/0HvZs79Bo/XuHbNhJNYm2fCrFgQpo8dCtchknPBjkeO6
         CrWIVy71HCiFbXpptj21N6M90eN/ISEkesflB601s350va4nI7ZBrg9k2Mo/d33ljFrk
         WppC3QL6rXpsuR01hCo2Yd7PixuKXp8kxMht7ktnYgI0yWAzWKBTkBZw0f88hbUI7QkQ
         e0Azt/LQAMLbBO+D2GDz2Ka7GDWlIyfwuEpasTs1D44UEoIYMYwNAgOVqxti3VQwQPXV
         5dHs3y3nDwOg9AM71yNcgZv3GSkrr8rRrvZXpA9AZPE+FHwaEPrgzI5wkouLftlvFpyG
         9blQ==
X-Gm-Message-State: AOJu0Yxhi7i2d4HrPFjJrV3meOZj3hHA4C1yovYsQQmWmVtUK4RS3FQM
	51KOmEK4pMx24JGap+CED91zzzSt8bV0Hcj2lJtXMLl+tdmo6A0llZ4qQKD2yG1fdlbGkYO91yw
	a
X-Google-Smtp-Source: AGHT+IE7/6X+GvsmFVGW7tzTXxjTt5aBzp7nu7W6jrFwq8jT2lRDWd8rwgf8rzTkapTUdzCf029V1Q==
X-Received: by 2002:a2e:90cc:0:b0:2ee:7a7e:8ebb with SMTP id 38308e7fff4ca-2eeb3198b20mr27667901fa.52.1720593371988;
        Tue, 09 Jul 2024 23:36:11 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f7420cesm67516445e9.46.2024.07.09.23.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 23:36:11 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	parav@nvidia.com,
	feliu@nvidia.com,
	hengqi@linux.alibaba.com
Subject: [PATCH virtio v2 05/13] virtio_pci: introduce vector allocation fallback for slow path virtqueues
Date: Wed, 10 Jul 2024 08:35:53 +0200
Message-ID: <20240710063601.2000149-6-jiri@resnulli.us>
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

