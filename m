Received: from cvsmtppost21.nm.naver.com (cvsmtppost21.nm.naver.com [114.111.35.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7FB3D9529
	for <virtualization@lists.linux.dev>; Tue,  6 Oct 2026 10:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.111.35.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791282092; cv=none; b=Cil3oe7TY1Hp3QD65qR5camH7BD7nJw5VhMk/FwIOiuXAn63Ue3LzgEMRD8rfshc1gqhew0x7c4gfxyWlsC2dRLYGrXzkY1tP7ejOHDSx9fPkTlq0ywxcAzFpDx70eHqmuapXxR4jOgCw/XKEcQYzVBz2tUSdGZl57jOaRdGTlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791282092; c=relaxed/simple;
	bh=QqulCsapT2Fj83sxvE+DQ+IFCCV3oHDYRXWdlknJDXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i4T+HZQAFTcsa0sBz5m1aT3I2Lw9CbXc/W8xKTo4kLkR5+Gtud/tTexdDxZIod1/kdDiArk67HF5eUyzBCIWD/7V1T3YZcwLa7k0YbKFIgWJf213OCneRF0Um1VwbR8CBYIQHeA90SYHhVKuBUuc/mIwofeso46+9TmUqfFhfqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com; spf=pass smtp.mailfrom=naver.com; dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b=NZtZY2bG; arc=none smtp.client-ip=114.111.35.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b="NZtZY2bG"
Received: from cvsendbo002.nm ([10.112.20.42])
  by cvsmtppost21.nm.naver.com with ESMTP id anPUWllhTXqELGN6l40B7A
  for <virtualization@lists.linux.dev>;
  Tue, 06 Oct 2026 10:21:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=naver.com; s=s20171208;
	t=1791282081; bh=QqulCsapT2Fj83sxvE+DQ+IFCCV3oHDYRXWdlknJDXM=;
	h=From:To:Subject:Date:Message-ID:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=NZtZY2bGJESDcPACv4Klb5akAQJeAaikUNp5jak0dFfbWw6G2J/Eugrn6O1/AV7D4
	 MP9o3ZPLVMPo8Y2Bh2sOzsUOoki0FYyEqxCwI4A85zEL4FtMtKrdadR4XDQy7s4T5n
	 k+UHXO/hMQ+bUM3VgR50+wGB90JR9gf1P5J8eiE4rhKMgy3sz29virUJ0RqdCouXws
	 yYW+GqDsL7hy7rwjAJeKjJghhrlqM8T2IgNoXUYxmcpNd1DqA1rWvx0jzxykHNSYFC
	 flIklu9PJkcBRqabYa6zTKCFjASu3oDKXl946crAh2dRfxQJWEVMUdyZi65JHqF9GU
	 RIM5o0lNgBjjg==
X-Session-ID: ye+qwul7SeqKFDwcQXNVyg
X-Works-Send-Opt: OPewpzGdjHmdKHFOMr39Ko3YKBmrjAudFqM9KqMqFxIYkEljxBmwjAg=
X-Works-Smtp-Source: /dYdKoulFqJZ+HmmaAMl+6E=
Received: from localhost.localdomain ([115.136.205.4])
  by cvnsmtp003.nm.naver.com with ESMTP id ye+qwul7SeqKFDwcQXNVyg
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Tue, 06 Oct 2026 10:21:20 -0000
From: sungbyeongchan <tjdqudcks0424@naver.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	sungbyeongchan <tjdqudcks0424@naver.com>
Subject: [PATCH v2] virtio_ring: use shadow flags when detaching split descriptors
Date: Tue,  6 Oct 2026 19:21:12 +0900
Message-ID: <20261006102112.847280-1-tjdqudcks0424@naver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes: 72b5e8958738 ("virtio-ring: store DMA metadata in desc_extra for split virtqueue")
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: LLM
Signed-off-by: sungbyeongchan <tjdqudcks0424@naver.com>
---
Changes in v2:
- Drop the commit message paragraphs as requested by Michael S. Tsirkin.
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
-- 
2.43.0

