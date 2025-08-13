Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829772D0615
	for <virtualization@lists.linux.dev>; Wed, 13 Aug 2025 05:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755064152; cv=none; b=IZ2pIb1xEYCo+X+q1WAmge+t2siQqzzcF2Qdb9z2sUjhNo1hlHY0e9sXogs/8n/FZBE9QE4CJq10l2WejDLGxtd/VStz0xjFltUssgEWQQ2H5R23jR5/XKkpWagUMTk6CVivGgbaq/rhacQ2sRkqZO72Y5fr5MYDTH8GG7BrGE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755064152; c=relaxed/simple;
	bh=5oqAJoPzHR0GxmVVo7AvUscPsv5V0EJLro0zKMyYk2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hNsizhnq/mL3cwLFLaG+ZsaQ4ADdrGSJWgM6Lg/jOydgxPBraChCl+arU/Ab6Uh+Zs9f1ve2byQtQmWv0JwnKcYvfSWCR0aRyoWnOuclPh/dB9+WV9UUyAJnknQslAz1XI/moQJ6FLPimn7mxXP0NnFCDjxTlYhdD4elGi48r4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YJiQnNP8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YJiQnNP8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755064149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=80lhT498S4jOzJ/P6kb5gkt8pK+u0mT9rN4yk+mBlD0=;
	b=YJiQnNP8uvIgzKQiKkLg7rgKGOQE4XKhFYuDTd8lXVERkax3q9ybczLHt2/F3zlXxxux0v
	qMEJrAk3X8TFZ0cJfDHdlt/Pj/IP3aUhFqmtGnXvidCXpxRjlGNBzwEEIF8jry6mvG1Ts4
	JgQhCUgjpZwGJqntZOfYS1WGrCP5lcs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-536-o41aZ9LeO8mQGQu7Ep0CAA-1; Wed,
 13 Aug 2025 01:49:06 -0400
X-MC-Unique: o41aZ9LeO8mQGQu7Ep0CAA-1
X-Mimecast-MFC-AGG-ID: o41aZ9LeO8mQGQu7Ep0CAA_1755064145
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DFF12180034F;
	Wed, 13 Aug 2025 05:49:04 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.168])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C4A3F180028D;
	Wed, 13 Aug 2025 05:49:00 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: hch@infradead.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH V5 5/9] virtio_ring: rename dma_handle to map_handle
Date: Wed, 13 Aug 2025 13:48:27 +0800
Message-ID: <20250813054831.25865-6-jasowang@redhat.com>
In-Reply-To: <20250813054831.25865-1-jasowang@redhat.com>
References: <20250813054831.25865-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Following patch will introduce virtio map opreations which means the
address is not necessarily used for DMA. Let's rename the dma_handle
to map_handle first.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index fb1d407d5f1b..94b2a8f3acc2 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -305,18 +305,18 @@ size_t virtio_max_dma_size(const struct virtio_device *vdev)
 EXPORT_SYMBOL_GPL(virtio_max_dma_size);
 
 static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
-			       dma_addr_t *dma_handle, gfp_t flag,
+			       dma_addr_t *map_handle, gfp_t flag,
 			       union vring_mapping_token *mapping_token)
 {
 	if (vring_use_map_api(vdev)) {
 		return dma_alloc_coherent(mapping_token->dma_dev, size,
-					  dma_handle, flag);
+					  map_handle, flag);
 	} else {
 		void *queue = alloc_pages_exact(PAGE_ALIGN(size), flag);
 
 		if (queue) {
 			phys_addr_t phys_addr = virt_to_phys(queue);
-			*dma_handle = (dma_addr_t)phys_addr;
+			*map_handle = (dma_addr_t)phys_addr;
 
 			/*
 			 * Sanity check: make sure we dind't truncate
@@ -329,7 +329,7 @@ static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
 			 * warning and abort if we end up with an
 			 * unrepresentable address.
 			 */
-			if (WARN_ON_ONCE(*dma_handle != phys_addr)) {
+			if (WARN_ON_ONCE(*map_handle != phys_addr)) {
 				free_pages_exact(queue, PAGE_ALIGN(size));
 				return NULL;
 			}
@@ -339,11 +339,11 @@ static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
 }
 
 static void vring_free_queue(struct virtio_device *vdev, size_t size,
-			     void *queue, dma_addr_t dma_handle,
+			     void *queue, dma_addr_t map_handle,
 			     union vring_mapping_token *mapping_token)
 {
 	if (vring_use_map_api(vdev))
-		dma_free_coherent(mapping_token->dma_dev, size, queue, dma_handle);
+		dma_free_coherent(mapping_token->dma_dev, size, queue, map_handle);
 	else
 		free_pages_exact(queue, PAGE_ALIGN(size));
 }
-- 
2.31.1

