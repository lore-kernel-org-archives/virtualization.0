Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96FA7C6FA8E
	for <virtualization@archiver.kernel.org>; Thu,  2 Mar 2023 11:35:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 38BCD419DC;
	Thu,  2 Mar 2023 11:35:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 38BCD419DC
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QFfbW7h5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gxlyo98XFnFh; Thu,  2 Mar 2023 11:35:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B56A4409BE;
	Thu,  2 Mar 2023 11:35:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B56A4409BE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8F735C0035;
	Thu,  2 Mar 2023 11:35:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CCD5AC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:35:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A70C5410DF
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:35:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A70C5410DF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CK64ucQrxPZR
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:35:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 23AC6409BE
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 23AC6409BE
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677756909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wr7wXnFCQpY1zpniPAgMpMPx/fjhLmfIKoC/NtXm0MU=;
 b=QFfbW7h5qvxScKtRTT9XzsLkxgi0/YvYM2DbBGvqmLX/dA3w3J9nONPUvd43FnVKdvd68t
 +ad/fo85CdP++OuTetJSyAxUjL1Li+0ouZSvIZ6VHWoLcTBtSfXA39MPlcl758/cJAk+DY
 uYgi9MveZXgCFb873jMtXI2RWTZNO+Q=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-496-O_jiDA3GOeSf9alYllhI8A-1; Thu, 02 Mar 2023 06:35:07 -0500
X-MC-Unique: O_jiDA3GOeSf9alYllhI8A-1
Received: by mail-qk1-f200.google.com with SMTP id
 u28-20020a05620a085c00b0073b88cae2f5so9814132qku.8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Mar 2023 03:35:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1677756905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wr7wXnFCQpY1zpniPAgMpMPx/fjhLmfIKoC/NtXm0MU=;
 b=JI6dqTadMSL/5WjRuP1IqthgRNy1SQb3zApsNAyfx/cGBCk8Ttd5OLRF8K6xVcE8Lp
 TUDP+1CJevkOidrQmyPI5BcL/Y87s5ZdIKLNPDy4v+ykq0kVyeNlVszHAA8QYCEuxYH6
 FIB2r24FmfjHcgMhkT4qDvUuCSdomH9yoyFyX5fNg1cLqSPYb931j7PpvLCoygl9KvJX
 BYkY2UagMGY3WMlMHqENX8fvLEfqJlAlRMxXpiIwmPxm+D7QZYpdZ1D5D6X9xOL2sHWZ
 uyV5rRkXW+WF9c6KJpNEobkuIDSPHYyGUfmq0IM3MRXlci/BXDZdz4QAYheriQRLxe2Q
 KDoA==
X-Gm-Message-State: AO0yUKUSSiwrkVw7nmHJ+Hl/2YbMHGab+cTW1CZzm6cioNEEgLOEcvfR
 SmOKdjg5dfrV4fDIqEp8vLg0by59QOCGgPgoqkmHwa/8/p9gQYFUKMItl4EsXnyuKcJGSXyQeZb
 NdpNHiQkSqr1kCz0NAtb15NHGMIomz+S/M48vHoG/G9ycbs3cs4MAMBfuaGYDXRe20VrIg2lKIl
 JwKVHTQnRPujKiSMf08Te9bIg=
X-Received: by 2002:a05:6214:20c1:b0:56e:a556:f28f with SMTP id
 1-20020a05621420c100b0056ea556f28fmr18887356qve.34.1677756905435; 
 Thu, 02 Mar 2023 03:35:05 -0800 (PST)
X-Google-Smtp-Source: AK7set86Y3xWX8FFzNBNJULTR0DAk3t0Mhnai0hp6+YthKrk45BUDZ8jdC/DKPHKvqNQR5FHp9fcgw==
X-Received: by 2002:a05:6214:20c1:b0:56e:a556:f28f with SMTP id
 1-20020a05621420c100b0056ea556f28fmr18887295qve.34.1677756904884; 
 Thu, 02 Mar 2023 03:35:04 -0800 (PST)
Received: from step1.redhat.com (c-115-213.cust-q.wadsl.it. [212.43.115.213])
 by smtp.gmail.com with ESMTPSA id
 p12-20020a37420c000000b007426ec97253sm8383058qka.111.2023.03.02.03.35.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Mar 2023 03:35:04 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v2 4/8] vringh: support VA with iotlb
Date: Thu,  2 Mar 2023 12:34:17 +0100
Message-Id: <20230302113421.174582-5-sgarzare@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230302113421.174582-1-sgarzare@redhat.com>
References: <20230302113421.174582-1-sgarzare@redhat.com>
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
    v2:
    - replace kmap_atomic() with kmap_local_page() [see previous patch]
    - fix cast warnings when build with W=1 C=1

 include/linux/vringh.h            |   5 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c |   2 +-
 drivers/vdpa/vdpa_sim/vdpa_sim.c  |   4 +-
 drivers/vhost/vringh.c            | 247 ++++++++++++++++++++++++------
 4 files changed, 205 insertions(+), 53 deletions(-)

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
index 3a0e721aef05..babc8dd171a6 100644
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
index 6a0a65814626..481eb156658b 100644
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
@@ -81,7 +81,7 @@ static void vdpasim_vq_reset(struct vdpasim *vdpasim,
 	vq->cb = NULL;
 	vq->private = NULL;
 	vringh_init_iotlb(&vq->vring, vdpasim->dev_attr.supported_features,
-			  VDPASIM_QUEUE_MAX, false, NULL, NULL, NULL);
+			  VDPASIM_QUEUE_MAX, false, false, NULL, NULL, NULL);
 
 	vq->vring.notify = NULL;
 }
diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index 0ba3ef809e48..61c79cea44ca 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -1094,15 +1094,99 @@ EXPORT_SYMBOL(vringh_need_notify_kern);
 
 #if IS_REACHABLE(CONFIG_VHOST_IOTLB)
 
-static int iotlb_translate(const struct vringh *vrh,
-			   u64 addr, u64 len, u64 *translated,
-			   struct bio_vec iov[],
-			   int iov_size, u32 perm)
+static int iotlb_translate_va(const struct vringh *vrh,
+			      u64 addr, u64 len, u64 *translated,
+			      struct iovec iov[],
+			      int iov_size, u32 perm)
 {
 	struct vhost_iotlb_map *map;
 	struct vhost_iotlb *iotlb = vrh->iotlb;
+	u64 s = 0, last = addr + len - 1;
 	int ret = 0;
+
+	spin_lock(vrh->iotlb_lock);
+
+	while (len > s) {
+		u64 size;
+
+		if (unlikely(ret >= iov_size)) {
+			ret = -ENOBUFS;
+			break;
+		}
+
+		map = vhost_iotlb_itree_first(iotlb, addr, last);
+		if (!map || map->start > addr) {
+			ret = -EINVAL;
+			break;
+		} else if (!(map->perm & perm)) {
+			ret = -EPERM;
+			break;
+		}
+
+		size = map->size - addr + map->start;
+		iov[ret].iov_len = min(len - s, size);
+		iov[ret].iov_base = (void __user *)(unsigned long)
+				    (map->addr + addr - map->start);
+		s += size;
+		addr += size;
+		++ret;
+	}
+
+	spin_unlock(vrh->iotlb_lock);
+
+	if (translated)
+		*translated = min(len, s);
+
+	return ret;
+}
+
+static inline int copy_from_va(const struct vringh *vrh, void *dst, void *src,
+			       u64 len, u64 *translated)
+{
+	struct iovec iov[16];
+	struct iov_iter iter;
+	int ret;
+
+	ret = iotlb_translate_va(vrh, (u64)(uintptr_t)src, len, translated, iov,
+				 ARRAY_SIZE(iov), VHOST_MAP_RO);
+	if (ret == -ENOBUFS)
+		ret = ARRAY_SIZE(iov);
+	else if (ret < 0)
+		return ret;
+
+	iov_iter_init(&iter, ITER_SOURCE, iov, ret, *translated);
+
+	return copy_from_iter(dst, *translated, &iter);
+}
+
+static inline int copy_to_va(const struct vringh *vrh, void *dst, void *src,
+			     u64 len, u64 *translated)
+{
+	struct iovec iov[16];
+	struct iov_iter iter;
+	int ret;
+
+	ret = iotlb_translate_va(vrh, (u64)(uintptr_t)dst, len, translated, iov,
+				 ARRAY_SIZE(iov), VHOST_MAP_WO);
+	if (ret == -ENOBUFS)
+		ret = ARRAY_SIZE(iov);
+	else if (ret < 0)
+		return ret;
+
+	iov_iter_init(&iter, ITER_DEST, iov, ret, *translated);
+
+	return copy_to_iter(src, *translated, &iter);
+}
+
+static int iotlb_translate_pa(const struct vringh *vrh,
+			      u64 addr, u64 len, u64 *translated,
+			      struct bio_vec iov[],
+			      int iov_size, u32 perm)
+{
+	struct vhost_iotlb_map *map;
+	struct vhost_iotlb *iotlb = vrh->iotlb;
 	u64 s = 0, last = addr + len - 1;
+	int ret = 0;
 
 	spin_lock(vrh->iotlb_lock);
 
@@ -1141,28 +1225,61 @@ static int iotlb_translate(const struct vringh *vrh,
 	return ret;
 }
 
+static inline int copy_from_pa(const struct vringh *vrh, void *dst, void *src,
+			       u64 len, u64 *translated)
+{
+	struct bio_vec iov[16];
+	struct iov_iter iter;
+	int ret;
+
+	ret = iotlb_translate_pa(vrh, (u64)(uintptr_t)src, len, translated, iov,
+				 ARRAY_SIZE(iov), VHOST_MAP_RO);
+	if (ret == -ENOBUFS)
+		ret = ARRAY_SIZE(iov);
+	else if (ret < 0)
+		return ret;
+
+	iov_iter_bvec(&iter, ITER_SOURCE, iov, ret, *translated);
+
+	return copy_from_iter(dst, *translated, &iter);
+}
+
+static inline int copy_to_pa(const struct vringh *vrh, void *dst, void *src,
+			     u64 len, u64 *translated)
+{
+	struct bio_vec iov[16];
+	struct iov_iter iter;
+	int ret;
+
+	ret = iotlb_translate_pa(vrh, (u64)(uintptr_t)dst, len, translated, iov,
+				 ARRAY_SIZE(iov), VHOST_MAP_WO);
+	if (ret == -ENOBUFS)
+		ret = ARRAY_SIZE(iov);
+	else if (ret < 0)
+		return ret;
+
+	iov_iter_bvec(&iter, ITER_DEST, iov, ret, *translated);
+
+	return copy_to_iter(src, *translated, &iter);
+}
+
 static inline int copy_from_iotlb(const struct vringh *vrh, void *dst,
 				  void *src, size_t len)
 {
 	u64 total_translated = 0;
 
 	while (total_translated < len) {
-		struct bio_vec iov[16];
-		struct iov_iter iter;
 		u64 translated;
 		int ret;
 
-		ret = iotlb_translate(vrh, (u64)(uintptr_t)src,
-				      len - total_translated, &translated,
-				      iov, ARRAY_SIZE(iov), VHOST_MAP_RO);
-		if (ret == -ENOBUFS)
-			ret = ARRAY_SIZE(iov);
-		else if (ret < 0)
-			return ret;
-
-		iov_iter_bvec(&iter, ITER_SOURCE, iov, ret, translated);
+		if (vrh->use_va) {
+			ret = copy_from_va(vrh, dst, src,
+					   len - total_translated, &translated);
+		} else {
+			ret = copy_from_pa(vrh, dst, src,
+					   len - total_translated, &translated);
+		}
 
-		ret = copy_from_iter(dst, translated, &iter);
 		if (ret < 0)
 			return ret;
 
@@ -1180,22 +1297,17 @@ static inline int copy_to_iotlb(const struct vringh *vrh, void *dst,
 	u64 total_translated = 0;
 
 	while (total_translated < len) {
-		struct bio_vec iov[16];
-		struct iov_iter iter;
 		u64 translated;
 		int ret;
 
-		ret = iotlb_translate(vrh, (u64)(uintptr_t)dst,
-				      len - total_translated, &translated,
-				      iov, ARRAY_SIZE(iov), VHOST_MAP_WO);
-		if (ret == -ENOBUFS)
-			ret = ARRAY_SIZE(iov);
-		else if (ret < 0)
-			return ret;
-
-		iov_iter_bvec(&iter, ITER_DEST, iov, ret, translated);
+		if (vrh->use_va) {
+			ret = copy_to_va(vrh, dst, src,
+					 len - total_translated, &translated);
+		} else {
+			ret = copy_to_pa(vrh, dst, src,
+					 len - total_translated, &translated);
+		}
 
-		ret = copy_to_iter(src, translated, &iter);
 		if (ret < 0)
 			return ret;
 
@@ -1210,20 +1322,37 @@ static inline int copy_to_iotlb(const struct vringh *vrh, void *dst,
 static inline int getu16_iotlb(const struct vringh *vrh,
 			       u16 *val, const __virtio16 *p)
 {
-	struct bio_vec iov;
-	void *kaddr, *from;
 	int ret;
 
 	/* Atomic read is needed for getu16 */
-	ret = iotlb_translate(vrh, (u64)(uintptr_t)p, sizeof(*p), NULL,
-			      &iov, 1, VHOST_MAP_RO);
-	if (ret < 0)
-		return ret;
+	if (vrh->use_va) {
+		struct iovec iov;
+		__virtio16 tmp;
+
+		ret = iotlb_translate_va(vrh, (u64)(uintptr_t)p, sizeof(*p),
+					 NULL, &iov, 1, VHOST_MAP_RO);
+		if (ret < 0)
+			return ret;
 
-	kaddr = kmap_local_page(iov.bv_page);
-	from = kaddr + iov.bv_offset;
-	*val = vringh16_to_cpu(vrh, READ_ONCE(*(__virtio16 *)from));
-	kunmap_local(kaddr);
+		ret = __get_user(tmp, (__virtio16 __user *)iov.iov_base);
+		if (ret)
+			return ret;
+
+		*val = vringh16_to_cpu(vrh, tmp);
+	} else {
+		struct bio_vec iov;
+		void *kaddr, *from;
+
+		ret = iotlb_translate_pa(vrh, (u64)(uintptr_t)p, sizeof(*p),
+					 NULL, &iov, 1, VHOST_MAP_RO);
+		if (ret < 0)
+			return ret;
+
+		kaddr = kmap_local_page(iov.bv_page);
+		from = kaddr + iov.bv_offset;
+		*val = vringh16_to_cpu(vrh, READ_ONCE(*(__virtio16 *)from));
+		kunmap_local(kaddr);
+	}
 
 	return 0;
 }
@@ -1231,20 +1360,37 @@ static inline int getu16_iotlb(const struct vringh *vrh,
 static inline int putu16_iotlb(const struct vringh *vrh,
 			       __virtio16 *p, u16 val)
 {
-	struct bio_vec iov;
-	void *kaddr, *to;
 	int ret;
 
 	/* Atomic write is needed for putu16 */
-	ret = iotlb_translate(vrh, (u64)(uintptr_t)p, sizeof(*p), NULL,
-			      &iov, 1, VHOST_MAP_WO);
-	if (ret < 0)
-		return ret;
+	if (vrh->use_va) {
+		struct iovec iov;
+		__virtio16 tmp;
 
-	kaddr = kmap_local_page(iov.bv_page);
-	to = kaddr + iov.bv_offset;
-	WRITE_ONCE(*(__virtio16 *)to, cpu_to_vringh16(vrh, val));
-	kunmap_local(kaddr);
+		ret = iotlb_translate_va(vrh, (u64)(uintptr_t)p, sizeof(*p),
+					 NULL, &iov, 1, VHOST_MAP_RO);
+		if (ret < 0)
+			return ret;
+
+		tmp = cpu_to_vringh16(vrh, val);
+
+		ret = __put_user(tmp, (__virtio16 __user *)iov.iov_base);
+		if (ret)
+			return ret;
+	} else {
+		struct bio_vec iov;
+		void *kaddr, *to;
+
+		ret = iotlb_translate_pa(vrh, (u64)(uintptr_t)p, sizeof(*p), NULL,
+					 &iov, 1, VHOST_MAP_WO);
+		if (ret < 0)
+			return ret;
+
+		kaddr = kmap_local_page(iov.bv_page);
+		to = kaddr + iov.bv_offset;
+		WRITE_ONCE(*(__virtio16 *)to, cpu_to_vringh16(vrh, val));
+		kunmap_local(kaddr);
+	}
 
 	return 0;
 }
@@ -1306,6 +1452,7 @@ static inline int putused_iotlb(const struct vringh *vrh,
  * @features: the feature bits for this ring.
  * @num: the number of elements.
  * @weak_barriers: true if we only need memory barriers, not I/O.
+ * @use_va: true if IOTLB contains user VA
  * @desc: the userpace descriptor pointer.
  * @avail: the userpace avail pointer.
  * @used: the userpace used pointer.
@@ -1313,11 +1460,13 @@ static inline int putused_iotlb(const struct vringh *vrh,
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
