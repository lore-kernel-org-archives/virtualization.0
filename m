Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FC231B138
	for <virtualization@lists.linux.dev>; Tue, 16 Sep 2025 13:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758028152; cv=none; b=f6IIVR7DiV20SAIGyhY6NtRml1VvqdUGTYdTOs0AQryqSoa8U4tGjgh/+SCVZa8JhW5g8w5Stez6qxm99kgd9RMriy5A2h9KCJFP5g1II8DJs21QEdrlWlnt4NT4RAypOjMXsFj1EXky9cjHlUImTYwUcUxqws5rkpDMtNYzFgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758028152; c=relaxed/simple;
	bh=dliCQynGAe/gHAOPKDRtB9YPRIonGYk4YALBzZAI21c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L+TjR78bQtUpkCUhHYRMU6uSzJL5CsbltKuhGgH/KJdzXvjjJOeYoCLtRAksaMKRHPHRdAn5iYtb1hZwyEK8rB05KWfsRc+K5Fraijr3+o470D3O+09s65Us8ljH64jigYk+Hh3bRNIjnSv7kBE93DienJyczfbhtBIEdoSE5Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NBp0TUXH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NBp0TUXH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758028149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uixg72Jfkxev7ts5faGYDDwpmN8VEFxGF3BrCV5rlv0=;
	b=NBp0TUXHzc6LU7mO9Z6RhqmYFSfJS3IpzDFIGZgCcCyDqaIYs2bKVR2CcoPNMEIucR2GM6
	C7KPfSm+OoY94NvPZ8Bzju39CzRPjnWrJ0on6VpSuKZ1RFE1G+FTJRgIwmPnnmCjrGHNhB
	n7v9TRPzVtuomrfKT83i8aQP+DytSFI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-52-Q0xQhW6PP_-YAzBi9gm63g-1; Tue,
 16 Sep 2025 09:09:07 -0400
X-MC-Unique: Q0xQhW6PP_-YAzBi9gm63g-1
X-Mimecast-MFC-AGG-ID: Q0xQhW6PP_-YAzBi9gm63g_1758028146
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 72A191800291;
	Tue, 16 Sep 2025 13:09:06 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.34.12])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5428A19560B8;
	Tue, 16 Sep 2025 13:09:02 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	jasowang@redhat.com,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	linux-kernel@vger.kernel.org,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	Cindy Lu <lulu@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>,
	virtualization@lists.linux.dev,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH v2 5/7] vduse: create vduse_as to make it an array
Date: Tue, 16 Sep 2025 15:08:31 +0200
Message-ID: <20250916130833.329087-6-eperezma@redhat.com>
In-Reply-To: <20250916130833.329087-1-eperezma@redhat.com>
References: <20250916130833.329087-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This is a first step so we can make more than one different address
spaces.  No change on the colde flow intended.

Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 114 +++++++++++++++--------------
 1 file changed, 59 insertions(+), 55 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 9c12ae72abc2..b45b1d22784f 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -86,6 +86,12 @@ struct vduse_umem {
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
@@ -94,7 +100,7 @@ struct vduse_dev {
 	struct vduse_vdpa *vdev;
 	struct device *dev;
 	struct vduse_virtqueue **vqs;
-	struct vduse_iova_domain *domain;
+	struct vduse_as as;
 	char *name;
 	struct mutex lock;
 	spinlock_t msg_lock;
@@ -122,9 +128,7 @@ struct vduse_dev {
 	u32 vq_num;
 	u32 vq_align;
 	u32 ngroups;
-	struct vduse_umem *umem;
 	struct vduse_vq_group_int *groups;
-	struct mutex mem_lock;
 	unsigned int bounce_size;
 	rwlock_t domain_lock;
 };
@@ -439,7 +443,7 @@ static __poll_t vduse_dev_poll(struct file *file, poll_table *wait)
 static void vduse_dev_reset(struct vduse_dev *dev)
 {
 	int i;
-	struct vduse_iova_domain *domain = dev->domain;
+	struct vduse_iova_domain *domain = dev->as.domain;
 
 	/* The coherent mappings are handled in vduse_dev_free_coherent() */
 	if (domain && domain->bounce_map)
@@ -788,13 +792,13 @@ static int vduse_vdpa_set_map(struct vdpa_device *vdpa,
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
 
@@ -846,7 +850,7 @@ static void vduse_dev_sync_single_for_device(union virtio_map token,
 					     enum dma_data_direction dir)
 {
 	struct vduse_dev *vdev = token.group->dev;
-	struct vduse_iova_domain *domain = vdev->domain;
+	struct vduse_iova_domain *domain = vdev->as.domain;
 
 	vduse_domain_sync_single_for_device(domain, dma_addr, size, dir);
 }
@@ -856,7 +860,7 @@ static void vduse_dev_sync_single_for_cpu(union virtio_map token,
 					     enum dma_data_direction dir)
 {
 	struct vduse_dev *vdev = token.group->dev;
-	struct vduse_iova_domain *domain = vdev->domain;
+	struct vduse_iova_domain *domain = vdev->as.domain;
 
 	vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir);
 }
@@ -867,7 +871,7 @@ static dma_addr_t vduse_dev_map_page(union virtio_map token, struct page *page,
 				     unsigned long attrs)
 {
 	struct vduse_dev *vdev = token.group->dev;
-	struct vduse_iova_domain *domain = vdev->domain;
+	struct vduse_iova_domain *domain = vdev->as.domain;
 
 	return vduse_domain_map_page(domain, page, offset, size, dir, attrs);
 }
@@ -877,7 +881,7 @@ static void vduse_dev_unmap_page(union virtio_map token, dma_addr_t dma_addr,
 				 unsigned long attrs)
 {
 	struct vduse_dev *vdev = token.group->dev;
-	struct vduse_iova_domain *domain = vdev->domain;
+	struct vduse_iova_domain *domain = vdev->as.domain;
 
 	return vduse_domain_unmap_page(domain, dma_addr, size, dir, attrs);
 }
@@ -886,7 +890,7 @@ static void *vduse_dev_alloc_coherent(union virtio_map token, size_t size,
 				      dma_addr_t *dma_addr, gfp_t flag)
 {
 	struct vduse_dev *vdev = token.group->dev;
-	struct vduse_iova_domain *domain = vdev->domain;
+	struct vduse_iova_domain *domain = vdev->as.domain;
 	unsigned long iova;
 	void *addr;
 
@@ -906,7 +910,7 @@ static void vduse_dev_free_coherent(union virtio_map token, size_t size,
 				    unsigned long attrs)
 {
 	struct vduse_dev *vdev = token.group->dev;
-	struct vduse_iova_domain *domain = vdev->domain;
+	struct vduse_iova_domain *domain = vdev->as.domain;
 
 	vduse_domain_free_coherent(domain, size, vaddr, dma_addr, attrs);
 }
@@ -914,7 +918,7 @@ static void vduse_dev_free_coherent(union virtio_map token, size_t size,
 static bool vduse_dev_need_sync(union virtio_map token, dma_addr_t dma_addr)
 {
 	struct vduse_dev *vdev = token.group->dev;
-	struct vduse_iova_domain *domain = vdev->domain;
+	struct vduse_iova_domain *domain = vdev->as.domain;
 
 	return dma_addr < domain->bounce_size;
 }
@@ -929,7 +933,7 @@ static int vduse_dev_mapping_error(union virtio_map token, dma_addr_t dma_addr)
 static size_t vduse_dev_max_mapping_size(union virtio_map token)
 {
 	struct vduse_dev *vdev = token.group->dev;
-	struct vduse_iova_domain *domain = vdev->domain;
+	struct vduse_iova_domain *domain = vdev->as.domain;
 
 	return domain->bounce_size;
 }
@@ -1076,29 +1080,29 @@ static int vduse_dev_dereg_umem(struct vduse_dev *dev,
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
 
@@ -1111,14 +1115,14 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev,
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
@@ -1142,7 +1146,7 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev,
 		goto out;
 	}
 
-	ret = vduse_domain_add_user_bounce_pages(dev->domain,
+	ret = vduse_domain_add_user_bounce_pages(dev->as.domain,
 						 page_list, pinned);
 	if (ret)
 		goto out;
@@ -1155,7 +1159,7 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev,
 	umem->mm = current->mm;
 	mmgrab(current->mm);
 
-	dev->umem = umem;
+	dev->as.umem = umem;
 out:
 	if (ret && pinned > 0)
 		unpin_user_pages(page_list, pinned);
@@ -1166,7 +1170,7 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev,
 		vfree(page_list);
 		kfree(umem);
 	}
-	mutex_unlock(&dev->mem_lock);
+	mutex_unlock(&dev->as.mem_lock);
 	return ret;
 }
 
@@ -1212,12 +1216,12 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 			break;
 
 		read_lock(&dev->domain_lock);
-		if (!dev->domain) {
+		if (!dev->as.domain) {
 			read_unlock(&dev->domain_lock);
 			break;
 		}
-		spin_lock(&dev->domain->iotlb_lock);
-		map = vhost_iotlb_itree_first(dev->domain->iotlb,
+		spin_lock(&dev->as.domain->iotlb_lock);
+		map = vhost_iotlb_itree_first(dev->as.domain->iotlb,
 					      entry.start, entry.last);
 		if (map) {
 			map_file = (struct vdpa_map_file *)map->opaque;
@@ -1227,7 +1231,7 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 			entry.last = map->last;
 			entry.perm = map->perm;
 		}
-		spin_unlock(&dev->domain->iotlb_lock);
+		spin_unlock(&dev->as.domain->iotlb_lock);
 		read_unlock(&dev->domain_lock);
 		ret = -EINVAL;
 		if (!f)
@@ -1430,22 +1434,22 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 			break;
 
 		read_lock(&dev->domain_lock);
-		if (!dev->domain) {
+		if (!dev->as.domain) {
 			read_unlock(&dev->domain_lock);
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
 		read_unlock(&dev->domain_lock);
 		if (!map)
 			break;
@@ -1470,8 +1474,8 @@ static int vduse_dev_release(struct inode *inode, struct file *file)
 	struct vduse_dev *dev = file->private_data;
 
 	write_lock(&dev->domain_lock);
-	if (dev->domain)
-		vduse_dev_dereg_umem(dev, 0, dev->domain->bounce_size);
+	if (dev->as.domain)
+		vduse_dev_dereg_umem(dev, 0, dev->as.domain->bounce_size);
 	write_unlock(&dev->domain_lock);
 	spin_lock(&dev->msg_lock);
 	/* Make sure the inflight messages can processed after reconncection */
@@ -1690,7 +1694,7 @@ static struct vduse_dev *vduse_dev_create(void)
 		return NULL;
 
 	mutex_init(&dev->lock);
-	mutex_init(&dev->mem_lock);
+	mutex_init(&dev->as.mem_lock);
 	rwlock_init(&dev->domain_lock);
 	spin_lock_init(&dev->msg_lock);
 	INIT_LIST_HEAD(&dev->send_list);
@@ -1741,8 +1745,8 @@ static int vduse_destroy_dev(char *name)
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
@@ -1858,7 +1862,7 @@ static ssize_t bounce_size_store(struct device *device,
 
 	ret = -EPERM;
 	write_lock(&dev->domain_lock);
-	if (dev->domain)
+	if (dev->as.domain)
 		goto unlock;
 
 	ret = kstrtouint(buf, 10, &bounce_size);
@@ -2109,11 +2113,11 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 		return ret;
 
 	write_lock(&dev->domain_lock);
-	if (!dev->domain)
-		dev->domain = vduse_domain_create(VDUSE_IOVA_SIZE - 1,
+	if (!dev->as.domain)
+		dev->as.domain = vduse_domain_create(VDUSE_IOVA_SIZE - 1,
 						  dev->bounce_size);
 	write_unlock(&dev->domain_lock);
-	if (!dev->domain) {
+	if (!dev->as.domain) {
 		put_device(&dev->vdev->vdpa.dev);
 		return -ENOMEM;
 	}
@@ -2122,8 +2126,8 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	if (ret) {
 		put_device(&dev->vdev->vdpa.dev);
 		write_lock(&dev->domain_lock);
-		vduse_domain_destroy(dev->domain);
-		dev->domain = NULL;
+		vduse_domain_destroy(dev->as.domain);
+		dev->as.domain = NULL;
 		write_unlock(&dev->domain_lock);
 		return ret;
 	}
-- 
2.51.0

