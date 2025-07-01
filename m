Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDEB1CDFD5
	for <virtualization@lists.linux.dev>; Tue,  1 Jul 2025 01:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751332502; cv=none; b=UeuugoU4UKIiUcaMdZWcO0+w007dbN+5Vz3f+z9Kz8ElDSv7Ea+yhCRdnXxtd/riJgcd2XCU+ZjzNYYLJQhKMIZ+VrwK74uQN9vyLsq6yhoOOPURZaENZho3OkZOfdPTUqI6ognJbhgWDz6BlUaiqiz+aI+v+2qAT8uNFPY9fog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751332502; c=relaxed/simple;
	bh=w8Q7p2/jymUTLxEN4p15BtUVOFpy1++JTaS420OfFYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mUqHHU6F4P7IaeJTI+mDCi9fBB2wWXKstyl+gj+vlEaUui0DOsKmzfJbOD24ymsrs7TGsBKWYUFRAocKgN8WN/qjoGl/hqWRrwx2ly25An6C9lj3pwCFLxVpEXvp+5IuY/4rLsh+RIdO5QKiwubPuKkqUAGBcjTHUSFuKE3gfjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KdrV7/qb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KdrV7/qb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751332499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kYAOcmbEwBg2VfBZu4DP5Zw8EdQwqNIx4zWCkiCTB04=;
	b=KdrV7/qbBvuanNgc5RR0WCsS7joIGtOEv1wAnNG0evFvkCpnAUL6KHSY94zN82A8nqTKQA
	YrGvF3khD7kIIbCYeIPJ9VLSn45yr5acYz4YKfUSzQTWhQ1GZQs2fOc1dqrNlzLFse2hCb
	OXfZAKTiID6MwlDNoR1LxkzZjsCoj34=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-382-WB4pCMVaMCaIy3CFLrfxMw-1; Mon,
 30 Jun 2025 21:14:55 -0400
X-MC-Unique: WB4pCMVaMCaIy3CFLrfxMw-1
X-Mimecast-MFC-AGG-ID: WB4pCMVaMCaIy3CFLrfxMw_1751332494
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3F38C18DA5CB;
	Tue,  1 Jul 2025 01:14:54 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.134])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F04E330001B1;
	Tue,  1 Jul 2025 01:14:48 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	hch@infradead.org,
	xieyongji@bytedance.com
Subject: [PATCH 7/9] vdpa: rename dma_dev to map_token
Date: Tue,  1 Jul 2025 09:13:59 +0800
Message-ID: <20250701011401.74851-8-jasowang@redhat.com>
In-Reply-To: <20250701011401.74851-1-jasowang@redhat.com>
References: <20250701011401.74851-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Virtio core switches from DMA device to mapping token, let's do that
as well for vDPA.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/alibaba/eni_vdpa.c          |  2 +-
 drivers/vdpa/ifcvf/ifcvf_main.c          |  2 +-
 drivers/vdpa/octeon_ep/octep_vdpa_main.c |  2 +-
 drivers/vdpa/vdpa.c                      |  2 +-
 drivers/vdpa/vdpa_sim/vdpa_sim.c         |  2 +-
 drivers/vdpa/vdpa_user/vduse_dev.c       |  2 +-
 drivers/vdpa/virtio_pci/vp_vdpa.c        |  2 +-
 drivers/vhost/vdpa.c                     |  4 ++--
 drivers/virtio/virtio_vdpa.c             | 12 ++++++------
 include/linux/vdpa.h                     | 12 ++++++------
 10 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/vdpa/alibaba/eni_vdpa.c b/drivers/vdpa/alibaba/eni_vdpa.c
index ad7f3447fe90..34bf726dc660 100644
--- a/drivers/vdpa/alibaba/eni_vdpa.c
+++ b/drivers/vdpa/alibaba/eni_vdpa.c
@@ -496,7 +496,7 @@ static int eni_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	pci_set_master(pdev);
 	pci_set_drvdata(pdev, eni_vdpa);
 
-	eni_vdpa->vdpa.dma_dev = &pdev->dev;
+	eni_vdpa->vdpa.map_token = &pdev->dev;
 	eni_vdpa->queues = eni_vdpa_get_num_queues(eni_vdpa);
 
 	eni_vdpa->vring = devm_kcalloc(&pdev->dev, eni_vdpa->queues,
diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index ccf64d7bbfaa..64d28ec97136 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -713,7 +713,7 @@ static int ifcvf_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 
 	ifcvf_mgmt_dev->adapter = adapter;
 	adapter->pdev = pdev;
-	adapter->vdpa.dma_dev = &pdev->dev;
+	adapter->vdpa.map_token = &pdev->dev;
 	adapter->vdpa.mdev = mdev;
 	adapter->vf = vf;
 	vdpa_dev = &adapter->vdpa;
diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_main.c b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
index 9b49efd24391..42a4df4613dd 100644
--- a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
+++ b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
@@ -516,7 +516,7 @@ static int octep_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	}
 
 	oct_vdpa->pdev = pdev;
-	oct_vdpa->vdpa.dma_dev = &pdev->dev;
+	oct_vdpa->vdpa.map_token = &pdev->dev;
 	oct_vdpa->vdpa.mdev = mdev;
 	oct_vdpa->oct_hw = oct_hw;
 	vdpa_dev = &oct_vdpa->vdpa;
diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 8a372b51c21a..1cc4285ebd67 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -151,7 +151,7 @@ static void vdpa_release_dev(struct device *d)
  * Driver should use vdpa_alloc_device() wrapper macro instead of
  * using this directly.
  *
- * Return: Returns an error when parent/config/dma_dev is not set or fail to get
+ * Return: Returns an error when parent/config/map_token is not set or fail to get
  *	   ida.
  */
 struct vdpa_device *__vdpa_alloc_device(struct device *parent,
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index c204fc8e471a..7c8e468f2f8c 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -272,7 +272,7 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
 		vringh_set_iotlb(&vdpasim->vqs[i].vring, &vdpasim->iommu[0],
 				 &vdpasim->iommu_lock);
 
-	vdpasim->vdpa.dma_dev = dev;
+	vdpasim->vdpa.map_token = dev;
 
 	return vdpasim;
 
diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 6a9a37351310..7420e90488ef 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -2022,7 +2022,7 @@ static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *name)
 		return ret;
 	}
 	set_dma_ops(&vdev->vdpa.dev, &vduse_dev_dma_ops);
-	vdev->vdpa.dma_dev = &vdev->vdpa.dev;
+	vdev->vdpa.map_token = &vdev->vdpa.dev;
 	vdev->vdpa.mdev = &vduse_mgmt->mgmt_dev;
 
 	return 0;
diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
index 8787407f75b0..6e22e95245fa 100644
--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
@@ -520,7 +520,7 @@ static int vp_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 
 	vp_vdpa_mgtdev->vp_vdpa = vp_vdpa;
 
-	vp_vdpa->vdpa.dma_dev = &pdev->dev;
+	vp_vdpa->vdpa.map_token = &pdev->dev;
 	vp_vdpa->queues = vp_modern_get_num_queues(mdev);
 	vp_vdpa->mdev = mdev;
 
diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 5a49b5a6d496..732ed118c138 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -1320,7 +1320,7 @@ static int vhost_vdpa_alloc_domain(struct vhost_vdpa *v)
 {
 	struct vdpa_device *vdpa = v->vdpa;
 	const struct vdpa_config_ops *ops = vdpa->config;
-	struct device *dma_dev = vdpa_get_dma_dev(vdpa);
+	struct device *dma_dev = vdpa_get_map_token(vdpa);
 	int ret;
 
 	/* Device want to do DMA by itself */
@@ -1355,7 +1355,7 @@ static int vhost_vdpa_alloc_domain(struct vhost_vdpa *v)
 static void vhost_vdpa_free_domain(struct vhost_vdpa *v)
 {
 	struct vdpa_device *vdpa = v->vdpa;
-	struct device *dma_dev = vdpa_get_dma_dev(vdpa);
+	struct device *dma_dev = vdpa_get_map_token(vdpa);
 
 	if (v->domain) {
 		iommu_detach_device(v->domain, dma_dev);
diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index 59b53032f1e2..cb68458cd809 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -147,7 +147,6 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 {
 	struct virtio_vdpa_device *vd_dev = to_virtio_vdpa_device(vdev);
 	struct vdpa_device *vdpa = vd_get_vdpa(vdev);
-	struct device *dma_dev;
 	const struct vdpa_config_ops *ops = vdpa->config;
 	struct virtio_vdpa_vq_info *info;
 	bool (*notify)(struct virtqueue *vq) = virtio_vdpa_notify;
@@ -159,6 +158,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 	unsigned long flags;
 	u32 align, max_num, min_num = 1;
 	bool may_reduce_num = true;
+	void *map_token;
 	int err;
 
 	if (!name)
@@ -201,13 +201,13 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 	/* Create the vring */
 	align = ops->get_vq_align(vdpa);
 
-	if (ops->get_vq_dma_dev)
-		dma_dev = ops->get_vq_dma_dev(vdpa, index);
+	if (ops->get_vq_map_token)
+		map_token = ops->get_vq_map_token(vdpa, index);
 	else
-		dma_dev = vdpa_get_dma_dev(vdpa);
+		map_token = vdpa_get_map_token(vdpa);
 	vq = vring_create_virtqueue_map(index, max_num, align, vdev,
 					true, may_reduce_num, ctx,
-					notify, callback, name, dma_dev);
+					notify, callback, name, map_token);
 	if (!vq) {
 		err = -ENOMEM;
 		goto error_new_virtqueue;
@@ -497,7 +497,7 @@ static int virtio_vdpa_probe(struct vdpa_device *vdpa)
 	if (!vd_dev)
 		return -ENOMEM;
 
-	vd_dev->vdev.dev.parent = vdpa_get_dma_dev(vdpa);
+	vd_dev->vdev.dev.parent = vdpa_get_map_token(vdpa);
 	vd_dev->vdev.dev.release = virtio_vdpa_release_dev;
 	vd_dev->vdev.config = &virtio_vdpa_config_ops;
 	vd_dev->vdpa = vdpa;
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 2e7a30fe6b92..352ca5609c9a 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -70,7 +70,7 @@ struct vdpa_mgmt_dev;
 /**
  * struct vdpa_device - representation of a vDPA device
  * @dev: underlying device
- * @dma_dev: the actual device that is performing DMA
+ * @map_token: the token passed to upper layer to be used for mappping
  * @driver_override: driver name to force a match; do not set directly,
  *                   because core frees it; use driver_set_override() to
  *                   set or clear it.
@@ -87,7 +87,7 @@ struct vdpa_mgmt_dev;
  */
 struct vdpa_device {
 	struct device dev;
-	struct device *dma_dev;
+	void *map_token;
 	const char *driver_override;
 	const struct vdpa_config_ops *config;
 	struct rw_semaphore cf_lock; /* Protects get/set config */
@@ -352,7 +352,7 @@ struct vdpa_map_file {
  *				@vdev: vdpa device
  *				@asid: address space identifier
  *				Returns integer: success (0) or error (< 0)
- * @get_vq_dma_dev:		Get the dma device for a specific
+ * @get_vq_map_token:		Get the map token for a specific
  *				virtqueue (optional)
  *				@vdev: vdpa device
  *				@idx: virtqueue index
@@ -436,7 +436,7 @@ struct vdpa_config_ops {
 	int (*reset_map)(struct vdpa_device *vdev, unsigned int asid);
 	int (*set_group_asid)(struct vdpa_device *vdev, unsigned int group,
 			      unsigned int asid);
-	struct device *(*get_vq_dma_dev)(struct vdpa_device *vdev, u16 idx);
+	struct device *(*get_vq_map_token)(struct vdpa_device *vdev, u16 idx);
 	int (*bind_mm)(struct vdpa_device *vdev, struct mm_struct *mm);
 	void (*unbind_mm)(struct vdpa_device *vdev);
 
@@ -520,9 +520,9 @@ static inline void vdpa_set_drvdata(struct vdpa_device *vdev, void *data)
 	dev_set_drvdata(&vdev->dev, data);
 }
 
-static inline struct device *vdpa_get_dma_dev(struct vdpa_device *vdev)
+static inline void *vdpa_get_map_token(struct vdpa_device *vdev)
 {
-	return vdev->dma_dev;
+	return vdev->map_token;
 }
 
 static inline int vdpa_reset(struct vdpa_device *vdev, u32 flags)
-- 
2.34.1

