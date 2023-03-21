Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E0FC74A5B
	for <virtualization@archiver.kernel.org>; Tue, 21 Mar 2023 15:43:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9239F81FDF;
	Tue, 21 Mar 2023 15:43:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9239F81FDF
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JDpyEAxO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZpBG2uR7zG9o; Tue, 21 Mar 2023 15:43:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D4E5381E42;
	Tue, 21 Mar 2023 15:43:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D4E5381E42
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1542C0071;
	Tue, 21 Mar 2023 15:43:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B31ECC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 15:43:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9AE3A81FDF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 15:43:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9AE3A81FDF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YnQmoQnDIPua
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 15:43:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 63B8C81E42
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 63B8C81E42
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 15:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679413392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bIv3PP4yBpsiDfFQUDhlNlVTwLloVQU9kKPFwpUK4lo=;
 b=JDpyEAxOi9JcMYbHzVJh8J6EBniz4sQV9KVBjdiERaaheQwxCHmNFnVzxYXt28pcbs7FDO
 GmTXYsqsKO/j2gd+OpHzI7klrzn3YArhqhlrxmsQdgyOzfFXJhcvAbP+JfvVNDjGtVIG9c
 CuumHRJ/jXCetzzaCG78r5n1iGVcmPc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-srtGyyekMl6wcsAYd9hrJQ-1; Tue, 21 Mar 2023 11:43:03 -0400
X-MC-Unique: srtGyyekMl6wcsAYd9hrJQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 i3-20020a05600c354300b003edfa408811so3054010wmq.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 08:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679413380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bIv3PP4yBpsiDfFQUDhlNlVTwLloVQU9kKPFwpUK4lo=;
 b=OwoQR1fVo1TU3K480IbQTxym2vH60gZaQKSTkZdlY15VN/CToLUQedJnmwo+ptdTMc
 TJtShracZV0H274pD2hPvhigSLAm/RagcvzYfgOkeNVMBIpA4hsDcUOjM7TlMCqgYkaL
 BYrb39JaO0mE55TY3K463JtGvohg8JeSzMp9IpBg308/ylCdZ0Ryx0xmVvSrfjSGhPvQ
 VQBOwXgYDXxVQKAz5h3BA7s95h+U7VHcWE5H3Fz4uF8kfuzRl20d3o2TwO2GWFrVHyGk
 wwqhDxCEKmzN7eaC1D4TfGD7AgcYw9Zac8XvSNpv8pLYSZt3IiHHVg8VKyTdcdOfIL6e
 /amA==
X-Gm-Message-State: AO0yUKXJo0Mf0RBK77G/rRp0pjnL/QrOiEkqf1IAQ/WAZgvWPEei2v/S
 raLvEY9ce4C9lnDhwtuvywqyFO/uBqWqWpsXNvQZJCB795yPFdRBzdtltRS22ePghgh2CnF65hM
 vkqW4iwfPHUvU7XsM9xAmvVtb+soZEOXHe0YinZ/Gi6fykZRdZplS4igUHxiJ+Y/tobNdatep/q
 T/ZCSqCzkmG5W6Zx5MoZlMa6SSkg==
X-Received: by 2002:a5d:4d0f:0:b0:2cd:e089:398d with SMTP id
 z15-20020a5d4d0f000000b002cde089398dmr2806146wrt.5.1679413380350; 
 Tue, 21 Mar 2023 08:43:00 -0700 (PDT)
X-Google-Smtp-Source: AK7set8cYR72hdvy3mHJEzDhnqtBs/xqBE/H6lo8y8NxTbvPjr87rHIO4A/V1Ti6cu3VeSVcB8D4+A==
X-Received: by 2002:a5d:4d0f:0:b0:2cd:e089:398d with SMTP id
 z15-20020a5d4d0f000000b002cde089398dmr2806126wrt.5.1679413379955; 
 Tue, 21 Mar 2023 08:42:59 -0700 (PDT)
Received: from step1.redhat.com (host-82-57-51-170.retail.telecomitalia.it.
 [82.57.51.170]) by smtp.gmail.com with ESMTPSA id
 p5-20020adfce05000000b002d64fcb362dsm6340125wrn.111.2023.03.21.08.42.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Mar 2023 08:42:59 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v3 4/8] vringh: support VA with iotlb
Date: Tue, 21 Mar 2023 16:42:24 +0100
Message-Id: <20230321154228.182769-5-sgarzare@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230321154228.182769-1-sgarzare@redhat.com>
References: <20230321154228.182769-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, eperezma@redhat.com, stefanha@redhat.com
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

vDPA supports the possibility to use user VA in the iotlb messages.
So, let's add support for user VA in vringh to use it in the vDPA
simulators.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---

Notes:
    v3:
    - refactored avoiding code duplication [Eugenio]
    v2:
    - replace kmap_atomic() with kmap_local_page() [see previous patch]
    - fix cast warnings when build with W=1 C=1

 include/linux/vringh.h            |   5 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c |   2 +-
 drivers/vdpa/vdpa_sim/vdpa_sim.c  |   4 +-
 drivers/vhost/vringh.c            | 153 +++++++++++++++++++++++-------
 4 files changed, 127 insertions(+), 37 deletions(-)

diff --git a/include/linux/vringh.h b/include/linux/vringh.h
index 1991a02c6431..d39b9f2dcba0 100644
--- a/include/linux/vringh.h
+++ b/include/linux/vringh.h
@@ -32,6 +32,9 @@ struct vringh {
 	/* Can we get away with weak barriers? */
 	bool weak_barriers;
 
+	/* Use user's VA */
+	bool use_va;
+
 	/* Last available index we saw (ie. where we're up to). */
 	u16 last_avail_idx;
 
@@ -279,7 +282,7 @@ void vringh_set_iotlb(struct vringh *vrh, struct vhost_iotlb *iotlb,
 		      spinlock_t *iotlb_lock);
 
 int vringh_init_iotlb(struct vringh *vrh, u64 features,
-		      unsigned int num, bool weak_barriers,
+		      unsigned int num, bool weak_barriers, bool use_va,
 		      struct vring_desc *desc,
 		      struct vring_avail *avail,
 		      struct vring_used *used);
diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 520646ae7fa0..dfd0e000217b 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2537,7 +2537,7 @@ static int setup_cvq_vring(struct mlx5_vdpa_dev *mvdev)
 
 	if (mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ))
 		err = vringh_init_iotlb(&cvq->vring, mvdev->actual_features,
-					MLX5_CVQ_MAX_ENT, false,
+					MLX5_CVQ_MAX_ENT, false, false,
 					(struct vring_desc *)(uintptr_t)cvq->desc_addr,
 					(struct vring_avail *)(uintptr_t)cvq->driver_addr,
 					(struct vring_used *)(uintptr_t)cvq->device_addr);
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index eea23c630f7c..47cdf2a1f5b8 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -60,7 +60,7 @@ static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int idx)
 	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
 	uint16_t last_avail_idx = vq->vring.last_avail_idx;
 
-	vringh_init_iotlb(&vq->vring, vdpasim->features, vq->num, true,
+	vringh_init_iotlb(&vq->vring, vdpasim->features, vq->num, true, false,
 			  (struct vring_desc *)(uintptr_t)vq->desc_addr,
 			  (struct vring_avail *)
 			  (uintptr_t)vq->driver_addr,
@@ -92,7 +92,7 @@ static void vdpasim_vq_reset(struct vdpasim *vdpasim,
 	vq->cb = NULL;
 	vq->private = NULL;
 	vringh_init_iotlb(&vq->vring, vdpasim->dev_attr.supported_features,
-			  VDPASIM_QUEUE_MAX, false, NULL, NULL, NULL);
+			  VDPASIM_QUEUE_MAX, false, false, NULL, NULL, NULL);
 
 	vq->vring.notify = NULL;
 }
diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index 0ba3ef809e48..72c88519329a 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -1094,10 +1094,18 @@ EXPORT_SYMBOL(vringh_need_notify_kern);
 
 #if IS_REACHABLE(CONFIG_VHOST_IOTLB)
 
+struct iotlb_vec {
+	union {
+		struct iovec *iovec;
+		struct bio_vec *bvec;
+	} iov;
+	size_t count;
+	bool is_iovec;
+};
+
 static int iotlb_translate(const struct vringh *vrh,
 			   u64 addr, u64 len, u64 *translated,
-			   struct bio_vec iov[],
-			   int iov_size, u32 perm)
+			   struct iotlb_vec *ivec, u32 perm)
 {
 	struct vhost_iotlb_map *map;
 	struct vhost_iotlb *iotlb = vrh->iotlb;
@@ -1107,9 +1115,9 @@ static int iotlb_translate(const struct vringh *vrh,
 	spin_lock(vrh->iotlb_lock);
 
 	while (len > s) {
-		u64 size, pa, pfn;
+		u64 size;
 
-		if (unlikely(ret >= iov_size)) {
+		if (unlikely(ret >= ivec->count)) {
 			ret = -ENOBUFS;
 			break;
 		}
@@ -1124,10 +1132,22 @@ static int iotlb_translate(const struct vringh *vrh,
 		}
 
 		size = map->size - addr + map->start;
-		pa = map->addr + addr - map->start;
-		pfn = pa >> PAGE_SHIFT;
-		bvec_set_page(&iov[ret], pfn_to_page(pfn), min(len - s, size),
-			      pa & (PAGE_SIZE - 1));
+		if (ivec->is_iovec) {
+			struct iovec *iovec = ivec->iov.iovec;
+
+			iovec[ret].iov_len = min(len - s, size);
+			iovec[ret].iov_base = (void __user *)(unsigned long)
+					      (map->addr + addr - map->start);
+		} else {
+			u64 pa = map->addr + addr - map->start;
+			u64 pfn = pa >> PAGE_SHIFT;
+			struct bio_vec *bvec = ivec->iov.bvec;
+
+			bvec_set_page(&bvec[ret], pfn_to_page(pfn),
+				      min(len - s, size),
+				      pa & (PAGE_SIZE - 1));
+		}
+
 		s += size;
 		addr += size;
 		++ret;
@@ -1141,26 +1161,42 @@ static int iotlb_translate(const struct vringh *vrh,
 	return ret;
 }
 
+#define IOTLB_IOV_SIZE 16
+
 static inline int copy_from_iotlb(const struct vringh *vrh, void *dst,
 				  void *src, size_t len)
 {
+	struct iotlb_vec ivec;
+	union {
+		struct iovec iovec[IOTLB_IOV_SIZE];
+		struct bio_vec bvec[IOTLB_IOV_SIZE];
+	} iov;
 	u64 total_translated = 0;
 
+	ivec.iov.iovec = iov.iovec;
+	ivec.count = IOTLB_IOV_SIZE;
+	ivec.is_iovec = vrh->use_va;
+
 	while (total_translated < len) {
-		struct bio_vec iov[16];
 		struct iov_iter iter;
 		u64 translated;
 		int ret;
 
 		ret = iotlb_translate(vrh, (u64)(uintptr_t)src,
 				      len - total_translated, &translated,
-				      iov, ARRAY_SIZE(iov), VHOST_MAP_RO);
+				      &ivec, VHOST_MAP_RO);
 		if (ret == -ENOBUFS)
-			ret = ARRAY_SIZE(iov);
+			ret = IOTLB_IOV_SIZE;
 		else if (ret < 0)
 			return ret;
 
-		iov_iter_bvec(&iter, ITER_SOURCE, iov, ret, translated);
+		if (ivec.is_iovec) {
+			iov_iter_init(&iter, ITER_SOURCE, ivec.iov.iovec, ret,
+				      translated);
+		} else {
+			iov_iter_bvec(&iter, ITER_SOURCE, ivec.iov.bvec, ret,
+				      translated);
+		}
 
 		ret = copy_from_iter(dst, translated, &iter);
 		if (ret < 0)
@@ -1177,23 +1213,37 @@ static inline int copy_from_iotlb(const struct vringh *vrh, void *dst,
 static inline int copy_to_iotlb(const struct vringh *vrh, void *dst,
 				void *src, size_t len)
 {
+	struct iotlb_vec ivec;
+	union {
+		struct iovec iovec[IOTLB_IOV_SIZE];
+		struct bio_vec bvec[IOTLB_IOV_SIZE];
+	} iov;
 	u64 total_translated = 0;
 
+	ivec.iov.iovec = iov.iovec;
+	ivec.count = IOTLB_IOV_SIZE;
+	ivec.is_iovec = vrh->use_va;
+
 	while (total_translated < len) {
-		struct bio_vec iov[16];
 		struct iov_iter iter;
 		u64 translated;
 		int ret;
 
 		ret = iotlb_translate(vrh, (u64)(uintptr_t)dst,
 				      len - total_translated, &translated,
-				      iov, ARRAY_SIZE(iov), VHOST_MAP_WO);
+				      &ivec, VHOST_MAP_WO);
 		if (ret == -ENOBUFS)
-			ret = ARRAY_SIZE(iov);
+			ret = IOTLB_IOV_SIZE;
 		else if (ret < 0)
 			return ret;
 
-		iov_iter_bvec(&iter, ITER_DEST, iov, ret, translated);
+		if (ivec.is_iovec) {
+			iov_iter_init(&iter, ITER_DEST, ivec.iov.iovec, ret,
+				      translated);
+		} else {
+			iov_iter_bvec(&iter, ITER_DEST, ivec.iov.bvec, ret,
+				      translated);
+		}
 
 		ret = copy_to_iter(src, translated, &iter);
 		if (ret < 0)
@@ -1210,20 +1260,37 @@ static inline int copy_to_iotlb(const struct vringh *vrh, void *dst,
 static inline int getu16_iotlb(const struct vringh *vrh,
 			       u16 *val, const __virtio16 *p)
 {
-	struct bio_vec iov;
-	void *kaddr, *from;
+	struct iotlb_vec ivec;
+	union {
+		struct iovec iovec[1];
+		struct bio_vec bvec[1];
+	} iov;
+	__virtio16 tmp;
 	int ret;
 
+	ivec.iov.iovec = iov.iovec;
+	ivec.count = 1;
+	ivec.is_iovec = vrh->use_va;
+
 	/* Atomic read is needed for getu16 */
-	ret = iotlb_translate(vrh, (u64)(uintptr_t)p, sizeof(*p), NULL,
-			      &iov, 1, VHOST_MAP_RO);
+	ret = iotlb_translate(vrh, (u64)(uintptr_t)p, sizeof(*p),
+			      NULL, &ivec, VHOST_MAP_RO);
 	if (ret < 0)
 		return ret;
 
-	kaddr = kmap_local_page(iov.bv_page);
-	from = kaddr + iov.bv_offset;
-	*val = vringh16_to_cpu(vrh, READ_ONCE(*(__virtio16 *)from));
-	kunmap_local(kaddr);
+	if (ivec.is_iovec) {
+		ret = __get_user(tmp, (__virtio16 __user *)ivec.iov.iovec[0].iov_base);
+		if (ret)
+			return ret;
+	} else {
+		void *kaddr = kmap_local_page(ivec.iov.bvec[0].bv_page);
+		void *from = kaddr + ivec.iov.bvec[0].bv_offset;
+
+		tmp = READ_ONCE(*(__virtio16 *)from);
+		kunmap_local(kaddr);
+	}
+
+	*val = vringh16_to_cpu(vrh, tmp);
 
 	return 0;
 }
@@ -1231,20 +1298,37 @@ static inline int getu16_iotlb(const struct vringh *vrh,
 static inline int putu16_iotlb(const struct vringh *vrh,
 			       __virtio16 *p, u16 val)
 {
-	struct bio_vec iov;
-	void *kaddr, *to;
+	struct iotlb_vec ivec;
+	union {
+		struct iovec iovec;
+		struct bio_vec bvec;
+	} iov;
+	__virtio16 tmp;
 	int ret;
 
+	ivec.iov.iovec = &iov.iovec;
+	ivec.count = 1;
+	ivec.is_iovec = vrh->use_va;
+
 	/* Atomic write is needed for putu16 */
-	ret = iotlb_translate(vrh, (u64)(uintptr_t)p, sizeof(*p), NULL,
-			      &iov, 1, VHOST_MAP_WO);
+	ret = iotlb_translate(vrh, (u64)(uintptr_t)p, sizeof(*p),
+			      NULL, &ivec, VHOST_MAP_RO);
 	if (ret < 0)
 		return ret;
 
-	kaddr = kmap_local_page(iov.bv_page);
-	to = kaddr + iov.bv_offset;
-	WRITE_ONCE(*(__virtio16 *)to, cpu_to_vringh16(vrh, val));
-	kunmap_local(kaddr);
+	tmp = cpu_to_vringh16(vrh, val);
+
+	if (ivec.is_iovec) {
+		ret = __put_user(tmp, (__virtio16 __user *)ivec.iov.iovec[0].iov_base);
+		if (ret)
+			return ret;
+	} else {
+		void *kaddr = kmap_local_page(ivec.iov.bvec[0].bv_page);
+		void *to = kaddr + ivec.iov.bvec[0].bv_offset;
+
+		WRITE_ONCE(*(__virtio16 *)to, tmp);
+		kunmap_local(kaddr);
+	}
 
 	return 0;
 }
@@ -1306,6 +1390,7 @@ static inline int putused_iotlb(const struct vringh *vrh,
  * @features: the feature bits for this ring.
  * @num: the number of elements.
  * @weak_barriers: true if we only need memory barriers, not I/O.
+ * @use_va: true if IOTLB contains user VA
  * @desc: the userpace descriptor pointer.
  * @avail: the userpace avail pointer.
  * @used: the userpace used pointer.
@@ -1313,11 +1398,13 @@ static inline int putused_iotlb(const struct vringh *vrh,
  * Returns an error if num is invalid.
  */
 int vringh_init_iotlb(struct vringh *vrh, u64 features,
-		      unsigned int num, bool weak_barriers,
+		      unsigned int num, bool weak_barriers, bool use_va,
 		      struct vring_desc *desc,
 		      struct vring_avail *avail,
 		      struct vring_used *used)
 {
+	vrh->use_va = use_va;
+
 	return vringh_init_kern(vrh, features, num, weak_barriers,
 				desc, avail, used);
 }
-- 
2.39.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
