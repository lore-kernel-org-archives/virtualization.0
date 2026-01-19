Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24AA38757B
	for <virtualization@lists.linux.dev>; Mon, 19 Jan 2026 14:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768833235; cv=none; b=DDNxBAIMqoilAK0qnIs2ABvKZk2ccFNsE+VoUz31v6AAPJSUJIHiFULUWODgnjx9U18JydfpMeGThxefmju34uLZ7MTJenVxESKvN4d467EzVZELQgFG0BRcDMQ62EWYDNa744QbRUI/0GAX1zUYqXjp1pAX4HpUcusO2ocp9B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768833235; c=relaxed/simple;
	bh=76EIoIOaG6/VJajsr8Jtx+vVzMJQ7SRBLU3Sfot2koE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KFN4egbYdXCEBas+X7o/EWvaCar3Vdq7EYLkzc03IAr7ImzeQRoJwxil2oYDMq4lrLSTITvZRTbBtW/ZqQW/rCcXiAuXXG36BkDT08pRN89w5pypCp3a7bAt8UkPy+eylfZP21nv47cuXQ5u3162CSr9rYMQMPAQEJIbG2EnyCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FqWxzdB9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FqWxzdB9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768833233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s81dUgqwYas7OncME6/Tc3HamdjySXE8XHF7PknnqC0=;
	b=FqWxzdB9rdhjSgnuNV2FqklW7V2eGt7dlet80v6LbdzhPZ11bdTyli8u1e/Ikxw/Qp8Mbj
	u+464AXcQBSrx1D/MW3jrHZuSmtzqbJoPTblndp+FTlyLmz96LMypzk+E68iL0Ogu8ZLk6
	CDB+qGZDUin/W1aZGOW28ZxqDcMuTOQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-338-o7isd5N-NeCu3b31O0AOcA-1; Mon,
 19 Jan 2026 09:33:49 -0500
X-MC-Unique: o7isd5N-NeCu3b31O0AOcA-1
X-Mimecast-MFC-AGG-ID: o7isd5N-NeCu3b31O0AOcA_1768833228
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C7AD41956046;
	Mon, 19 Jan 2026 14:33:48 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.33.172])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F29411800577;
	Mon, 19 Jan 2026 14:33:44 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: virtualization@lists.linux.dev,
	Yongji Xie <xieyongji@bytedance.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	jasowang@redhat.com,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>,
	Cindy Lu <lulu@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v15 09/13] vduse: take out allocations from vduse_dev_alloc_coherent
Date: Mon, 19 Jan 2026 15:33:02 +0100
Message-ID: <20260119143306.1818855-10-eperezma@redhat.com>
In-Reply-To: <20260119143306.1818855-1-eperezma@redhat.com>
References: <20260119143306.1818855-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The function vduse_dev_alloc_coherent will be called under rwlock in
next patches.  Make it out of the lock to avoid increasing its fail
rate.

Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
v12:
* Avoid free_pages_exact(NULL, size) in case vduse_domain_alloc_coherent
  fails (MST).

v11: Remove duplicated call to free_pages_exact (Jason).
---
 drivers/vdpa/vdpa_user/iova_domain.c | 24 +++++++-----------------
 drivers/vdpa/vdpa_user/iova_domain.h |  5 ++---
 drivers/vdpa/vdpa_user/vduse_dev.c   | 17 +++++++++++------
 3 files changed, 20 insertions(+), 26 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
index 309cd5a039d1..0a9f668467a8 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.c
+++ b/drivers/vdpa/vdpa_user/iova_domain.c
@@ -493,17 +493,15 @@ void vduse_domain_unmap_page(struct vduse_iova_domain *domain,
 	vduse_domain_free_iova(iovad, dma_addr, size);
 }
 
-void *vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
-				  size_t size, dma_addr_t *dma_addr,
-				  gfp_t flag)
+dma_addr_t vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
+				       size_t size, void *orig)
 {
 	struct iova_domain *iovad = &domain->consistent_iovad;
 	unsigned long limit = domain->iova_limit;
 	dma_addr_t iova = vduse_domain_alloc_iova(iovad, size, limit);
-	void *orig = alloc_pages_exact(size, flag);
 
-	if (!iova || !orig)
-		goto err;
+	if (!iova)
+		return DMA_MAPPING_ERROR;
 
 	spin_lock(&domain->iotlb_lock);
 	if (vduse_iotlb_add_range(domain, (u64)iova, (u64)iova + size - 1,
@@ -514,17 +512,12 @@ void *vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
 	}
 	spin_unlock(&domain->iotlb_lock);
 
-	*dma_addr = iova;
+	return iova;
 
-	return orig;
 err:
-	*dma_addr = DMA_MAPPING_ERROR;
-	if (orig)
-		free_pages_exact(orig, size);
-	if (iova)
-		vduse_domain_free_iova(iovad, iova, size);
+	vduse_domain_free_iova(iovad, iova, size);
 
-	return NULL;
+	return DMA_MAPPING_ERROR;
 }
 
 void vduse_domain_free_coherent(struct vduse_iova_domain *domain, size_t size,
@@ -533,7 +526,6 @@ void vduse_domain_free_coherent(struct vduse_iova_domain *domain, size_t size,
 	struct iova_domain *iovad = &domain->consistent_iovad;
 	struct vhost_iotlb_map *map;
 	struct vdpa_map_file *map_file;
-	phys_addr_t pa;
 
 	spin_lock(&domain->iotlb_lock);
 	map = vhost_iotlb_itree_first(domain->iotlb, (u64)dma_addr,
@@ -545,12 +537,10 @@ void vduse_domain_free_coherent(struct vduse_iova_domain *domain, size_t size,
 	map_file = (struct vdpa_map_file *)map->opaque;
 	fput(map_file->file);
 	kfree(map_file);
-	pa = map->addr;
 	vhost_iotlb_map_free(domain->iotlb, map);
 	spin_unlock(&domain->iotlb_lock);
 
 	vduse_domain_free_iova(iovad, dma_addr, size);
-	free_pages_exact(phys_to_virt(pa), size);
 }
 
 static vm_fault_t vduse_domain_mmap_fault(struct vm_fault *vmf)
diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa_user/iova_domain.h
index 081f06c52cdc..e50e55d1396f 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.h
+++ b/drivers/vdpa/vdpa_user/iova_domain.h
@@ -65,9 +65,8 @@ void vduse_domain_unmap_page(struct vduse_iova_domain *domain,
 			     dma_addr_t dma_addr, size_t size,
 			     enum dma_data_direction dir, unsigned long attrs);
 
-void *vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
-				  size_t size, dma_addr_t *dma_addr,
-				  gfp_t flag);
+dma_addr_t vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
+				       size_t size, void *orig);
 
 void vduse_domain_free_coherent(struct vduse_iova_domain *domain, size_t size,
 				dma_addr_t dma_addr, unsigned long attrs);
diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 0e3cf5128ad0..6dba1f3224d9 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -916,23 +916,27 @@ static void *vduse_dev_alloc_coherent(union virtio_map token, size_t size,
 {
 	struct vduse_dev *vdev;
 	struct vduse_iova_domain *domain;
-	unsigned long iova;
 	void *addr;
 
 	*dma_addr = DMA_MAPPING_ERROR;
 	if (!token.group)
 		return NULL;
 
-	vdev = token.group->dev;
-	domain = vdev->domain;
-	addr = vduse_domain_alloc_coherent(domain, size,
-					   (dma_addr_t *)&iova, flag);
+	addr = alloc_pages_exact(size, flag);
 	if (!addr)
 		return NULL;
 
-	*dma_addr = (dma_addr_t)iova;
+	vdev = token.group->dev;
+	domain = vdev->domain;
+	*dma_addr = vduse_domain_alloc_coherent(domain, size, addr);
+	if (*dma_addr == DMA_MAPPING_ERROR)
+		goto err;
 
 	return addr;
+
+err:
+	free_pages_exact(addr, size);
+	return NULL;
 }
 
 static void vduse_dev_free_coherent(union virtio_map token, size_t size,
@@ -949,6 +953,7 @@ static void vduse_dev_free_coherent(union virtio_map token, size_t size,
 	domain = vdev->domain;
 
 	vduse_domain_free_coherent(domain, size, dma_addr, attrs);
+	free_pages_exact(vaddr, size);
 }
 
 static bool vduse_dev_need_sync(union virtio_map token, dma_addr_t dma_addr)
-- 
2.52.0

