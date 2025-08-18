Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6B630C346
	for <virtualization@lists.linux.dev>; Mon, 18 Aug 2025 08:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755507469; cv=none; b=D0ZNOkp1YxpgWPFMJLqHh0ziz6ZSGWyQ/DOHRsp6PFCLcjO1zoqRMGMFeV1V3H1zYAlTRTIq1m93YUJf6CpalX2FGX+qWS+Adb8AIbasAYACUbw079+of/GjgpEww2D9ZnPISVzN/12PjGfEtnatRwaZQd3HrXTphrLPbEGPPWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755507469; c=relaxed/simple;
	bh=YeVHgpr0G/Epi9J9NURDwYa/iqPbsgPFjaSKQrD2xBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oSfeKtyAgXKnIGpQRSkWR49/KsGEgP4GVtZQYKV/y34IBHVipuQF37zQL5YWxR13vqnuuTUp8kS4P3AaQ7YON3QPHKEYQEBQFdbFtTYK7c6eETIBzr4t+mbYIVmhgjnsFKF95xhR0rLzJqqX/bZXUq09KFpyZHvctIaG+VEWIMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U/+z/E8b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/+z/E8b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755507466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AaLpftRzHAuIfiitvGtvjTGLY40NdnI2bh71byGQyKc=;
	b=U/+z/E8blBzSqmoP+25Df/Fhla+c1qh8OVdHaqHC5FIwq4X+RipHAZWj/eEr/GFf6BaGUO
	+tQV9UljppzJzNghi+t9KUNE+8EfIHBx46LRBlWuIxyGVQIFpfSF+XEum/XZ+M+x6Mk9N1
	iNWlFzXJKRv6RJOX2plqBQi8S+3snmk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-108-3CINtWkyO7arldixSZTtvA-1; Mon,
 18 Aug 2025 04:57:43 -0400
X-MC-Unique: 3CINtWkyO7arldixSZTtvA-1
X-Mimecast-MFC-AGG-ID: 3CINtWkyO7arldixSZTtvA_1755507462
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B3E7919560A6;
	Mon, 18 Aug 2025 08:57:41 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.213])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4849A180028B;
	Mon, 18 Aug 2025 08:57:36 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>,
	virtualization@lists.linux.dev,
	jasowang@redhat.com,
	Cindy Lu <lulu@redhat.com>,
	linux-kernel@vger.kernel.org,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [RFC v3 5/7] vduse: create vduse_as to make it an array
Date: Mon, 18 Aug 2025 10:57:09 +0200
Message-ID: <20250818085711.3461758-6-eperezma@redhat.com>
In-Reply-To: <20250818085711.3461758-1-eperezma@redhat.com>
References: <20250818085711.3461758-1-eperezma@redhat.com>
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
 drivers/vdpa/vdpa_user/vduse_dev.c | 115 +++++++++++++++--------------
 1 file changed, 59 insertions(+), 56 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 45b188dc2659..561aab048d1a 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -84,6 +84,12 @@ struct vduse_umem {
 	struct mm_struct *mm;
 };
 
+struct vduse_as {
+	struct vduse_iova_domain *domain;
+	struct vduse_umem *umem;
+	struct mutex mem_lock;
+};
+
 struct vduse_vq_group_int {
 	struct vring_mapping_opaque token;
 	struct vduse_dev *dev;
@@ -93,8 +99,7 @@ struct vduse_dev {
 	struct vduse_vdpa *vdev;
 	struct device *dev;
 	struct vduse_virtqueue **vqs;
-	struct vduse_iova_domain *domain;
-	struct vduse_iova_domain *dom;
+	struct vduse_as as;
 	char *name;
 	struct mutex lock;
 	spinlock_t msg_lock;
@@ -122,9 +127,7 @@ struct vduse_dev {
 	u32 vq_num;
 	u32 vq_align;
 	u32 ngroups;
-	struct vduse_umem *umem;
 	struct vduse_vq_group_int *groups;
-	struct mutex mem_lock;
 	unsigned int bounce_size;
 	struct mutex domain_lock;
 };
@@ -444,7 +447,7 @@ static __poll_t vduse_dev_poll(struct file *file, poll_table *wait)
 static void vduse_dev_reset(struct vduse_dev *dev)
 {
 	int i;
-	struct vduse_iova_domain *domain = dev->domain;
+	struct vduse_iova_domain *domain = dev->as.domain;
 
 	/* The coherent mappings are handled in vduse_dev_free_coherent() */
 	if (domain && domain->bounce_map)
@@ -823,13 +826,13 @@ static int vduse_vdpa_set_map(struct vdpa_device *vdpa,
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
 
@@ -882,7 +885,7 @@ static void vduse_dev_sync_single_for_device(struct vring_mapping_opaque *token,
 {
 	struct vduse_vq_group_int *group = vduse_token_to_vq_group(token);
 	struct vduse_dev *vdev = group->dev;
-	struct vduse_iova_domain *domain = vdev->domain;
+	struct vduse_iova_domain *domain = vdev->as.domain;
 
 	vduse_domain_sync_single_for_device(domain, dma_addr, size, dir);
 }
@@ -893,7 +896,7 @@ static void vduse_dev_sync_single_for_cpu(struct vring_mapping_opaque *token,
 {
 	struct vduse_vq_group_int *group = vduse_token_to_vq_group(token);
 	struct vduse_dev *vdev = group->dev;
-	struct vduse_iova_domain *domain = vdev->domain;
+	struct vduse_iova_domain *domain = vdev->as.domain;
 
 	vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir);
 }
@@ -906,7 +909,7 @@ static dma_addr_t vduse_dev_map_page(struct vring_mapping_opaque *token,
 {
 	struct vduse_vq_group_int *group = vduse_token_to_vq_group(token);
 	struct vduse_dev *vdev = group->dev;
-	struct vduse_iova_domain *domain = vdev->domain;
+	struct vduse_iova_domain *domain = vdev->as.domain;
 
 	return vduse_domain_map_page(domain, page, offset, size, dir, attrs);
 }
@@ -918,7 +921,7 @@ static void vduse_dev_unmap_page(struct vring_mapping_opaque *token,
 {
 	struct vduse_vq_group_int *group = vduse_token_to_vq_group(token);
 	struct vduse_dev *vdev = group->dev;
-	struct vduse_iova_domain *domain = vdev->domain;
+	struct vduse_iova_domain *domain = vdev->as.domain;
 
 	return vduse_domain_unmap_page(domain, dma_addr, size, dir, attrs);
 }
@@ -929,7 +932,7 @@ static void *vduse_dev_alloc_coherent(struct vring_mapping_opaque *token,
 {
 	struct vduse_vq_group_int *group = vduse_token_to_vq_group(token);
 	struct vduse_dev *vdev = group->dev;
-	struct vduse_iova_domain *domain = vdev->domain;
+	struct vduse_iova_domain *domain = vdev->as.domain;
 	unsigned long iova;
 	void *addr;
 
@@ -950,7 +953,7 @@ static void vduse_dev_free_coherent(struct vring_mapping_opaque *token,
 {
 	struct vduse_vq_group_int *group = vduse_token_to_vq_group(token);
 	struct vduse_dev *vdev = group->dev;
-	struct vduse_iova_domain *domain = vdev->domain;
+	struct vduse_iova_domain *domain = vdev->as.domain;
 
 	vduse_domain_free_coherent(domain, size, vaddr, dma_addr, attrs);
 }
@@ -960,7 +963,7 @@ static bool vduse_dev_need_sync(struct vring_mapping_opaque *token,
 {
 	struct vduse_vq_group_int *group = vduse_token_to_vq_group(token);
 	struct vduse_dev *vdev = group->dev;
-	struct vduse_iova_domain *domain = vdev->domain;
+	struct vduse_iova_domain *domain = vdev->as.domain;
 
 	return dma_addr < domain->bounce_size;
 }
@@ -977,7 +980,7 @@ static size_t vduse_dev_max_mapping_size(struct vring_mapping_opaque *token)
 {
 	struct vduse_vq_group_int *group = vduse_token_to_vq_group(token);
 	struct vduse_dev *vdev = group->dev;
-	struct vduse_iova_domain *domain = vdev->domain;
+	struct vduse_iova_domain *domain = vdev->as.domain;
 
 	return domain->bounce_size;
 }
@@ -1124,29 +1127,29 @@ static int vduse_dev_dereg_umem(struct vduse_dev *dev,
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
 
@@ -1159,14 +1162,14 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev,
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
@@ -1190,7 +1193,7 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev,
 		goto out;
 	}
 
-	ret = vduse_domain_add_user_bounce_pages(dev->domain,
+	ret = vduse_domain_add_user_bounce_pages(dev->as.domain,
 						 page_list, pinned);
 	if (ret)
 		goto out;
@@ -1203,7 +1206,7 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev,
 	umem->mm = current->mm;
 	mmgrab(current->mm);
 
-	dev->umem = umem;
+	dev->as.umem = umem;
 out:
 	if (ret && pinned > 0)
 		unpin_user_pages(page_list, pinned);
@@ -1214,7 +1217,7 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev,
 		vfree(page_list);
 		kfree(umem);
 	}
-	mutex_unlock(&dev->mem_lock);
+	mutex_unlock(&dev->as.mem_lock);
 	return ret;
 }
 
@@ -1260,12 +1263,12 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
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
@@ -1275,7 +1278,7 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 			entry.last = map->last;
 			entry.perm = map->perm;
 		}
-		spin_unlock(&dev->domain->iotlb_lock);
+		spin_unlock(&dev->as.domain->iotlb_lock);
 		mutex_unlock(&dev->domain_lock);
 		ret = -EINVAL;
 		if (!f)
@@ -1469,22 +1472,22 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
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
@@ -1509,8 +1512,8 @@ static int vduse_dev_release(struct inode *inode, struct file *file)
 	struct vduse_dev *dev = file->private_data;
 
 	mutex_lock(&dev->domain_lock);
-	if (dev->domain)
-		vduse_dev_dereg_umem(dev, 0, dev->domain->bounce_size);
+	if (dev->as.domain)
+		vduse_dev_dereg_umem(dev, 0, dev->as.domain->bounce_size);
 	mutex_unlock(&dev->domain_lock);
 	spin_lock(&dev->msg_lock);
 	/* Make sure the inflight messages can processed after reconncection */
@@ -1729,7 +1732,7 @@ static struct vduse_dev *vduse_dev_create(void)
 		return NULL;
 
 	mutex_init(&dev->lock);
-	mutex_init(&dev->mem_lock);
+	mutex_init(&dev->as.mem_lock);
 	mutex_init(&dev->domain_lock);
 	spin_lock_init(&dev->msg_lock);
 	INIT_LIST_HEAD(&dev->send_list);
@@ -1780,8 +1783,8 @@ static int vduse_destroy_dev(char *name)
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
@@ -1897,7 +1900,7 @@ static ssize_t bounce_size_store(struct device *device,
 
 	ret = -EPERM;
 	mutex_lock(&dev->domain_lock);
-	if (dev->domain)
+	if (dev->as.domain)
 		goto unlock;
 
 	ret = kstrtouint(buf, 10, &bounce_size);
@@ -2148,11 +2151,11 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
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
@@ -2161,8 +2164,8 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
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
2.50.1

