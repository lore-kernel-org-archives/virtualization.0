Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2780B16EB42
	for <virtualization@lists.linux.dev>; Mon, 24 Mar 2025 05:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742795093; cv=none; b=GRhQDBbuiqhB7hUJbSLeYKG69q+xHfLNGTg3tkhxVtUPPmKlrOCNjhpk9Cp04zHpzWmP5eFreTEiIzAWNEK7QRKXqwfnTyZmNJ0gSaMakfCfyOnwV8l7LbgJbwlxtLGBlsSn8hWQ7LVpLDEINmi/T+Ry++b+X15Mu09+muoO0F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742795093; c=relaxed/simple;
	bh=U8FQ3WCzUpzAdt4fdoQCq31niiSqwzR0pgRI9MZWhyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=HzhCprrM96x31M/OIl0Cy60bNbNOUQmARV+8TQZobFMjLpFS4FpcnZsweosN2hZmNr3BcqoGM2nErTlc3NlbUN8qh9ru18kBYZjDWJW74Nt9mKj+i3uq443VJUPZ7l03GSwf79TkU++5SVW9YKaTQW+7gACx994Ie7LG1eV34vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MWDjJoPr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MWDjJoPr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742795091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hdtJBojWysf83uWkpYenJh6PvgKphWk5R5ZDMHe4SEs=;
	b=MWDjJoPrfYrLSBCdMzLjK9y2+EaRm8REiD4OBlF2OppWLvl95DVMWPYOsPz1lv9lXdlc2u
	rSB/6ypQLSI45GbzjC+hZjQrQ6opuubtb/pUtlnja1vov2D3DRFDbH8PC67LOYR+Z0l3Kb
	9UVM7IpsmqN+WS5xqt2S2ubHEBP78UA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-241-Q8S0RL1oNsGm5pCCs4wyAw-1; Mon,
 24 Mar 2025 01:44:47 -0400
X-MC-Unique: Q8S0RL1oNsGm5pCCs4wyAw-1
X-Mimecast-MFC-AGG-ID: Q8S0RL1oNsGm5pCCs4wyAw_1742795086
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4AD75180AF49;
	Mon, 24 Mar 2025 05:44:45 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.200])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 839231828B5B;
	Mon, 24 Mar 2025 05:44:33 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 12/19] virtio_ring: use u16 for last_used_idx in virtqueue_poll_split()
Date: Mon, 24 Mar 2025 13:43:26 +0800
Message-ID: <20250324054333.1954-13-jasowang@redhat.com>
In-Reply-To: <20250324054333.1954-1-jasowang@redhat.com>
References: <20250324054333.1954-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Use u16 for last_used_idx in virtqueue_poll_split() to align with the
spec.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 19aa24d62d20..a2884eae14d9 100644
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
2.42.0

