Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADBF26A0DB
	for <virtualization@lists.linux.dev>; Wed, 24 Sep 2025 07:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758697265; cv=none; b=L9RkCWB/0l96M3UxVFe9IlfIPMAtChIjemPhkVxzrbtGUdE6uY3MDMnTE8n0SBt8YWCR6KK2PZ+UckhDEFywf8sRxRIpJbl9WQYjSisHA4O874ozzOrdT9tdV51Pru+cBRN0vpwbZJGG04OR0DVsRTU3N1rjxqD2iefW66EbjcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758697265; c=relaxed/simple;
	bh=lFMTZtgXG2W5MMhPbM+M5RsqnWrxHr2A+AmhHwVWhk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n/2us+Oe7Bb2C0FRptXGxP8aM8P7mIuvfruKCoKVpaAvikDmJYyUJtMSkMLRI2bV3hcG1i4dYm+Sp3QMDNiYLK1iDlZuAkXWyU2IcnlUnyyAulE2POa8c4hybrncvGPxNoyQP5fGJUMG0smr7Mdvwd03mMiyaYyaynZNxO0YbjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=al6WFfVf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="al6WFfVf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758697262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F4scP4nkkJB/ykH0o3geV2MoMx4np23FbBzlUsofvFQ=;
	b=al6WFfVfaq7MRmRnqM7Vy/XcykrWeApWWn9PNa/UFXvn/Ew6uqa3LGDlGf3+BGw+TM1q0n
	/vAhmDVM+Yl7nDpvPq9xzb9fdjJZop7ynN6ZxDdknziQtBJF4ljo1UZXijemEVbU81Y9vi
	OaOZpVXmtZBKiPN0O0bfeKEeBrHwsl8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-E5Xj1TZQN9yfnqirq8mIuQ-1; Wed,
 24 Sep 2025 03:00:58 -0400
X-MC-Unique: E5Xj1TZQN9yfnqirq8mIuQ-1
X-Mimecast-MFC-AGG-ID: E5Xj1TZQN9yfnqirq8mIuQ_1758697257
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 13ECA18002E9;
	Wed, 24 Sep 2025 07:00:57 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.172])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 31FC930002C5;
	Wed, 24 Sep 2025 07:00:52 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH V7 1/2] vdpa: introduce map ops
Date: Wed, 24 Sep 2025 15:00:44 +0800
Message-ID: <20250924070045.10361-2-jasowang@redhat.com>
In-Reply-To: <20250924070045.10361-1-jasowang@redhat.com>
References: <20250924070045.10361-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Virtio core allows the transport to provide device or transport
specific mapping functions. This patch adds this support to vDPA. We
can simply do this by allowing the vDPA parent to register a
virtio_map_ops.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/alibaba/eni_vdpa.c          |  3 ++-
 drivers/vdpa/ifcvf/ifcvf_main.c          |  3 ++-
 drivers/vdpa/mlx5/net/mlx5_vnet.c        |  2 +-
 drivers/vdpa/octeon_ep/octep_vdpa_main.c |  4 ++--
 drivers/vdpa/pds/vdpa_dev.c              |  3 ++-
 drivers/vdpa/solidrun/snet_main.c        |  4 ++--
 drivers/vdpa/vdpa.c                      |  3 +++
 drivers/vdpa/vdpa_sim/vdpa_sim.c         |  2 +-
 drivers/vdpa/vdpa_user/vduse_dev.c       |  3 ++-
 drivers/vdpa/virtio_pci/vp_vdpa.c        |  3 ++-
 drivers/virtio/virtio_vdpa.c             |  4 +++-
 include/linux/vdpa.h                     | 10 +++++++---
 12 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/drivers/vdpa/alibaba/eni_vdpa.c b/drivers/vdpa/alibaba/eni_vdpa.c
index 54aea086d08c..e476504db0c8 100644
--- a/drivers/vdpa/alibaba/eni_vdpa.c
+++ b/drivers/vdpa/alibaba/eni_vdpa.c
@@ -478,7 +478,8 @@ static int eni_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return ret;
 
 	eni_vdpa = vdpa_alloc_device(struct eni_vdpa, vdpa,
-				     dev, &eni_vdpa_ops, 1, 1, NULL, false);
+				     dev, &eni_vdpa_ops, NULL,
+				     1, 1, NULL, false);
 	if (IS_ERR(eni_vdpa)) {
 		ENI_ERR(pdev, "failed to allocate vDPA structure\n");
 		return PTR_ERR(eni_vdpa);
diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index 979d188d74ee..6658dc74d915 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -705,7 +705,8 @@ static int ifcvf_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	vf = &ifcvf_mgmt_dev->vf;
 	pdev = vf->pdev;
 	adapter = vdpa_alloc_device(struct ifcvf_adapter, vdpa,
-				    &pdev->dev, &ifc_vdpa_ops, 1, 1, NULL, false);
+				    &pdev->dev, &ifc_vdpa_ops,
+				    NULL, 1, 1, NULL, false);
 	if (IS_ERR(adapter)) {
 		IFCVF_ERR(pdev, "Failed to allocate vDPA structure");
 		return PTR_ERR(adapter);
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index a7e76f175914..82034efb74fc 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -3882,7 +3882,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 	}
 
 	ndev = vdpa_alloc_device(struct mlx5_vdpa_net, mvdev.vdev, mdev->device, &mgtdev->vdpa_ops,
-				 MLX5_VDPA_NUMVQ_GROUPS, MLX5_VDPA_NUM_AS, name, false);
+				 NULL, MLX5_VDPA_NUMVQ_GROUPS, MLX5_VDPA_NUM_AS, name, false);
 	if (IS_ERR(ndev))
 		return PTR_ERR(ndev);
 
diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_main.c b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
index 5818dae133a3..9e8d07078606 100644
--- a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
+++ b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
@@ -508,8 +508,8 @@ static int octep_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	u64 device_features;
 	int ret;
 
-	oct_vdpa = vdpa_alloc_device(struct octep_vdpa, vdpa, &pdev->dev, &octep_vdpa_ops, 1, 1,
-				     NULL, false);
+	oct_vdpa = vdpa_alloc_device(struct octep_vdpa, vdpa, &pdev->dev, &octep_vdpa_ops,
+				     NULL, 1, 1, NULL, false);
 	if (IS_ERR(oct_vdpa)) {
 		dev_err(&pdev->dev, "Failed to allocate vDPA structure for octep vdpa device");
 		return PTR_ERR(oct_vdpa);
diff --git a/drivers/vdpa/pds/vdpa_dev.c b/drivers/vdpa/pds/vdpa_dev.c
index 63d82263fb52..36f61cc96e21 100644
--- a/drivers/vdpa/pds/vdpa_dev.c
+++ b/drivers/vdpa/pds/vdpa_dev.c
@@ -632,7 +632,8 @@ static int pds_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	}
 
 	pdsv = vdpa_alloc_device(struct pds_vdpa_device, vdpa_dev,
-				 dev, &pds_vdpa_ops, 1, 1, name, false);
+				 dev, &pds_vdpa_ops, NULL,
+				 1, 1, name, false);
 	if (IS_ERR(pdsv)) {
 		dev_err(dev, "Failed to allocate vDPA structure: %pe\n", pdsv);
 		return PTR_ERR(pdsv);
diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
index 39050aab147f..4588211d57eb 100644
--- a/drivers/vdpa/solidrun/snet_main.c
+++ b/drivers/vdpa/solidrun/snet_main.c
@@ -1008,8 +1008,8 @@ static int snet_vdpa_probe_vf(struct pci_dev *pdev)
 	}
 
 	/* Allocate vdpa device */
-	snet = vdpa_alloc_device(struct snet, vdpa, &pdev->dev, &snet_config_ops, 1, 1, NULL,
-				 false);
+	snet = vdpa_alloc_device(struct snet, vdpa, &pdev->dev, &snet_config_ops,
+				 NULL, 1, 1, NULL, false);
 	if (!snet) {
 		SNET_ERR(pdev, "Failed to allocate a vdpa device\n");
 		ret = -ENOMEM;
diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index c71debeb8471..34874beb0152 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -142,6 +142,7 @@ static void vdpa_release_dev(struct device *d)
  * initialized but before registered.
  * @parent: the parent device
  * @config: the bus operations that is supported by this device
+ * @map: the map operations that is supported by this device
  * @ngroups: number of groups supported by this device
  * @nas: number of address spaces supported by this device
  * @size: size of the parent structure that contains private data
@@ -156,6 +157,7 @@ static void vdpa_release_dev(struct device *d)
  */
 struct vdpa_device *__vdpa_alloc_device(struct device *parent,
 					const struct vdpa_config_ops *config,
+					const struct virtio_map_ops *map,
 					unsigned int ngroups, unsigned int nas,
 					size_t size, const char *name,
 					bool use_va)
@@ -187,6 +189,7 @@ struct vdpa_device *__vdpa_alloc_device(struct device *parent,
 	vdev->dev.release = vdpa_release_dev;
 	vdev->index = err;
 	vdev->config = config;
+	vdev->map = map;
 	vdev->features_valid = false;
 	vdev->use_va = use_va;
 	vdev->ngroups = ngroups;
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 22ee53538444..c1c6431950e1 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -215,7 +215,7 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
 	else
 		ops = &vdpasim_config_ops;
 
-	vdpa = __vdpa_alloc_device(NULL, ops,
+	vdpa = __vdpa_alloc_device(NULL, ops, NULL,
 				   dev_attr->ngroups, dev_attr->nas,
 				   dev_attr->alloc_size,
 				   dev_attr->name, use_va);
diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index f68ed569394c..ad782d20a8ed 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -2009,7 +2009,8 @@ static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *name)
 		return -EEXIST;
 
 	vdev = vdpa_alloc_device(struct vduse_vdpa, vdpa, dev->dev,
-				 &vduse_vdpa_config_ops, 1, 1, name, true);
+				 &vduse_vdpa_config_ops, NULL,
+				 1, 1, name, true);
 	if (IS_ERR(vdev))
 		return PTR_ERR(vdev);
 
diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
index 242641c0f2bd..17a19a728c9c 100644
--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
@@ -511,7 +511,8 @@ static int vp_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 	int ret, i;
 
 	vp_vdpa = vdpa_alloc_device(struct vp_vdpa, vdpa,
-				    dev, &vp_vdpa_ops, 1, 1, name, false);
+				    dev, &vp_vdpa_ops, NULL,
+				    1, 1, name, false);
 
 	if (IS_ERR(vp_vdpa)) {
 		dev_err(dev, "vp_vdpa: Failed to allocate vDPA structure\n");
diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index 8b27c6e8eebb..2464fa655f09 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -466,9 +466,11 @@ static int virtio_vdpa_probe(struct vdpa_device *vdpa)
 	if (!vd_dev)
 		return -ENOMEM;
 
-	vd_dev->vdev.dev.parent = vdpa_get_map(vdpa).dma_dev;
+	vd_dev->vdev.dev.parent = vdpa->map ? &vdpa->dev :
+				  vdpa_get_map(vdpa).dma_dev;
 	vd_dev->vdev.dev.release = virtio_vdpa_release_dev;
 	vd_dev->vdev.config = &virtio_vdpa_config_ops;
+	vd_dev->vdev.map = vdpa->map;
 	vd_dev->vdpa = vdpa;
 
 	vd_dev->vdev.id.device = ops->get_device_id(vdpa);
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index ae0451945851..4cf21d6e9cfd 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -76,6 +76,7 @@ struct vdpa_mgmt_dev;
  *                   because core frees it; use driver_set_override() to
  *                   set or clear it.
  * @config: the configuration ops for this device.
+ * @map: the map ops for this device
  * @cf_lock: Protects get and set access to configuration layout.
  * @index: device index
  * @features_valid: were features initialized? for legacy guests
@@ -91,6 +92,7 @@ struct vdpa_device {
 	union virtio_map vmap;
 	const char *driver_override;
 	const struct vdpa_config_ops *config;
+	const struct virtio_map_ops *map;
 	struct rw_semaphore cf_lock; /* Protects get/set config */
 	unsigned int index;
 	bool features_valid;
@@ -447,6 +449,7 @@ struct vdpa_config_ops {
 
 struct vdpa_device *__vdpa_alloc_device(struct device *parent,
 					const struct vdpa_config_ops *config,
+					const struct virtio_map_ops *map,
 					unsigned int ngroups, unsigned int nas,
 					size_t size, const char *name,
 					bool use_va);
@@ -458,6 +461,7 @@ struct vdpa_device *__vdpa_alloc_device(struct device *parent,
  * @member: the name of struct vdpa_device within the @dev_struct
  * @parent: the parent device
  * @config: the bus operations that is supported by this device
+ * @map: the map operations that is supported by this device
  * @ngroups: the number of virtqueue groups supported by this device
  * @nas: the number of address spaces
  * @name: name of the vdpa device
@@ -465,10 +469,10 @@ struct vdpa_device *__vdpa_alloc_device(struct device *parent,
  *
  * Return allocated data structure or ERR_PTR upon error
  */
-#define vdpa_alloc_device(dev_struct, member, parent, config, ngroups, nas, \
-			  name, use_va) \
+#define vdpa_alloc_device(dev_struct, member, parent, config, map, \
+			  ngroups, nas, name, use_va)		   \
 			  container_of((__vdpa_alloc_device( \
-				       parent, config, ngroups, nas, \
+				       parent, config, map, ngroups, nas, \
 				       (sizeof(dev_struct) + \
 				       BUILD_BUG_ON_ZERO(offsetof( \
 				       dev_struct, member))), name, use_va)), \
-- 
2.31.1

