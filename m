Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE9D2F360B
	for <virtualization@lists.linux.dev>; Fri, 19 Sep 2025 09:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758274473; cv=none; b=mpRVnPW7ALEyEpFuoKJS/ZTgJezuJFjjOzoPeTmlxl9L7v2oe+DDoyY2g49yEM8G7YpG894fTTal/MY3L4Eyv29pLwHwtxFXtkpVMaxFdTdLPHvVY+4UuveTQLN1DYpiDh/O9ROW2jhQCZRFw4Kp5597z7fiLov0nAJrK5/HXgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758274473; c=relaxed/simple;
	bh=wLSqDJ2E7jOCn4G3iCd5jisMjiBa/HRAsKNOwGReuRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=doK1pvjwnvyZmQ0IQ3A08lCMTn5qOgIImKqTxf26vZk57iX3RIA7XuvkuyyQlPMpbGZyjfQYvf9fwmYBxrZ812qR92SrpBky9wm5QS8fGpujgP9YEzL3jwJF2uXNpNmQdt84y+NvGvI7ASMhMGsry4gd7iRY5yFiZZ7E2ynwm7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XBOh2rHz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XBOh2rHz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758274470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uU0QFvZkgbONix0ZNU2JdIVRas5qkokSX3OvSMTiTuU=;
	b=XBOh2rHzkHAC3FSMHrqwWDJgQhnmVXDxuOO04bsInjbDNhjlECndkG/wRYJ6A+xwLQitfQ
	XfYU0AFrDmnEUSxnGDScoZU4G56Wn+B4ojGDhFTk42V/PyPZ1Bk1dg8v0mrYLCxmexqk+l
	rytqGE+kxfjwkjLtZp/eWvvPm75Obxg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-348-91yUQuAsOsO4fwZ6RX6ZrA-1; Fri,
 19 Sep 2025 05:34:29 -0400
X-MC-Unique: 91yUQuAsOsO4fwZ6RX6ZrA-1
X-Mimecast-MFC-AGG-ID: 91yUQuAsOsO4fwZ6RX6ZrA_1758274466
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C52521954B33;
	Fri, 19 Sep 2025 09:34:26 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.69])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A6983180035C;
	Fri, 19 Sep 2025 09:34:22 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	Maxime Coquelin <mcoqueli@redhat.com>,
	linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	Cindy Lu <lulu@redhat.com>,
	jasowang@redhat.com,
	Laurent Vivier <lvivier@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v3 4/6] vduse: return internal vq group struct as map token
Date: Fri, 19 Sep 2025 11:33:57 +0200
Message-ID: <20250919093359.961296-5-eperezma@redhat.com>
In-Reply-To: <20250919093359.961296-1-eperezma@redhat.com>
References: <20250919093359.961296-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Return the internal struct that represents the vq group as virtqueue map
token, instead of the device.  This allows the map functions to access
the information per group.

At this moment all the virtqueues share the same vq group, that only
can point to ASID 0.  This change prepares the infrastructure for actual
per-group address space handling

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
v3:
* Adapt all virtio_map_ops callbacks to handle empty tokens in case of
  invalid groups.
* Make setting status DRIVER_OK fail if vq group is not valid.
* Remove the _int name suffix from struct vduse_vq_group.

RFC v3:
* Make the vq groups a dynamic array to support an arbitrary number of
  them.
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 111 ++++++++++++++++++++++++++---
 include/linux/virtio.h             |   6 +-
 2 files changed, 105 insertions(+), 12 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 7ddd81456f7b..6fdabc3c910e 100644
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
@@ -88,6 +89,10 @@ struct vduse_umem {
 	struct mm_struct *mm;
 };
 
+struct vduse_vq_group {
+	struct vduse_dev *dev;
+};
+
 struct vduse_dev {
 	struct vduse_vdpa *vdev;
 	struct device *dev;
@@ -121,6 +126,7 @@ struct vduse_dev {
 	u32 vq_align;
 	u32 ngroups;
 	struct vduse_umem *umem;
+	struct vduse_vq_group *groups;
 	struct mutex mem_lock;
 	unsigned int bounce_size;
 	rwlock_t domain_lock;
@@ -308,6 +314,13 @@ static int vduse_dev_set_status(struct vduse_dev *dev, u8 status)
 	msg.req.type = VDUSE_SET_STATUS;
 	msg.req.s.status = status;
 
+	if (dev->api_version >= VDUSE_API_VERSION_1 &&
+	    !(dev->status & VIRTIO_CONFIG_S_DRIVER_OK) &&
+	    status & VIRTIO_CONFIG_S_DRIVER_OK)
+		for (u32 i = 0; i < dev->vq_num; ++i)
+			if (dev->vqs[i]->vq_group == VQ_GROUP_INVALID)
+				return -EIO;
+
 	return vduse_dev_msg_sync(dev, &msg);
 }
 
@@ -612,6 +625,20 @@ static s64 vduse_get_vq_group(struct vdpa_device *vdpa, u16 idx)
 	return dev->vqs[idx]->vq_group;
 }
 
+static union virtio_map vduse_get_vq_map(struct vdpa_device *vdpa, u16 idx)
+{
+	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
+	u32 vq_group = vduse_get_vq_group(vdpa, idx);
+	union virtio_map ret;
+
+	if (vq_group < 0)
+		ret.group = NULL;
+	else
+		ret.group = &dev->groups[vq_group];
+
+	return ret;
+}
+
 static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx,
 				struct vdpa_vq_state *state)
 {
@@ -832,6 +859,7 @@ static const struct vdpa_config_ops vduse_vdpa_config_ops = {
 	.get_vq_affinity	= vduse_vdpa_get_vq_affinity,
 	.reset			= vduse_vdpa_reset,
 	.set_map		= vduse_vdpa_set_map,
+	.get_vq_map		= vduse_get_vq_map,
 	.free			= vduse_vdpa_free,
 };
 
@@ -839,7 +867,14 @@ static void vduse_dev_sync_single_for_device(union virtio_map token,
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
@@ -848,7 +883,14 @@ static void vduse_dev_sync_single_for_cpu(union virtio_map token,
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
@@ -858,7 +900,14 @@ static dma_addr_t vduse_dev_map_page(union virtio_map token, struct page *page,
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
@@ -867,7 +916,14 @@ static void vduse_dev_unmap_page(union virtio_map token, dma_addr_t dma_addr,
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
@@ -875,11 +931,17 @@ static void vduse_dev_unmap_page(union virtio_map token, dma_addr_t dma_addr,
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
@@ -894,14 +956,28 @@ static void vduse_dev_free_coherent(union virtio_map token, size_t size,
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
@@ -915,7 +991,14 @@ static int vduse_dev_mapping_error(union virtio_map token, dma_addr_t dma_addr)
 
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
@@ -1733,6 +1816,7 @@ static int vduse_destroy_dev(char *name)
 	if (dev->domain)
 		vduse_domain_destroy(dev->domain);
 	kfree(dev->name);
+	kfree(dev->groups);
 	vduse_dev_destroy(dev);
 	module_put(THIS_MODULE);
 
@@ -1899,7 +1983,15 @@ static int vduse_create_dev(struct vduse_dev_config *config,
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
@@ -1936,6 +2028,8 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 err_idr:
 	kfree(dev->name);
 err_str:
+	kfree(dev->groups);
+err_vq_groups:
 	vduse_dev_destroy(dev);
 err:
 	return ret;
@@ -2097,7 +2191,6 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
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

