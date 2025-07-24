Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C5621858D
	for <virtualization@lists.linux.dev>; Thu, 24 Jul 2025 06:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753339283; cv=none; b=TI7cF9d66VY5K3jW+ynOIs3WMbA8ySebdciK+lRkwlJcFh9xo33NL+p58Uv/KLPRYQB+zz68HMF6Y4h0tjGZ0iyT5Oyd/S/rjUO+H+nDB3dK1VfTB78q0d0I1ig3sd00vhSZinJcpTXIPQDFDvkDnrdFbxZ+ITzMNWALGIfgp2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753339283; c=relaxed/simple;
	bh=BrUp54+Nw89iAStDLuvi4fujbgr5ptH8J/GZDCWHtGI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sa1RYQDPNupwHAbM/1mNQPbWGUlWiwa9OejxZ9ucf/PrkB24evg0sMfkDliSGgg2kRZOIxKWOK59XRrkdY2fZyoc6HAxrq06V/xyviluyZCoGO0r3zxPmNdBNxtA7OtUaG18h3AezioiWORMQ6nmNNPeei7cP+FueYH9sUDa/Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K1YILXqL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K1YILXqL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753339280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yCK9EXlCNR+D1rOETqxNqaof4DwL+sBnRuTMJtuZIeg=;
	b=K1YILXqL+eDjpUwvWfmVCef7VtxZN7CGClyF/LbkeIL1knZXL4jhOKLh0cDDJW0eC0lJfA
	WjfVlE3JmQYJWEwn6btBC7k/g9f/26/yLDJwp3yGMDn839iUc8JtdUeb95FKaLt/BTZaek
	5iPRfv8owD+pL+LB13UInZk+tSx6d24=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-599-1EJXPPRtO_ijHj0Le9bu-Q-1; Thu,
 24 Jul 2025 02:41:17 -0400
X-MC-Unique: 1EJXPPRtO_ijHj0Le9bu-Q-1
X-Mimecast-MFC-AGG-ID: 1EJXPPRtO_ijHj0Le9bu-Q_1753339276
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 14D131800165;
	Thu, 24 Jul 2025 06:41:16 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.231])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B602D180035E;
	Thu, 24 Jul 2025 06:41:12 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V4 12/19] virtio_ring: use u16 for last_used_idx in virtqueue_poll_split()
Date: Thu, 24 Jul 2025 14:40:10 +0800
Message-ID: <20250724064017.26058-13-jasowang@redhat.com>
In-Reply-To: <20250724064017.26058-1-jasowang@redhat.com>
References: <20250724064017.26058-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Use u16 for last_used_idx in virtqueue_poll_split() to align with the
spec.

Acked-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 27d1239705bd..103e807249b6 100644
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
2.39.5

