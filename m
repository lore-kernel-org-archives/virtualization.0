Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B8837A491
	for <virtualization@lists.linux.dev>; Fri, 16 Jan 2026 11:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768563801; cv=none; b=IhWxMaDKGLCABDNYr5/SPhjqzSemtoOZSPdpEUG/4JH2H0CcaSUXH9R0tKMEzo6G6/LFPrvNvon3ARcgzcve5sXE/MDtfjNRrG0zdILHf+ifNPGZ8uhRkJrVir8PpG3wFgUKJd71IiNTowiIwG3kXbRpRXSIZx3FQD0CPzOWFNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768563801; c=relaxed/simple;
	bh=h1ix4/OpVOP1YodydNrqu+/k/yp+QcMNM+RWjSLIAnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JYy0h5f8IRkN/HgIcV/hcPpkodGsl0EeubUfbrCWegSi7O9crU8KaUFOPngoJkxZJjt59xEPDb5ohen7qqO/v6hvHNO2dWyHnS2ZZwhxcIAF/aLK6ZK0yyarm4C3kc4AZXEsNRYKUfrrL/eB9eJH/IcJR+1rIs9N5BHooluxouY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EevmFHTm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EevmFHTm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768563799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t8r37IrWlL6TNwvrTbZ9d4b9SIJ0stlyZpgQwTmkyS4=;
	b=EevmFHTmPoQsSCDRLJKuKc8unqzt3Ewaj9Z4M/jsF+hc+fDSjXJ08PywzILHu1MTu1F1Ts
	zOxSY3PMkSGOMV7N+KeOardHnk7CfxJxbI4kaSSO64Go0WskAjjeozM35odeyPnX81ZSUQ
	mfGqdDRKnPk+Q4QnN3Oi+ATv97ktQe4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374--3md0uUhPf65R_s7RzgpmQ-1; Fri,
 16 Jan 2026 06:43:15 -0500
X-MC-Unique: -3md0uUhPf65R_s7RzgpmQ-1
X-Mimecast-MFC-AGG-ID: -3md0uUhPf65R_s7RzgpmQ_1768563795
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B9DA01800359;
	Fri, 16 Jan 2026 11:43:14 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.226.82])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D4079180049F;
	Fri, 16 Jan 2026 11:43:10 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: "Michael S . Tsirkin " <mst@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Maxime Coquelin <mcoqueli@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>,
	Yongji Xie <xieyongji@bytedance.com>,
	Cindy Lu <lulu@redhat.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	jasowang@redhat.com
Subject: [PATCH v13 08/13] vduse: remove unused vaddr parameter of vduse_domain_free_coherent
Date: Fri, 16 Jan 2026 12:42:26 +0100
Message-ID: <20260116114231.1474306-9-eperezma@redhat.com>
In-Reply-To: <20260116114231.1474306-1-eperezma@redhat.com>
References: <20260116114231.1474306-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

We will modify the function in next patches so let's clean it first.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 drivers/vdpa/vdpa_user/iova_domain.c | 3 +--
 drivers/vdpa/vdpa_user/iova_domain.h | 3 +--
 drivers/vdpa/vdpa_user/vduse_dev.c   | 2 +-
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
index 4352b5cf74f0..309cd5a039d1 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.c
+++ b/drivers/vdpa/vdpa_user/iova_domain.c
@@ -528,8 +528,7 @@ void *vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
 }
 
 void vduse_domain_free_coherent(struct vduse_iova_domain *domain, size_t size,
-				void *vaddr, dma_addr_t dma_addr,
-				unsigned long attrs)
+				dma_addr_t dma_addr, unsigned long attrs)
 {
 	struct iova_domain *iovad = &domain->consistent_iovad;
 	struct vhost_iotlb_map *map;
diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa_user/iova_domain.h
index a923971a64f5..081f06c52cdc 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.h
+++ b/drivers/vdpa/vdpa_user/iova_domain.h
@@ -70,8 +70,7 @@ void *vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
 				  gfp_t flag);
 
 void vduse_domain_free_coherent(struct vduse_iova_domain *domain, size_t size,
-				void *vaddr, dma_addr_t dma_addr,
-				unsigned long attrs);
+				dma_addr_t dma_addr, unsigned long attrs);
 
 void vduse_domain_reset_bounce_map(struct vduse_iova_domain *domain);
 
diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 43851b0711ac..0e3cf5128ad0 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -948,7 +948,7 @@ static void vduse_dev_free_coherent(union virtio_map token, size_t size,
 	vdev = token.group->dev;
 	domain = vdev->domain;
 
-	vduse_domain_free_coherent(domain, size, vaddr, dma_addr, attrs);
+	vduse_domain_free_coherent(domain, size, dma_addr, attrs);
 }
 
 static bool vduse_dev_need_sync(union virtio_map token, dma_addr_t dma_addr)
-- 
2.52.0

