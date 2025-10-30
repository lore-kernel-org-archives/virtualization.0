Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D02634F48D
	for <virtualization@lists.linux.dev>; Thu, 30 Oct 2025 10:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761818453; cv=none; b=uOs9Seyn1l/i4ayv2D+rP96o2wpk8gEWMjc4NNnLKDTn0Rw2G4Nis5wJz6dET6d9QHXBA1JJrog3KO+vnpgCpAlFCgMkvZllx6KE/3eQ0mTb7tvDeLie6zCW9cyvfz/7N+JApozGlPzaPFdd9O1sIx1NLeS+Wb0B5FGQHDssBUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761818453; c=relaxed/simple;
	bh=DsAtaD9n7kgxNXdZYKnrP7bmwe5mMuhuMm5n6YWx+Us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dxbyJqKI/YB+ItXaW8o43YLPh+7vE78vjhZETArjRYkyQ3Dtr2LkJSsAYNlwF58SWsTTshUoFqkeYo+au/s4OPApQp3dhA02ShAxso+Pn2U1YcZhapbecXfnKYPqx685+y3TA5qGu5xts6Ib7HgjGJneHQXug1gvKDTzHSFUGy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M1S32aAZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M1S32aAZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761818450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cKFV76Uxska8wIFsfVvZ/UIpn6HNXWgh4kZ14k2wRbQ=;
	b=M1S32aAZorJ3ojwcEsLffGQ5O2vxcYH1m/BQbvLF4n7m3ZYb99aJ/cL/Bt28rc1tAW1mva
	2gCjwlu+kJm3Dchnd1lte/KiPOp6bu3/oXBdZkDTwimHGGvzEIXnbiDkOPQ90Pq6EBgac9
	oBj5Lm5kb0bOOZoTQNx5TdqLbE8sgRI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-79-zzXcoF9nMdigbe0NTJ_UHw-1; Thu,
 30 Oct 2025 06:00:47 -0400
X-MC-Unique: zzXcoF9nMdigbe0NTJ_UHw-1
X-Mimecast-MFC-AGG-ID: zzXcoF9nMdigbe0NTJ_UHw_1761818446
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3EE3A180AE12;
	Thu, 30 Oct 2025 10:00:46 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.22])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 549BE19560B6;
	Thu, 30 Oct 2025 10:00:41 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: Yongji Xie <xieyongji@bytedance.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>,
	Maxime Coquelin <mcoqueli@redhat.com>,
	virtualization@lists.linux.dev,
	Stefano Garzarella <sgarzare@redhat.com>,
	jasowang@redhat.com,
	Cindy Lu <lulu@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 3/6] vduse: return internal vq group struct as map token
Date: Thu, 30 Oct 2025 11:00:22 +0100
Message-ID: <20251030100025.95113-4-eperezma@redhat.com>
In-Reply-To: <20251030100025.95113-1-eperezma@redhat.com>
References: <20251030100025.95113-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Return the internal struct that represents the vq group as virtqueue map
token, instead of the device.  This allows the map functions to access
the information per group.

At this moment all the virtqueues share the same vq group, that only
can point to ASID 0.  This change prepares the infrastructure for actual
per-group address space handling

Acked-by: Jason Wang <jasowang@redhat.com>
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
index d5c90c599698..b01f55a1c22d 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -22,6 +22,7 @@
 #include <linux/uio.h>
 #include <linux/vdpa.h>
 #include <linux/nospec.h>
+#include <linux/virtio.h>
 #include <linux/vmalloc.h>
 #include <linux/sched/mm.h>
 #include <uapi/linux/vduse.h>
@@ -85,6 +86,10 @@ struct vduse_umem {
 	struct mm_struct *mm;
 };
 
+struct vduse_vq_group {
+	struct vduse_dev *dev;
+};
+
 struct vduse_dev {
 	struct vduse_vdpa *vdev;
 	struct device *dev;
@@ -118,6 +123,7 @@ struct vduse_dev {
 	u32 vq_align;
 	u32 ngroups;
 	struct vduse_umem *umem;
+	struct vduse_vq_group *groups;
 	struct mutex mem_lock;
 	unsigned int bounce_size;
 	struct mutex domain_lock;
@@ -606,6 +612,17 @@ static u32 vduse_get_vq_group(struct vdpa_device *vdpa, u16 idx)
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
@@ -826,6 +843,7 @@ static const struct vdpa_config_ops vduse_vdpa_config_ops = {
 	.get_vq_affinity	= vduse_vdpa_get_vq_affinity,
 	.reset			= vduse_vdpa_reset,
 	.set_map		= vduse_vdpa_set_map,
+	.get_vq_map		= vduse_get_vq_map,
 	.free			= vduse_vdpa_free,
 };
 
@@ -833,7 +851,14 @@ static void vduse_dev_sync_single_for_device(union virtio_map token,
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
@@ -842,7 +867,14 @@ static void vduse_dev_sync_single_for_cpu(union virtio_map token,
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
@@ -852,7 +884,14 @@ static dma_addr_t vduse_dev_map_page(union virtio_map token, struct page *page,
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
@@ -861,7 +900,14 @@ static void vduse_dev_unmap_page(union virtio_map token, dma_addr_t dma_addr,
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
@@ -869,11 +915,17 @@ static void vduse_dev_unmap_page(union virtio_map token, dma_addr_t dma_addr,
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
@@ -888,14 +940,28 @@ static void vduse_dev_free_coherent(union virtio_map token, size_t size,
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
@@ -909,7 +975,14 @@ static int vduse_dev_mapping_error(union virtio_map token, dma_addr_t dma_addr)
 
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
@@ -1727,6 +1800,7 @@ static int vduse_destroy_dev(char *name)
 	if (dev->domain)
 		vduse_domain_destroy(dev->domain);
 	kfree(dev->name);
+	kfree(dev->groups);
 	vduse_dev_destroy(dev);
 	module_put(THIS_MODULE);
 
@@ -1896,6 +1970,13 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 	dev->ngroups = (dev->api_version < VDUSE_API_VERSION_1)
 		       ? 1
 		       : config->ngroups;
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
@@ -1932,6 +2013,8 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 err_idr:
 	kfree(dev->name);
 err_str:
+	kfree(dev->groups);
+err_vq_groups:
 	vduse_dev_destroy(dev);
 err:
 	return ret;
@@ -2093,7 +2176,6 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
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

