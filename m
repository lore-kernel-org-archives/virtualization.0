Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF07134CF
	for <virtualization@lists.linux.dev>; Tue,  2 Jun 2026 04:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780374735; cv=none; b=tgPKayzXOMVj3tyAh0f7SZ80Ov8VkX0IoYINT38rvUaE8L/LyRnhG2zLe3xBYxk2QlEOZrx/jLBSoCW1uN7QPhB3lGi7j7n2PpGXQWnB2kCkOWVjUm4c/rhp+v4bW+IGkB6lYRXp3OL9B/b/vhZzqgEsckloptGQNJlJIOu8vW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780374735; c=relaxed/simple;
	bh=2Y6n5vptl+UQKIOpJvWwgsp4V3dO0ej51oIaDqxEORY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=aZ240qiTcH01tit+s4k9CadXZ3aRAN+lDwUCp3Orj4tuKmr+FWtSLFKi3vL+q3FBnolyktdgET+TKEuQjKVMc/Z88dFkit0qvhsUb8F4+im9mTx/RPInKzDZ/Qs33llTTpIMf9HQOMo10wovcpi/xc9v7ZWilHy3IOgQsUEpv9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=SGxNI7I7; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SGxNI7I7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=fjVGfXcKNG+YTxVcw+/rYcl97WsmjmXNVuWfW4kOW6Y=;
	b=SGxNI7I7a2Pau4wEoeTi/3AjccHY9VDLQ+oTuceAE+LhOxOwvip9pexQu0BlCW
	D+mF1T2sZRg+UZU0XI32gf9hGeBRVj2eKsv84T7d94vsLsy95miOIVt537Ms95Bg
	qN9Jo4AQt0maDJJiiI9eTAeoohWg/uphxe8czh3UvfZlw=
Received: from yangjl.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wAn0+fDXB5qSNGwAw--.28891S2;
	Tue, 02 Jun 2026 12:32:04 +0800 (CST)
From: yangjiale <yangjiale133@163.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	yangjiale <yangjiale133@163.com>
Subject: [PATCH] VIRTIO: Update the desc 'flag' fied last in packed ring.
Date: Tue,  2 Jun 2026 12:31:23 +0800
Message-Id: <20260602043123.10207-1-yangjiale133@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAn0+fDXB5qSNGwAw--.28891S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFykZry8GF4xCF1xCFy7GFg_yoW8GFW7pF
	4Ykay5C3WfZF12qanrGF17WFy5u3s3K34fZayUW34Y9F15ZF17Xry0kFyxtr4UJryvyw48
	Ar4xuayUGF1kuFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEiL0-UUUUU=
X-CM-SenderInfo: p1dqwy5ldoviitt6il2tof0z/xtbC-gRqg2oeXMQlMQAA3r

When a descriptor list spans across cache lines,
updating the flag first can lead to a scenario where the device side
perceives the flag as valid, yet the corresponding address and length
fields remain unupdated—resulting in invalid values.
Therefore, the flag field must be updated last.

Signed-off-by: yangjiale <yangjiale133@163.com>
---
 drivers/virtio/virtio_ring.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index fbca7ce1c6bf..036b4f90d30f 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1688,6 +1688,10 @@ static inline int virtqueue_add_packed(struct vring_virtqueue *vq,
 					     &addr, &len, premapped, attr))
 				goto unmap_release;
 
+			desc[i].addr = cpu_to_le64(addr);
+			desc[i].len = cpu_to_le32(len);
+			desc[i].id = cpu_to_le16(id);
+
 			flags = cpu_to_le16(vq->packed.avail_used_flags |
 				    (++c == total_sg ? 0 : VRING_DESC_F_NEXT) |
 				    (n < out_sgs ? 0 : VRING_DESC_F_WRITE));
@@ -1696,10 +1700,6 @@ static inline int virtqueue_add_packed(struct vring_virtqueue *vq,
 			else
 				desc[i].flags = flags;
 
-			desc[i].addr = cpu_to_le64(addr);
-			desc[i].len = cpu_to_le32(len);
-			desc[i].id = cpu_to_le16(id);
-
 			if (unlikely(vq->use_map_api)) {
 				vq->packed.desc_extra[curr].addr = premapped ?
 					DMA_MAPPING_ERROR : addr;
-- 
2.25.1

