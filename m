Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C29BC6FD20
	for <virtualization@archiver.kernel.org>; Fri, 24 Mar 2023 15:39:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C39BB615EC;
	Fri, 24 Mar 2023 15:39:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C39BB615EC
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Rb1ccTi2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9R2sQURPJotl; Fri, 24 Mar 2023 15:39:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DA56960F21;
	Fri, 24 Mar 2023 15:39:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DA56960F21
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BCD62C0035;
	Fri, 24 Mar 2023 15:39:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83567C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 15:39:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5168A81E5C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 15:39:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5168A81E5C
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Rb1ccTi2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g9V0mYILCcW5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 15:39:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 48E0981DEB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 48E0981DEB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 15:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679672373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+04OpsvyUrUsuT6XcLeeN9Ze/5Klc/NacWCLWIQp650=;
 b=Rb1ccTi2fUs4aGe5PfkWStAN/pWvulUJ1JzA0MKzjJVq2i9tAIrs3p4txreEJGH2XURCye
 /SNYVuKATPifUtf6bgX9YyrSh0G5DgGB2nqbO7E3SJRnmGt5tZessw2wCoMs3NydvrPtho
 z1qngu3R6anpI4tCF5s9EMsRgFrpoSg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-tR94FRLEOpKRYYY0_4hIRw-1; Fri, 24 Mar 2023 11:39:31 -0400
X-MC-Unique: tR94FRLEOpKRYYY0_4hIRw-1
Received: by mail-ed1-f70.google.com with SMTP id
 r19-20020a50aad3000000b005002e950cd3so3799751edc.11
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 08:39:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679672370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+04OpsvyUrUsuT6XcLeeN9Ze/5Klc/NacWCLWIQp650=;
 b=MhWw682O13GHq/PMQhUa5Fz8pTeIuKbTYnGcw0w7BNOrK9bccLpeFZKsEACj45adWi
 LSmR5CeoFe2d9LLhGrZJj4KbuqIA7azN9PQtviXr1H9NbLY+yRpj9e1myfyiKuctuZin
 /m+XciUPf9lNSCTAlUG0GnarS84spdB2oYmJ3Zn9RX258IG75sE2i2FCLettcRU/EYM7
 dImFdf0mtGeKJkrv5TjLsgwMF5GALonEYLQVfpOQqmJsuiinkolpTeRq8V9UjjsNt7A9
 KZ/EqyUkPn2TrboJykDarggjQz4+nIbRC0UcAZTtNgempZl6igOEy/btwIFy2/q0ZvZ4
 qXBw==
X-Gm-Message-State: AAQBX9e6LJ9pRsiEhemGXBzCHi+vj9/Tial7oHmJQBkkVdFoIwxvLszu
 nRjtiHIGlAyJR0h73ZmJb+/UAhg1p0yA80l9PaumnlIb4ZTO2iX5+3Dnby6igQvJkG2zFDuxvNz
 +6JUIzYuTWfaVu5+2DWmESXfdqDH1BRdDgMddprMGdXDRiL5JxJafNTC3W58P+FROr1nflwHJm+
 Ecwo7Ptczas6zvqG5Fgl399izyFQ==
X-Received: by 2002:a05:6402:3445:b0:4fd:2b05:1722 with SMTP id
 l5-20020a056402344500b004fd2b051722mr3182565edc.7.1679672369945; 
 Fri, 24 Mar 2023 08:39:29 -0700 (PDT)
X-Google-Smtp-Source: AKy350bq4L61I8EczA4/4nm0Gn5Q60S6s6HDFgOqRKq3vWBdC5wTa3I/hX31ckQT0ABvHJvSMmcVxQ==
X-Received: by 2002:a05:6402:3445:b0:4fd:2b05:1722 with SMTP id
 l5-20020a056402344500b004fd2b051722mr3182539edc.7.1679672369577; 
 Fri, 24 Mar 2023 08:39:29 -0700 (PDT)
Received: from localhost.localdomain
 (host-82-53-134-98.retail.telecomitalia.it. [82.53.134.98])
 by smtp.gmail.com with ESMTPSA id
 u5-20020a50d505000000b004c09f0ba24dsm10904587edi.48.2023.03.24.08.39.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Mar 2023 08:39:28 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v4 5/9] vringh: support VA with iotlb
Date: Fri, 24 Mar 2023 16:39:19 +0100
Message-Id: <20230324153919.47633-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230324153607.46836-1-sgarzare@redhat.com>
References: <20230324153607.46836-1-sgarzare@redhat.com>
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
    v4:
    - used uintptr_t for `io_addr` [Eugenio]
    - added `io_addr` and `io_len` variables in iotlb_translate
    - avoided overflow doing `map->addr - map->start + addr` [Jason]
    - removed `is_iovec` field from struct iotlb_vec [Jason]
    - added vringh_init_iotlb_va() [Jason]
    v3:
    - refactored avoiding code duplication [Eugenio]
    v2:
    - replace kmap_atomic() with kmap_local_page() [see previous patch]
    - fix cast warnings when build with W=1 C=1

 include/linux/vringh.h |   9 +++
 drivers/vhost/vringh.c | 171 +++++++++++++++++++++++++++++++++--------
 2 files changed, 148 insertions(+), 32 deletions(-)

diff --git a/include/linux/vringh.h b/include/linux/vringh.h
index 1991a02c6431..b4edfadf5479 100644
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
 
@@ -284,6 +287,12 @@ int vringh_init_iotlb(struct vringh *vrh, u64 features,
 		      struct vring_avail *avail,
 		      struct vring_used *used);
 
+int vringh_init_iotlb_va(struct vringh *vrh, u64 features,
+			 unsigned int num, bool weak_barriers,
+			 struct vring_desc *desc,
+			 struct vring_avail *avail,
+			 struct vring_used *used);
+
 int vringh_getdesc_iotlb(struct vringh *vrh,
 			 struct vringh_kiov *riov,
 			 struct vringh_kiov *wiov,
diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index 4aee230f7622..771c2aba8aac 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -1094,10 +1094,17 @@ EXPORT_SYMBOL(vringh_need_notify_kern);
 
 #if IS_REACHABLE(CONFIG_VHOST_IOTLB)
 
+struct iotlb_vec {
+	union {
+		struct iovec *iovec;
+		struct bio_vec *bvec;
+	} iov;
+	size_t count;
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
@@ -1107,9 +1114,11 @@ static int iotlb_translate(const struct vringh *vrh,
 	spin_lock(vrh->iotlb_lock);
 
 	while (len > s) {
-		u64 size, pa, pfn;
+		uintptr_t io_addr;
+		size_t io_len;
+		u64 size;
 
-		if (unlikely(ret >= iov_size)) {
+		if (unlikely(ret >= ivec->count)) {
 			ret = -ENOBUFS;
 			break;
 		}
@@ -1124,10 +1133,22 @@ static int iotlb_translate(const struct vringh *vrh,
 		}
 
 		size = map->size - addr + map->start;
-		pa = map->addr + addr - map->start;
-		pfn = pa >> PAGE_SHIFT;
-		bvec_set_page(&iov[ret], pfn_to_page(pfn), min(len - s, size),
-			      pa & (PAGE_SIZE - 1));
+		io_len = min(len - s, size);
+		io_addr = map->addr - map->start + addr;
+
+		if (vrh->use_va) {
+			struct iovec *iovec = ivec->iov.iovec;
+
+			iovec[ret].iov_len = io_len;
+			iovec[ret].iov_base = (void __user *)io_addr;
+		} else {
+			u64 pfn = io_addr >> PAGE_SHIFT;
+			struct bio_vec *bvec = ivec->iov.bvec;
+
+			bvec_set_page(&bvec[ret], pfn_to_page(pfn), io_len,
+				      io_addr & (PAGE_SIZE - 1));
+		}
+
 		s += size;
 		addr += size;
 		++ret;
@@ -1146,23 +1167,36 @@ static int iotlb_translate(const struct vringh *vrh,
 static inline int copy_from_iotlb(const struct vringh *vrh, void *dst,
 				  void *src, size_t len)
 {
+	struct iotlb_vec ivec;
+	union {
+		struct iovec iovec[IOTLB_IOV_STRIDE];
+		struct bio_vec bvec[IOTLB_IOV_STRIDE];
+	} iov;
 	u64 total_translated = 0;
 
+	ivec.iov.iovec = iov.iovec;
+	ivec.count = IOTLB_IOV_STRIDE;
+
 	while (total_translated < len) {
-		struct bio_vec iov[IOTLB_IOV_STRIDE];
 		struct iov_iter iter;
 		u64 translated;
 		int ret;
 
 		ret = iotlb_translate(vrh, (u64)(uintptr_t)src,
 				      len - total_translated, &translated,
-				      iov, ARRAY_SIZE(iov), VHOST_MAP_RO);
+				      &ivec, VHOST_MAP_RO);
 		if (ret == -ENOBUFS)
-			ret = ARRAY_SIZE(iov);
+			ret = IOTLB_IOV_STRIDE;
 		else if (ret < 0)
 			return ret;
 
-		iov_iter_bvec(&iter, ITER_SOURCE, iov, ret, translated);
+		if (vrh->use_va) {
+			iov_iter_init(&iter, ITER_SOURCE, ivec.iov.iovec, ret,
+				      translated);
+		} else {
+			iov_iter_bvec(&iter, ITER_SOURCE, ivec.iov.bvec, ret,
+				      translated);
+		}
 
 		ret = copy_from_iter(dst, translated, &iter);
 		if (ret < 0)
@@ -1179,23 +1213,36 @@ static inline int copy_from_iotlb(const struct vringh *vrh, void *dst,
 static inline int copy_to_iotlb(const struct vringh *vrh, void *dst,
 				void *src, size_t len)
 {
+	struct iotlb_vec ivec;
+	union {
+		struct iovec iovec[IOTLB_IOV_STRIDE];
+		struct bio_vec bvec[IOTLB_IOV_STRIDE];
+	} iov;
 	u64 total_translated = 0;
 
+	ivec.iov.iovec = iov.iovec;
+	ivec.count = IOTLB_IOV_STRIDE;
+
 	while (total_translated < len) {
-		struct bio_vec iov[IOTLB_IOV_STRIDE];
 		struct iov_iter iter;
 		u64 translated;
 		int ret;
 
 		ret = iotlb_translate(vrh, (u64)(uintptr_t)dst,
 				      len - total_translated, &translated,
-				      iov, ARRAY_SIZE(iov), VHOST_MAP_WO);
+				      &ivec, VHOST_MAP_WO);
 		if (ret == -ENOBUFS)
-			ret = ARRAY_SIZE(iov);
+			ret = IOTLB_IOV_STRIDE;
 		else if (ret < 0)
 			return ret;
 
-		iov_iter_bvec(&iter, ITER_DEST, iov, ret, translated);
+		if (vrh->use_va) {
+			iov_iter_init(&iter, ITER_DEST, ivec.iov.iovec, ret,
+				      translated);
+		} else {
+			iov_iter_bvec(&iter, ITER_DEST, ivec.iov.bvec, ret,
+				      translated);
+		}
 
 		ret = copy_to_iter(src, translated, &iter);
 		if (ret < 0)
@@ -1212,20 +1259,36 @@ static inline int copy_to_iotlb(const struct vringh *vrh, void *dst,
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
+	if (vrh->use_va) {
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
@@ -1233,20 +1296,36 @@ static inline int getu16_iotlb(const struct vringh *vrh,
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
+	if (vrh->use_va) {
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
@@ -1320,11 +1399,39 @@ int vringh_init_iotlb(struct vringh *vrh, u64 features,
 		      struct vring_avail *avail,
 		      struct vring_used *used)
 {
+	vrh->use_va = false;
+
 	return vringh_init_kern(vrh, features, num, weak_barriers,
 				desc, avail, used);
 }
 EXPORT_SYMBOL(vringh_init_iotlb);
 
+/**
+ * vringh_init_iotlb_va - initialize a vringh for a ring with IOTLB containing
+ *                        user VA.
+ * @vrh: the vringh to initialize.
+ * @features: the feature bits for this ring.
+ * @num: the number of elements.
+ * @weak_barriers: true if we only need memory barriers, not I/O.
+ * @desc: the userpace descriptor pointer.
+ * @avail: the userpace avail pointer.
+ * @used: the userpace used pointer.
+ *
+ * Returns an error if num is invalid.
+ */
+int vringh_init_iotlb_va(struct vringh *vrh, u64 features,
+			 unsigned int num, bool weak_barriers,
+			 struct vring_desc *desc,
+			 struct vring_avail *avail,
+			 struct vring_used *used)
+{
+	vrh->use_va = true;
+
+	return vringh_init_kern(vrh, features, num, weak_barriers,
+				desc, avail, used);
+}
+EXPORT_SYMBOL(vringh_init_iotlb_va);
+
 /**
  * vringh_set_iotlb - initialize a vringh for a ring with IOTLB.
  * @vrh: the vring
-- 
2.39.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
