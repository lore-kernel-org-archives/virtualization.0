Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57951325705
	for <virtualization@lists.linux.dev>; Mon,  5 Jan 2026 08:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767601404; cv=none; b=ZXtSuwy0QFzH2AqR3+/NA+9x8xjHk6PT64PbSJy4k0tVktOcR/0J7E/HlMsAj3uxnohKRkoiGSBqqp6uID+NsR7s/rVH+sOAwCkahkDlhiXlExVmaMGJ9B6y97wqqxAxHl2lL+vUOgCEMTFdTp9dGvyJslQBc6hVpBnsCyv9sPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767601404; c=relaxed/simple;
	bh=+fh5yr7B9tzMU58eX5VqhVn+kLA6dyyd9L7KjvRe8jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=MWto9f9NXjPW/Ep/kaDC5RKMUcM2h04tNwwBXeanQ6acvqdQd7cdNN5wDbZaORjXFV96hdb2fa1p/ff8KrjYkTIA14FsIrIcfpX7CAqSBrZ+eGvI4d8MWwXUfyzzMOaYPJ8qa7a82k2K15IaYqzBI8rYwUG0HOASnljFegbvgLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bolAL//B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bolAL//B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767601400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KKTzcDg3xAPTqY88u2oQetZhvyJiwFAVniuIJmxLHUY=;
	b=bolAL//BUWG/SNjmKy9prVvN8W2cNw95UETx/vc1cKxicNQZJaN1jFMmdqMkot8DdTvBv0
	j9iCGFYJKM8dySwT4tFbKuFSUdIUZ+HBpFjJPqyjh2hPvCvkq0nJaNM89lWZ0lGZORX9Yh
	gOHsJwMTOFy2TA1dwGcIjXaMpCa3RNQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-Qd_-d7tGP-2YCyLA7p5ZwA-1; Mon, 05 Jan 2026 03:23:19 -0500
X-MC-Unique: Qd_-d7tGP-2YCyLA7p5ZwA-1
X-Mimecast-MFC-AGG-ID: Qd_-d7tGP-2YCyLA7p5ZwA_1767601398
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4325b182e3cso5757085f8f.2
        for <virtualization@lists.linux.dev>; Mon, 05 Jan 2026 00:23:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767601398; x=1768206198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KKTzcDg3xAPTqY88u2oQetZhvyJiwFAVniuIJmxLHUY=;
        b=tG78dNeNimW9Csc4xd7c+elXSYwY3y3OYguVW96bKy+vsFWGgc1XdwlTot2cthle/v
         QbEvHt97e57q9gAsKoDVLaqzBjxm8I9aW4uBUznCEchOvGIgAhu1Y1k/shq9RxQAt937
         OW97KaYV+TpcezahlvDZLiVpqZyGh0CHH2A5q1M8b+kPNTs3Ad0js0wUVZPTTOXf5xn4
         uVu/+ECir2uakcphLnl9snPF+Czd2hu2lBjTuIBVN0HvpX5BSV/oI5al3VKivHhlbcnS
         6ouxC/B+D0rVGF9gQQ+3fzjdbwg5OQ2HhkEdFYPMZiA21Z6+3lwWm/XpqtICHgADmCw/
         8e5w==
X-Forwarded-Encrypted: i=1; AJvYcCUuRkwfiBR9O/ZT4VqsKenxmGdDfkkx+ga82ZL1ZRdiwFs07u+rItv5Geirv0Kduk7WK5EiY7jWGbrgmX3qAw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwgLw4YrqZ7s6qTbZD2WlW2Cq+ZPZeTVGrMsjRys96avgZY5Vi0
	QD/sSjkhLQyJFs9Ao+aHUFlMa6RqM8CILdpr3JGHmvd/fwUfXbELEnjIWCZMvRyxhsVu8BQ3oJd
	vCwMKO7f7/cY6d0EM14cLc0jYh+Um6VgLDYXxdRZ+/6amwsj49NAMysOwG0dtDCzsg1Fp
X-Gm-Gg: AY/fxX6Xqba9niA07QCBnT4ifWF4NBLm160CA2oBwBVyAb1xJUWkSzTAQ7esXZEI/Fn
	XNuUP8/xlJY6nHnCygqxTATpPmK89R5T6Uh2aQ8e/uzAEMJFyqhxn0UEkYqGJDZE0Qcfb6X+3ZX
	M+RNczR1s7UZFkQzEAg2g5kQYpXctXCFhRdpRQVoIL5sbV5ajioOaP0S5370oey/ejjPN4wX5Wi
	1FCSdupEgB4yCUEg3cWnSYLXn9Vn6c9aXhKv49T5IhQa8VW0zmzM/aPWouP1BqQQjPp3uV77+AK
	2khizBKes5gDM/tu2DdTEV5RSm+nxTNzhXsD9wj5IKK9EPC82WQHg4dyUm2ZPsdhS0k+6JlkIWO
	R5vetDSFJ/o+jA5e1RllsFf2hOyax7kl0iQ==
X-Received: by 2002:a5d:5f49:0:b0:42c:b8fd:21b4 with SMTP id ffacd0b85a97d-4324e709d72mr66277144f8f.57.1767601398098;
        Mon, 05 Jan 2026 00:23:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFd+BKePtnLnTT2Wp7pDPsb2ZtKPYbwHq2FGpVmLPCddNuF0tBL9FqE7HQpZrJRIHQ41vPQg==
X-Received: by 2002:a5d:5f49:0:b0:42c:b8fd:21b4 with SMTP id ffacd0b85a97d-4324e709d72mr66277090f8f.57.1767601397490;
        Mon, 05 Jan 2026 00:23:17 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43277b0efefsm66584454f8f.25.2026.01.05.00.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 00:23:17 -0800 (PST)
Date: Mon, 5 Jan 2026 03:23:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Petr Tesarik <ptesarik@suse.com>,
	Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, virtualization@lists.linux.dev,
	linux-scsi@vger.kernel.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v2 06/15] virtio: add virtqueue_add_inbuf_cache_clean API
Message-ID: <e50d38c974859e731e50bda7a0ee5691debf5bc4.1767601130.git.mst@redhat.com>
References: <cover.1767601130.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1767601130.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xVZWXbEO9m52CQhvxcgqcTGfFDsEfZNDfDu4aWLBeE0_1767601398
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add virtqueue_add_inbuf_cache_clean() for passing DMA_ATTR_CPU_CACHE_CLEAN
to virtqueue operations. This suppresses DMA debug cacheline overlap
warnings for buffers where proper cache management is ensured by the
caller.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_ring.c | 83 ++++++++++++++++++++++++++----------
 include/linux/virtio.h       |  5 +++
 2 files changed, 65 insertions(+), 23 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 95e320b23624..4fe0f78df5ec 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -174,7 +174,8 @@ struct virtqueue_ops {
 	int (*add)(struct vring_virtqueue *vq, struct scatterlist *sgs[],
 		   unsigned int total_sg, unsigned int out_sgs,
 		   unsigned int in_sgs,	void *data,
-		   void *ctx, bool premapped, gfp_t gfp);
+		   void *ctx, bool premapped, gfp_t gfp,
+		   unsigned long attr);
 	void *(*get)(struct vring_virtqueue *vq, unsigned int *len, void **ctx);
 	bool (*kick_prepare)(struct vring_virtqueue *vq);
 	void (*disable_cb)(struct vring_virtqueue *vq);
@@ -444,7 +445,7 @@ static int vring_mapping_error(const struct vring_virtqueue *vq,
 /* Map one sg entry. */
 static int vring_map_one_sg(const struct vring_virtqueue *vq, struct scatterlist *sg,
 			    enum dma_data_direction direction, dma_addr_t *addr,
-			    u32 *len, bool premapped)
+			    u32 *len, bool premapped, unsigned long attr)
 {
 	if (premapped) {
 		*addr = sg_dma_address(sg);
@@ -472,7 +473,7 @@ static int vring_map_one_sg(const struct vring_virtqueue *vq, struct scatterlist
 	 */
 	*addr = virtqueue_map_page_attrs(&vq->vq, sg_page(sg),
 					 sg->offset, sg->length,
-					 direction, 0);
+					 direction, attr);
 
 	if (vring_mapping_error(vq, *addr))
 		return -ENOMEM;
@@ -603,7 +604,8 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
 				      void *data,
 				      void *ctx,
 				      bool premapped,
-				      gfp_t gfp)
+				      gfp_t gfp,
+				      unsigned long attr)
 {
 	struct vring_desc_extra *extra;
 	struct scatterlist *sg;
@@ -675,7 +677,8 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
 			if (++sg_count != total_sg)
 				flags |= VRING_DESC_F_NEXT;
 
-			if (vring_map_one_sg(vq, sg, DMA_TO_DEVICE, &addr, &len, premapped))
+			if (vring_map_one_sg(vq, sg, DMA_TO_DEVICE, &addr, &len,
+					     premapped, attr))
 				goto unmap_release;
 
 			/* Note that we trust indirect descriptor
@@ -694,7 +697,8 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
 			if (++sg_count != total_sg)
 				flags |= VRING_DESC_F_NEXT;
 
-			if (vring_map_one_sg(vq, sg, DMA_FROM_DEVICE, &addr, &len, premapped))
+			if (vring_map_one_sg(vq, sg, DMA_FROM_DEVICE, &addr, &len,
+					     premapped, attr))
 				goto unmap_release;
 
 			/* Note that we trust indirect descriptor
@@ -1487,7 +1491,8 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 					 void *data,
 					 bool premapped,
 					 gfp_t gfp,
-					 u16 id)
+					 u16 id,
+					 unsigned long attr)
 {
 	struct vring_desc_extra *extra;
 	struct vring_packed_desc *desc;
@@ -1516,7 +1521,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
 			if (vring_map_one_sg(vq, sg, n < out_sgs ?
 					     DMA_TO_DEVICE : DMA_FROM_DEVICE,
-					     &addr, &len, premapped))
+					     &addr, &len, premapped, attr))
 				goto unmap_release;
 
 			desc[i].flags = cpu_to_le16(n < out_sgs ?
@@ -1615,7 +1620,8 @@ static inline int virtqueue_add_packed(struct vring_virtqueue *vq,
 				       void *data,
 				       void *ctx,
 				       bool premapped,
-				       gfp_t gfp)
+				       gfp_t gfp,
+				       unsigned long attr)
 {
 	struct vring_packed_desc *desc;
 	struct scatterlist *sg;
@@ -1642,8 +1648,8 @@ static inline int virtqueue_add_packed(struct vring_virtqueue *vq,
 		id = vq->free_head;
 		BUG_ON(id == vq->packed.vring.num);
 		err = virtqueue_add_indirect_packed(vq, sgs, total_sg, out_sgs,
-						    in_sgs, data, premapped,
-						    gfp, id);
+						    in_sgs, data, premapped, gfp,
+						    id, attr);
 		if (err != -ENOMEM) {
 			END_USE(vq);
 			return err;
@@ -1679,7 +1685,7 @@ static inline int virtqueue_add_packed(struct vring_virtqueue *vq,
 
 			if (vring_map_one_sg(vq, sg, n < out_sgs ?
 					     DMA_TO_DEVICE : DMA_FROM_DEVICE,
-					     &addr, &len, premapped))
+					     &addr, &len, premapped, attr))
 				goto unmap_release;
 
 			flags = cpu_to_le16(vq->packed.avail_used_flags |
@@ -1772,7 +1778,8 @@ static inline int virtqueue_add_packed_in_order(struct vring_virtqueue *vq,
 						void *data,
 						void *ctx,
 						bool premapped,
-						gfp_t gfp)
+						gfp_t gfp,
+						unsigned long attr)
 {
 	struct vring_packed_desc *desc;
 	struct scatterlist *sg;
@@ -1799,7 +1806,8 @@ static inline int virtqueue_add_packed_in_order(struct vring_virtqueue *vq,
 	if (virtqueue_use_indirect(vq, total_sg)) {
 		err = virtqueue_add_indirect_packed(vq, sgs, total_sg, out_sgs,
 						    in_sgs, data, premapped, gfp,
-						    vq->packed.next_avail_idx);
+						    vq->packed.next_avail_idx,
+						    attr);
 		if (err != -ENOMEM) {
 			END_USE(vq);
 			return err;
@@ -1838,7 +1846,7 @@ static inline int virtqueue_add_packed_in_order(struct vring_virtqueue *vq,
 
 			if (vring_map_one_sg(vq, sg, n < out_sgs ?
 					     DMA_TO_DEVICE : DMA_FROM_DEVICE,
-					     &addr, &len, premapped))
+					     &addr, &len, premapped, attr))
 				goto unmap_release;
 
 			flags |= cpu_to_le16(vq->packed.avail_used_flags);
@@ -2781,13 +2789,14 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 				void *data,
 				void *ctx,
 				bool premapped,
-				gfp_t gfp)
+				gfp_t gfp,
+				unsigned long attr)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
 	return VIRTQUEUE_CALL(vq, add, sgs, total_sg,
 			      out_sgs, in_sgs, data,
-			      ctx, premapped, gfp);
+			      ctx, premapped, gfp, attr);
 }
 
 /**
@@ -2825,7 +2834,7 @@ int virtqueue_add_sgs(struct virtqueue *_vq,
 			total_sg++;
 	}
 	return virtqueue_add(_vq, sgs, total_sg, out_sgs, in_sgs,
-			     data, NULL, false, gfp);
+			     data, NULL, false, gfp, 0);
 }
 EXPORT_SYMBOL_GPL(virtqueue_add_sgs);
 
@@ -2847,7 +2856,7 @@ int virtqueue_add_outbuf(struct virtqueue *vq,
 			 void *data,
 			 gfp_t gfp)
 {
-	return virtqueue_add(vq, &sg, num, 1, 0, data, NULL, false, gfp);
+	return virtqueue_add(vq, &sg, num, 1, 0, data, NULL, false, gfp, 0);
 }
 EXPORT_SYMBOL_GPL(virtqueue_add_outbuf);
 
@@ -2870,7 +2879,7 @@ int virtqueue_add_outbuf_premapped(struct virtqueue *vq,
 				   void *data,
 				   gfp_t gfp)
 {
-	return virtqueue_add(vq, &sg, num, 1, 0, data, NULL, true, gfp);
+	return virtqueue_add(vq, &sg, num, 1, 0, data, NULL, true, gfp, 0);
 }
 EXPORT_SYMBOL_GPL(virtqueue_add_outbuf_premapped);
 
@@ -2892,10 +2901,38 @@ int virtqueue_add_inbuf(struct virtqueue *vq,
 			void *data,
 			gfp_t gfp)
 {
-	return virtqueue_add(vq, &sg, num, 0, 1, data, NULL, false, gfp);
+	return virtqueue_add(vq, &sg, num, 0, 1, data, NULL, false, gfp, 0);
 }
 EXPORT_SYMBOL_GPL(virtqueue_add_inbuf);
 
+/**
+ * virtqueue_add_inbuf_cache_clean - expose input buffers with cache clean
+ * @vq: the struct virtqueue we're talking about.
+ * @sg: scatterlist (must be well-formed and terminated!)
+ * @num: the number of entries in @sg writable by other side
+ * @data: the token identifying the buffer.
+ * @gfp: how to do memory allocations (if necessary).
+ *
+ * Same as virtqueue_add_inbuf but passes DMA_ATTR_CPU_CACHE_CLEAN to indicate
+ * that the CPU will not dirty any cacheline overlapping this buffer while it
+ * is available, and to suppress overlapping cacheline warnings in DMA debug
+ * builds.
+ *
+ * Caller must ensure we don't call this with other virtqueue operations
+ * at the same time (except where noted).
+ *
+ * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
+ */
+int virtqueue_add_inbuf_cache_clean(struct virtqueue *vq,
+				    struct scatterlist *sg, unsigned int num,
+				    void *data,
+				    gfp_t gfp)
+{
+	return virtqueue_add(vq, &sg, num, 0, 1, data, NULL, false, gfp,
+			     DMA_ATTR_CPU_CACHE_CLEAN);
+}
+EXPORT_SYMBOL_GPL(virtqueue_add_inbuf_cache_clean);
+
 /**
  * virtqueue_add_inbuf_ctx - expose input buffers to other end
  * @vq: the struct virtqueue we're talking about.
@@ -2916,7 +2953,7 @@ int virtqueue_add_inbuf_ctx(struct virtqueue *vq,
 			void *ctx,
 			gfp_t gfp)
 {
-	return virtqueue_add(vq, &sg, num, 0, 1, data, ctx, false, gfp);
+	return virtqueue_add(vq, &sg, num, 0, 1, data, ctx, false, gfp, 0);
 }
 EXPORT_SYMBOL_GPL(virtqueue_add_inbuf_ctx);
 
@@ -2941,7 +2978,7 @@ int virtqueue_add_inbuf_premapped(struct virtqueue *vq,
 				  void *ctx,
 				  gfp_t gfp)
 {
-	return virtqueue_add(vq, &sg, num, 0, 1, data, ctx, true, gfp);
+	return virtqueue_add(vq, &sg, num, 0, 1, data, ctx, true, gfp, 0);
 }
 EXPORT_SYMBOL_GPL(virtqueue_add_inbuf_premapped);
 
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 3626eb694728..63bb05ece8c5 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -62,6 +62,11 @@ int virtqueue_add_inbuf(struct virtqueue *vq,
 			void *data,
 			gfp_t gfp);
 
+int virtqueue_add_inbuf_cache_clean(struct virtqueue *vq,
+				    struct scatterlist sg[], unsigned int num,
+				    void *data,
+				    gfp_t gfp);
+
 int virtqueue_add_inbuf_ctx(struct virtqueue *vq,
 			    struct scatterlist sg[], unsigned int num,
 			    void *data,
-- 
MST

