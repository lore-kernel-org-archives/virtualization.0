Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3A0270552
	for <virtualization@lists.linux.dev>; Mon, 16 Jun 2025 08:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750062382; cv=none; b=IEY0cSawQ8NoLUuM1iQv/5dfNF7NCDY31tj8e8THgCWzEa0TPuL0hIGvnJ+Sj5J/inoUwyME/hP5N5KumeFSqFTZVNIE3BsSHng2BW3IUgG+qgtwrK6ybTqJRM7rd7iSTPLnmbeSc3RhBEMWfGdcpTnDDc/dKqZT3zIndQpollI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750062382; c=relaxed/simple;
	bh=k/j1JWrfmON7u1bdWCZW/FUEJTJ4hJKFDMpYrNv/D+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sgO5KFMt9SVsFvrdLIEMXPKX8UcfsWLSxnhWi4EUYRJG7LoLIDpuhccIamnAvuyNK9/7K8PRpGm0/9i7pTOKwWQVV/7tPvlDLp8by+uiOFUcg/qZa+7Gx5IwkUbVcomHAahDlHwp5a7VQzNMHwIbyeC2+xkrgCYzwXXEDk8gmzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mk+gU85g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mk+gU85g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750062379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+mjucDLGVtGHMuWA+LOyGgBQQBmFJEsmCYtz1e+yPSU=;
	b=Mk+gU85ghH1Z22TUhaA5e43HkatPKGx6pwSVDFCmjimx6D71byRRQdEWFJ+E2clRUcfya4
	zioIrKiou0aLlH1VPn6U73n9YomTqU5/iI/nHl3eCW/+rc9GiwFMBgY46uSv1tkNywHKd+
	VrClgZKor6fUBU02ehk0zB9B4Dw9PyM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-qHmnmFFzMTaM8t_Cj_1V9Q-1; Mon,
 16 Jun 2025 04:26:15 -0400
X-MC-Unique: qHmnmFFzMTaM8t_Cj_1V9Q-1
X-Mimecast-MFC-AGG-ID: qHmnmFFzMTaM8t_Cj_1V9Q_1750062374
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 38B881808985;
	Mon, 16 Jun 2025 08:26:14 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.72])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0BA3A180045B;
	Mon, 16 Jun 2025 08:26:10 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V3 12/19] virtio_ring: use u16 for last_used_idx in virtqueue_poll_split()
Date: Mon, 16 Jun 2025 16:25:10 +0800
Message-ID: <20250616082518.10411-13-jasowang@redhat.com>
In-Reply-To: <20250616082518.10411-1-jasowang@redhat.com>
References: <20250616082518.10411-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Use u16 for last_used_idx in virtqueue_poll_split() to align with the
spec.

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 03b17bc275dd..b14bbb4d6713 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -801,7 +801,7 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 }
 
 static bool virtqueue_poll_split(const struct vring_virtqueue *vq,
-				 unsigned int last_used_idx)
+				 u16 last_used_idx)
 {
 	return (u16)last_used_idx != virtio16_to_cpu(vq->vq.vdev,
 			vq->split.vring.used->idx);
-- 
2.34.1

