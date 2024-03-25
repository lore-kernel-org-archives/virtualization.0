Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46E915EFA3
	for <virtualization@lists.linux.dev>; Mon, 25 Mar 2024 08:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711356880; cv=none; b=ClMlWryc+7hpDLrLd43Ja6/NXfn6bsPkyuwhfxnmQXp6YeICq9h5xQl+zDO0FHgEBXj7vAO3JBBC7FGVLPpWqOzMDMbOjwS8scNBgOgRNH5SiDG/8tm4k3kNjDrONnjCW0B+16B7CMF22bX+N/R35JnG9/FaYya3ULFxquod7OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711356880; c=relaxed/simple;
	bh=YzZ6Dmk5yesSigLff95Hr/BBX+cZXEqEv3/7ZiUTwu4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KjfWqRO4ZfOJitYzj67sYH5IS4vzEKVSL5prht0zA+41tNztiFEQuuXLoNGmfFVBIws45xrc2OxED+GmxPVK6A8ndC4QqK3S672SRY5kNIAeLIueBgqOMnIMsk+98B0IpCsvcDlB9Ve0n9178KFWnGYK4T+p8iPU4Gjlloe4L9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mZVOYL0C; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mZVOYL0C"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711356876; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=fH3/UYfFm0HBtaqIAa282OSPXTuZ06kVQ9Av1BoHR7E=;
	b=mZVOYL0CswrI+MmG7DU7Mu1jEd2boPMAVuOSdu1FdMJoKdC/rP0kGaNBAV/FpnHMuE/9geMccQzG2ihXb3aGJRei9HnaU68dSjRvMSbQGPN4rgXoY5mhSOGM8zXvgaSNaJsLmDuoaswvjCKPFTnt2U9uR/O8hmu9O/DBKyY2YBM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W3DVful_1711356875;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W3DVful_1711356875)
          by smtp.aliyun-inc.com;
          Mon, 25 Mar 2024 16:54:36 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH vhost v5 07/10] virtio: find_vqs: add new parameter premapped
Date: Mon, 25 Mar 2024 16:54:25 +0800
Message-Id: <20240325085428.7275-8-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240325085428.7275-1-xuanzhuo@linux.alibaba.com>
References: <20240325085428.7275-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: 630d711f51f7
Content-Transfer-Encoding: 8bit

If the premapped mode is enabled, the dma array(struct vring_desc_dma) of
virtio core will not be allocated. That is judged when find_vqs() is
called. To avoid allocating dma array in find_vqs() and releasing it
immediately by virtqueue_set_dma_premapped(). This patch introduces a
new parameter to find_vqs(). Then we can judge should we allocate the
dma array(struct vring_desc_dma) or not inside find_vqs().

The driver must check the premapped mode of every vq after find_vqs().

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c  | 4 ++--
 include/linux/virtio_config.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index f67f4ac2d58f..b0a715f23f17 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2148,7 +2148,7 @@ static struct virtqueue *vring_create_virtqueue_packed(struct virtio_device *vde
 	vq->packed_ring = true;
 	vq->dma_dev = dma_dev;
 	vq->use_dma_api = vring_use_dma_api(vdev);
-	vq->premapped = false;
+	vq->premapped = vq->use_dma_api && cfg_vq_get(cfg, premapped);
 
 	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
 		!cfg_vq_get(cfg, ctx);
@@ -2696,7 +2696,7 @@ static struct virtqueue *__vring_new_virtqueue(struct virtio_device *vdev,
 #endif
 	vq->dma_dev = tp_cfg->dma_dev;
 	vq->use_dma_api = vring_use_dma_api(vdev);
-	vq->premapped = false;
+	vq->premapped = vq->use_dma_api && cfg_vq_get(cfg, premapped);
 
 	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
 		!cfg_vq_get(cfg, ctx);
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index d47188303d34..f1f62e57f395 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -107,6 +107,7 @@ struct virtio_vq_config {
 	vq_callback_t **callbacks;
 	const char **names;
 	const bool *ctx;
+	const bool *premapped;
 	struct irq_affinity *desc;
 };
 
-- 
2.32.0.3.g01195cf9f

