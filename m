Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0890B13D8B6
	for <virtualization@lists.linux.dev>; Mon, 25 Mar 2024 09:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711357467; cv=none; b=iTk89+OW1YGW+TAWIt0LF22PgKvXDnmrg9cMp5F983pJi5Aja3lqVoewJTX+qvlb7B+frSyEhvVwQdIZqT9EBCzx3HtD96AzuLJhjJLdHftNvtz2qh4w+EDo5kdGZWlo7PTy7XyNdjYejA1NtbmkCLW3Ly3xab7w/3ZfGwBfnHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711357467; c=relaxed/simple;
	bh=SZsK5xLS0BLJ1/GqEFhUHfzQ4IlUJuJfMq7ykQcrgNo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eaKYeoyTeK7d4X+pU0DgMKihLbHx91bJIRO5yvgRueulbR32IRybCczOhCzOpLBRWNbUfIzNiBW7BwjfT7nOE/6YI5w9JzGRkRHetVAb2qOM4EmPlMpAb999Moc8NE7F3PCryMIPYuNx8uqcQR7hcHBZ5or5zS9M+M8of1EXAl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=R1aA1dpk; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="R1aA1dpk"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711357462; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=zH1bfqG7iyJRLFrnYFbUd+K/XLbnQYfUsfT+La4OOPE=;
	b=R1aA1dpk2G5ddcB420uOWSd0tdAdUV3YlgAcbwCyMZIWJ1CNMrZ27pyqwEJuoHFPDrN/+yl7ljZb3WTKzjMrmG44DONYHEfSy1qJKOwK1TpXYE8cQ+JVqLowth1CIJe1DuwzoyT1C+R8EkgPHmujfngQsBD4kyc2252tFo4vrVA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=26;SR=0;TI=SMTPD_---0W3DW6on_1711357461;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W3DW6on_1711357461)
          by smtp.aliyun-inc.com;
          Mon, 25 Mar 2024 17:04:22 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux.dev
Cc: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	linux-um@lists.infradead.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH vhost v5 1/6] virtio_balloon: remove the dependence where names[] is null
Date: Mon, 25 Mar 2024 17:04:14 +0800
Message-Id: <20240325090419.33677-2-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240325090419.33677-1-xuanzhuo@linux.alibaba.com>
References: <20240325090419.33677-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: f38b33f54e32
Content-Transfer-Encoding: 8bit

Currently, the init_vqs function within the virtio_balloon driver relies
on the condition that certain names array entries are null in order to
skip the initialization of some virtual queues (vqs). This behavior is
unique to this part of the codebase. In an upcoming commit, we plan to
eliminate this dependency by removing the function entirely. Therefore,
with this change, we are ensuring that the virtio_balloon no longer
depends on the aforementioned function.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_balloon.c | 46 +++++++++++++--------------------
 1 file changed, 18 insertions(+), 28 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 1f5b3dd31fcf..8409642e54d7 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -531,49 +531,39 @@ static int init_vqs(struct virtio_balloon *vb)
 	struct virtqueue *vqs[VIRTIO_BALLOON_VQ_MAX];
 	vq_callback_t *callbacks[VIRTIO_BALLOON_VQ_MAX];
 	const char *names[VIRTIO_BALLOON_VQ_MAX];
-	int err;
+	int err, nvqs = 0, idx = 0;
 
-	/*
-	 * Inflateq and deflateq are used unconditionally. The names[]
-	 * will be NULL if the related feature is not enabled, which will
-	 * cause no allocation for the corresponding virtqueue in find_vqs.
-	 */
-	callbacks[VIRTIO_BALLOON_VQ_INFLATE] = balloon_ack;
-	names[VIRTIO_BALLOON_VQ_INFLATE] = "inflate";
-	callbacks[VIRTIO_BALLOON_VQ_DEFLATE] = balloon_ack;
-	names[VIRTIO_BALLOON_VQ_DEFLATE] = "deflate";
-	callbacks[VIRTIO_BALLOON_VQ_STATS] = NULL;
-	names[VIRTIO_BALLOON_VQ_STATS] = NULL;
-	callbacks[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
-	names[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
-	names[VIRTIO_BALLOON_VQ_REPORTING] = NULL;
+	callbacks[nvqs] = balloon_ack;
+	names[nvqs++] = "inflate";
+	callbacks[nvqs] = balloon_ack;
+	names[nvqs++] = "deflate";
 
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
-		names[VIRTIO_BALLOON_VQ_STATS] = "stats";
-		callbacks[VIRTIO_BALLOON_VQ_STATS] = stats_request;
+		names[nvqs] = "stats";
+		callbacks[nvqs++] = stats_request;
 	}
 
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
-		names[VIRTIO_BALLOON_VQ_FREE_PAGE] = "free_page_vq";
-		callbacks[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
+		names[nvqs] = "free_page_vq";
+		callbacks[nvqs++] = NULL;
 	}
 
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING)) {
-		names[VIRTIO_BALLOON_VQ_REPORTING] = "reporting_vq";
-		callbacks[VIRTIO_BALLOON_VQ_REPORTING] = balloon_ack;
+		names[nvqs] = "reporting_vq";
+		callbacks[nvqs++] = balloon_ack;
 	}
 
-	err = virtio_find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX, vqs,
-			      callbacks, names, NULL);
+	err = virtio_find_vqs(vb->vdev, nvqs, vqs, callbacks, names, NULL);
 	if (err)
 		return err;
 
-	vb->inflate_vq = vqs[VIRTIO_BALLOON_VQ_INFLATE];
-	vb->deflate_vq = vqs[VIRTIO_BALLOON_VQ_DEFLATE];
+	vb->inflate_vq = vqs[idx++];
+	vb->deflate_vq = vqs[idx++];
+
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
 		struct scatterlist sg;
 		unsigned int num_stats;
-		vb->stats_vq = vqs[VIRTIO_BALLOON_VQ_STATS];
+		vb->stats_vq = vqs[idx++];
 
 		/*
 		 * Prime this virtqueue with one buffer so the hypervisor can
@@ -593,10 +583,10 @@ static int init_vqs(struct virtio_balloon *vb)
 	}
 
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
-		vb->free_page_vq = vqs[VIRTIO_BALLOON_VQ_FREE_PAGE];
+		vb->free_page_vq = vqs[idx++];
 
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING))
-		vb->reporting_vq = vqs[VIRTIO_BALLOON_VQ_REPORTING];
+		vb->reporting_vq = vqs[idx++];
 
 	return 0;
 }
-- 
2.32.0.3.g01195cf9f

