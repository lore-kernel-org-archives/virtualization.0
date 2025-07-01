Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E781D5154
	for <virtualization@lists.linux.dev>; Tue,  1 Jul 2025 01:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751332510; cv=none; b=fMI0UE0VCS/Z939dzKbURsOxVvrbB51KKP9RkQRSh7UycqnOOcaAyTh1nwjdpep1vN1ftXWs/bgs3RMAx9qv3QbVTe7gcvgykSLOZqBInrQTzKx/TTSk6ajIxpBMnHdgQIvV6HSkCUT7yvQCnQftk384RV/N6STICnGLZhahYR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751332510; c=relaxed/simple;
	bh=55/NSFXrWdEpV1D/v39C2nQXFEA1ZVHNlRY+nPen2Bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZNkPBHpmIWMcPFRcaN5dN0R0muqywors4P+d/31t879D/sljKogxJC8hO7poXMiZrfCPdoHvcti0xjxqR1v2+wAzOv+lH2vDfPSRZwbib9ctsNkMjctHMUB9lbd10xmwAozJGmiYThXwXbZURW/lQnLylv1pYOEr1geyjKexbb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZbdUYO6L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZbdUYO6L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751332507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=je3b8PIs0E6FvZBuxFcoFdovw4S2zeNhIppefR0E2Og=;
	b=ZbdUYO6LYn9MAvdbQRYzQqi/N8v8abcXe2ZN+FI2zxA3zHQD4HEl9ctQXTc5ZnlKWU8n+v
	ezrynJuCvXeqTcEQGnASsnxhcjBsRSllCSF/VxwNJzdNRkIyyJZmNcWMzyi6/JpbjXJV6O
	Hz+4OQ/fQxuCOSs6en5U38862hkCAHE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-58y2rdvZP9enLAN_heBbAQ-1; Mon,
 30 Jun 2025 21:15:01 -0400
X-MC-Unique: 58y2rdvZP9enLAN_heBbAQ-1
X-Mimecast-MFC-AGG-ID: 58y2rdvZP9enLAN_heBbAQ_1751332500
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 935DF19560A2;
	Tue,  1 Jul 2025 01:15:00 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.134])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 866EE30001B5;
	Tue,  1 Jul 2025 01:14:54 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	hch@infradead.org,
	xieyongji@bytedance.com
Subject: [PATCH 8/9] vdpa: introduce map ops
Date: Tue,  1 Jul 2025 09:14:00 +0800
Message-ID: <20250701011401.74851-9-jasowang@redhat.com>
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

Virtio core allows the transport to provide device or transport
specific mapping functions. This patch adds this support to vDPA. We
can simply do this by allowing the vDPA parent to register a
virtio_map_ops.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/alibaba/eni_vdpa.c          |  3 ++-
 drivers/vdpa/ifcvf/ifcvf_main.c          |  3 ++-
 drivers/vdpa/octeon_ep/octep_vdpa_main.c |  4 ++--
 drivers/vdpa/pds/vdpa_dev.c              |  3 ++-
 drivers/vdpa/solidrun/snet_main.c        |  4 ++--
 drivers/vdpa/vdpa.c                      |  3 +++
 drivers/vdpa/vdpa_sim/vdpa_sim.c         |  2 +-
 drivers/vdpa/vdpa_user/iova_domain.c     |  6 ++++++
 drivers/vdpa/vdpa_user/iova_domain.h     |  3 +++
 drivers/vdpa/vdpa_user/vduse_dev.c       |  3 ++-
 drivers/vdpa/virtio_pci/vp_vdpa.c        |  3 ++-
 drivers/vhost/vdpa.c                     |  9 ++++++++-
 drivers/virtio/virtio_vdpa.c             |  1 +
 include/linux/vdpa.h                     | 10 +++++++---
 14 files changed, 43 insertions(+), 14 deletions(-)

diff --git a/drivers/vdpa/alibaba/eni_vdpa.c b/drivers/vdpa/alibaba/eni_vdpa.c
index 34bf726dc660..4ddf23065087 100644
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
index 64d28ec97136..1bc22020d0cc 100644
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
diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_main.c b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
index 42a4df4613dd..bb4a68b6cce5 100644
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
index 301d95e08596..d2a017697827 100644
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
index 55ec51c17ab3..46f1743eb9f5 100644
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
index 1cc4285ebd67..2715ffcda585 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -142,6 +142,7 @@ static void vdpa_release_dev(struct device *d)
  * initialized but before registered.
  * @parent: the parent device
  * @config: the bus operations that is supported by this device
+ * @map: the map opeartions that is supported by this device
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
index 7c8e468f2f8c..89a795e2a44b 100644
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
diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
index 58116f89d8da..019f3305c0ac 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.c
+++ b/drivers/vdpa/vdpa_user/iova_domain.c
@@ -506,6 +506,12 @@ void vduse_domain_free_coherent(struct vduse_iova_domain *domain, size_t size,
 	free_pages_exact(phys_to_virt(pa), size);
 }
 
+bool vduse_domain_need_sync(struct vduse_iova_domain *domain,
+			    dma_addr_t dma_addr)
+{
+	return dma_addr < domain->bounce_size;
+}
+
 static vm_fault_t vduse_domain_mmap_fault(struct vm_fault *vmf)
 {
 	struct vduse_iova_domain *domain = vmf->vma->vm_private_data;
diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa_user/iova_domain.h
index 7f3f0928ec78..846572b95c23 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.h
+++ b/drivers/vdpa/vdpa_user/iova_domain.h
@@ -70,6 +70,9 @@ void vduse_domain_free_coherent(struct vduse_iova_domain *domain, size_t size,
 				void *vaddr, dma_addr_t dma_addr,
 				unsigned long attrs);
 
+bool vduse_domain_need_sync(struct vduse_iova_domain *domain,
+			    dma_addr_t dma_addr);
+
 void vduse_domain_reset_bounce_map(struct vduse_iova_domain *domain);
 
 int vduse_domain_add_user_bounce_pages(struct vduse_iova_domain *domain,
diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 7420e90488ef..64bc39722007 100644
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
index 6e22e95245fa..395996ec4608 100644
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
diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 732ed118c138..4932271899ea 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -1320,13 +1320,20 @@ static int vhost_vdpa_alloc_domain(struct vhost_vdpa *v)
 {
 	struct vdpa_device *vdpa = v->vdpa;
 	const struct vdpa_config_ops *ops = vdpa->config;
-	struct device *dma_dev = vdpa_get_map_token(vdpa);
+	const struct virtio_map_ops *map = vdpa->map;
+	struct device *dma_dev;
 	int ret;
 
 	/* Device want to do DMA by itself */
 	if (ops->set_map || ops->dma_map)
 		return 0;
 
+	if (map) {
+		dev_warn(&v->dev, "Can't allocate a domian, device use vendor specific mappings\n");
+		return -EINVAL;
+	}
+
+	dma_dev = vdpa_get_map_token(vdpa);
 	if (!device_iommu_capable(dma_dev, IOMMU_CAP_CACHE_COHERENCY)) {
 		dev_warn_once(&v->dev,
 			      "Failed to allocate domain, device is not IOMMU cache coherent capable\n");
diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index cb68458cd809..286b60ce3637 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -500,6 +500,7 @@ static int virtio_vdpa_probe(struct vdpa_device *vdpa)
 	vd_dev->vdev.dev.parent = vdpa_get_map_token(vdpa);
 	vd_dev->vdev.dev.release = virtio_vdpa_release_dev;
 	vd_dev->vdev.config = &virtio_vdpa_config_ops;
+	vd_dev->vdev.map = vdpa->map;
 	vd_dev->vdpa = vdpa;
 	INIT_LIST_HEAD(&vd_dev->virtqueues);
 	spin_lock_init(&vd_dev->lock);
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 352ca5609c9a..cb51b7e2e569 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -75,6 +75,7 @@ struct vdpa_mgmt_dev;
  *                   because core frees it; use driver_set_override() to
  *                   set or clear it.
  * @config: the configuration ops for this device.
+ * @map: the map ops for this device
  * @cf_lock: Protects get and set access to configuration layout.
  * @index: device index
  * @features_valid: were features initialized? for legacy guests
@@ -90,6 +91,7 @@ struct vdpa_device {
 	void *map_token;
 	const char *driver_override;
 	const struct vdpa_config_ops *config;
+	const struct virtio_map_ops *map;
 	struct rw_semaphore cf_lock; /* Protects get/set config */
 	unsigned int index;
 	bool features_valid;
@@ -446,6 +448,7 @@ struct vdpa_config_ops {
 
 struct vdpa_device *__vdpa_alloc_device(struct device *parent,
 					const struct vdpa_config_ops *config,
+					const struct virtio_map_ops *map,
 					unsigned int ngroups, unsigned int nas,
 					size_t size, const char *name,
 					bool use_va);
@@ -457,6 +460,7 @@ struct vdpa_device *__vdpa_alloc_device(struct device *parent,
  * @member: the name of struct vdpa_device within the @dev_struct
  * @parent: the parent device
  * @config: the bus operations that is supported by this device
+ * @map: the map operations that is supported by this device
  * @ngroups: the number of virtqueue groups supported by this device
  * @nas: the number of address spaces
  * @name: name of the vdpa device
@@ -464,10 +468,10 @@ struct vdpa_device *__vdpa_alloc_device(struct device *parent,
  *
  * Return allocated data structure or ERR_PTR upon error
  */
-#define vdpa_alloc_device(dev_struct, member, parent, config, ngroups, nas, \
-			  name, use_va) \
+#define vdpa_alloc_device(dev_struct, member, parent, config, map, \
+	                  ngroups, nas, name, use_va) \
 			  container_of((__vdpa_alloc_device( \
-				       parent, config, ngroups, nas, \
+				       parent, config, map, ngroups, nas, \
 				       (sizeof(dev_struct) + \
 				       BUILD_BUG_ON_ZERO(offsetof( \
 				       dev_struct, member))), name, use_va)), \
-- 
2.34.1

