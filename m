Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F68D2F5319
	for <virtualization@lists.linux.dev>; Thu, 25 Sep 2025 10:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796722; cv=none; b=cpnOl1JeoSDJBv9IfU5Zrz1GhmyFlql7zoRtKHFkEXz1JDYW9sIKpMNMk19E0sPNyCCT2Snf15TbRzdMRamV8d1s7YX8hAhHx51/7/i+tb4QIgpEh4QRfgx3YO6y3AI41aG1s3N+iH0fgd03sHj4txt9FWAonedE1LikawDVgLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796722; c=relaxed/simple;
	bh=ocOCRW4oRahFe6gINci3LTtb0zMmQjXlb35yqyLD96w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dPXZoef/WM0GIt9zxjf5/Y6Z/xFP6wOvZ6aC0AKPrczB7JZmWo2JEqKyuMSzELJq+1Bc3oHImwb/7UlZ8GcomzeDX7tEUNRXpDvmxR3dOFfcTERU/mxQ1dZy4N1LSFX5FMXymCv4nW7e/DkXr6kwP/1yrmiD2U0jeEyhJKSpa74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hzZklVvu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hzZklVvu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758796719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5A6DBYxsE58etQFlbYr7MZyK8rPhk3xiyMDL6XBVQmw=;
	b=hzZklVvu8neiHeBDKLcjZbXCOzCznz1TckkMTX21/VozBfx12KXH8zrHp6CvyH/EpQfWEU
	nSERB75aIzNNHthxV059ebgbMr94jByZLR+X+DcG4qGWK+UwDyXeNZF2FLx70axWVoGqX4
	KzUufWf/mpFSheONZ28UAL9Xkjrhqbs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-75-APhKrOp8Po2Wf5b95huGSg-1; Thu,
 25 Sep 2025 06:38:34 -0400
X-MC-Unique: APhKrOp8Po2Wf5b95huGSg-1
X-Mimecast-MFC-AGG-ID: APhKrOp8Po2Wf5b95huGSg_1758796713
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C8D84195609F;
	Thu, 25 Sep 2025 10:38:33 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.10])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 877AA19560A2;
	Thu, 25 Sep 2025 10:38:30 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V7 18/19] virtio_ring: factor out split detaching logic
Date: Thu, 25 Sep 2025 18:37:07 +0800
Message-ID: <20250925103708.44589-19-jasowang@redhat.com>
In-Reply-To: <20250925103708.44589-1-jasowang@redhat.com>
References: <20250925103708.44589-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This patch factors out the split core detaching logic that could be
reused by in order feature into a dedicated function.

Acked-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 58f2e82159f1..e134f914a408 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -801,8 +801,9 @@ static void detach_indirect_split(struct vring_virtqueue *vq,
 	vq->split.desc_state[head].indir_desc = NULL;
 }
 
-static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
-			     void **ctx)
+static unsigned detach_buf_split_in_order(struct vring_virtqueue *vq,
+					  unsigned int head,
+					  void **ctx)
 {
 	struct vring_desc_extra *extra;
 	unsigned int i;
@@ -823,8 +824,6 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 	}
 
 	vring_unmap_one_split(vq, &extra[i]);
-	vq->split.desc_extra[i].next = vq->free_head;
-	vq->free_head = head;
 
 	/* Plus final descriptor */
 	vq->vq.num_free++;
@@ -833,6 +832,17 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 		detach_indirect_split(vq, head);
 	else if (ctx)
 		*ctx = vq->split.desc_state[head].indir_desc;
+
+	return i;
+}
+
+static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
+			     void **ctx)
+{
+	unsigned int i = detach_buf_split_in_order(vq, head, ctx);
+
+	vq->split.desc_extra[i].next = vq->free_head;
+	vq->free_head = head;
 }
 
 static bool virtqueue_poll_split(const struct vring_virtqueue *vq,
-- 
2.31.1

