Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9B935F5E3
	for <virtualization@lists.linux.dev>; Sun,  9 Aug 2026 18:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786299623; cv=none; b=c4xMb6HSv53dywW0YEzpQ7/QG62G46NkqURDv1c7sk5ZIeI2op4jeFjbP0uTQlVRHEkL+nrTV8oi0bTBmOtTJxPDMEUKhpushRzQFS/kMdNOB/dDnav0/t0sXS3IFn4h1GEm2iUtbdjM7nIaGjAXWuX6YKN55bc5jneEhuTwd2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786299623; c=relaxed/simple;
	bh=gjlLwSNnFDEPAFVzQhoA8ipTHI1t2/ZcdBup/Ck6aaE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jxibJ4WJHIGayc2fIs/p0WYYN5gTklimEK5jBhHDqBJ2HuFRO0A5dRDLE3IU07Cn9Q/oLtfmKBoe2vEOUnuPPU/3la+kpbms7G58Hrn7JZdfn1SJHTmlaaWDA976prIDev7UJyYTJR5fnGsH6edXeemFoIyiM7FCWhlUD3jy0V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=UMwXBGTH; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="UMwXBGTH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1786299622; x=1817835622;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=84/xp2Y+X18kdGch+tpdJM7HA+HBrJiXOp2jp+iO4aU=;
  b=UMwXBGTHDm2xLOXlXL0CMzKgXOaerRLEZDd9m4UO4u7TMyPryoTZY7a4
   sTDbTRN5rXMVNHVuWuEDY3Oa6arqJDIDrMF+l1p/0ZqiqG5I78K8u49BW
   ywdloXcJ7ikUk85x41roBitUQRzAutMJXDYvBOF2PKrrVGTMItCS/7uP3
   GL5r6hV1mYs6NaSJ2fcvYD3v8CRaWAtmNmaIlgVX5YY+OPtBivCT4Etyw
   Ru6DlI3WO/Gwf6AMSgnIdAifzPeWouDtQ9kn5P4IH0qSTThJ/ssjMSAq4
   uhhdNquJgLmBmniKaw9Gsp0TwyXvAJHgtnRRw7WNSS1ZiHWZk4aymMpjK
   w==;
X-CSE-ConnectionGUID: dhgwElU8R/ShSAX2NjCLzg==
X-CSE-MsgGUID: 1vXdf49BQsifaZJnFixo+w==
X-IronPort-AV: E=Sophos;i="6.25,214,1779148800"; 
   d="scan'208";a="25395366"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2026 18:20:20 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:11000]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.171:2525] with esmtp (Farcaster)
 id e378ef4f-fe59-44b5-b2e4-eab231faa2d1; Sun, 9 Aug 2026 18:20:19 +0000 (UTC)
X-Farcaster-Flow-ID: e378ef4f-fe59-44b5-b2e4-eab231faa2d1
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Sun, 9 Aug 2026 18:20:19 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Sun, 9 Aug 2026 18:20:17 +0000
From: Alexander Graf <graf@amazon.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>
CC: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?q?Eugenio=20P=C3=A9rez?=
	<eperezma@redhat.com>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <nh-open-source@amazon.com>, Stefan Hajnoczi
	<stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH 02/12] virtio_ring: validate premapped addresses through the device's map
Date: Sun, 9 Aug 2026 18:20:00 +0000
Message-ID: <20260809182010.32931-3-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260809182010.32931-1-graf@amazon.com>
References: <20260809182010.32931-1-graf@amazon.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWC001.ant.amazon.com (10.13.139.202) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Callers that forget to handle a mapping failure may accidentally pass
DMA_MAPPING_ERROR as target map address and we don't error out for it.
The mapped path in vring_map_one_sg() checks the result, but the
premapped path takes the address as given. That makes it more difficult
to identify accidental API misuse.

Run the address through the existing vring_mapping_error(), which asks
the device's virtio_map_ops mapping_error op or dma_mapping_error(),
warn once and return -ENOMEM when it rejects the address. Document
where the premapped helpers expect their addresses to come from, since
an address from any other source is indistinguishable from a valid one.
That way an API misuse shows up at the call that made it.

Assisted-by: Kiro:claude-opus-5 checkpatch sparse
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 drivers/virtio/virtio_ring.c | 40 ++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index b438dc2ce1b8..9caa4f96204f 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -499,6 +499,19 @@ static int vring_map_one_sg(const struct vring_virtqueue *vq, struct scatterlist
 	if (premapped) {
 		*addr = sg_dma_address(sg);
 		*len = sg_dma_len(sg);
+
+		/*
+		 * The caller mapped this itself, so the map it used is the
+		 * only thing that can judge the result.  Ask it rather than
+		 * skipping the check the mapped path performs: a caller that
+		 * ignored a failed mapping would otherwise publish the
+		 * reserved error value to the device.
+		 */
+		if (dev_WARN_ONCE(&vq->vq.vdev->dev,
+				  vring_mapping_error(vq, *addr),
+				  "premapped buffer holds no valid mapping\n"))
+			return -ENOMEM;
+
 		return 0;
 	}
 
@@ -2910,6 +2923,14 @@ EXPORT_SYMBOL_GPL(virtqueue_add_outbuf);
  * @data: the token identifying the buffer.
  * @gfp: how to do memory allocations (if necessary).
  *
+ * Each entry of @sg must carry an address the caller obtained for this
+ * virtqueue: from the DMA API when virtqueue_dma_dev() returns a device, and
+ * from virtqueue_map_page_attrs() when it returns NULL, because the device
+ * then interprets every address published to it in its own terms.  Only an
+ * address the map itself rejects is caught here; an address from any other
+ * source is indistinguishable from a valid one and reaches the device
+ * unchanged.
+ *
  * Caller must ensure we don't call this with other virtqueue operations
  * at the same time (except where noted).
  *
@@ -3008,6 +3029,14 @@ EXPORT_SYMBOL_GPL(virtqueue_add_inbuf_ctx);
  * @ctx: extra context for the token
  * @gfp: how to do memory allocations (if necessary).
  *
+ * Each entry of @sg must carry an address the caller obtained for this
+ * virtqueue: from the DMA API when virtqueue_dma_dev() returns a device, and
+ * from virtqueue_map_page_attrs() when it returns NULL, because the device
+ * then interprets every address published to it in its own terms.  Only an
+ * address the map itself rejects is caught here; an address from any other
+ * source is indistinguishable from a valid one and reaches the device
+ * unchanged.
+ *
  * Caller must ensure we don't call this with other virtqueue operations
  * at the same time (except where noted).
  *
@@ -3025,10 +3054,17 @@ int virtqueue_add_inbuf_premapped(struct virtqueue *vq,
 EXPORT_SYMBOL_GPL(virtqueue_add_inbuf_premapped);
 
 /**
- * virtqueue_dma_dev - get the dma dev
+ * virtqueue_dma_dev - get the device to use for DMA API calls
  * @_vq: the struct virtqueue we're talking about.
  *
- * Returns the dma dev. That can been used for dma api.
+ * A NULL return means this virtqueue publishes no DMA addresses: either it
+ * needs no mapping at all, or the device supplies its own virtio_map_ops and
+ * interprets every address published to it in its own terms.  A caller that
+ * maps buffers itself must therefore check for NULL before using the DMA API
+ * on this virtqueue's behalf, and use virtqueue_map_page_attrs() when it is,
+ * which maps through whichever of the two the device uses.
+ *
+ * Return: the device to use for DMA API calls, or NULL when there is none.
  */
 struct device *virtqueue_dma_dev(struct virtqueue *_vq)
 {
