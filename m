Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FA12951A8
	for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 09:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752830221; cv=none; b=nSnghsDlODEeR5k2rwhWw0qkGvnmp0xGvXyXgCvvpB8z6ku3WwOkTLNP90dQ3eiJ/rDeeX9/pQfM/ZEEJjYDSz9P0pet5Vle0XWz4HlUjQrA95MUAS7lJWHOBWrbAr35ESCMvisUNhxx2nNUrScmmiWLaZU0eVdhScWJES7PQXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752830221; c=relaxed/simple;
	bh=LFQ9wLs2PuUKBdbuHwwxlt1NCqpQh/+swhx+HDs6JOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Q7a+RL/wk8XIbprGewCLRnVH9dKepfoArnOKzZ4e0ptvJFIDkTwCWTCBQSJWP4kew8t0C3GhFeDDN8xbwdNJ7mYR+HsbhadjLg4POsudgHkwWlGMvk2ASEkp8b1Q76O1GSJSuFmOoRUamQqrTwf4gYOCyIMzj+jF+BEnSyxGsuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=brqU6zgr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="brqU6zgr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752830217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uCFqk6sciaOFxQb4oQ28npkezWLZjGPoFRCJ35NnYds=;
	b=brqU6zgrZNfVneIh27063vD4IIM0wMUF5FVRAdW5tJonBdYilPw1fHjYXNU5JBHVXuMWMY
	M5dQUvGCBFZ0fj6ijLQyg4edhAi/ZDR+CYz0eMZkvS2bpmW5hbJ5reIE/uf6g+KcCtg9mu
	skjZgw4Z2ioVDWNqz9t2tYf1OlOlNNw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-53-tqxLKW1NMS6filL6OHR19A-1; Fri,
 18 Jul 2025 05:16:56 -0400
X-MC-Unique: tqxLKW1NMS6filL6OHR19A-1
X-Mimecast-MFC-AGG-ID: tqxLKW1NMS6filL6OHR19A_1752830215
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6741B19560B0;
	Fri, 18 Jul 2025 09:16:55 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.32])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E006F195609D;
	Fri, 18 Jul 2025 09:16:51 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	hch@infradead.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH V4 7/9] vdpa: rename dma_dev to map_token
Date: Fri, 18 Jul 2025 17:16:14 +0800
Message-ID: <20250718091616.6140-8-jasowang@redhat.com>
In-Reply-To: <20250718091616.6140-1-jasowang@redhat.com>
References: <20250718091616.6140-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8yskulvAQTZg8s4xytJ0AQ4bcjjzb7z40K2LRdtRRvM_1752830215
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Virtio core switches from DMA device to mapping token, let's do that
as well for vDPA.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/alibaba/eni_vdpa.c          |  2 +-
 drivers/vdpa/ifcvf/ifcvf_main.c          |  2 +-
 drivers/vdpa/mlx5/core/mr.c              |  4 ++--
 drivers/vdpa/mlx5/net/mlx5_vnet.c        |  8 ++++----
 drivers/vdpa/octeon_ep/octep_vdpa_main.c |  2 +-
 drivers/vdpa/pds/vdpa_dev.c              |  2 +-
 drivers/vdpa/solidrun/snet_main.c        |  4 ++--
 drivers/vdpa/vdpa.c                      |  2 +-
 drivers/vdpa/vdpa_sim/vdpa_sim.c         |  2 +-
 drivers/vdpa/vdpa_user/vduse_dev.c       |  2 +-
 drivers/vdpa/virtio_pci/vp_vdpa.c        |  2 +-
 drivers/vhost/vdpa.c                     |  4 ++--
 drivers/virtio/virtio_vdpa.c             | 12 ++++++------
 include/linux/vdpa.h                     | 12 ++++++------
 14 files changed, 30 insertions(+), 30 deletions(-)

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
diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
index c7a20278bc3c..9175d7441fec 100644
--- a/drivers/vdpa/mlx5/core/mr.c
+++ b/drivers/vdpa/mlx5/core/mr.c
@@ -378,7 +378,7 @@ static int map_direct_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_direct_mr
 	u64 pa, offset;
 	u64 paend;
 	struct scatterlist *sg;
-	struct device *dma = mvdev->vdev.dma_dev;
+	struct device *dma = mvdev->vdev.map_token;
 
 	for (map = vhost_iotlb_itree_first(iotlb, mr->start, mr->end - 1);
 	     map; map = vhost_iotlb_itree_next(map, mr->start, mr->end - 1)) {
@@ -432,7 +432,7 @@ static int map_direct_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_direct_mr
 
 static void unmap_direct_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_direct_mr *mr)
 {
-	struct device *dma = mvdev->vdev.dma_dev;
+	struct device *dma = mvdev->vdev.map_token;
 
 	destroy_direct_mr(mvdev, mr);
 	dma_unmap_sg_attrs(dma, mr->sg_head.sgl, mr->nsg, DMA_BIDIRECTIONAL, 0);
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 0ed2fc28e1ce..1c2342942200 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -3395,14 +3395,14 @@ static int mlx5_vdpa_reset_map(struct vdpa_device *vdev, unsigned int asid)
 	return err;
 }
 
-static struct device *mlx5_get_vq_dma_dev(struct vdpa_device *vdev, u16 idx)
+static struct device *mlx5_get_vq_map_token(struct vdpa_device *vdev, u16 idx)
 {
 	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
 
 	if (is_ctrl_vq_idx(mvdev, idx))
 		return &vdev->dev;
 
-	return mvdev->vdev.dma_dev;
+	return mvdev->vdev.map_token;
 }
 
 static void free_irqs(struct mlx5_vdpa_net *ndev)
@@ -3686,7 +3686,7 @@ static const struct vdpa_config_ops mlx5_vdpa_ops = {
 	.set_map = mlx5_vdpa_set_map,
 	.reset_map = mlx5_vdpa_reset_map,
 	.set_group_asid = mlx5_set_group_asid,
-	.get_vq_dma_dev = mlx5_get_vq_dma_dev,
+	.get_vq_map_token = mlx5_get_vq_map_token,
 	.free = mlx5_vdpa_free,
 	.suspend = mlx5_vdpa_suspend,
 	.resume = mlx5_vdpa_resume, /* Op disabled if not supported. */
@@ -3965,7 +3965,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 	}
 
 	ndev->mvdev.mlx_features = device_features;
-	mvdev->vdev.dma_dev = &mdev->pdev->dev;
+	mvdev->vdev.map_token = &mdev->pdev->dev;
 	err = mlx5_vdpa_alloc_resources(&ndev->mvdev);
 	if (err)
 		goto err_alloc;
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
diff --git a/drivers/vdpa/pds/vdpa_dev.c b/drivers/vdpa/pds/vdpa_dev.c
index 301d95e08596..cff9c9811d8e 100644
--- a/drivers/vdpa/pds/vdpa_dev.c
+++ b/drivers/vdpa/pds/vdpa_dev.c
@@ -643,7 +643,7 @@ static int pds_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 
 	pdev = vdpa_aux->padev->vf_pdev;
 	dma_dev = &pdev->dev;
-	pdsv->vdpa_dev.dma_dev = dma_dev;
+	pdsv->vdpa_dev.map_token = dma_dev;
 
 	status = pds_vdpa_get_status(&pdsv->vdpa_dev);
 	if (status == 0xff) {
diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
index 55ec51c17ab3..1864fd1655ea 100644
--- a/drivers/vdpa/solidrun/snet_main.c
+++ b/drivers/vdpa/solidrun/snet_main.c
@@ -1052,8 +1052,8 @@ static int snet_vdpa_probe_vf(struct pci_dev *pdev)
 	 */
 	snet_reserve_irq_idx(pf_irqs ? pdev_pf : pdev, snet);
 
-	/*set DMA device*/
-	snet->vdpa.dma_dev = &pdev->dev;
+	/* set map token */
+	snet->vdpa.map_token = &pdev->dev;
 
 	/* Register VDPA device */
 	ret = vdpa_register_device(&snet->vdpa, snet->cfg->vq_num);
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
index 04620bb77203..cf4e3525aac4 100644
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
index dbf207cd3996..7b9bc123166d 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -133,7 +133,6 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 		     const char *name, bool ctx)
 {
 	struct vdpa_device *vdpa = vd_get_vdpa(vdev);
-	struct device *dma_dev;
 	const struct vdpa_config_ops *ops = vdpa->config;
 	bool (*notify)(struct virtqueue *vq) = virtio_vdpa_notify;
 	struct vdpa_callback cb;
@@ -143,6 +142,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 	struct vdpa_vq_state state = {0};
 	u32 align, max_num, min_num = 1;
 	bool may_reduce_num = true;
+	void *map_token;
 	int err;
 
 	if (!name)
@@ -181,13 +181,13 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
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
@@ -461,7 +461,7 @@ static int virtio_vdpa_probe(struct vdpa_device *vdpa)
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
2.47.3

