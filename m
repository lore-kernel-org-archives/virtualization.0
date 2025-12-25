Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FC01DF74F
	for <virtualization@lists.linux.dev>; Thu, 25 Dec 2025 04:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766636832; cv=none; b=MU3Nodv4iZ7apimULSzs/M1lpCzPycTrfvA8922k4bRdhpuPa95SANBtU0eZFEpphD5KXnhnf4Ylil++IUjWvX3xvHeojvwC4m7czzhp99vubtZ3zURWT8OhfsiV5WjRTWvyOA1EL6nnCouYnD0JU3BRAsoelzRxNczp3TlOsUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766636832; c=relaxed/simple;
	bh=7+M6FY0CrnWAV+hhAExp3CegwI0pm5qlnSpU5bH5yfU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r0c/pjhMUKXN8VnnMCk4ZQS+8PlsoSHUHzms4AiIUjxysBEWvBKN89fzD0pOY8zbhOLBGDtcVJEBrX13aXcbLTu2gbrH/8WBiH7WwurNqrxrsIpKcK8jrKROe+BGwiL2lrb3FML1/306H+LYt4Fay5rGe3qcFv3D80w5k18kvRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PwApsYu3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PwApsYu3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766636830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v7SW6y3BaocdVTeTcaXd7PTcuFbJm5a3JDZdYiqSd8E=;
	b=PwApsYu3zJxoQS0ZsTH7uzVF6mCSVfNMBWf43+BpJJE3SxNKTRXwoLEWVVGHuU1F7aN6BP
	XGEFUr0dp+91+yFJ2ACnjfM08hQrurW3tYr3ZXONmP2lxQAk1hw1RG7SkAPjCDQh7TryIC
	ROs1LaW8WC0DEYLmWn9oybg9Sj6hKkw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-191-PqrGRsypPRabuzDXGoWWLg-1; Wed,
 24 Dec 2025 23:27:06 -0500
X-MC-Unique: PqrGRsypPRabuzDXGoWWLg-1
X-Mimecast-MFC-AGG-ID: PqrGRsypPRabuzDXGoWWLg_1766636826
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A9023195605A;
	Thu, 25 Dec 2025 04:27:05 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.120.18])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 89FEE180049F;
	Thu, 25 Dec 2025 04:27:02 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V11 12/19] virtio_ring: switch to use unsigned int for virtqueue_poll_packed()
Date: Thu, 25 Dec 2025 12:26:01 +0800
Message-ID: <20251225042608.32350-13-jasowang@redhat.com>
In-Reply-To: <20251225042608.32350-1-jasowang@redhat.com>
References: <20251225042608.32350-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Switch to use unsigned int for virtqueue_poll_packed() to match
virtqueue_poll() and virtqueue_poll_split() and to ease the
abstraction of the virtqueue ops.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index db5cdb5fcb20..f804c5c6975a 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1699,7 +1699,8 @@ static inline bool is_used_desc_packed(const struct vring_virtqueue *vq,
 	return avail == used && used == used_wrap_counter;
 }
 
-static bool virtqueue_poll_packed(const struct vring_virtqueue *vq, u16 off_wrap)
+static bool virtqueue_poll_packed(const struct vring_virtqueue *vq,
+				  unsigned int off_wrap)
 {
 	bool wrap_counter;
 	u16 used_idx;
-- 
2.31.1

