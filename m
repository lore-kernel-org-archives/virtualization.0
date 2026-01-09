Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE38E363C74
	for <virtualization@lists.linux.dev>; Fri,  9 Jan 2026 15:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767972322; cv=none; b=RaZKGpEjeI6Xjv+4VxvP6+wH6Jz9W04ivSUSKPMDEWfQ2UoSGxO1RWTIzxC1tksuevwxKlDKz5US2Cbg1PsVyyzy1BBo6x95/6LTVfL/H/8YEqQB+OcW+bIrrI/dBCgqE4wNizvVXDCZzwV/XejP3djZg8rLJqeeEeF/uQy3yVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767972322; c=relaxed/simple;
	bh=RnZx4insZm8UIrsCaVOGOtN8hcASoPRmklqAH7+tnWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m3ZCKugH+sHayJjOoA7bJuhaUhW/qzY23+sf20VsC5sXZVJbV1wB3/41C8JPVFnburGDrDJ+5FXZrv48GEZXSMYVxPgcxJ2bmymDF8LzQDpCT3VPGvXFOA5Vywjjvv4pt1/w790MaupFLCz0Gm66Fvg32CJHc+2pKMA3gND+BEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N6YLkqS4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N6YLkqS4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767972320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r1HAgfK0SSfRPgnXshIXynY3YncqdNYzJWAn3Wb8bK4=;
	b=N6YLkqS4o4iwSqQ+4iZyS4kbF1zewNdfZLTrDcEsyUoTNSNgRCVRIBIBn2tZN4G1GQnOWw
	q+gBdT1dFkxyuUMYTL7YJfTPc0afFKKd3K7mIrjjynAC9Wba2/Xj9EOZ48iCzlWBygrYpf
	GGxN20tKflcSS8TF4mq6mkLhS8KBB20=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-541-aL4HzgOUNAW2vcyJ1iTbEQ-1; Fri,
 09 Jan 2026 10:25:16 -0500
X-MC-Unique: aL4HzgOUNAW2vcyJ1iTbEQ-1
X-Mimecast-MFC-AGG-ID: aL4HzgOUNAW2vcyJ1iTbEQ_1767972315
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C9D8419560AD;
	Fri,  9 Jan 2026 15:25:15 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.96])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 747BB1954185;
	Fri,  9 Jan 2026 15:25:12 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>,
	Cindy Lu <lulu@redhat.com>,
	jasowang@redhat.com,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH v11 09/12] vduse: take out allocations from vduse_dev_alloc_coherent
Date: Fri,  9 Jan 2026 16:24:27 +0100
Message-ID: <20260109152430.512923-10-eperezma@redhat.com>
In-Reply-To: <20260109152430.512923-1-eperezma@redhat.com>
References: <20260109152430.512923-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The function vduse_dev_alloc_coherent will be called under rwlock in
next patches.  Make it out of the lock to avoid increasing its fail
rate.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
v11: Remove duplicated call to free_pages_exact (Jason).
---
 drivers/vdpa/vdpa_user/iova_domain.c | 10 ++--------
 drivers/vdpa/vdpa_user/iova_domain.h |  2 +-
 drivers/vdpa/vdpa_user/vduse_dev.c   | 13 +++++++++++--
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
index 309cd5a039d1..3955690696fe 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.c
+++ b/drivers/vdpa/vdpa_user/iova_domain.c
@@ -495,14 +495,13 @@ void vduse_domain_unmap_page(struct vduse_iova_domain *domain,
 
 void *vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
 				  size_t size, dma_addr_t *dma_addr,
-				  gfp_t flag)
+				  void *orig)
 {
 	struct iova_domain *iovad = &domain->consistent_iovad;
 	unsigned long limit = domain->iova_limit;
 	dma_addr_t iova = vduse_domain_alloc_iova(iovad, size, limit);
-	void *orig = alloc_pages_exact(size, flag);
 
-	if (!iova || !orig)
+	if (!iova)
 		goto err;
 
 	spin_lock(&domain->iotlb_lock);
@@ -519,8 +518,6 @@ void *vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
 	return orig;
 err:
 	*dma_addr = DMA_MAPPING_ERROR;
-	if (orig)
-		free_pages_exact(orig, size);
 	if (iova)
 		vduse_domain_free_iova(iovad, iova, size);
 
@@ -533,7 +530,6 @@ void vduse_domain_free_coherent(struct vduse_iova_domain *domain, size_t size,
 	struct iova_domain *iovad = &domain->consistent_iovad;
 	struct vhost_iotlb_map *map;
 	struct vdpa_map_file *map_file;
-	phys_addr_t pa;
 
 	spin_lock(&domain->iotlb_lock);
 	map = vhost_iotlb_itree_first(domain->iotlb, (u64)dma_addr,
@@ -545,12 +541,10 @@ void vduse_domain_free_coherent(struct vduse_iova_domain *domain, size_t size,
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
index 081f06c52cdc..1854fdc25597 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.h
+++ b/drivers/vdpa/vdpa_user/iova_domain.h
@@ -67,7 +67,7 @@ void vduse_domain_unmap_page(struct vduse_iova_domain *domain,
 
 void *vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
 				  size_t size, dma_addr_t *dma_addr,
-				  gfp_t flag);
+				  void *orig);
 
 void vduse_domain_free_coherent(struct vduse_iova_domain *domain, size_t size,
 				dma_addr_t dma_addr, unsigned long attrs);
diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 82ee476d45e0..675da1465e0e 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -923,16 +923,24 @@ static void *vduse_dev_alloc_coherent(union virtio_map token, size_t size,
 	if (!token.group)
 		return NULL;
 
+	addr = alloc_pages_exact(size, flag);
+	if (!addr)
+		return NULL;
+
 	vdev = token.group->dev;
 	domain = vdev->domain;
 	addr = vduse_domain_alloc_coherent(domain, size,
-					   (dma_addr_t *)&iova, flag);
+					   (dma_addr_t *)&iova, addr);
 	if (!addr)
-		return NULL;
+		goto err;
 
 	*dma_addr = (dma_addr_t)iova;
 
 	return addr;
+
+err:
+	free_pages_exact(addr, size);
+	return NULL;
 }
 
 static void vduse_dev_free_coherent(union virtio_map token, size_t size,
@@ -949,6 +957,7 @@ static void vduse_dev_free_coherent(union virtio_map token, size_t size,
 	domain = vdev->domain;
 
 	vduse_domain_free_coherent(domain, size, dma_addr, attrs);
+	free_pages_exact(vaddr, size);
 }
 
 static bool vduse_dev_need_sync(union virtio_map token, dma_addr_t dma_addr)
-- 
2.52.0

