Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655132882C3
	for <virtualization@lists.linux.dev>; Fri,  6 Jun 2025 11:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749210639; cv=none; b=mbBq+vsHLToyV9I//7itQ70Ik86n6hWfwOpSwBNRht1EIwICMJxX6dGG4vgiXVpGcHRJTpInnNtBknMM0kHFc24ghIi13OyqtcC1LeIVkPr3zaZ3ibA9nk20YkkH2qaIiEvhPaXfto797Pw92HULSdh6Om1Y7AakUOR68QkOY9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749210639; c=relaxed/simple;
	bh=JjnV/cMKZ21bR+kkecYTjDSU7m/Vn38S16UYMsTJD2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SgxjXeUe8SWI2UkM49RrIz3RRCEwCzgBF3kpjcPq7+GG7/F4jDC9uPZLLqUD40tJ3K8GT7M1Ql8lRyvhOJARTAkjYdmQ6JON7cAmTr8FH9okyUF9QK++lGWgehMMXen/7hOJ6SB27+tLib02vLYG5uB+GPa4vT/lIGIHk+/yueY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PU+EfHpr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PU+EfHpr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749210636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jKyGoqk8vynqsNeQjiRI+TmiQQKqLOuQiBp+LnnxBGc=;
	b=PU+EfHprpMMvio+TF53MV2XjYwN4wN/+FiFFcZU5tDQfvf7wttuO4djaOQ62+UTmCN2+DT
	JHL7vX/0KhpnQ58JBUWAO6mA4x39LJ6JxPiOqCx373wtll5vOn6w9dY4HZAszWCRW643pF
	3txsUVjh6SWcxOl/I8kFRDokEt0ouOw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-49-70eA9zMkO6yJunHjYlTCow-1; Fri,
 06 Jun 2025 07:50:33 -0400
X-MC-Unique: 70eA9zMkO6yJunHjYlTCow-1
X-Mimecast-MFC-AGG-ID: 70eA9zMkO6yJunHjYlTCow_1749210632
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8890B1956046;
	Fri,  6 Jun 2025 11:50:32 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.33.72])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7768719560B2;
	Fri,  6 Jun 2025 11:50:28 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: jasowang@redhat.com
Cc: Yongji Xie <xieyongji@bytedance.com>,
	Cindy Lu <lulu@redhat.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Maxime Coquelin <mcoqueli@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	virtualization@lists.linux.dev,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Laurent Vivier <lvivier@redhat.com>
Subject: [RFC 3/6] vduse: add vq group asid support
Date: Fri,  6 Jun 2025 13:50:09 +0200
Message-ID: <20250606115012.1331551-4-eperezma@redhat.com>
In-Reply-To: <20250606115012.1331551-1-eperezma@redhat.com>
References: <20250606115012.1331551-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Make one IOTLB domain per address space, and allow the driver to assign
each ASID to a vq group.  Each address space via an dedicated identifier
(ASID).

During vDPA device allocation, the VDUSE device needs to report the
number of address spaces supported.  Then the vdpa driver is able to
configure them.  At this moment only vhost_vdpa is able to do it.

This helps to isolate the environments for the virtqueue that will not
be assigned directly.  E.g in the case of virtio-net, the control
virtqueue will not be assigned directly to guest.

TODO: Ideally, umem should not be duplicated.  But it is hard or
impossible to refactor everything around one single umem.  So should we
continue with device specifying umem per vq group?

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 250 +++++++++++++++++++++--------
 include/uapi/linux/vduse.h         |  38 ++++-
 2 files changed, 216 insertions(+), 72 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 6fa687bc4912..d51e4f26fe72 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -51,6 +51,11 @@
  */
 #define VDUSE_MAX_VQ_GROUPS 2
 
+/*
+ * Let's make it 2 for simplicity.
+ */
+#define VDUSE_MAX_ASID 2
+
 #define IRQ_UNBOUND -1
 
 struct vduse_virtqueue {
@@ -92,7 +97,7 @@ struct vduse_dev {
 	struct vduse_vdpa *vdev;
 	struct device *dev;
 	struct vduse_virtqueue **vqs;
-	struct vduse_iova_domain *domain;
+	struct vduse_iova_domain *domain[VDUSE_MAX_ASID];
 	char *name;
 	struct mutex lock;
 	spinlock_t msg_lock;
@@ -120,7 +125,8 @@ struct vduse_dev {
 	u32 vq_num;
 	u32 vq_align;
 	u32 ngroups;
-	struct vduse_umem *umem;
+	u32 nas;
+	struct vduse_umem *umem[VDUSE_MAX_ASID];
 	struct mutex mem_lock;
 	unsigned int bounce_size;
 	struct mutex domain_lock;
@@ -436,11 +442,14 @@ static __poll_t vduse_dev_poll(struct file *file, poll_table *wait)
 static void vduse_dev_reset(struct vduse_dev *dev)
 {
 	int i;
-	struct vduse_iova_domain *domain = dev->domain;
 
 	/* The coherent mappings are handled in vduse_dev_free_coherent() */
-	if (domain && domain->bounce_map)
-		vduse_domain_reset_bounce_map(domain);
+	for (i = 0; i < dev->nas; i++) {
+		struct vduse_iova_domain *domain = dev->domain[i];
+
+		if (domain && domain->bounce_map)
+			vduse_domain_reset_bounce_map(domain);
+	}
 
 	down_write(&dev->rwsem);
 
@@ -617,6 +626,23 @@ static u32 vduse_get_vq_group(struct vdpa_device *vdpa, u16 idx)
 	return msg.resp.vq_group.num;
 }
 
+static int vduse_set_group_asid(struct vdpa_device *vdpa, unsigned int group,
+				unsigned int asid)
+{
+	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
+	struct vduse_dev_msg msg = { 0 };
+
+	if (dev->api_version < VDUSE_API_VERSION_1 ||
+	    group >= dev->ngroups || asid >= dev->nas)
+		return -EINVAL;
+
+	msg.req.type = VDUSE_SET_VQ_GROUP_ASID;
+	msg.req.vq_group_asid.group = group;
+	msg.req.vq_group_asid.asid = asid;
+
+	return vduse_dev_msg_sync(dev, &msg);
+}
+
 static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx,
 				struct vdpa_vq_state *state)
 {
@@ -788,13 +814,13 @@ static int vduse_vdpa_set_map(struct vdpa_device *vdpa,
 	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
 	int ret;
 
-	ret = vduse_domain_set_map(dev->domain, iotlb);
+	ret = vduse_domain_set_map(dev->domain[asid], iotlb);
 	if (ret)
 		return ret;
 
 	ret = vduse_dev_update_iotlb(dev, 0ULL, ULLONG_MAX);
 	if (ret) {
-		vduse_domain_clear_map(dev->domain, iotlb);
+		vduse_domain_clear_map(dev->domain[asid], iotlb);
 		return ret;
 	}
 
@@ -837,6 +863,7 @@ static const struct vdpa_config_ops vduse_vdpa_config_ops = {
 	.get_vq_affinity	= vduse_vdpa_get_vq_affinity,
 	.reset			= vduse_vdpa_reset,
 	.set_map		= vduse_vdpa_set_map,
+	.set_group_asid		= vduse_set_group_asid,
 	.free			= vduse_vdpa_free,
 };
 
@@ -845,9 +872,12 @@ static void vduse_dev_sync_single_for_device(struct device *dev,
 					     enum dma_data_direction dir)
 {
 	struct vduse_dev *vdev = dev_to_vduse(dev);
-	struct vduse_iova_domain *domain = vdev->domain;
 
-	vduse_domain_sync_single_for_device(domain, dma_addr, size, dir);
+	for (int i = 0; i < vdev->nas; i++) {
+		struct vduse_iova_domain *domain = vdev->domain[i];
+
+		vduse_domain_sync_single_for_device(domain, dma_addr, size, dir);
+	}
 }
 
 static void vduse_dev_sync_single_for_cpu(struct device *dev,
@@ -855,9 +885,12 @@ static void vduse_dev_sync_single_for_cpu(struct device *dev,
 					     enum dma_data_direction dir)
 {
 	struct vduse_dev *vdev = dev_to_vduse(dev);
-	struct vduse_iova_domain *domain = vdev->domain;
 
-	vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir);
+	for (int i = 0; i < vdev->nas; i++) {
+		struct vduse_iova_domain *domain = vdev->domain[i];
+
+		vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir);
+	}
 }
 
 static dma_addr_t vduse_dev_map_page(struct device *dev, struct page *page,
@@ -866,7 +899,7 @@ static dma_addr_t vduse_dev_map_page(struct device *dev, struct page *page,
 				     unsigned long attrs)
 {
 	struct vduse_dev *vdev = dev_to_vduse(dev);
-	struct vduse_iova_domain *domain = vdev->domain;
+	struct vduse_iova_domain *domain = vdev->domain[0];
 
 	return vduse_domain_map_page(domain, page, offset, size, dir, attrs);
 }
@@ -876,7 +909,7 @@ static void vduse_dev_unmap_page(struct device *dev, dma_addr_t dma_addr,
 				unsigned long attrs)
 {
 	struct vduse_dev *vdev = dev_to_vduse(dev);
-	struct vduse_iova_domain *domain = vdev->domain;
+	struct vduse_iova_domain *domain = vdev->domain[0];
 
 	return vduse_domain_unmap_page(domain, dma_addr, size, dir, attrs);
 }
@@ -886,7 +919,7 @@ static void *vduse_dev_alloc_coherent(struct device *dev, size_t size,
 					unsigned long attrs)
 {
 	struct vduse_dev *vdev = dev_to_vduse(dev);
-	struct vduse_iova_domain *domain = vdev->domain;
+	struct vduse_iova_domain *domain = vdev->domain[0];
 	unsigned long iova;
 	void *addr;
 
@@ -906,17 +939,25 @@ static void vduse_dev_free_coherent(struct device *dev, size_t size,
 					unsigned long attrs)
 {
 	struct vduse_dev *vdev = dev_to_vduse(dev);
-	struct vduse_iova_domain *domain = vdev->domain;
+	struct vduse_iova_domain *domain = vdev->domain[0];
 
 	vduse_domain_free_coherent(domain, size, vaddr, dma_addr, attrs);
 }
 
+/* TODO check if this is correct */
 static size_t vduse_dev_max_mapping_size(struct device *dev)
 {
 	struct vduse_dev *vdev = dev_to_vduse(dev);
-	struct vduse_iova_domain *domain = vdev->domain;
+	size_t max_mapping_size = 0;
+
+	for (int i = 0; i < vdev->nas; i++) {
+		struct vduse_iova_domain *domain = vdev->domain[i];
 
-	return domain->bounce_size;
+		if (domain->bounce_size > max_mapping_size)
+			max_mapping_size = domain->bounce_size;
+	}
+
+	return max_mapping_size;
 }
 
 static const struct dma_map_ops vduse_dev_dma_ops = {
@@ -1054,31 +1095,32 @@ static int vduse_dev_queue_irq_work(struct vduse_dev *dev,
 	return ret;
 }
 
-static int vduse_dev_dereg_umem(struct vduse_dev *dev,
+static int vduse_dev_dereg_umem(struct vduse_dev *dev, u32 asid,
 				u64 iova, u64 size)
 {
 	int ret;
 
 	mutex_lock(&dev->mem_lock);
 	ret = -ENOENT;
-	if (!dev->umem)
+	if (!dev->umem[asid])
 		goto unlock;
 
 	ret = -EINVAL;
-	if (!dev->domain)
+	if (!dev->domain[asid])
 		goto unlock;
 
-	if (dev->umem->iova != iova || size != dev->domain->bounce_size)
+	if (dev->umem[asid]->iova != iova ||
+	    size != dev->domain[asid]->bounce_size)
 		goto unlock;
 
-	vduse_domain_remove_user_bounce_pages(dev->domain);
-	unpin_user_pages_dirty_lock(dev->umem->pages,
-				    dev->umem->npages, true);
-	atomic64_sub(dev->umem->npages, &dev->umem->mm->pinned_vm);
-	mmdrop(dev->umem->mm);
-	vfree(dev->umem->pages);
-	kfree(dev->umem);
-	dev->umem = NULL;
+	vduse_domain_remove_user_bounce_pages(dev->domain[asid]);
+	unpin_user_pages_dirty_lock(dev->umem[asid]->pages,
+				    dev->umem[asid]->npages, true);
+	atomic64_sub(dev->umem[asid]->npages, &dev->umem[asid]->mm->pinned_vm);
+	mmdrop(dev->umem[asid]->mm);
+	vfree(dev->umem[asid]->pages);
+	kfree(dev->umem[asid]);
+	dev->umem[asid] = NULL;
 	ret = 0;
 unlock:
 	mutex_unlock(&dev->mem_lock);
@@ -1086,7 +1128,7 @@ static int vduse_dev_dereg_umem(struct vduse_dev *dev,
 }
 
 static int vduse_dev_reg_umem(struct vduse_dev *dev,
-			      u64 iova, u64 uaddr, u64 size)
+			      u32 asid, u64 iova, u64 uaddr, u64 size)
 {
 	struct page **page_list = NULL;
 	struct vduse_umem *umem = NULL;
@@ -1094,14 +1136,14 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev,
 	unsigned long npages, lock_limit;
 	int ret;
 
-	if (!dev->domain || !dev->domain->bounce_map ||
-	    size != dev->domain->bounce_size ||
+	if (!dev->domain[asid] || !dev->domain[asid]->bounce_map ||
+	    size != dev->domain[asid]->bounce_size ||
 	    iova != 0 || uaddr & ~PAGE_MASK)
 		return -EINVAL;
 
 	mutex_lock(&dev->mem_lock);
 	ret = -EEXIST;
-	if (dev->umem)
+	if (dev->umem[asid])
 		goto unlock;
 
 	ret = -ENOMEM;
@@ -1125,7 +1167,7 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev,
 		goto out;
 	}
 
-	ret = vduse_domain_add_user_bounce_pages(dev->domain,
+	ret = vduse_domain_add_user_bounce_pages(dev->domain[asid],
 						 page_list, pinned);
 	if (ret)
 		goto out;
@@ -1138,7 +1180,7 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev,
 	umem->mm = current->mm;
 	mmgrab(current->mm);
 
-	dev->umem = umem;
+	dev->umem[asid] = umem;
 out:
 	if (ret && pinned > 0)
 		unpin_user_pages(page_list, pinned);
@@ -1181,26 +1223,42 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 
 	switch (cmd) {
 	case VDUSE_IOTLB_GET_FD: {
-		struct vduse_iotlb_entry entry;
+		struct vduse_iotlb_entry_v2 entry = {};
+		struct vduse_iotlb_entry entry_old;
 		struct vhost_iotlb_map *map;
 		struct vdpa_map_file *map_file;
 		struct file *f = NULL;
 
 		ret = -EFAULT;
-		if (copy_from_user(&entry, argp, sizeof(entry)))
-			break;
+		if (dev->api_version >= VDUSE_API_VERSION_1) {
+			if (copy_from_user(&entry, argp, sizeof(entry)))
+				break;
+		} else {
+			if (copy_from_user(&entry_old, argp,
+					   sizeof(entry_old)))
+				break;
+
+			entry.offset = entry_old.offset;
+			entry.start = entry_old.start;
+			entry.last = entry_old.last;
+			entry.perm = entry_old.perm;
+		}
 
 		ret = -EINVAL;
 		if (entry.start > entry.last)
 			break;
 
+		if (entry.asid >= dev->nas)
+			break;
+
 		mutex_lock(&dev->domain_lock);
-		if (!dev->domain) {
+		/* TODO accessing an array with idx from userspace, mitigations? */
+		if (!dev->domain[entry.asid]) {
 			mutex_unlock(&dev->domain_lock);
 			break;
 		}
-		spin_lock(&dev->domain->iotlb_lock);
-		map = vhost_iotlb_itree_first(dev->domain->iotlb,
+		spin_lock(&dev->domain[entry.asid]->iotlb_lock);
+		map = vhost_iotlb_itree_first(dev->domain[entry.asid]->iotlb,
 					      entry.start, entry.last);
 		if (map) {
 			map_file = (struct vdpa_map_file *)map->opaque;
@@ -1210,7 +1268,7 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 			entry.last = map->last;
 			entry.perm = map->perm;
 		}
-		spin_unlock(&dev->domain->iotlb_lock);
+		spin_unlock(&dev->domain[entry.asid]->iotlb_lock);
 		mutex_unlock(&dev->domain_lock);
 		ret = -EINVAL;
 		if (!f)
@@ -1360,12 +1418,18 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 			break;
 
 		ret = -EINVAL;
+		/* TODO: Using asid from userspace, need to mitigate? */
 		if (!is_mem_zero((const char *)umem.reserved,
-				 sizeof(umem.reserved)))
+				 sizeof(umem.reserved)) ||
+		    !is_mem_zero((const char *)umem.reserved2,
+				 sizeof(umem.reserved2)) ||
+		    (dev->api_version < VDUSE_API_VERSION_1 &&
+		     umem.asid != 0) ||
+		     umem.asid >= dev->nas)
 			break;
 
 		mutex_lock(&dev->domain_lock);
-		ret = vduse_dev_reg_umem(dev, umem.iova,
+		ret = vduse_dev_reg_umem(dev, umem.asid, umem.iova,
 					 umem.uaddr, umem.size);
 		mutex_unlock(&dev->domain_lock);
 		break;
@@ -1378,15 +1442,23 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 			break;
 
 		ret = -EINVAL;
+		/* TODO: Using asid from userspace, need to mitigate? */
 		if (!is_mem_zero((const char *)umem.reserved,
-				 sizeof(umem.reserved)))
+				 sizeof(umem.reserved)) ||
+		    !is_mem_zero((const char *)umem.reserved2,
+				 sizeof(umem.reserved2)) ||
+		    (dev->api_version < VDUSE_API_VERSION_1 &&
+		     umem.asid != 0) ||
+		     umem.asid >= dev->nas)
 			break;
+
 		mutex_lock(&dev->domain_lock);
-		ret = vduse_dev_dereg_umem(dev, umem.iova,
+		ret = vduse_dev_dereg_umem(dev, umem.asid, umem.iova,
 					   umem.size);
 		mutex_unlock(&dev->domain_lock);
 		break;
 	}
+	/* TODO can we merge this with GET_FD? */
 	case VDUSE_IOTLB_GET_INFO: {
 		struct vduse_iova_info info;
 		struct vhost_iotlb_map *map;
@@ -1399,27 +1471,32 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 		if (info.start > info.last)
 			break;
 
+		if (info.asid >= dev->nas)
+			break;
+
 		if (!is_mem_zero((const char *)info.reserved,
 				 sizeof(info.reserved)))
 			break;
 
 		mutex_lock(&dev->domain_lock);
-		if (!dev->domain) {
+		/* TODO asid comes from userspace. mitigations? */
+		if (!dev->domain[info.asid]) {
 			mutex_unlock(&dev->domain_lock);
 			break;
 		}
-		spin_lock(&dev->domain->iotlb_lock);
-		map = vhost_iotlb_itree_first(dev->domain->iotlb,
+		spin_lock(&dev->domain[info.asid]->iotlb_lock);
+		map = vhost_iotlb_itree_first(dev->domain[info.asid]->iotlb,
 					      info.start, info.last);
 		if (map) {
 			info.start = map->start;
 			info.last = map->last;
 			info.capability = 0;
-			if (dev->domain->bounce_map && map->start == 0 &&
-			    map->last == dev->domain->bounce_size - 1)
+			if (dev->domain[info.asid]->bounce_map &&
+			    map->start == 0 &&
+			    map->last == dev->domain[info.asid]->bounce_size - 1)
 				info.capability |= VDUSE_IOVA_CAP_UMEM;
 		}
-		spin_unlock(&dev->domain->iotlb_lock);
+		spin_unlock(&dev->domain[info.asid]->iotlb_lock);
 		mutex_unlock(&dev->domain_lock);
 		if (!map)
 			break;
@@ -1444,8 +1521,13 @@ static int vduse_dev_release(struct inode *inode, struct file *file)
 	struct vduse_dev *dev = file->private_data;
 
 	mutex_lock(&dev->domain_lock);
-	if (dev->domain)
-		vduse_dev_dereg_umem(dev, 0, dev->domain->bounce_size);
+	for (int i = 0; i < dev->nas; i++) {
+		if (dev->domain[i]) {
+			vduse_dev_dereg_umem(dev, i, 0,
+					     dev->domain[i]->bounce_size);
+			dev->domain[i] = NULL;
+		}
+	}
 	mutex_unlock(&dev->domain_lock);
 	spin_lock(&dev->msg_lock);
 	/* Make sure the inflight messages can processed after reconncection */
@@ -1715,8 +1797,10 @@ static int vduse_destroy_dev(char *name)
 	idr_remove(&vduse_idr, dev->minor);
 	kvfree(dev->config);
 	vduse_dev_deinit_vqs(dev);
-	if (dev->domain)
-		vduse_domain_destroy(dev->domain);
+	for (int i = 0; i < dev->nas; i++) {
+		if (dev->domain[i])
+			vduse_domain_destroy(dev->domain[i]);
+	}
 	kfree(dev->name);
 	vduse_dev_destroy(dev);
 	module_put(THIS_MODULE);
@@ -1824,7 +1908,7 @@ static ssize_t bounce_size_store(struct device *device,
 
 	ret = -EPERM;
 	mutex_lock(&dev->domain_lock);
-	if (dev->domain)
+	if (dev->domain[0] && dev->domain[1])
 		goto unlock;
 
 	ret = kstrtouint(buf, 10, &bounce_size);
@@ -1882,9 +1966,18 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 				config->ngroups, VDUSE_MAX_VQ_GROUPS);
 			goto err_ngroups;
 		}
+
+		if (config->nas > VDUSE_MAX_ASID) {
+			pr_err("Not creating a VDUSE device with %u asid. Max: %u",
+				config->nas, VDUSE_MAX_ASID);
+			goto err_nas;
+		}
+
 		dev->ngroups = config->ngroups ?: 1;
+		dev->nas = config->nas ?: 1;
 	} else {
 		dev->ngroups = 1;
+		dev->nas = 1;
 	}
 	dev->name = kstrdup(config->name, GFP_KERNEL);
 	if (!dev->name)
@@ -1923,6 +2016,7 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 	kfree(dev->name);
 err_ngroups:
 err_str:
+err_nas:
 	vduse_dev_destroy(dev);
 err:
 	return ret;
@@ -2015,7 +2109,6 @@ static int vduse_open(struct inode *inode, struct file *file)
 	if (!control)
 		return -ENOMEM;
 
-	control->api_version = VDUSE_API_VERSION;
 	file->private_data = control;
 
 	return 0;
@@ -2040,17 +2133,15 @@ static struct vduse_mgmt_dev *vduse_mgmt;
 static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *name)
 {
 	struct vduse_vdpa *vdev;
-	__u32 ngroups = 1;
+	__u32 ngroups = dev->ngroups;
 	int ret;
 
 	if (dev->vdev)
 		return -EEXIST;
 
-	if (vdev->dev->api_version >= VDUSE_API_VERSION_1)
-		ngroups = vdev->dev->ngroups;
-
+	/* TODO do we need to store ngroups and nas? vdpa device already store it for us */
 	vdev = vdpa_alloc_device(struct vduse_vdpa, vdpa, dev->dev,
-				 &vduse_vdpa_config_ops, ngroups, 1, name,
+				 &vduse_vdpa_config_ops, ngroups, dev->nas, name,
 				 true);
 	if (IS_ERR(vdev))
 		return PTR_ERR(vdev);
@@ -2088,11 +2179,23 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 		return ret;
 
 	mutex_lock(&dev->domain_lock);
-	if (!dev->domain)
-		dev->domain = vduse_domain_create(VDUSE_IOVA_SIZE - 1,
-						  dev->bounce_size);
+	ret = 0;
+
+	/* TODO we could delay the creation of the domain */
+	for (int i = 0; i < dev->nas; ++i) {
+		if (!dev->domain[i])
+			dev->domain[i] = vduse_domain_create(VDUSE_IOVA_SIZE - 1,
+							     dev->bounce_size);
+		if (!dev->domain[i]) {
+			ret = -ENOMEM;
+			for (int j = 0; j < i; ++j)
+				vduse_domain_destroy(dev->domain[j]);
+			goto err_domain;
+		}
+	}
+
 	mutex_unlock(&dev->domain_lock);
-	if (!dev->domain) {
+	if (ret == -ENOMEM) {
 		put_device(&dev->vdev->vdpa.dev);
 		return -ENOMEM;
 	}
@@ -2101,13 +2204,22 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	if (ret) {
 		put_device(&dev->vdev->vdpa.dev);
 		mutex_lock(&dev->domain_lock);
-		vduse_domain_destroy(dev->domain);
-		dev->domain = NULL;
+		for (int i = 0; i < dev->nas; i++) {
+			if (dev->domain[i]) {
+				vduse_domain_destroy(dev->domain[i]);
+				dev->domain[i] = NULL;
+			}
+		}
 		mutex_unlock(&dev->domain_lock);
 		return ret;
 	}
 
 	return 0;
+
+err_domain:
+	/* TODO do I need to call put_device? */
+	mutex_unlock(&dev->domain_lock);
+	return ret;
 }
 
 static void vdpa_dev_del(struct vdpa_mgmt_dev *mdev, struct vdpa_device *dev)
diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
index a779bcddac58..3a17a0b4e938 100644
--- a/include/uapi/linux/vduse.h
+++ b/include/uapi/linux/vduse.h
@@ -46,7 +46,8 @@ struct vduse_dev_config {
 	__u32 vq_num;
 	__u32 vq_align;
 	__u32 ngroups; /* if VDUSE_API_VERSION >= 1 */
-	__u32 reserved[12];
+	__u32 nas; /* if VDUSE_API_VERSION >= 1 */
+	__u32 reserved[11];
 	__u32 config_size;
 	__u8 config[];
 };
@@ -81,6 +82,17 @@ struct vduse_iotlb_entry {
 	__u8 perm;
 };
 
+struct vduse_iotlb_entry_v2 {
+	__u64 offset;
+	__u64 start;
+	__u64 last;
+	__u32 asid;
+#define VDUSE_ACCESS_RO 0x1
+#define VDUSE_ACCESS_WO 0x2
+#define VDUSE_ACCESS_RW 0x3
+	__u8 perm;
+};
+
 /*
  * Find the first IOVA region that overlaps with the range [start, last]
  * and return the corresponding file descriptor. Return -EINVAL means the
@@ -171,6 +183,16 @@ struct vduse_vq_group {
 	__u32 num;
 };
 
+/**
+ * struct vduse_vq_group - virtqueue group
+ @ @group: Index of the virtqueue group
+ * @asid: Address space ID of the group
+ */
+struct vduse_vq_group_asid {
+	__u32 group;
+	__u32 asid;
+};
+
 /**
  * struct vduse_vq_info - information of a virtqueue
  * @index: virtqueue index
@@ -231,7 +253,9 @@ struct vduse_vq_eventfd {
  * @uaddr: start address of userspace memory, it must be aligned to page size
  * @iova: start of the IOVA region
  * @size: size of the IOVA region
+ * @asid: Address space ID of the IOVA region
  * @reserved: for future use, needs to be initialized to zero
+ * @reserved2: for future use, needs to be initialized to zero
  *
  * Structure used by VDUSE_IOTLB_REG_UMEM and VDUSE_IOTLB_DEREG_UMEM
  * ioctls to register/de-register userspace memory for IOVA regions
@@ -240,7 +264,9 @@ struct vduse_iova_umem {
 	__u64 uaddr;
 	__u64 iova;
 	__u64 size;
-	__u64 reserved[3];
+	__u32 asid;
+	__u32 reserved[1];
+	__u64 reserved2[2];
 };
 
 /* Register userspace memory for IOVA regions */
@@ -264,7 +290,8 @@ struct vduse_iova_info {
 	__u64 last;
 #define VDUSE_IOVA_CAP_UMEM (1 << 0)
 	__u64 capability;
-	__u64 reserved[3];
+	__u64 asid; /* Only if device API version >= 1 */
+	__u64 reserved[2];
 };
 
 /*
@@ -287,6 +314,7 @@ enum vduse_req_type {
 	VDUSE_SET_STATUS,
 	VDUSE_UPDATE_IOTLB,
 	VDUSE_GET_VQ_GROUP,
+	VDUSE_SET_VQ_GROUP_ASID,
 };
 
 /**
@@ -342,6 +370,8 @@ struct vduse_dev_request {
 		struct vduse_dev_status s;
 		struct vduse_iova_range iova;
 		struct vduse_vq_group vq_group; /* Only if vduse api version >= 1 */
+		/* Only if vduse api version >= 1 */
+		struct vduse_vq_group_asid vq_group_asid;
 		__u32 padding[32];
 	};
 };
@@ -365,6 +395,8 @@ struct vduse_dev_response {
 	union {
 		struct vduse_vq_state vq_state;
 		struct vduse_vq_group vq_group; /* Only if vduse api version >= 1 */
+		/* Only if vduse api version >= 1 */
+		struct vduse_vq_group_asid vq_group_asid;
 		__u32 padding[32];
 	};
 };
-- 
2.49.0

