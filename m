Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A7E33F8A8
	for <virtualization@lists.linux.dev>; Wed, 17 Dec 2025 11:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765970694; cv=none; b=grIV9f7lYK6kPgSBrO2ydfUF3JGRJLS0ZNGpeDRLSG57xD9YqknlaHW+6ZDziosGzwLEA9ySNvferzq6882BkabIaY5XU6BG0Wzc5Q+MdmaLUD1NdqrWdsC9ymQFsm9jXXuAeR4Ry1pHi5CaGy25+H2UUtk6ig74NtTl8y6L/84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765970694; c=relaxed/simple;
	bh=LxzE1hkrXg+IA1DydmXFVRxIMeeQYdOVJFcT12jTN/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SicclueqUyBblNHc8hMF/K3jWDHaqdDAudKvErXRaUDOmdNfYXevVrJXDX09mED6cFqlq6PrFs6KEFEV0Tw7WIGRjR3mUIaoYd94T0MhBnMYW8B5mYqR2yYwOKzL0UqA+20IRHoon7on2l002d1pCpE3pl5RwYTHHctLF0OUlBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zdi5K7SL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zdi5K7SL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765970690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0IUcXwE5mBGW85/ZKVoXrLqsALgfq4FyValS2fu7D4Q=;
	b=Zdi5K7SLFfsFWQ1CxS7ygI/wnAHOwyT/eX9uAntgBAeomtCi4xQpJzdOo4YwVJMVdpn1m+
	7YNiR6a8Pn4OnxzaQsdBP8bsUp4xi42s1D4G5vCIs0rh5gqa949wgF6ObKTRWlDIkFUosn
	qFecd9cln4ZxdycAWvRy2tIV/3sbLmE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-397-zbSsSkQkOuGkUHMjxrJ0dg-1; Wed,
 17 Dec 2025 06:24:46 -0500
X-MC-Unique: zbSsSkQkOuGkUHMjxrJ0dg-1
X-Mimecast-MFC-AGG-ID: zbSsSkQkOuGkUHMjxrJ0dg_1765970685
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9008F18002DE;
	Wed, 17 Dec 2025 11:24:45 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.69])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 25CE9180045B;
	Wed, 17 Dec 2025 11:24:41 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	jasowang@redhat.com,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Cindy Lu <lulu@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH v10 6/8] vduse: take out allocations from vduse_dev_alloc_coherent
Date: Wed, 17 Dec 2025 12:24:12 +0100
Message-ID: <20251217112414.2374672-7-eperezma@redhat.com>
In-Reply-To: <20251217112414.2374672-1-eperezma@redhat.com>
References: <20251217112414.2374672-1-eperezma@redhat.com>
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

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 drivers/vdpa/vdpa_user/iova_domain.c |  7 ++-----
 drivers/vdpa/vdpa_user/iova_domain.h |  2 +-
 drivers/vdpa/vdpa_user/vduse_dev.c   | 13 +++++++++++--
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
index 309cd5a039d1..0ae52890518c 100644
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
 
diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa_user/iova_domain.h
index 42090cd1a622..86b7c7eadfd0 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.h
+++ b/drivers/vdpa/vdpa_user/iova_domain.h
@@ -69,7 +69,7 @@ void vduse_domain_unmap_page(struct vduse_iova_domain *domain,
 
 void *vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
 				  size_t size, dma_addr_t *dma_addr,
-				  gfp_t flag);
+				  void *orig);
 
 void vduse_domain_free_coherent(struct vduse_iova_domain *domain, size_t size,
 				dma_addr_t dma_addr, unsigned long attrs);
diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index a278cff7a4fa..767abcb7e375 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -924,16 +924,24 @@ static void *vduse_dev_alloc_coherent(union virtio_map token, size_t size,
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
@@ -950,6 +958,7 @@ static void vduse_dev_free_coherent(union virtio_map token, size_t size,
 	domain = vdev->domain;
 
 	vduse_domain_free_coherent(domain, size, dma_addr, attrs);
+	free_pages_exact(vaddr, size);
 }
 
 static bool vduse_dev_need_sync(union virtio_map token, dma_addr_t dma_addr)
-- 
2.52.0

