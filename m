Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B30A3093AB
	for <virtualization@lists.linux.dev>; Tue, 26 Aug 2025 11:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756207663; cv=none; b=DbzUlXclmsoYMQQvo//9reEbKIoV4fm2H3gD/30/9U8Ouvrxy3FIkXw9l4M9oqbyoc7RwNnUBnv75jGrPjXWeVJScxEtPASrJIYDdJdUXbb+ldPQaxQ09IbCSlc8Gw+Ki8tlOUQ9ACQkxBuX652m1bVKUE5I+0sV9Sde7xdpg4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756207663; c=relaxed/simple;
	bh=c7np7wFs5C7h4kp6DPHDmZu+HWXGPh/Vk8/YfTB0+hY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C6wWr4u9frJZ7/QIvjVNlUsm/koFvnPImpVvUbOOvYm0Gfdr9ehtC/w1+dFakQtFhuFY/1zwUC0iwJ4WkjHn8wccbaQQhYAnxj+cj4gGOI5KALAVYJ4/xiCTYDQbhE6DR1p9a4BYY7E6rDEFNVtvCjy3i73OAoyg5e3oC5vwCow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ayN4VL6l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ayN4VL6l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756207660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yx4vb+s5ggcUcQEddBgN/ctZ6bRxzwXy1Ly3fxABGVw=;
	b=ayN4VL6lMVVvakRA0LIin8Fykt8nhgtzTBOiV/It/7po2i9BCjp96CVhQmDgq/F6Nf3SMg
	TyMcn1wz0FVye1IwgUaRYyel+dxqDIjDpR+JRCeeosFh8iqnIB/3axRwrx6NncYiZxQN0E
	TfrizgEDZbQrEvn/hLDa/7yfsyRFN6M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-348-xFH7A1pwP3GVWuE7v-3eaA-1; Tue,
 26 Aug 2025 07:27:35 -0400
X-MC-Unique: xFH7A1pwP3GVWuE7v-3eaA-1
X-Mimecast-MFC-AGG-ID: xFH7A1pwP3GVWuE7v-3eaA_1756207654
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6ED6A180035C;
	Tue, 26 Aug 2025 11:27:34 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.67])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 63E071800280;
	Tue, 26 Aug 2025 11:27:29 +0000 (UTC)
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
Subject: [PATCH 4/6] vduse: create vduse_as to make it an array
Date: Tue, 26 Aug 2025 13:27:07 +0200
Message-ID: <20250826112709.1051172-5-eperezma@redhat.com>
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

This is a first step so we can make more than one different address
spaces.  No change on the colde flow intended.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 114 +++++++++++++++--------------
 1 file changed, 59 insertions(+), 55 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index cdb3dc2b5e3f..7d2a3ed77b1e 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -85,6 +85,12 @@ struct vduse_umem {
 	struct mm_struct *mm;
 };
 
+struct vduse_as {
+	struct vduse_iova_domain *domain;
+	struct vduse_umem *umem;
+	struct mutex mem_lock;
+};
+
 struct vduse_vq_group_int {
 	struct vduse_dev *dev;
 };
@@ -93,7 +99,7 @@ struct vduse_dev {
 	struct vduse_vdpa *vdev;
 	struct device *dev;
 	struct vduse_virtqueue **vqs;
-	struct vduse_iova_domain *domain;
+	struct vduse_as as;
 	char *name;
 	struct mutex lock;
 	spinlock_t msg_lock;
@@ -121,9 +127,7 @@ struct vduse_dev {
 	u32 vq_num;
 	u32 vq_align;
 	u32 ngroups;
-	struct vduse_umem *umem;
 	struct vduse_vq_group_int *groups;
-	struct mutex mem_lock;
 	unsigned int bounce_size;
 	struct mutex domain_lock;
 };
@@ -438,7 +442,7 @@ static __poll_t vduse_dev_poll(struct file *file, poll_table *wait)
 static void vduse_dev_reset(struct vduse_dev *dev)
 {
 	int i;
-	struct vduse_iova_domain *domain = dev->domain;
+	struct vduse_iova_domain *domain = dev->as.domain;
 
 	/* The coherent mappings are handled in vduse_dev_free_coherent() */
 	if (domain && domain->bounce_map)
@@ -814,13 +818,13 @@ static int vduse_vdpa_set_map(struct vdpa_device *vdpa,
 	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
 	int ret;
 
-	ret = vduse_domain_set_map(dev->domain, iotlb);
+	ret = vduse_domain_set_map(dev->as.domain, iotlb);
 	if (ret)
 		return ret;
 
 	ret = vduse_dev_update_iotlb(dev, 0ULL, ULLONG_MAX);
 	if (ret) {
-		vduse_domain_clear_map(dev->domain, iotlb);
+		vduse_domain_clear_map(dev->as.domain, iotlb);
 		return ret;
 	}
 
@@ -872,7 +876,7 @@ static void vduse_dev_sync_single_for_device(union virtio_map token,
 					     enum dma_data_direction dir)
 {
 	struct vduse_dev *vdev = token.group->dev;
-	struct vduse_iova_domain *domain = vdev->domain;
+	struct vduse_iova_domain *domain = vdev->as.domain;
 
 	vduse_domain_sync_single_for_device(domain, dma_addr, size, dir);
 }
@@ -882,7 +886,7 @@ static void vduse_dev_sync_single_for_cpu(union virtio_map token,
 					     enum dma_data_direction dir)
 {
 	struct vduse_dev *vdev = token.group->dev;
-	struct vduse_iova_domain *domain = vdev->domain;
+	struct vduse_iova_domain *domain = vdev->as.domain;
 
 	vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir);
 }
@@ -893,7 +897,7 @@ static dma_addr_t vduse_dev_map_page(union virtio_map token, struct page *page,
 				     unsigned long attrs)
 {
 	struct vduse_dev *vdev = token.group->dev;
-	struct vduse_iova_domain *domain = vdev->domain;
+	struct vduse_iova_domain *domain = vdev->as.domain;
 
 	return vduse_domain_map_page(domain, page, offset, size, dir, attrs);
 }
@@ -903,7 +907,7 @@ static void vduse_dev_unmap_page(union virtio_map token, dma_addr_t dma_addr,
 				 unsigned long attrs)
 {
 	struct vduse_dev *vdev = token.group->dev;
-	struct vduse_iova_domain *domain = vdev->domain;
+	struct vduse_iova_domain *domain = vdev->as.domain;
 
 	return vduse_domain_unmap_page(domain, dma_addr, size, dir, attrs);
 }
@@ -912,7 +916,7 @@ static void *vduse_dev_alloc_coherent(union virtio_map token, size_t size,
 				      dma_addr_t *dma_addr, gfp_t flag)
 {
 	struct vduse_dev *vdev = token.group->dev;
-	struct vduse_iova_domain *domain = vdev->domain;
+	struct vduse_iova_domain *domain = vdev->as.domain;
 	unsigned long iova;
 	void *addr;
 
@@ -932,7 +936,7 @@ static void vduse_dev_free_coherent(union virtio_map token, size_t size,
 				    unsigned long attrs)
 {
 	struct vduse_dev *vdev = token.group->dev;
-	struct vduse_iova_domain *domain = vdev->domain;
+	struct vduse_iova_domain *domain = vdev->as.domain;
 
 	vduse_domain_free_coherent(domain, size, vaddr, dma_addr, attrs);
 }
@@ -940,7 +944,7 @@ static void vduse_dev_free_coherent(union virtio_map token, size_t size,
 static bool vduse_dev_need_sync(union virtio_map token, dma_addr_t dma_addr)
 {
 	struct vduse_dev *vdev = token.group->dev;
-	struct vduse_iova_domain *domain = vdev->domain;
+	struct vduse_iova_domain *domain = vdev->as.domain;
 
 	return dma_addr < domain->bounce_size;
 }
@@ -955,7 +959,7 @@ static int vduse_dev_mapping_error(union virtio_map token, dma_addr_t dma_addr)
 static size_t vduse_dev_max_mapping_size(union virtio_map token)
 {
 	struct vduse_dev *vdev = token.group->dev;
-	struct vduse_iova_domain *domain = vdev->domain;
+	struct vduse_iova_domain *domain = vdev->as.domain;
 
 	return domain->bounce_size;
 }
@@ -1102,29 +1106,29 @@ static int vduse_dev_dereg_umem(struct vduse_dev *dev,
 {
 	int ret;
 
-	mutex_lock(&dev->mem_lock);
+	mutex_lock(&dev->as.mem_lock);
 	ret = -ENOENT;
-	if (!dev->umem)
+	if (!dev->as.umem)
 		goto unlock;
 
 	ret = -EINVAL;
-	if (!dev->domain)
+	if (!dev->as.domain)
 		goto unlock;
 
-	if (dev->umem->iova != iova || size != dev->domain->bounce_size)
+	if (dev->as.umem->iova != iova || size != dev->as.domain->bounce_size)
 		goto unlock;
 
-	vduse_domain_remove_user_bounce_pages(dev->domain);
-	unpin_user_pages_dirty_lock(dev->umem->pages,
-				    dev->umem->npages, true);
-	atomic64_sub(dev->umem->npages, &dev->umem->mm->pinned_vm);
-	mmdrop(dev->umem->mm);
-	vfree(dev->umem->pages);
-	kfree(dev->umem);
-	dev->umem = NULL;
+	vduse_domain_remove_user_bounce_pages(dev->as.domain);
+	unpin_user_pages_dirty_lock(dev->as.umem->pages,
+				    dev->as.umem->npages, true);
+	atomic64_sub(dev->as.umem->npages, &dev->as.umem->mm->pinned_vm);
+	mmdrop(dev->as.umem->mm);
+	vfree(dev->as.umem->pages);
+	kfree(dev->as.umem);
+	dev->as.umem = NULL;
 	ret = 0;
 unlock:
-	mutex_unlock(&dev->mem_lock);
+	mutex_unlock(&dev->as.mem_lock);
 	return ret;
 }
 
@@ -1137,14 +1141,14 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev,
 	unsigned long npages, lock_limit;
 	int ret;
 
-	if (!dev->domain || !dev->domain->bounce_map ||
-	    size != dev->domain->bounce_size ||
+	if (!dev->as.domain || !dev->as.domain->bounce_map ||
+	    size != dev->as.domain->bounce_size ||
 	    iova != 0 || uaddr & ~PAGE_MASK)
 		return -EINVAL;
 
-	mutex_lock(&dev->mem_lock);
+	mutex_lock(&dev->as.mem_lock);
 	ret = -EEXIST;
-	if (dev->umem)
+	if (dev->as.umem)
 		goto unlock;
 
 	ret = -ENOMEM;
@@ -1168,7 +1172,7 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev,
 		goto out;
 	}
 
-	ret = vduse_domain_add_user_bounce_pages(dev->domain,
+	ret = vduse_domain_add_user_bounce_pages(dev->as.domain,
 						 page_list, pinned);
 	if (ret)
 		goto out;
@@ -1181,7 +1185,7 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev,
 	umem->mm = current->mm;
 	mmgrab(current->mm);
 
-	dev->umem = umem;
+	dev->as.umem = umem;
 out:
 	if (ret && pinned > 0)
 		unpin_user_pages(page_list, pinned);
@@ -1192,7 +1196,7 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev,
 		vfree(page_list);
 		kfree(umem);
 	}
-	mutex_unlock(&dev->mem_lock);
+	mutex_unlock(&dev->as.mem_lock);
 	return ret;
 }
 
@@ -1238,12 +1242,12 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 			break;
 
 		mutex_lock(&dev->domain_lock);
-		if (!dev->domain) {
+		if (!dev->as.domain) {
 			mutex_unlock(&dev->domain_lock);
 			break;
 		}
-		spin_lock(&dev->domain->iotlb_lock);
-		map = vhost_iotlb_itree_first(dev->domain->iotlb,
+		spin_lock(&dev->as.domain->iotlb_lock);
+		map = vhost_iotlb_itree_first(dev->as.domain->iotlb,
 					      entry.start, entry.last);
 		if (map) {
 			map_file = (struct vdpa_map_file *)map->opaque;
@@ -1253,7 +1257,7 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 			entry.last = map->last;
 			entry.perm = map->perm;
 		}
-		spin_unlock(&dev->domain->iotlb_lock);
+		spin_unlock(&dev->as.domain->iotlb_lock);
 		mutex_unlock(&dev->domain_lock);
 		ret = -EINVAL;
 		if (!f)
@@ -1447,22 +1451,22 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 			break;
 
 		mutex_lock(&dev->domain_lock);
-		if (!dev->domain) {
+		if (!dev->as.domain) {
 			mutex_unlock(&dev->domain_lock);
 			break;
 		}
-		spin_lock(&dev->domain->iotlb_lock);
-		map = vhost_iotlb_itree_first(dev->domain->iotlb,
+		spin_lock(&dev->as.domain->iotlb_lock);
+		map = vhost_iotlb_itree_first(dev->as.domain->iotlb,
 					      info.start, info.last);
 		if (map) {
 			info.start = map->start;
 			info.last = map->last;
 			info.capability = 0;
-			if (dev->domain->bounce_map && map->start == 0 &&
-			    map->last == dev->domain->bounce_size - 1)
+			if (dev->as.domain->bounce_map && map->start == 0 &&
+			    map->last == dev->as.domain->bounce_size - 1)
 				info.capability |= VDUSE_IOVA_CAP_UMEM;
 		}
-		spin_unlock(&dev->domain->iotlb_lock);
+		spin_unlock(&dev->as.domain->iotlb_lock);
 		mutex_unlock(&dev->domain_lock);
 		if (!map)
 			break;
@@ -1487,8 +1491,8 @@ static int vduse_dev_release(struct inode *inode, struct file *file)
 	struct vduse_dev *dev = file->private_data;
 
 	mutex_lock(&dev->domain_lock);
-	if (dev->domain)
-		vduse_dev_dereg_umem(dev, 0, dev->domain->bounce_size);
+	if (dev->as.domain)
+		vduse_dev_dereg_umem(dev, 0, dev->as.domain->bounce_size);
 	mutex_unlock(&dev->domain_lock);
 	spin_lock(&dev->msg_lock);
 	/* Make sure the inflight messages can processed after reconncection */
@@ -1707,7 +1711,7 @@ static struct vduse_dev *vduse_dev_create(void)
 		return NULL;
 
 	mutex_init(&dev->lock);
-	mutex_init(&dev->mem_lock);
+	mutex_init(&dev->as.mem_lock);
 	mutex_init(&dev->domain_lock);
 	spin_lock_init(&dev->msg_lock);
 	INIT_LIST_HEAD(&dev->send_list);
@@ -1758,8 +1762,8 @@ static int vduse_destroy_dev(char *name)
 	idr_remove(&vduse_idr, dev->minor);
 	kvfree(dev->config);
 	vduse_dev_deinit_vqs(dev);
-	if (dev->domain)
-		vduse_domain_destroy(dev->domain);
+	if (dev->as.domain)
+		vduse_domain_destroy(dev->as.domain);
 	kfree(dev->name);
 	kfree(dev->groups);
 	vduse_dev_destroy(dev);
@@ -1875,7 +1879,7 @@ static ssize_t bounce_size_store(struct device *device,
 
 	ret = -EPERM;
 	mutex_lock(&dev->domain_lock);
-	if (dev->domain)
+	if (dev->as.domain)
 		goto unlock;
 
 	ret = kstrtouint(buf, 10, &bounce_size);
@@ -2126,11 +2130,11 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 		return ret;
 
 	mutex_lock(&dev->domain_lock);
-	if (!dev->domain)
-		dev->domain = vduse_domain_create(VDUSE_IOVA_SIZE - 1,
+	if (!dev->as.domain)
+		dev->as.domain = vduse_domain_create(VDUSE_IOVA_SIZE - 1,
 						  dev->bounce_size);
 	mutex_unlock(&dev->domain_lock);
-	if (!dev->domain) {
+	if (!dev->as.domain) {
 		put_device(&dev->vdev->vdpa.dev);
 		return -ENOMEM;
 	}
@@ -2139,8 +2143,8 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	if (ret) {
 		put_device(&dev->vdev->vdpa.dev);
 		mutex_lock(&dev->domain_lock);
-		vduse_domain_destroy(dev->domain);
-		dev->domain = NULL;
+		vduse_domain_destroy(dev->as.domain);
+		dev->as.domain = NULL;
 		mutex_unlock(&dev->domain_lock);
 		return ret;
 	}
-- 
2.51.0

