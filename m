Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B942B322763
	for <virtualization@lists.linux.dev>; Tue, 26 Aug 2025 11:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756207657; cv=none; b=C1w+jLfcouMtpmdLqFYE9pucKLfApBZw4hhI3IZXQ/8H/9Ewx2HqohBJQcT7gXzGIPG66VXX9hheDf9klwwJbh/wL5MmQvScpQBNgPvvcLLDtIkbzzZVSg8FK6d9r3NuQjdNgu+k0hE5qm5gbgCWIi2GfOiYhU3OHlcfisJsykA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756207657; c=relaxed/simple;
	bh=fyJBCsG54JY+WM3Xv4WvD/U3V/1BZ7OuzTAGcEwEYGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HEJjkHKJiLkWCMr/CfzYPdyLlpGQns3xrq/spV0mO98EWLG/DSFQrQC67zsMJn9ZfS+dHBdkwpbKM+Kce3K0bIUqqNcnmgir7f588J2wRIDnbigALoDU02SuS4BBGL1ItbTCbfql0QmYNpAFdrRkCJS6OMsekYckeTQj7ouqddQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W0x9qZA5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W0x9qZA5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756207654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DfofubBiNflkdS+7MPj9QFpqK45aUd4DQMvbYep/TB8=;
	b=W0x9qZA5dPP/kQdV7pOqpdCl/LlWTS0PD0/bswiEUA87D/Jj3C1UkY7VtQCfbjftAIx+iZ
	2mltF01vPf1Gow5QM3pcUHy2u/DBQaBBdc+7gmF+LOIKu9zwpAAh7PW1FjxDWz4Jqdbrkz
	uzES7OyoEEe0aB1r3G8mQ6Sd4IBlE3s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-158-6UMgqMDLNlOdPL_RIKLerw-1; Tue,
 26 Aug 2025 07:27:30 -0400
X-MC-Unique: 6UMgqMDLNlOdPL_RIKLerw-1
X-Mimecast-MFC-AGG-ID: 6UMgqMDLNlOdPL_RIKLerw_1756207650
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 97810180035D;
	Tue, 26 Aug 2025 11:27:29 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.67])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ADD221800280;
	Tue, 26 Aug 2025 11:27:25 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Cindy Lu <lulu@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Laurent Vivier <lvivier@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	jasowang@redhat.com,
	Yongji Xie <xieyongji@bytedance.com>,
	Maxime Coquelin <mcoqueli@redhat.com>
Subject: [PATCH 3/6] vduse: return internal vq group struct as map token
Date: Tue, 26 Aug 2025 13:27:06 +0200
Message-ID: <20250826112709.1051172-4-eperezma@redhat.com>
In-Reply-To: <20250826112709.1051172-1-eperezma@redhat.com>
References: <20250826112709.1051172-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Return the internal struct that represents the vq group as virtqueue map
token, instead of the device.  This allows the map functions to access
the information per group.

At this moment all the virtqueues share the same vq group, that only
can point to ASID 0.  This change prepares the infrastructure for actual
per-group address space handling

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
v3:
* Make the vq groups a dynamic array to support an arbitrary number of
  them.
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 52 ++++++++++++++++++++++++------
 include/linux/virtio.h             |  6 ++--
 2 files changed, 46 insertions(+), 12 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 0f4e36dd167e..cdb3dc2b5e3f 100644
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
@@ -84,6 +85,10 @@ struct vduse_umem {
 	struct mm_struct *mm;
 };
 
+struct vduse_vq_group_int {
+	struct vduse_dev *dev;
+};
+
 struct vduse_dev {
 	struct vduse_vdpa *vdev;
 	struct device *dev;
@@ -117,6 +122,7 @@ struct vduse_dev {
 	u32 vq_align;
 	u32 ngroups;
 	struct vduse_umem *umem;
+	struct vduse_vq_group_int *groups;
 	struct mutex mem_lock;
 	unsigned int bounce_size;
 	struct mutex domain_lock;
@@ -601,6 +607,15 @@ static u32 vduse_get_vq_group(struct vdpa_device *vdpa, u16 idx)
 	return dev->vqs[idx]->vq_group;
 }
 
+static union virtio_map vduse_get_vq_map(struct vdpa_device *vdpa, u16 idx)
+{
+	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
+	u32 vq_group = dev->vqs[idx]->vq_group;
+	union virtio_map ret = { .group = &dev->groups[vq_group] };
+
+	return ret;
+}
+
 static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx,
 				struct vdpa_vq_state *state)
 {
@@ -848,6 +863,7 @@ static const struct vdpa_config_ops vduse_vdpa_config_ops = {
 	.get_vq_affinity	= vduse_vdpa_get_vq_affinity,
 	.reset			= vduse_vdpa_reset,
 	.set_map		= vduse_vdpa_set_map,
+	.get_vq_map		= vduse_get_vq_map,
 	.free			= vduse_vdpa_free,
 };
 
@@ -855,7 +871,8 @@ static void vduse_dev_sync_single_for_device(union virtio_map token,
 					     dma_addr_t dma_addr, size_t size,
 					     enum dma_data_direction dir)
 {
-	struct vduse_iova_domain *domain = token.iova_domain;
+	struct vduse_dev *vdev = token.group->dev;
+	struct vduse_iova_domain *domain = vdev->domain;
 
 	vduse_domain_sync_single_for_device(domain, dma_addr, size, dir);
 }
@@ -864,7 +881,8 @@ static void vduse_dev_sync_single_for_cpu(union virtio_map token,
 					     dma_addr_t dma_addr, size_t size,
 					     enum dma_data_direction dir)
 {
-	struct vduse_iova_domain *domain = token.iova_domain;
+	struct vduse_dev *vdev = token.group->dev;
+	struct vduse_iova_domain *domain = vdev->domain;
 
 	vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir);
 }
@@ -874,7 +892,8 @@ static dma_addr_t vduse_dev_map_page(union virtio_map token, struct page *page,
 				     enum dma_data_direction dir,
 				     unsigned long attrs)
 {
-	struct vduse_iova_domain *domain = token.iova_domain;
+	struct vduse_dev *vdev = token.group->dev;
+	struct vduse_iova_domain *domain = vdev->domain;
 
 	return vduse_domain_map_page(domain, page, offset, size, dir, attrs);
 }
@@ -883,7 +902,8 @@ static void vduse_dev_unmap_page(union virtio_map token, dma_addr_t dma_addr,
 				 size_t size, enum dma_data_direction dir,
 				 unsigned long attrs)
 {
-	struct vduse_iova_domain *domain = token.iova_domain;
+	struct vduse_dev *vdev = token.group->dev;
+	struct vduse_iova_domain *domain = vdev->domain;
 
 	return vduse_domain_unmap_page(domain, dma_addr, size, dir, attrs);
 }
@@ -891,7 +911,8 @@ static void vduse_dev_unmap_page(union virtio_map token, dma_addr_t dma_addr,
 static void *vduse_dev_alloc_coherent(union virtio_map token, size_t size,
 				      dma_addr_t *dma_addr, gfp_t flag)
 {
-	struct vduse_iova_domain *domain = token.iova_domain;
+	struct vduse_dev *vdev = token.group->dev;
+	struct vduse_iova_domain *domain = vdev->domain;
 	unsigned long iova;
 	void *addr;
 
@@ -910,14 +931,16 @@ static void vduse_dev_free_coherent(union virtio_map token, size_t size,
 				    void *vaddr, dma_addr_t dma_addr,
 				    unsigned long attrs)
 {
-	struct vduse_iova_domain *domain = token.iova_domain;
+	struct vduse_dev *vdev = token.group->dev;
+	struct vduse_iova_domain *domain = vdev->domain;
 
 	vduse_domain_free_coherent(domain, size, vaddr, dma_addr, attrs);
 }
 
 static bool vduse_dev_need_sync(union virtio_map token, dma_addr_t dma_addr)
 {
-	struct vduse_iova_domain *domain = token.iova_domain;
+	struct vduse_dev *vdev = token.group->dev;
+	struct vduse_iova_domain *domain = vdev->domain;
 
 	return dma_addr < domain->bounce_size;
 }
@@ -931,7 +954,8 @@ static int vduse_dev_mapping_error(union virtio_map token, dma_addr_t dma_addr)
 
 static size_t vduse_dev_max_mapping_size(union virtio_map token)
 {
-	struct vduse_iova_domain *domain = token.iova_domain;
+	struct vduse_dev *vdev = token.group->dev;
+	struct vduse_iova_domain *domain = vdev->domain;
 
 	return domain->bounce_size;
 }
@@ -1737,6 +1761,7 @@ static int vduse_destroy_dev(char *name)
 	if (dev->domain)
 		vduse_domain_destroy(dev->domain);
 	kfree(dev->name);
+	kfree(dev->groups);
 	vduse_dev_destroy(dev);
 	module_put(THIS_MODULE);
 
@@ -1902,7 +1927,15 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 	dev->device_features = config->features;
 	dev->device_id = config->device_id;
 	dev->vendor_id = config->vendor_id;
+
 	dev->ngroups = (dev->api_version < 1) ? 1 : (config->ngroups ?: 1);
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
@@ -1939,6 +1972,8 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 err_idr:
 	kfree(dev->name);
 err_str:
+	kfree(dev->groups);
+err_vq_groups:
 	vduse_dev_destroy(dev);
 err:
 	return ret;
@@ -2100,7 +2135,6 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 		return -ENOMEM;
 	}
 
-	dev->vdev->vdpa.vmap.iova_domain = dev->domain;
 	ret = _vdpa_register_device(&dev->vdev->vdpa, dev->vq_num);
 	if (ret) {
 		put_device(&dev->vdev->vdpa.dev);
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 07040c7f1f4d..ff46d287a003 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -40,13 +40,13 @@ struct virtqueue {
 	void *priv;
 };
 
-struct vduse_iova_domain;
+struct vduse_vq_group_int;
 
 union virtio_map {
 	/* Device that performs DMA */
 	struct device *dma_dev;
-	/* VDUSE specific mapping data */
-	struct vduse_iova_domain *iova_domain;
+	/* VDUSE specific virtqueue group for doing map */
+	struct vduse_vq_group_int *group;
 };
 
 int virtqueue_add_outbuf(struct virtqueue *vq,
-- 
2.51.0

