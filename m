Received: from cvsmtppost19.nm.naver.com (cvsmtppost19.nm.naver.com [114.111.35.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43342D0617
	for <virtualization@lists.linux.dev>; Thu,  8 Oct 2026 05:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.111.35.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791435882; cv=none; b=TZcDJjU7K+GNl3CzEReAjdQofo9S4KpWHFYd2ddYtcbU6mgAfbfCP9ga0F4tdDsaIqOQ5MN449eQ4n4jANVk74gArULfq/Qe/hHEhdRriq3yrM+ttlbVqMS4v2ASohDfzYFhPD95fOk3SRWW8kgFx4cftj/I68y8G1tG4V7/xGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791435882; c=relaxed/simple;
	bh=CUos84z5KZXbTdX8Kh9rzJYzKZ9etXkVcYv6cbYxNXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vEK2GuGmxBf/pfKKtJt5+YUPLVUZEbonNZK86elK4xP6cgmJQJCZWKKEXGF+mnDUB8fJ9mdwu8CApQqi2lKGsOMzAa2n9J1tEqdmtGOaOqG7vB2PKmt8bjJ3mGsSG41mbwJVS+AhsgjwiWAz+yiTA7+OXpJRCqfv+rEcnO7kynI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com; spf=pass smtp.mailfrom=naver.com; dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b=nG8Jz8yR; arc=none smtp.client-ip=114.111.35.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b="nG8Jz8yR"
Received: from cvsendbo016.nm ([10.112.24.39])
  by cvsmtppost19.nm.naver.com with ESMTP id +ksT3xZzQCWSDa2Bu+13eg
  for <virtualization@lists.linux.dev>;
  Thu, 08 Oct 2026 05:04:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=naver.com; s=s20171208;
	t=1791435872; bh=CUos84z5KZXbTdX8Kh9rzJYzKZ9etXkVcYv6cbYxNXc=;
	h=From:To:Subject:Date:Message-ID:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=nG8Jz8yRhHURhrHV5PgBZe6E04fR6Z1SWdpKpU5gFOC3j6uIyNGbHiVLDLSfJJIY7
	 +a9WLIjc2Mh3uEtFBu9QGSRvg4R3SBhVjWZ7ChpAllglg6cdGuSMlLkqwkZmHkr/bm
	 Bm6ftQQcPdWYhuZRCfWkuQFx0cz7rLQ+DfmAa3lGmVbCYhOxomyaL6E3udCwm2ALNX
	 KcQWBK2wAkUc+e/tSByWgeJ1n6kYxo6kcq2ztbFQbcz67R7i45391ObO1ko7MoCA2O
	 cPLr0STud9cpul0HMeHXABYJ/JhZq5otADtJ693AjXny7vR5G5iQvhM93ei32vFGtV
	 MF1n6LO8uShlQ==
X-Session-ID: l09+7Nq8SmuWbELd-SAZMQ
X-Works-Send-Opt: OPewpzGdjHmdKHFOMr39Ko3YKBmrjAudFqM9KqMqFxIYkEljxBmwjAg=
X-Works-Smtp-Source: rqKmFAulFqJZ+HmZFqtq+6E=
Received: from localhost.localdomain ([115.136.205.4])
  by cvnsmtp009.nm.naver.com with ESMTP id l09+7Nq8SmuWbELd-SAZMQ
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Thu, 08 Oct 2026 05:04:32 -0000
From: sung byeongchan <tjdqudcks0424@naver.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	sungbyeongchan <tjdqudcks0424@naver.com>
Subject: [PATCH v3] virtio_ring: use shadow flags when detaching split descriptors
Date: Thu,  8 Oct 2026 14:04:23 +0900
Message-ID: <20261008050423.32221-1-tjdqudcks0424@naver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261006102112.847280-1-tjdqudcks0424@naver.com>
References: <20261006102112.847280-1-tjdqudcks0424@naver.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: sungbyeongchan <tjdqudcks0424@naver.com>

Split virtqueues save descriptor flags and next indexes in desc_extra
before publishing descriptors to the device. The detach path uses the
shadow next index, but decides whether to continue by rereading the NEXT
flag from the shared descriptor.

Use the shadow flags for the continuation decision as well. This keeps
all detach metadata in the same driver-owned snapshot and avoids an
unnecessary shared-ring read.

Fixes: 72b5e8958738 ("virtio-ring: store DMA metadata in desc_extra for split virtqueue")
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: LLM
Signed-off-by: sungbyeongchan <tjdqudcks0424@naver.com>
---
Changes in v3:
- Restore a concise commit message explaining the mixed shared/shadow
  metadata problem. The v2 response had removed the whole description.
- Keep Michael's Acked-by.
- No code changes.

Changes in v2:
- Drop the two paragraphs Michael identified as unnecessary.
- Add Michael's Acked-by.

 drivers/virtio/virtio_ring.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index db678f5a80e03..b4cb433df1dec 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -905,7 +905,6 @@ static unsigned detach_buf_split_in_order(struct vring_virtqueue *vq,
 {
 	struct vring_desc_extra *extra;
 	unsigned int i;
-	__virtio16 nextflag = cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT);
 
 	/* Clear data ptr. */
 	vq->split.desc_state[head].data = NULL;
@@ -915,7 +914,7 @@ static unsigned detach_buf_split_in_order(struct vring_virtqueue *vq,
 	/* Put back on free list: unmap first-level descriptors and find end */
 	i = head;
 
-	while (vq->split.vring.desc[i].flags & nextflag) {
+	while (extra[i].flags & VRING_DESC_F_NEXT) {
 		i = vring_unmap_one_split(vq, &extra[i]);
 		vq->vq.num_free++;
 	}
base-commit: 0c2669a9f4a1d607e7591ae50ccf3c432a0aff08
-- 
2.43.0

