Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826E034F254
	for <virtualization@lists.linux.dev>; Thu, 30 Oct 2025 10:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761818465; cv=none; b=OfopiepZmir1PT2jX3/4X+P+JFYJ5MK+p5ERW6LY0Af6lj0K21FnbzjboI3b1kD631xtBheEsfPzkyN2Gvv9vNri+D2JZ7hM0t+IaNFpAERLxf7p+yK/6nnJxeFD8p4vKMJAtwHvKJJJqrePd1xHcssirb3mjj8Fh41WxFPN5Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761818465; c=relaxed/simple;
	bh=yGrrzc3emhiO3AKBfNRhs6AH1lcGK3Fe74Ar2cSxGCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FIYsfaS+s3VIx5yJzn8IZQRdsBKVMUqsup4jGSZ5Up4OUWVC6ozu2FEJXUOXcSk9XpZuLTAxKRvYY3x/B7QGugJLXYnF9lUZc1BlzE3XpO7Y5Gpo8sz8aHlQWnVoxYa/wjsS1cUulW3b1uUmduSMIyV/9Qdc1HHaZWafpil4pT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C49UXK6h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C49UXK6h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761818461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6+q8KI1aeb8/lemW106JSTcZ9dkilWrqsuq60rxWqWE=;
	b=C49UXK6hoBdoGofpl9Nley0gPMcvKzV2lupDXD/tQtiBM9g1Zaj9h/MdzFf2adDmeyhKpO
	Xdqkh2sIr0vuFJ+kFtVAQK1vyw6zidvoCQrgwXhuhwWIl487SAMhWKg4ZNsDhyzQ2dWSjF
	CtPH0wvu7TL6Z0DVf66fBCA7sQ+FUzQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-345-67YztAk_N4Sq9ZwNmo9hWw-1; Thu,
 30 Oct 2025 06:00:56 -0400
X-MC-Unique: 67YztAk_N4Sq9ZwNmo9hWw-1
X-Mimecast-MFC-AGG-ID: 67YztAk_N4Sq9ZwNmo9hWw_1761818455
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A1FEF1955E7F;
	Thu, 30 Oct 2025 10:00:55 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.22])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 86D8B19560B7;
	Thu, 30 Oct 2025 10:00:51 +0000 (UTC)
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
Subject: [PATCH v8 5/6] vduse: add vq group asid support
Date: Thu, 30 Oct 2025 11:00:24 +0100
Message-ID: <20251030100025.95113-6-eperezma@redhat.com>
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

Add support for assigning Address Space Identifiers (ASIDs) to each VQ
group.  This enables mapping each group into a distinct memory space.

Now that the driver can change ASID in the middle of operation, the
domain that each vq address point is also protected by domain_lock.

Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
v8:
* Revert the mutex to rwlock change, it needs proper profiling to
  justify it.

v7:
* Take write lock in the error path (Jason).

v6:
* Make vdpa_dev_add use gotos for error handling (MST).
* s/(dev->api_version < 1) ?/(dev->api_version < VDUSE_API_VERSION_1) ?/
  (MST).
* Fix struct name not matching in the doc.

v5:
* Properly return errno if copy_to_user returns >0 in VDUSE_IOTLB_GET_FD
  ioctl (Jason).
* Properly set domain bounce size to divide equally between nas (Jason).
* Exclude "padding" member from the only >V1 members in
  vduse_dev_request.

v4:
* Divide each domain bounce size between the device bounce size (Jason).
* revert unneeded addr = NULL assignment (Jason)
* Change if (x && (y || z)) return to if (x) { if (y) return; if (z)
  return; } (Jason)
* Change a bad multiline comment, using @ caracter instead of * (Jason).
* Consider config->nas == 0 as a fail (Jason).

v3:
* Get the vduse domain through the vduse_as in the map functions
  (Jason).
* Squash with the patch creating the vduse_as struct (Jason).
* Create VDUSE_DEV_MAX_AS instead of comparing agains a magic number
  (Jason)

v2:
* Convert the use of mutex to rwlock.

RFC v3:
* Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It was set to a lower
  value to reduce memory consumption, but vqs are already limited to
  that value and userspace VDUSE is able to allocate that many vqs.
* Remove TODO about merging VDUSE_IOTLB_GET_FD ioctl with
  VDUSE_IOTLB_GET_INFO.
* Use of array_index_nospec in VDUSE device ioctls.
* Embed vduse_iotlb_entry into vduse_iotlb_entry_v2.
* Move the umem mutex to asid struct so there is no contention between
  ASIDs.

RFC v2:
* Make iotlb entry the last one of vduse_iotlb_entry_v2 so the first
  part of the struct is the same.
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 348 ++++++++++++++++++++---------
 include/uapi/linux/vduse.h         |  53 ++++-
 2 files changed, 292 insertions(+), 109 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 97be04f73fbf..c6909d73d06d 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -41,6 +41,7 @@
 
 #define VDUSE_DEV_MAX (1U << MINORBITS)
 #define VDUSE_DEV_MAX_GROUPS 0xffff
+#define VDUSE_DEV_MAX_AS 0xffff
 #define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)
 #define VDUSE_MIN_BOUNCE_SIZE (1024 * 1024)
 #define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)
@@ -86,7 +87,14 @@ struct vduse_umem {
 	struct mm_struct *mm;
 };
 
+struct vduse_as {
+	struct vduse_iova_domain *domain;
+	struct vduse_umem *umem;
+	struct mutex mem_lock;
+};
+
 struct vduse_vq_group {
+	struct vduse_as *as;
 	struct vduse_dev *dev;
 };
 
@@ -94,7 +102,7 @@ struct vduse_dev {
 	struct vduse_vdpa *vdev;
 	struct device *dev;
 	struct vduse_virtqueue **vqs;
-	struct vduse_iova_domain *domain;
+	struct vduse_as *as;
 	char *name;
 	struct mutex lock;
 	spinlock_t msg_lock;
@@ -122,9 +130,8 @@ struct vduse_dev {
 	u32 vq_num;
 	u32 vq_align;
 	u32 ngroups;
-	struct vduse_umem *umem;
+	u32 nas;
 	struct vduse_vq_group *groups;
-	struct mutex mem_lock;
 	unsigned int bounce_size;
 	struct mutex domain_lock;
 };
@@ -314,7 +321,7 @@ static int vduse_dev_set_status(struct vduse_dev *dev, u8 status)
 	return vduse_dev_msg_sync(dev, &msg);
 }
 
-static int vduse_dev_update_iotlb(struct vduse_dev *dev,
+static int vduse_dev_update_iotlb(struct vduse_dev *dev, u32 asid,
 				  u64 start, u64 last)
 {
 	struct vduse_dev_msg msg = { 0 };
@@ -323,8 +330,14 @@ static int vduse_dev_update_iotlb(struct vduse_dev *dev,
 		return -EINVAL;
 
 	msg.req.type = VDUSE_UPDATE_IOTLB;
-	msg.req.iova.start = start;
-	msg.req.iova.last = last;
+	if (dev->api_version < VDUSE_API_VERSION_1) {
+		msg.req.iova.start = start;
+		msg.req.iova.last = last;
+	} else {
+		msg.req.iova_v2.start = start;
+		msg.req.iova_v2.last = last;
+		msg.req.iova_v2.asid = asid;
+	}
 
 	return vduse_dev_msg_sync(dev, &msg);
 }
@@ -436,14 +449,29 @@ static __poll_t vduse_dev_poll(struct file *file, poll_table *wait)
 	return mask;
 }
 
+/* Force set the asid to a vq group without a message to the VDUSE device */
+static void vduse_set_group_asid_nomsg(struct vduse_dev *dev,
+				       unsigned int group, unsigned int asid)
+{
+	mutex_lock(&dev->domain_lock);
+	dev->groups[group].as = &dev->as[asid];
+	mutex_unlock(&dev->domain_lock);
+}
+
 static void vduse_dev_reset(struct vduse_dev *dev)
 {
 	int i;
-	struct vduse_iova_domain *domain = dev->domain;
 
 	/* The coherent mappings are handled in vduse_dev_free_coherent() */
-	if (domain && domain->bounce_map)
-		vduse_domain_reset_bounce_map(domain);
+	for (i = 0; i < dev->nas; i++) {
+		struct vduse_iova_domain *domain = dev->as[i].domain;
+
+		if (domain && domain->bounce_map)
+			vduse_domain_reset_bounce_map(domain);
+	}
+
+	for (i = 0; i < dev->ngroups; i++)
+		vduse_set_group_asid_nomsg(dev, i, 0);
 
 	down_write(&dev->rwsem);
 
@@ -623,6 +651,29 @@ static union virtio_map vduse_get_vq_map(struct vdpa_device *vdpa, u16 idx)
 	return ret;
 }
 
+static int vduse_set_group_asid(struct vdpa_device *vdpa, unsigned int group,
+				unsigned int asid)
+{
+	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
+	struct vduse_dev_msg msg = { 0 };
+	int r;
+
+	if (dev->api_version < VDUSE_API_VERSION_1 ||
+	    group >= dev->ngroups || asid >= dev->nas)
+		return -EINVAL;
+
+	msg.req.type = VDUSE_SET_VQ_GROUP_ASID;
+	msg.req.vq_group_asid.group = group;
+	msg.req.vq_group_asid.asid = asid;
+
+	r = vduse_dev_msg_sync(dev, &msg);
+	if (r < 0)
+		return r;
+
+	vduse_set_group_asid_nomsg(dev, group, asid);
+	return 0;
+}
+
 static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx,
 				struct vdpa_vq_state *state)
 {
@@ -794,13 +845,13 @@ static int vduse_vdpa_set_map(struct vdpa_device *vdpa,
 	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
 	int ret;
 
-	ret = vduse_domain_set_map(dev->domain, iotlb);
+	ret = vduse_domain_set_map(dev->as[asid].domain, iotlb);
 	if (ret)
 		return ret;
 
-	ret = vduse_dev_update_iotlb(dev, 0ULL, ULLONG_MAX);
+	ret = vduse_dev_update_iotlb(dev, asid, 0ULL, ULLONG_MAX);
 	if (ret) {
-		vduse_domain_clear_map(dev->domain, iotlb);
+		vduse_domain_clear_map(dev->as[asid].domain, iotlb);
 		return ret;
 	}
 
@@ -843,6 +894,7 @@ static const struct vdpa_config_ops vduse_vdpa_config_ops = {
 	.get_vq_affinity	= vduse_vdpa_get_vq_affinity,
 	.reset			= vduse_vdpa_reset,
 	.set_map		= vduse_vdpa_set_map,
+	.set_group_asid		= vduse_set_group_asid,
 	.get_vq_map		= vduse_get_vq_map,
 	.free			= vduse_vdpa_free,
 };
@@ -858,9 +910,10 @@ static void vduse_dev_sync_single_for_device(union virtio_map token,
 		return;
 
 	vdev = token.group->dev;
-	domain = vdev->domain;
-
+	mutex_lock(&vdev->domain_lock);
+	domain = token.group->as->domain;
 	vduse_domain_sync_single_for_device(domain, dma_addr, size, dir);
+	mutex_unlock(&vdev->domain_lock);
 }
 
 static void vduse_dev_sync_single_for_cpu(union virtio_map token,
@@ -874,9 +927,10 @@ static void vduse_dev_sync_single_for_cpu(union virtio_map token,
 		return;
 
 	vdev = token.group->dev;
-	domain = vdev->domain;
-
+	mutex_lock(&vdev->domain_lock);
+	domain = token.group->as->domain;
 	vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir);
+	mutex_unlock(&vdev->domain_lock);
 }
 
 static dma_addr_t vduse_dev_map_page(union virtio_map token, struct page *page,
@@ -886,14 +940,18 @@ static dma_addr_t vduse_dev_map_page(union virtio_map token, struct page *page,
 {
 	struct vduse_dev *vdev;
 	struct vduse_iova_domain *domain;
+	dma_addr_t r;
 
 	if (!token.group)
 		return DMA_MAPPING_ERROR;
 
 	vdev = token.group->dev;
-	domain = vdev->domain;
+	mutex_lock(&vdev->domain_lock);
+	domain = token.group->as->domain;
+	r = vduse_domain_map_page(domain, page, offset, size, dir, attrs);
+	mutex_unlock(&vdev->domain_lock);
 
-	return vduse_domain_map_page(domain, page, offset, size, dir, attrs);
+	return r;
 }
 
 static void vduse_dev_unmap_page(union virtio_map token, dma_addr_t dma_addr,
@@ -907,9 +965,10 @@ static void vduse_dev_unmap_page(union virtio_map token, dma_addr_t dma_addr,
 		return;
 
 	vdev = token.group->dev;
-	domain = vdev->domain;
-
-	return vduse_domain_unmap_page(domain, dma_addr, size, dir, attrs);
+	mutex_lock(&vdev->domain_lock);
+	domain = token.group->as->domain;
+	vduse_domain_unmap_page(domain, dma_addr, size, dir, attrs);
+	mutex_unlock(&vdev->domain_lock);
 }
 
 static void *vduse_dev_alloc_coherent(union virtio_map token, size_t size,
@@ -925,14 +984,14 @@ static void *vduse_dev_alloc_coherent(union virtio_map token, size_t size,
 		return NULL;
 
 	vdev = token.group->dev;
-	domain = vdev->domain;
+	mutex_lock(&vdev->domain_lock);
+	domain = token.group->as->domain;
 	addr = vduse_domain_alloc_coherent(domain, size,
 					   (dma_addr_t *)&iova, flag);
-	if (!addr)
-		return NULL;
-
-	*dma_addr = (dma_addr_t)iova;
+	if (addr)
+		*dma_addr = (dma_addr_t)iova;
 
+	mutex_unlock(&vdev->domain_lock);
 	return addr;
 }
 
@@ -947,23 +1006,28 @@ static void vduse_dev_free_coherent(union virtio_map token, size_t size,
 		return;
 
 	vdev = token.group->dev;
-	domain = vdev->domain;
-
+	mutex_lock(&vdev->domain_lock);
+	domain = token.group->as->domain;
 	vduse_domain_free_coherent(domain, size, vaddr, dma_addr, attrs);
+	mutex_unlock(&vdev->domain_lock);
 }
 
 static bool vduse_dev_need_sync(union virtio_map token, dma_addr_t dma_addr)
 {
 	struct vduse_dev *vdev;
 	struct vduse_iova_domain *domain;
+	size_t bounce_size;
 
 	if (!token.group)
 		return false;
 
 	vdev = token.group->dev;
-	domain = vdev->domain;
+	mutex_lock(&vdev->domain_lock);
+	domain = token.group->as->domain;
+	bounce_size = domain->bounce_size;
+	mutex_unlock(&vdev->domain_lock);
 
-	return dma_addr < domain->bounce_size;
+	return dma_addr < bounce_size;
 }
 
 static int vduse_dev_mapping_error(union virtio_map token, dma_addr_t dma_addr)
@@ -977,14 +1041,18 @@ static size_t vduse_dev_max_mapping_size(union virtio_map token)
 {
 	struct vduse_dev *vdev;
 	struct vduse_iova_domain *domain;
+	size_t bounce_size;
 
 	if (!token.group)
 		return 0;
 
 	vdev = token.group->dev;
-	domain = vdev->domain;
+	mutex_lock(&vdev->domain_lock);
+	domain = token.group->as->domain;
+	bounce_size = domain->bounce_size;
+	mutex_unlock(&vdev->domain_lock);
 
-	return domain->bounce_size;
+	return bounce_size;
 }
 
 static const struct virtio_map_ops vduse_map_ops = {
@@ -1124,39 +1192,40 @@ static int vduse_dev_queue_irq_work(struct vduse_dev *dev,
 	return ret;
 }
 
-static int vduse_dev_dereg_umem(struct vduse_dev *dev,
+static int vduse_dev_dereg_umem(struct vduse_dev *dev, u32 asid,
 				u64 iova, u64 size)
 {
 	int ret;
 
-	mutex_lock(&dev->mem_lock);
+	mutex_lock(&dev->as[asid].mem_lock);
 	ret = -ENOENT;
-	if (!dev->umem)
+	if (!dev->as[asid].umem)
 		goto unlock;
 
 	ret = -EINVAL;
-	if (!dev->domain)
+	if (!dev->as[asid].domain)
 		goto unlock;
 
-	if (dev->umem->iova != iova || size != dev->domain->bounce_size)
+	if (dev->as[asid].umem->iova != iova ||
+	    size != dev->as[asid].domain->bounce_size)
 		goto unlock;
 
-	vduse_domain_remove_user_bounce_pages(dev->domain);
-	unpin_user_pages_dirty_lock(dev->umem->pages,
-				    dev->umem->npages, true);
-	atomic64_sub(dev->umem->npages, &dev->umem->mm->pinned_vm);
-	mmdrop(dev->umem->mm);
-	vfree(dev->umem->pages);
-	kfree(dev->umem);
-	dev->umem = NULL;
+	vduse_domain_remove_user_bounce_pages(dev->as[asid].domain);
+	unpin_user_pages_dirty_lock(dev->as[asid].umem->pages,
+				    dev->as[asid].umem->npages, true);
+	atomic64_sub(dev->as[asid].umem->npages, &dev->as[asid].umem->mm->pinned_vm);
+	mmdrop(dev->as[asid].umem->mm);
+	vfree(dev->as[asid].umem->pages);
+	kfree(dev->as[asid].umem);
+	dev->as[asid].umem = NULL;
 	ret = 0;
 unlock:
-	mutex_unlock(&dev->mem_lock);
+	mutex_unlock(&dev->as[asid].mem_lock);
 	return ret;
 }
 
 static int vduse_dev_reg_umem(struct vduse_dev *dev,
-			      u64 iova, u64 uaddr, u64 size)
+			      u32 asid, u64 iova, u64 uaddr, u64 size)
 {
 	struct page **page_list = NULL;
 	struct vduse_umem *umem = NULL;
@@ -1164,14 +1233,14 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev,
 	unsigned long npages, lock_limit;
 	int ret;
 
-	if (!dev->domain || !dev->domain->bounce_map ||
-	    size != dev->domain->bounce_size ||
+	if (!dev->as[asid].domain || !dev->as[asid].domain->bounce_map ||
+	    size != dev->as[asid].domain->bounce_size ||
 	    iova != 0 || uaddr & ~PAGE_MASK)
 		return -EINVAL;
 
-	mutex_lock(&dev->mem_lock);
+	mutex_lock(&dev->as[asid].mem_lock);
 	ret = -EEXIST;
-	if (dev->umem)
+	if (dev->as[asid].umem)
 		goto unlock;
 
 	ret = -ENOMEM;
@@ -1195,7 +1264,7 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev,
 		goto out;
 	}
 
-	ret = vduse_domain_add_user_bounce_pages(dev->domain,
+	ret = vduse_domain_add_user_bounce_pages(dev->as[asid].domain,
 						 page_list, pinned);
 	if (ret)
 		goto out;
@@ -1208,7 +1277,7 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev,
 	umem->mm = current->mm;
 	mmgrab(current->mm);
 
-	dev->umem = umem;
+	dev->as[asid].umem = umem;
 out:
 	if (ret && pinned > 0)
 		unpin_user_pages(page_list, pinned);
@@ -1219,7 +1288,7 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev,
 		vfree(page_list);
 		kfree(umem);
 	}
-	mutex_unlock(&dev->mem_lock);
+	mutex_unlock(&dev->as[asid].mem_lock);
 	return ret;
 }
 
@@ -1251,47 +1320,66 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 
 	switch (cmd) {
 	case VDUSE_IOTLB_GET_FD: {
-		struct vduse_iotlb_entry entry;
+		struct vduse_iotlb_entry_v2 entry;
 		struct vhost_iotlb_map *map;
 		struct vdpa_map_file *map_file;
 		struct file *f = NULL;
+		u32 asid;
 
 		ret = -EFAULT;
-		if (copy_from_user(&entry, argp, sizeof(entry)))
-			break;
+		if (dev->api_version >= VDUSE_API_VERSION_1) {
+			if (copy_from_user(&entry, argp, sizeof(entry)))
+				break;
+		} else {
+			entry.asid = 0;
+			if (copy_from_user(&entry.v1, argp,
+					   sizeof(entry.v1)))
+				break;
+		}
 
 		ret = -EINVAL;
-		if (entry.start > entry.last)
+		if (entry.v1.start > entry.v1.last)
+			break;
+
+		if (entry.asid >= dev->nas)
 			break;
 
 		mutex_lock(&dev->domain_lock);
-		if (!dev->domain) {
+		asid = array_index_nospec(entry.asid, dev->nas);
+		if (!dev->as[asid].domain) {
 			mutex_unlock(&dev->domain_lock);
 			break;
 		}
-		spin_lock(&dev->domain->iotlb_lock);
-		map = vhost_iotlb_itree_first(dev->domain->iotlb,
-					      entry.start, entry.last);
+		spin_lock(&dev->as[asid].domain->iotlb_lock);
+		map = vhost_iotlb_itree_first(dev->as[asid].domain->iotlb,
+					      entry.v1.start, entry.v1.last);
 		if (map) {
 			map_file = (struct vdpa_map_file *)map->opaque;
 			f = get_file(map_file->file);
-			entry.offset = map_file->offset;
-			entry.start = map->start;
-			entry.last = map->last;
-			entry.perm = map->perm;
+			entry.v1.offset = map_file->offset;
+			entry.v1.start = map->start;
+			entry.v1.last = map->last;
+			entry.v1.perm = map->perm;
 		}
-		spin_unlock(&dev->domain->iotlb_lock);
+		spin_unlock(&dev->as[asid].domain->iotlb_lock);
 		mutex_unlock(&dev->domain_lock);
 		ret = -EINVAL;
 		if (!f)
 			break;
 
-		ret = -EFAULT;
-		if (copy_to_user(argp, &entry, sizeof(entry))) {
+		if (dev->api_version >= VDUSE_API_VERSION_1)
+			ret = copy_to_user(argp, &entry,
+					   sizeof(entry));
+		else
+			ret = copy_to_user(argp, &entry.v1,
+					   sizeof(entry.v1));
+
+		if (ret) {
+			ret = -EFAULT;
 			fput(f);
 			break;
 		}
-		ret = receive_fd(f, NULL, perm_to_file_flags(entry.perm));
+		ret = receive_fd(f, NULL, perm_to_file_flags(entry.v1.perm));
 		fput(f);
 		break;
 	}
@@ -1436,6 +1524,7 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 	}
 	case VDUSE_IOTLB_REG_UMEM: {
 		struct vduse_iova_umem umem;
+		u32 asid;
 
 		ret = -EFAULT;
 		if (copy_from_user(&umem, argp, sizeof(umem)))
@@ -1443,17 +1532,21 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 
 		ret = -EINVAL;
 		if (!is_mem_zero((const char *)umem.reserved,
-				 sizeof(umem.reserved)))
+				 sizeof(umem.reserved)) ||
+		    (dev->api_version < VDUSE_API_VERSION_1 &&
+		     umem.asid != 0) || umem.asid >= dev->nas)
 			break;
 
 		mutex_lock(&dev->domain_lock);
-		ret = vduse_dev_reg_umem(dev, umem.iova,
+		asid = array_index_nospec(umem.asid, dev->nas);
+		ret = vduse_dev_reg_umem(dev, asid, umem.iova,
 					 umem.uaddr, umem.size);
 		mutex_unlock(&dev->domain_lock);
 		break;
 	}
 	case VDUSE_IOTLB_DEREG_UMEM: {
 		struct vduse_iova_umem umem;
+		u32 asid;
 
 		ret = -EFAULT;
 		if (copy_from_user(&umem, argp, sizeof(umem)))
@@ -1461,10 +1554,15 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 
 		ret = -EINVAL;
 		if (!is_mem_zero((const char *)umem.reserved,
-				 sizeof(umem.reserved)))
+				 sizeof(umem.reserved)) ||
+		    (dev->api_version < VDUSE_API_VERSION_1 &&
+		     umem.asid != 0) ||
+		     umem.asid >= dev->nas)
 			break;
+
 		mutex_lock(&dev->domain_lock);
-		ret = vduse_dev_dereg_umem(dev, umem.iova,
+		asid = array_index_nospec(umem.asid, dev->nas);
+		ret = vduse_dev_dereg_umem(dev, asid, umem.iova,
 					   umem.size);
 		mutex_unlock(&dev->domain_lock);
 		break;
@@ -1472,6 +1570,7 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 	case VDUSE_IOTLB_GET_INFO: {
 		struct vduse_iova_info info;
 		struct vhost_iotlb_map *map;
+		u32 asid;
 
 		ret = -EFAULT;
 		if (copy_from_user(&info, argp, sizeof(info)))
@@ -1485,23 +1584,31 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 				 sizeof(info.reserved)))
 			break;
 
+		if (dev->api_version < VDUSE_API_VERSION_1) {
+			if (info.asid)
+				break;
+		} else if (info.asid >= dev->nas)
+			break;
+
 		mutex_lock(&dev->domain_lock);
-		if (!dev->domain) {
+		asid = array_index_nospec(info.asid, dev->nas);
+		if (!dev->as[asid].domain) {
 			mutex_unlock(&dev->domain_lock);
 			break;
 		}
-		spin_lock(&dev->domain->iotlb_lock);
-		map = vhost_iotlb_itree_first(dev->domain->iotlb,
+		spin_lock(&dev->as[asid].domain->iotlb_lock);
+		map = vhost_iotlb_itree_first(dev->as[asid].domain->iotlb,
 					      info.start, info.last);
 		if (map) {
 			info.start = map->start;
 			info.last = map->last;
 			info.capability = 0;
-			if (dev->domain->bounce_map && map->start == 0 &&
-			    map->last == dev->domain->bounce_size - 1)
+			if (dev->as[asid].domain->bounce_map &&
+			    map->start == 0 &&
+			    map->last == dev->as[asid].domain->bounce_size - 1)
 				info.capability |= VDUSE_IOVA_CAP_UMEM;
 		}
-		spin_unlock(&dev->domain->iotlb_lock);
+		spin_unlock(&dev->as[asid].domain->iotlb_lock);
 		mutex_unlock(&dev->domain_lock);
 		if (!map)
 			break;
@@ -1526,8 +1633,10 @@ static int vduse_dev_release(struct inode *inode, struct file *file)
 	struct vduse_dev *dev = file->private_data;
 
 	mutex_lock(&dev->domain_lock);
-	if (dev->domain)
-		vduse_dev_dereg_umem(dev, 0, dev->domain->bounce_size);
+	for (int i = 0; i < dev->nas; i++)
+		if (dev->as[i].domain)
+			vduse_dev_dereg_umem(dev, i, 0,
+					     dev->as[i].domain->bounce_size);
 	mutex_unlock(&dev->domain_lock);
 	spin_lock(&dev->msg_lock);
 	/* Make sure the inflight messages can processed after reconncection */
@@ -1746,7 +1855,6 @@ static struct vduse_dev *vduse_dev_create(void)
 		return NULL;
 
 	mutex_init(&dev->lock);
-	mutex_init(&dev->mem_lock);
 	mutex_init(&dev->domain_lock);
 	spin_lock_init(&dev->msg_lock);
 	INIT_LIST_HEAD(&dev->send_list);
@@ -1797,8 +1905,11 @@ static int vduse_destroy_dev(char *name)
 	idr_remove(&vduse_idr, dev->minor);
 	kvfree(dev->config);
 	vduse_dev_deinit_vqs(dev);
-	if (dev->domain)
-		vduse_domain_destroy(dev->domain);
+	for (int i = 0; i < dev->nas; i++) {
+		if (dev->as[i].domain)
+			vduse_domain_destroy(dev->as[i].domain);
+	}
+	kfree(dev->as);
 	kfree(dev->name);
 	kfree(dev->groups);
 	vduse_dev_destroy(dev);
@@ -1845,12 +1956,17 @@ static bool vduse_validate_config(struct vduse_dev_config *config,
 			 sizeof(config->reserved)))
 		return false;
 
-	if (api_version < VDUSE_API_VERSION_1 && config->ngroups)
+	if (api_version < VDUSE_API_VERSION_1 &&
+	    (config->ngroups || config->nas))
 		return false;
 
-	if (api_version >= VDUSE_API_VERSION_1 &&
-	    (!config->ngroups || config->ngroups > VDUSE_DEV_MAX_GROUPS))
-		return false;
+	if (api_version >= VDUSE_API_VERSION_1) {
+		if (!config->ngroups || config->ngroups > VDUSE_DEV_MAX_GROUPS)
+			return false;
+
+		if (!config->nas || config->nas > VDUSE_DEV_MAX_AS)
+			return false;
+	}
 
 	if (config->vq_align > PAGE_SIZE)
 		return false;
@@ -1915,7 +2031,8 @@ static ssize_t bounce_size_store(struct device *device,
 
 	ret = -EPERM;
 	mutex_lock(&dev->domain_lock);
-	if (dev->domain)
+	/* Assuming that if the first domain is allocated, all are allocated */
+	if (dev->as[0].domain)
 		goto unlock;
 
 	ret = kstrtouint(buf, 10, &bounce_size);
@@ -1977,6 +2094,13 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 	for (u32 i = 0; i < dev->ngroups; ++i)
 		dev->groups[i].dev = dev;
 
+	dev->nas = (dev->api_version < VDUSE_API_VERSION_1) ? 1 : config->nas;
+	dev->as = kcalloc(dev->nas, sizeof(dev->as[0]), GFP_KERNEL);
+	if (!dev->as)
+		goto err_as;
+	for (int i = 0; i < dev->nas; i++)
+		mutex_init(&dev->as[i].mem_lock);
+
 	dev->name = kstrdup(config->name, GFP_KERNEL);
 	if (!dev->name)
 		goto err_str;
@@ -2013,6 +2137,8 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 err_idr:
 	kfree(dev->name);
 err_str:
+	kfree(dev->as);
+err_as:
 	kfree(dev->groups);
 err_vq_groups:
 	vduse_dev_destroy(dev);
@@ -2138,7 +2264,7 @@ static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *name)
 
 	vdev = vdpa_alloc_device(struct vduse_vdpa, vdpa, dev->dev,
 				 &vduse_vdpa_config_ops, &vduse_map_ops,
-				 dev->ngroups, 1, name, true);
+				 dev->ngroups, dev->nas, name, true);
 	if (IS_ERR(vdev))
 		return PTR_ERR(vdev);
 
@@ -2153,7 +2279,8 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 			const struct vdpa_dev_set_config *config)
 {
 	struct vduse_dev *dev;
-	int ret;
+	size_t domain_bounce_size;
+	int ret, i;
 
 	mutex_lock(&vduse_lock);
 	dev = vduse_find_dev(name);
@@ -2167,29 +2294,38 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 		return ret;
 
 	mutex_lock(&dev->domain_lock);
-	if (!dev->domain)
-		dev->domain = vduse_domain_create(VDUSE_IOVA_SIZE - 1,
-						  dev->bounce_size);
-	mutex_unlock(&dev->domain_lock);
-	if (!dev->domain) {
-		ret = -ENOMEM;
-		goto domain_err;
+	ret = 0;
+
+	domain_bounce_size = dev->bounce_size / dev->nas;
+	for (i = 0; i < dev->nas; ++i) {
+		dev->as[i].domain = vduse_domain_create(VDUSE_IOVA_SIZE - 1,
+							domain_bounce_size);
+		if (!dev->as[i].domain) {
+			ret = -ENOMEM;
+			goto err;
+		}
 	}
 
+	mutex_unlock(&dev->domain_lock);
+
 	ret = _vdpa_register_device(&dev->vdev->vdpa, dev->vq_num);
-	if (ret) {
-		goto register_err;
-	}
+	if (ret)
+		goto err_register;
 
 	return 0;
 
-register_err:
+err_register:
 	mutex_lock(&dev->domain_lock);
-	vduse_domain_destroy(dev->domain);
-	dev->domain = NULL;
+
+err:
+	for (int j = 0; j < i; j++) {
+		if (dev->as[j].domain) {
+			vduse_domain_destroy(dev->as[j].domain);
+			dev->as[j].domain = NULL;
+		}
+	}
 	mutex_unlock(&dev->domain_lock);
 
-domain_err:
 	put_device(&dev->vdev->vdpa.dev);
 
 	return ret;
diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
index a3d51cf6df3a..da2c5e47990e 100644
--- a/include/uapi/linux/vduse.h
+++ b/include/uapi/linux/vduse.h
@@ -47,7 +47,8 @@ struct vduse_dev_config {
 	__u32 vq_num;
 	__u32 vq_align;
 	__u32 ngroups; /* if VDUSE_API_VERSION >= 1 */
-	__u32 reserved[12];
+	__u32 nas; /* if VDUSE_API_VERSION >= 1 */
+	__u32 reserved[11];
 	__u32 config_size;
 	__u8 config[];
 };
@@ -82,6 +83,18 @@ struct vduse_iotlb_entry {
 	__u8 perm;
 };
 
+/**
+ * struct vduse_iotlb_entry_v2 - entry of IOTLB to describe one IOVA region in an ASID
+ * @v1: the original vduse_iotlb_entry
+ * @asid: address space ID of the IOVA region
+ *
+ * Structure used by VDUSE_IOTLB_GET_FD ioctl to find an overlapped IOVA region.
+ */
+struct vduse_iotlb_entry_v2 {
+	struct vduse_iotlb_entry v1;
+	__u32 asid;
+};
+
 /*
  * Find the first IOVA region that overlaps with the range [start, last]
  * and return the corresponding file descriptor. Return -EINVAL means the
@@ -166,6 +179,16 @@ struct vduse_vq_state_packed {
 	__u16 last_used_idx;
 };
 
+/**
+ * struct vduse_vq_group_asid - virtqueue group ASID
+ * @group: Index of the virtqueue group
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
@@ -225,6 +248,7 @@ struct vduse_vq_eventfd {
  * @uaddr: start address of userspace memory, it must be aligned to page size
  * @iova: start of the IOVA region
  * @size: size of the IOVA region
+ * @asid: Address space ID of the IOVA region
  * @reserved: for future use, needs to be initialized to zero
  *
  * Structure used by VDUSE_IOTLB_REG_UMEM and VDUSE_IOTLB_DEREG_UMEM
@@ -234,7 +258,8 @@ struct vduse_iova_umem {
 	__u64 uaddr;
 	__u64 iova;
 	__u64 size;
-	__u64 reserved[3];
+	__u32 asid;
+	__u32 reserved[5];
 };
 
 /* Register userspace memory for IOVA regions */
@@ -248,6 +273,7 @@ struct vduse_iova_umem {
  * @start: start of the IOVA region
  * @last: last of the IOVA region
  * @capability: capability of the IOVA region
+ * @asid: Address space ID of the IOVA region, only if device API version >= 1
  * @reserved: for future use, needs to be initialized to zero
  *
  * Structure used by VDUSE_IOTLB_GET_INFO ioctl to get information of
@@ -258,7 +284,8 @@ struct vduse_iova_info {
 	__u64 last;
 #define VDUSE_IOVA_CAP_UMEM (1 << 0)
 	__u64 capability;
-	__u64 reserved[3];
+	__u32 asid; /* Only if device API version >= 1 */
+	__u32 reserved[5];
 };
 
 /*
@@ -280,6 +307,7 @@ enum vduse_req_type {
 	VDUSE_GET_VQ_STATE,
 	VDUSE_SET_STATUS,
 	VDUSE_UPDATE_IOTLB,
+	VDUSE_SET_VQ_GROUP_ASID,
 };
 
 /**
@@ -314,6 +342,18 @@ struct vduse_iova_range {
 	__u64 last;
 };
 
+/**
+ * struct vduse_iova_range - IOVA range [start, last] if API_VERSION >= 1
+ * @start: start of the IOVA range
+ * @last: last of the IOVA range
+ * @asid: address space ID of the IOVA range
+ */
+struct vduse_iova_range_v2 {
+	__u64 start;
+	__u64 last;
+	__u32 asid;
+};
+
 /**
  * struct vduse_dev_request - control request
  * @type: request type
@@ -322,6 +362,8 @@ struct vduse_iova_range {
  * @vq_state: virtqueue state, only index field is available
  * @s: device status
  * @iova: IOVA range for updating
+ * @iova_v2: IOVA range for updating if API_VERSION >= 1
+ * @vq_group_asid: ASID of a virtqueue group
  * @padding: padding
  *
  * Structure used by read(2) on /dev/vduse/$NAME.
@@ -334,6 +376,11 @@ struct vduse_dev_request {
 		struct vduse_vq_state vq_state;
 		struct vduse_dev_status s;
 		struct vduse_iova_range iova;
+		/* Following members but padding exist only if vduse api
+		 * version >= 1
+		 */;
+		struct vduse_iova_range_v2 iova_v2;
+		struct vduse_vq_group_asid vq_group_asid;
 		__u32 padding[32];
 	};
 };
-- 
2.51.0

