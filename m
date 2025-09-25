Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFD32EA48D
	for <virtualization@lists.linux.dev>; Thu, 25 Sep 2025 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758791645; cv=none; b=DEY8V9fcv/T/2e+drwy2FlT3wWq8tRx2h2kndGh5e1oH5bFAy+m5WIsgEr2tlJxXZn0stJguNAeyE9HeuADvqi7mLpUhYnYZBnQrYYCwy3cngBqDR9Ma9EJxL5nt4jFavjypGECp+X8EXorpx0kzYf0IOXViDquJ8uLtuvTUwd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758791645; c=relaxed/simple;
	bh=KAEfgx/PxGp9Cd76wUYkI9/tLWrZaK6cVM17Ag95Hmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hQRnqAeVbBKUEdVh1ruHGN8+ZZBKgbyT2/y14PiDvd0sVSR+cnMDkaGdgB+Baf3TqYJQ6MP8iAPcW87kms1o2cDRgcAOwclYdfbJvN/SSfKNYmT3DdB3eOsHLwNOUAEqRR4Rxli/Xk4jjDRHNJCWRzKFrPGhEQkGFwQP4JP/WQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B7PRKisH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B7PRKisH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758791643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vFDohAWMr3M+CS9AK9V8RULtrfyu8taRnnsTmEogmWw=;
	b=B7PRKisHe4J2nCQjTWSzBqdLGO2DqJpar6E0mj5AxkmbHwStvfAXao6SyYPmcmqnCyl8GX
	Tz/tP+dgOSoJ/hkdC1kEO0qcCFSXFUoR/c0j8Cx3Zc1SkCx1o0TfCwGZ+cF4twoJrUcBPU
	uA70nIwDHSHe8T/NTpn/8GUA29uTmts=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-97-4TMzv9-qPHWHskRPGW9DXA-1; Thu,
 25 Sep 2025 05:14:00 -0400
X-MC-Unique: 4TMzv9-qPHWHskRPGW9DXA-1
X-Mimecast-MFC-AGG-ID: 4TMzv9-qPHWHskRPGW9DXA_1758791639
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6B03E1800378;
	Thu, 25 Sep 2025 09:13:59 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.91])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AD5141956095;
	Thu, 25 Sep 2025 09:13:55 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>,
	Cindy Lu <lulu@redhat.com>,
	jasowang@redhat.com,
	linux-kernel@vger.kernel.org,
	Maxime Coquelin <mcoqueli@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Laurent Vivier <lvivier@redhat.com>,
	virtualization@lists.linux.dev,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v4 4/6] vduse: return internal vq group struct as map token
Date: Thu, 25 Sep 2025 11:13:33 +0200
Message-ID: <20250925091335.1964283-5-eperezma@redhat.com>
In-Reply-To: <20250925091335.1964283-1-eperezma@redhat.com>
References: <20250925091335.1964283-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Return the internal struct that represents the vq group as virtqueue map
token, instead of the device.  This allows the map functions to access
the information per group.

At this moment all the virtqueues share the same vq group, that only
can point to ASID 0.  This change prepares the infrastructure for actual
per-group address space handling

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
v4:
* Revert the "invalid vq group" concept, and assume 0 by default.
* Revert unnecesary blank line addition (Jason)

v3:
* Adapt all virtio_map_ops callbacks to handle empty tokens in case of
  invalid groups.
* Make setting status DRIVER_OK fail if vq group is not valid.
* Remove the _int name suffix from struct vduse_vq_group.

RFC v3:
* Make the vq groups a dynamic array to support an arbitrary number of
  them.
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 100 ++++++++++++++++++++++++++---
 include/linux/virtio.h             |   6 +-
 2 files changed, 94 insertions(+), 12 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 3415217cb3a9..b181ea342592 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -23,6 +23,7 @@
 #include <linux/uio.h>
 #include <linux/vdpa.h>
 #include <linux/nospec.h>
+#include <linux/virtio.h>
 #include <linux/vmalloc.h>
 #include <linux/sched/mm.h>
 #include <uapi/linux/vduse.h>
@@ -86,6 +87,10 @@ struct vduse_umem {
 	struct mm_struct *mm;
 };
 
+struct vduse_vq_group {
+	struct vduse_dev *dev;
+};
+
 struct vduse_dev {
 	struct vduse_vdpa *vdev;
 	struct device *dev;
@@ -119,6 +124,7 @@ struct vduse_dev {
 	u32 vq_align;
 	u32 ngroups;
 	struct vduse_umem *umem;
+	struct vduse_vq_group *groups;
 	struct mutex mem_lock;
 	unsigned int bounce_size;
 	rwlock_t domain_lock;
@@ -607,6 +613,17 @@ static u32 vduse_get_vq_group(struct vdpa_device *vdpa, u16 idx)
 	return dev->vqs[idx]->vq_group;
 }
 
+static union virtio_map vduse_get_vq_map(struct vdpa_device *vdpa, u16 idx)
+{
+	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
+	u32 vq_group = vduse_get_vq_group(vdpa, idx);
+	union virtio_map ret = {
+		.group = &dev->groups[vq_group],
+	};
+
+	return ret;
+}
+
 static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx,
 				struct vdpa_vq_state *state)
 {
@@ -827,6 +844,7 @@ static const struct vdpa_config_ops vduse_vdpa_config_ops = {
 	.get_vq_affinity	= vduse_vdpa_get_vq_affinity,
 	.reset			= vduse_vdpa_reset,
 	.set_map		= vduse_vdpa_set_map,
+	.get_vq_map		= vduse_get_vq_map,
 	.free			= vduse_vdpa_free,
 };
 
@@ -834,7 +852,14 @@ static void vduse_dev_sync_single_for_device(union virtio_map token,
 					     dma_addr_t dma_addr, size_t size,
 					     enum dma_data_direction dir)
 {
-	struct vduse_iova_domain *domain = token.iova_domain;
+	struct vduse_dev *vdev;
+	struct vduse_iova_domain *domain;
+
+	if (!token.group)
+		return;
+
+	vdev = token.group->dev;
+	domain = vdev->domain;
 
 	vduse_domain_sync_single_for_device(domain, dma_addr, size, dir);
 }
@@ -843,7 +868,14 @@ static void vduse_dev_sync_single_for_cpu(union virtio_map token,
 					     dma_addr_t dma_addr, size_t size,
 					     enum dma_data_direction dir)
 {
-	struct vduse_iova_domain *domain = token.iova_domain;
+	struct vduse_dev *vdev;
+	struct vduse_iova_domain *domain;
+
+	if (!token.group)
+		return;
+
+	vdev = token.group->dev;
+	domain = vdev->domain;
 
 	vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir);
 }
@@ -853,7 +885,14 @@ static dma_addr_t vduse_dev_map_page(union virtio_map token, struct page *page,
 				     enum dma_data_direction dir,
 				     unsigned long attrs)
 {
-	struct vduse_iova_domain *domain = token.iova_domain;
+	struct vduse_dev *vdev;
+	struct vduse_iova_domain *domain;
+
+	if (!token.group)
+		return DMA_MAPPING_ERROR;
+
+	vdev = token.group->dev;
+	domain = vdev->domain;
 
 	return vduse_domain_map_page(domain, page, offset, size, dir, attrs);
 }
@@ -862,7 +901,14 @@ static void vduse_dev_unmap_page(union virtio_map token, dma_addr_t dma_addr,
 				 size_t size, enum dma_data_direction dir,
 				 unsigned long attrs)
 {
-	struct vduse_iova_domain *domain = token.iova_domain;
+	struct vduse_dev *vdev;
+	struct vduse_iova_domain *domain;
+
+	if (!token.group)
+		return;
+
+	vdev = token.group->dev;
+	domain = vdev->domain;
 
 	return vduse_domain_unmap_page(domain, dma_addr, size, dir, attrs);
 }
@@ -870,11 +916,17 @@ static void vduse_dev_unmap_page(union virtio_map token, dma_addr_t dma_addr,
 static void *vduse_dev_alloc_coherent(union virtio_map token, size_t size,
 				      dma_addr_t *dma_addr, gfp_t flag)
 {
-	struct vduse_iova_domain *domain = token.iova_domain;
+	struct vduse_dev *vdev;
+	struct vduse_iova_domain *domain;
 	unsigned long iova;
 	void *addr;
 
 	*dma_addr = DMA_MAPPING_ERROR;
+	if (!token.group)
+		return NULL;
+
+	vdev = token.group->dev;
+	domain = vdev->domain;
 	addr = vduse_domain_alloc_coherent(domain, size,
 					   (dma_addr_t *)&iova, flag);
 	if (!addr)
@@ -889,14 +941,28 @@ static void vduse_dev_free_coherent(union virtio_map token, size_t size,
 				    void *vaddr, dma_addr_t dma_addr,
 				    unsigned long attrs)
 {
-	struct vduse_iova_domain *domain = token.iova_domain;
+	struct vduse_dev *vdev;
+	struct vduse_iova_domain *domain;
+
+	if (!token.group)
+		return;
+
+	vdev = token.group->dev;
+	domain = vdev->domain;
 
 	vduse_domain_free_coherent(domain, size, vaddr, dma_addr, attrs);
 }
 
 static bool vduse_dev_need_sync(union virtio_map token, dma_addr_t dma_addr)
 {
-	struct vduse_iova_domain *domain = token.iova_domain;
+	struct vduse_dev *vdev;
+	struct vduse_iova_domain *domain;
+
+	if (!token.group)
+		return false;
+
+	vdev = token.group->dev;
+	domain = vdev->domain;
 
 	return dma_addr < domain->bounce_size;
 }
@@ -910,7 +976,14 @@ static int vduse_dev_mapping_error(union virtio_map token, dma_addr_t dma_addr)
 
 static size_t vduse_dev_max_mapping_size(union virtio_map token)
 {
-	struct vduse_iova_domain *domain = token.iova_domain;
+	struct vduse_dev *vdev;
+	struct vduse_iova_domain *domain;
+
+	if (!token.group)
+		return 0;
+
+	vdev = token.group->dev;
+	domain = vdev->domain;
 
 	return domain->bounce_size;
 }
@@ -1728,6 +1801,7 @@ static int vduse_destroy_dev(char *name)
 	if (dev->domain)
 		vduse_domain_destroy(dev->domain);
 	kfree(dev->name);
+	kfree(dev->groups);
 	vduse_dev_destroy(dev);
 	module_put(THIS_MODULE);
 
@@ -1895,6 +1969,13 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 	dev->device_id = config->device_id;
 	dev->vendor_id = config->vendor_id;
 	dev->ngroups = (dev->api_version < 1) ? 1 : config->ngroups;
+	dev->groups = kcalloc(dev->ngroups, sizeof(dev->groups[0]),
+			      GFP_KERNEL);
+	if (!dev->groups)
+		goto err_vq_groups;
+	for (u32 i = 0; i < dev->ngroups; ++i)
+		dev->groups[i].dev = dev;
+
 	dev->name = kstrdup(config->name, GFP_KERNEL);
 	if (!dev->name)
 		goto err_str;
@@ -1931,6 +2012,8 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 err_idr:
 	kfree(dev->name);
 err_str:
+	kfree(dev->groups);
+err_vq_groups:
 	vduse_dev_destroy(dev);
 err:
 	return ret;
@@ -2092,7 +2175,6 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 		return -ENOMEM;
 	}
 
-	dev->vdev->vdpa.vmap.iova_domain = dev->domain;
 	ret = _vdpa_register_device(&dev->vdev->vdpa, dev->vq_num);
 	if (ret) {
 		put_device(&dev->vdev->vdpa.dev);
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 96c66126c074..302109029700 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -41,13 +41,13 @@ struct virtqueue {
 	void *priv;
 };
 
-struct vduse_iova_domain;
+struct vduse_vq_group;
 
 union virtio_map {
 	/* Device that performs DMA */
 	struct device *dma_dev;
-	/* VDUSE specific mapping data */
-	struct vduse_iova_domain *iova_domain;
+	/* VDUSE specific virtqueue group for doing map */
+	struct vduse_vq_group *group;
 };
 
 int virtqueue_add_outbuf(struct virtqueue *vq,
-- 
2.51.0

