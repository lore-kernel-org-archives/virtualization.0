Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.249.96.39
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795680138;
	b=wcvSs/VjDlOfRnsPUeXfgfbv4BP7CmPO9AQxwT+NTLA4tB8APFzD6zmKXBd39Kobrr0p
	 nL5v4uGgWiDxP4dHx7Fx+McOzSqxpdK38BPsckEzMPaku9vm1MSo/+l10ynMUzqHyDZsy
	 HzCr0QHtUcvPIjsM2raZHL5vfOGiM/8fQN7BTpMnAY13wxJi0FhBMvf6Xo5crXJGfxv5n
	 6P2ZtqdbXDYZI1cei0Qi64Q6lmdJiTxXXtRU6syBj6DBgaBcBtgs4zEzza5a+ldiNMPAR
	 9Rk0btX/AkW4ap2UwauIYIno3e9z2hFIon+hk4Iiy0qjRYT8I/GbJzPyYbMsEs47GSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795680138;
	h=DMARC-Filter:Received:X-Original-SENDERIP:X-Original-SENDERCOUNTRY:
	 X-Original-MAILFROM:X-Original-RCPTTO:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=OzKQ/lm4zPHDFPSvdMmNbuacxwmuhPVf7/IXTKhlYuM=;
	b=Tz/etS0uqo04PLPWQpS+I5xgwON7fLqS/trvqUCSl/ROXwVikMuYlxG1A/g7IiJP/m2y
	 TSyxGDfcSwsP3UkmUYUpRaLFJ0M9l3yY6LWZEsQEN6JHKmVH7zumQuYY17qoy9E24VJHi
	 KmmdKp89CTwozieHawvkQi3sGDHL9DvPEYXs+VDPOeuZ/ZY6DuJgfnZzhH44aE/4a9+sj
	 jWl1sYKFUJISUn5h+PKg3kNb3OMEFbxU8/glHHjAhFwN0GK1nHp8jTW2FNEqEdvsWtXKe
	 xl8v7G5kOChNPM7qRqAa4UzTKYZaU/F35G3b9rm3ffE5wp5j0knfvaqeNxbcrY6azRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uos.ac.kr;
	spf=pass smtp.mailfrom=uos.ac.kr;
	arc=none smtp.remote-ip=203.249.96.39
Received: from sniper.uos.ac.kr (sniper2.uos.ac.kr [203.249.96.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427DD606A32D
	for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 08:02:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 427DD606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uos.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uos.ac.kr
Received: from unknown (HELO localhost.taild276f1.ts.net) (love09010224@uos.ac.kr@1.229.202.195)
	by 203.249.96.39 with ESMTP; 26 Nov 2026 17:02:14 +0900
X-Original-SENDERIP: 1.229.202.195
X-Original-SENDERCOUNTRY: KR, South Korea 
X-Original-MAILFROM: love09010224@uos.ac.kr
X-Original-RCPTTO: mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev,
	security@kernel.org
From: Seojin An <love09010224@uos.ac.kr>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	security@kernel.org
Subject: [PATCH] virtio_ring: reject unrepresentable split indirect tables
Date: Thu, 26 Nov 2026 17:02:09 +0900
Message-ID: <20261126080209.2898344-1-love09010224@uos.ac.kr>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split descriptors store the next index as u16. alloc_indirect_split() can
allocate a larger table, but virtqueue_add_split() feeds the truncated next
value back into its construction index. With more than 65,536 SG entries,
the index wraps and later entries replace descriptors at the start of the
table. The device then consumes a chain different from the caller's SG
sequence.

Reject split indirect tables whose entry count exceeds the representable
index range. Keep the existing compatibility policy that permits
representable indirect chains longer than Queue Size, and leave packed
indirect descriptors unchanged.

A virtio-gpu render client can reach this condition with a vmalloc-backed
EXECBUFFER. In a no-vIOMMU QEMU/virgl guest, the resulting command
substitution provided guest physical read/write and initial-namespace
uid/euid 0. The virtio-gpu producer needs its own Queue-Size check because
its current queue error path warns about an add failure but advances
pending state and reports success.

AI tools assisted the source audit, reproducer construction and patch
drafting.

Fixes: 9fa29b9df32b ("virtio: indirect ring entries (VIRTIO_RING_F_INDIRECT_DESC)")
Reported-by: Hyeonjun Hong <hyeonjunhong330@gmail.com>
Reported-by: GEONWOO HAN <gunwoo9643@uos.ac.kr>
Cc: stable@vger.kernel.org
Signed-off-by: Seojin An <love09010224@uos.ac.kr>
---
 drivers/virtio/virtio_ring.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index f683a2d6a2002..ad9e52584fb52 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -686,9 +686,19 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
 
 	head = vq->free_head;
 
-	if (virtqueue_use_indirect(vq, total_sg))
+	if (virtqueue_use_indirect(vq, total_sg)) {
+		/*
+		 * The core historically permits an indirect chain to exceed the
+		 * queue size.  Preserve that policy, but do not let its 16-bit
+		 * split descriptor links wrap within the allocated table.
+		 */
+		if (unlikely(total_sg > (1U << 16))) {
+			END_USE(vq);
+			return -E2BIG;
+		}
+
 		desc = alloc_indirect_split(vq, total_sg, gfp);
-	else {
+	} else {
 		desc = NULL;
 		WARN_ON_ONCE(total_sg > vq->split.vring.num && !vq->indirect);
 	}

base-commit: 40212b29a6f718d4e7fb3275cede181cb8e137cf
-- 
2.43.0

