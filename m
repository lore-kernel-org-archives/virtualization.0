Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35BA381E8B;
	Sun,  4 Oct 2026 13:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791118892; cv=none; b=qERk/oyEO/VCl31zREzoalmfCPpqFAWnXAYdG4N2FQPResS3fdcZB6TpuahPDnQr1hgR9evbCiP37VN951qqswY2T+q3arBz1GigNjhLmZ++pClVe4WOoemLNAJFCO5NTtlC9+WxaougFrDa+6rpkbgGEH01aXGgwCOa0vTrZk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791118892; c=relaxed/simple;
	bh=bvL2Sw9SKNhXymoaELUuQ+zDFklJX1wXujGbBpalkM0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=YqbOb79jXMHwuRDtYp+JT3opIHEVvGEynE2iWX14R3H3EcQfKPvsd6xKeu4I/5ehGzUNfFbxz+UTfwazqWKMR+BuTFhno9eJqR8/4EkI8rjkeQ0SsCU3MivC+bA9mryULP6cJDlH/vB/EP1eKO2sDL32PRBCXhjhxKNG+ufBWRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=VauAvPi5; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="VauAvPi5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1791118884; bh=Y41iRAIi79XmPTFM8qTLe9Gdp0c++/9F2DiTyEkC1xk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VauAvPi5Rc12KlaIjkbwBxwDSZmQWaenUqMO+QZ0FPqfN5K/PLoYijU6/fUNfBZeb
	 FemTc4QNZuU6c62q7P4kYFrMMfuG/9py78pwWs1z/GYt7LaeTmvYHrxGE4pla91lzs
	 IRbeePZnGjDKRgrGUEdn+Ax4jmEQF2UHD6vn4ytc=
Received: from xiuos ([2001:da8:201:1175:6e92:bfff:fe3b:37c3])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 4EAF2BA; Sun, 04 Oct 2026 21:01:14 +0800
X-QQ-mid: xmsmtpt1791118874tl3v2z7rs
Message-ID: <tencent_D1D6479CD59F6E5CED7C653937DE66C73106@qq.com>
X-QQ-XMAILINFO: NbgegmlEc3JuVOCS7sB1KTLtpargS3Febc979oU52PwSypBQ/H9V/1G/BuvW+Z
	 2R/P9+UNXaEZA1rCFDaKDM4MoRL6WCorPRZwB1n4PrKGcY6JtDRuU5/c/2wnnxX05vnBaiV+9U7r
	 ixQMTlU+YAVyfVhEwNmMtpOpB66xsPMF6zawaGWCEPUlD3bvdoxnyDOp70eThqSzibD24Mtfh1Lr
	 aK3Bc3+YPEFEP7mauVUyZc/NKu4Hzd/4uoORH/hygPsN42Qike/4HcLyUeo4kpKA5euFuD3/LUjm
	 MJUQpVfMokH2hAbXm+iloxGwbRUNBRDjgbVIaKvTVjpOyf4su0/B2VqMcxOP9Bh8fhfAv/4KYE9a
	 d/CxMOnm4tPPo7M46wgYPucXY6cmKYXLDPpSI9/HdnvVx9FvQhjJbg+6PSh/XBqrmfE7rvRQ921e
	 V+kuaMrAqHTgfAU5KjyNrRCgJRl1ni2TWWfxkhYYCYNmq/do7F4NINV+3ZuMrPakfXrn2IfyvHDZ
	 DUE2L8c4Ad74LC4+9TCaWgKXq3GuICvw4XfXA7Dc3ZyB+inAUCq3B2idLJQwvhmwiRE9f9ZMkuDh
	 gCylvEmm2yPWNiKN47SXhoeKWxNOnU37j6C6j4XEgenSSz05Z8hhRMzOufuuRcExZjcUtgKLAB1+
	 fRD7FwJaohNtd6iZ/Pg/wEQrLJi/kxjAi2/5txNhlzRHUnhQyBarYWlP3+huRHHetuRNb+ps+NS1
	 9Mf2U9auKT5ANAdxjOV8kqMJhiSDcVnc7DI8Wn+l1ddVn8f6oYKKFmfrBDi+X5mZg/Ek/9ADSuPh
	 NLEEoue7BPSvNMOs/mmEVT3aJwQE275WTOjQI6yDRusj9VplGG475wuUBGAZ0oEyV/pZtNT0mr9B
	 4xSaWlM9v1yiBtAMbpXFD2bfDus269eEgIOD4k40TStSh3xlE5t2zolw610tlok+YFvJEARxphzm
	 qIUxGVxP47ZJnmJP5DQU3gz7cR02jKCGCMEI8m7xhuVksV0GT6KAODD8uS78KtEIzdwkG+yb/ldj
	 HmEm2Yn4o6cXNW+WKYE8YNkx8mtlN//RHLIe4bB5d52XFfGT684gh0DaShRguBtd5P2J/Y3OZzqs
	 peyrw/aHoV/1Qtf9fFp/o8K1WS/EG98i7+VuBDpXnms1fqGcdFrCNudMn5RxMKQ3XOFEKhxBTw55
	 ckGdE=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Anlai Lu <agicy@qq.com>
To: Jean-Philippe Brucker <jpb@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	virtualization@lists.linux.dev,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Anlai Lu <agicy@qq.com>
Subject: [PATCH v2 1/6] iommu/virtio: publish the endpoint before replaying it
Date: Sun,  4 Oct 2026 13:01:08 +0000
X-OQ-MSGID: <20261004130113.3225005-1-agicy@qq.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <tencent_D757B544955DDC509B5DC7161F425620BA08@qq.com>
References: <tencent_D757B544955DDC509B5DC7161F425620BA08@qq.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The device drops a domain's mappings together with its last endpoint, so
the first endpoint attaching to a domain has to replay them. The driver
published that endpoint only after the replay (nr_endpoints++, without a
lock), while viommu_map_pages() used the same counter, also without a
lock, to decide whether to queue its own MAP or leave it to the replay. A
map_pages() landing after the replay's walk had passed its range and
before the counter was bumped was therefore queued by nobody: the mapping
stayed in the driver's tree and never reached the device, silently, until
the domain was detached and attached again - DMA to it faults in the
meantime.

Publish the endpoint first, with the decision moved into
viommu_add_mapping() under mappings_lock so that it cannot race the
insert, and let the replay pick up the rest. A mapping that such a race
sends while the replay walks it is on the device twice, which the spec says
a duplicate MAP SHOULD be rejected with S_INVAL and MUST NOT change the
existing mapping - so the replay ignores it. A
second endpoint attaching while the first replay runs, or after one
failed, must replay too - it cannot tell that the mappings made it -
which the per-domain replay_pending flag tracks; it is set by the attach
that replays, cleared by a successful one, and cleared when the last
endpoint leaves (the device drops the domain then).

The endpoint is retired before the ATTACH that moves it, as before: its
count must not stay high while the device is already forgetting the old
domain, or an endpoint attaching to it would see it as known, skip the
replay, and join a domain the device has just recreated empty.

If the ATTACH fails, the endpoint did not move: it is given back to the old
domain, whose count would otherwise stay one endpoint short and whose next
attach would retire it a second time. If the replay fails instead, the
attach is reported as failed and the endpoint is put back on the old
domain - an endpoint left with no domain would be bypassed by a device
that enables bypass; the old domain lost its mappings when the endpoint
left it, so a replay is pending for the next attach to it.

Measured with a map thread racing the first attach (N=8192 4K mappings,
QEMU virtio-iommu): the unpatched driver leaves 1-2 mappings off the
device in 2 of 3 runs, and in 2 of 6 and 3 of 3 in later runs; with this
change the device ends with exactly the mappings the driver believes in,
in every run.

Fixes: edcd69ab9a32 ("iommu: Add virtio-iommu driver")
Signed-off-by: Anlai Lu <agicy@qq.com>
---
 drivers/iommu/virtio-iommu.c | 318 ++++++++++++++++++++++++++++-------
 1 file changed, 260 insertions(+), 58 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 587fc13197f1..0cccb36ba8e5 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -68,8 +68,15 @@ struct viommu_domain {
 
 	spinlock_t			mappings_lock;
 	struct rb_root_cached		mappings;
-
 	unsigned long			nr_endpoints;
+	/*
+	 * The domain is not known to be complete on the device: a replay is
+	 * running or has failed, or an endpoint came back after a failed ATTACH
+	 * and the flag was re-armed.  Another endpoint attaching must replay
+	 * too - it cannot tell that the mappings are there - and until a replay
+	 * succeeds no attach may report success on this domain.
+	 */
+	bool				replay_pending;
 };
 
 struct viommu_endpoint {
@@ -200,18 +207,47 @@ static int viommu_sync_req(struct viommu_dev *viommu)
 }
 
 /*
- * __viommu_add_request - Add one request to the queue
+ * Hand a filled-in request to the queue.  Only synchronizes the queue if it is
+ * already full, and never kicks nor waits.  On success the request belongs to
+ * the queue and is freed by the drain, not by the caller.
+ */
+static int __viommu_queue_req(struct viommu_dev *viommu,
+			      struct viommu_request *req, off_t write_offset)
+{
+	int ret;
+	struct scatterlist top_sg, bottom_sg;
+	struct scatterlist *sg[2] = { &top_sg, &bottom_sg };
+	struct virtqueue *vq = viommu->vqs[VIOMMU_REQUEST_VQ];
+
+	assert_spin_locked(&viommu->request_lock);
+
+	sg_init_one(&top_sg, req->buf, write_offset);
+	sg_init_one(&bottom_sg, req->buf + write_offset,
+		    req->len - write_offset);
+
+	ret = virtqueue_add_sgs(vq, sg, 1, 1, req, GFP_ATOMIC);
+	if (ret == -ENOSPC) {
+		/* If the queue is full, sync and retry */
+		if (!__viommu_sync_req(viommu))
+			ret = virtqueue_add_sgs(vq, sg, 1, 1, req, GFP_ATOMIC);
+	}
+	if (ret)
+		return ret;
+
+	list_add_tail(&req->list, &viommu->requests);
+	return 0;
+}
+
+/*
+ * __viommu_add_req - Add one request to the queue
  * @buf: pointer to the request buffer
  * @len: length of the request buffer
  * @writeback: copy data back to the buffer when the request completes.
  *
- * Add a request to the queue. Only synchronize the queue if it's already full.
- * Otherwise don't kick the queue nor wait for requests to complete.
- *
- * When @writeback is true, data written by the device, including the request
- * status, is copied into @buf after the request completes. This is unsafe if
- * the caller allocates @buf on stack and drops the lock between add_req() and
- * sync_req().
+ * Allocate a request object, fill it and queue it.  When @writeback is true,
+ * data written by the device, including the request status, is copied into
+ * @buf after the request completes: this is unsafe if the caller allocates
+ * @buf on stack and drops the lock between add_req() and sync_req().
  *
  * Return 0 if the request was successfully added to the queue.
  */
@@ -221,9 +257,6 @@ static int __viommu_add_req(struct viommu_dev *viommu, void *buf, size_t len,
 	int ret;
 	off_t write_offset;
 	struct viommu_request *req;
-	struct scatterlist top_sg, bottom_sg;
-	struct scatterlist *sg[2] = { &top_sg, &bottom_sg };
-	struct virtqueue *vq = viommu->vqs[VIOMMU_REQUEST_VQ];
 
 	assert_spin_locked(&viommu->request_lock);
 
@@ -242,23 +275,10 @@ static int __viommu_add_req(struct viommu_dev *viommu, void *buf, size_t len,
 	}
 	memcpy(&req->buf, buf, write_offset);
 
-	sg_init_one(&top_sg, req->buf, write_offset);
-	sg_init_one(&bottom_sg, req->buf + write_offset, len - write_offset);
-
-	ret = virtqueue_add_sgs(vq, sg, 1, 1, req, GFP_ATOMIC);
-	if (ret == -ENOSPC) {
-		/* If the queue is full, sync and retry */
-		if (!__viommu_sync_req(viommu))
-			ret = virtqueue_add_sgs(vq, sg, 1, 1, req, GFP_ATOMIC);
-	}
+	ret = __viommu_queue_req(viommu, req, write_offset);
 	if (ret)
-		goto err_free;
-
-	list_add_tail(&req->list, &viommu->requests);
-	return 0;
+		kfree(req);
 
-err_free:
-	kfree(req);
 	return ret;
 }
 
@@ -325,12 +345,15 @@ static int viommu_send_attach_req(struct viommu_dev *viommu, struct device *dev,
 /*
  * viommu_add_mapping - add a mapping to the internal tree
  *
- * On success, return the new mapping. Otherwise return NULL.
+ * Queue a MAP for it if the device already knows the domain.  Returns 0 on
+ * success, a negative error code otherwise, in which case the mapping is not
+ * in the tree.
  */
 static int viommu_add_mapping(struct viommu_domain *vdomain, u64 iova, u64 end,
 			      phys_addr_t paddr, u32 flags)
 {
 	unsigned long irqflags;
+	int ret;
 	struct viommu_mapping *mapping;
 
 	mapping = kzalloc_obj(*mapping, GFP_ATOMIC);
@@ -344,6 +367,30 @@ static int viommu_add_mapping(struct viommu_domain *vdomain, u64 iova, u64 end,
 
 	spin_lock_irqsave(&vdomain->mappings_lock, irqflags);
 	interval_tree_insert(&mapping->iova, &vdomain->mappings);
+
+	/*
+	 * If the device already knows this domain, queue the MAP right away.
+	 * Nobody waits for it: a rejection is not reported to the caller, as
+	 * before.
+	 */
+	if (vdomain->nr_endpoints) {
+		struct virtio_iommu_req_map map = {
+			.head.type	= VIRTIO_IOMMU_T_MAP,
+			.domain		= cpu_to_le32(vdomain->id),
+			.virt_start	= cpu_to_le64(iova),
+			.phys_start	= cpu_to_le64(paddr),
+			.virt_end	= cpu_to_le64(end),
+			.flags		= cpu_to_le32(flags),
+		};
+
+		ret = viommu_add_req(vdomain->viommu, &map, sizeof(map));
+		if (ret) {
+			interval_tree_remove(&mapping->iova, &vdomain->mappings);
+			spin_unlock_irqrestore(&vdomain->mappings_lock, irqflags);
+			kfree(mapping);
+			return ret;
+		}
+	}
 	spin_unlock_irqrestore(&vdomain->mappings_lock, irqflags);
 
 	return 0;
@@ -469,8 +516,18 @@ static int viommu_replay_mappings(struct viommu_domain *vdomain)
 		};
 
 		ret = viommu_send_req_sync(vdomain->viommu, &map, sizeof(map));
-		if (ret)
-			break;
+		if (ret) {
+			/*
+			 * The endpoint was published before this walk, so a
+			 * map_pages() racing it can have sent the same MAP
+			 * already: the spec says a duplicate MAP SHOULD be
+			 * rejected with S_INVAL, and the device MUST NOT
+			 * change the existing mapping.
+			 */
+			if (ret != -EINVAL)
+				break;
+			ret = 0;
+		}
 
 		node = interval_tree_iter_next(node, 0, -1UL);
 	}
@@ -730,6 +787,97 @@ static struct iommu_domain *viommu_domain_alloc_identity(struct device *dev)
 	return domain;
 }
 
+/*
+ * Publish an endpoint on this domain, and return whether the caller has to
+ * replay the mappings: it does when the device did not know the domain (first
+ * endpoint), and also when a replay is still running or failed - a second
+ * endpoint cannot tell that the mappings made it.
+ */
+static bool viommu_get_endpoint(struct viommu_domain *vdomain)
+{
+	unsigned long flags;
+	bool replay;
+
+	spin_lock_irqsave(&vdomain->mappings_lock, flags);
+	replay = !vdomain->nr_endpoints || vdomain->replay_pending;
+	vdomain->nr_endpoints++;
+	/* an attach that does not replay has nothing to wait for */
+	if (replay)
+		vdomain->replay_pending = true;
+	spin_unlock_irqrestore(&vdomain->mappings_lock, flags);
+
+	return replay;
+}
+
+/* The device holds every mapping of the domain */
+static void viommu_replayed(struct viommu_domain *vdomain)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&vdomain->mappings_lock, flags);
+	vdomain->replay_pending = false;
+	spin_unlock_irqrestore(&vdomain->mappings_lock, flags);
+}
+
+static void viommu_put_endpoint(struct viommu_domain *vdomain)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&vdomain->mappings_lock, flags);
+	if (WARN_ON_ONCE(!vdomain->nr_endpoints))
+		goto out;
+	if (!--vdomain->nr_endpoints)
+		/* the device drops the domain, and what it holds with it */
+		vdomain->replay_pending = false;
+out:
+	spin_unlock_irqrestore(&vdomain->mappings_lock, flags);
+}
+
+/*
+ * Give the endpoint back to a domain an attach had retired it from before the
+ * endpoint ended up on the new one: either the ATTACH did not take it, or it
+ * was moved back after a failed replay.  The count has to keep matching what
+ * the device holds, and if retiring it had dropped the last endpoint a replay
+ * is pending again: the domain's mappings are not known to be on the device,
+ * so a later attach replays instead of assuming they are there.
+ */
+static void viommu_restore_endpoint(struct viommu_domain *vdomain)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&vdomain->mappings_lock, flags);
+	if (!vdomain->nr_endpoints)
+		vdomain->replay_pending = true;
+	vdomain->nr_endpoints++;
+	spin_unlock_irqrestore(&vdomain->mappings_lock, flags);
+}
+
+/*
+ * Put the endpoints of @vdev back on @vdomain on the device.  A failed attach
+ * must leave the endpoint where the core believes it still is: left with no
+ * domain, it would be bypassed by a device that enables bypass, while the core
+ * believes the device is still translated.
+ *
+ * Returns what queueing the request returned.
+ */
+static int viommu_revert_attach(struct viommu_endpoint *vdev,
+				struct viommu_domain *vdomain)
+{
+	struct virtio_iommu_req_attach req = {
+		.head.type	= VIRTIO_IOMMU_T_ATTACH,
+	};
+
+	if (vdomain == &viommu_identity_domain) {
+		/* the bypass domain, which has no id of its own */
+		req.domain = cpu_to_le32(vdev->viommu->identity_domain_id);
+		req.flags = cpu_to_le32(VIRTIO_IOMMU_ATTACH_F_BYPASS);
+	} else {
+		req.domain = cpu_to_le32(vdomain->id);
+	}
+
+	return viommu_send_attach_req(vdev->viommu, vdev->dev, &req);
+}
+
 static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev,
 			     struct iommu_domain *old)
 {
@@ -737,6 +885,7 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev,
 	struct virtio_iommu_req_attach req;
 	struct viommu_endpoint *vdev = dev_iommu_priv_get(dev);
 	struct viommu_domain *vdomain = to_viommu_domain(domain);
+	struct viommu_domain *old_vdomain;
 
 	if (vdomain->viommu != vdev->viommu)
 		return -EINVAL;
@@ -751,10 +900,16 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev,
 	 * recreated if it gets reattached to an endpoint. Otherwise it will be
 	 * freed explicitly.
 	 *
+	 * Retire the old endpoint before sending this ATTACH: the count must
+	 * not stay high while the device is already dropping that old domain,
+	 * or an endpoint attaching to it would see it as known, skip the
+	 * replay, and join a domain the device just recreated empty.
+	 *
 	 * vdev->vdomain is protected by group->mutex
 	 */
-	if (vdev->vdomain)
-		vdev->vdomain->nr_endpoints--;
+	old_vdomain = vdev->vdomain;
+	if (old_vdomain)
+		viommu_put_endpoint(old_vdomain);
 
 	req = (struct virtio_iommu_req_attach) {
 		.head.type	= VIRTIO_IOMMU_T_ATTACH,
@@ -762,20 +917,70 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev,
 	};
 
 	ret = viommu_send_attach_req(vdomain->viommu, dev, &req);
-	if (ret)
+	if (ret) {
+		/*
+		 * The ATTACH did not take the endpoint: it is still on the
+		 * old domain with its mappings, and nothing has to be
+		 * replayed now.  A request that could not be queued never
+		 * reached the device, and a device that rejects one it
+		 * received leaves the endpoint where it was.
+		 *
+		 * Give the endpoint back to the old domain: otherwise its
+		 * count would stay one short, and the next attach would
+		 * retire it a second time.
+		 */
+		if (old_vdomain)
+			viommu_restore_endpoint(old_vdomain);
 		return ret;
+	}
 
-	if (!vdomain->nr_endpoints) {
+	/*
+	 * Publish the endpoint before replaying: the device knows the domain
+	 * now, so a map_pages() running concurrently queues its own request
+	 * instead of recording a mapping that this replay has already passed
+	 * and that nothing else will ever send.
+	 */
+	if (viommu_get_endpoint(vdomain)) {
 		/*
-		 * This endpoint is the first to be attached to the domain.
-		 * Replay existing mappings (e.g. SW MSI).
+		 * First endpoint to this domain, or the previous replay did not
+		 * finish: send the existing mappings (e.g. SW MSI) again.  A
+		 * second endpoint must not skip this - it has no way to know
+		 * that the mappings are there.
 		 */
 		ret = viommu_replay_mappings(vdomain);
-		if (ret)
+		if (ret) {
+			/*
+			 * The ATTACH reached the device, so the endpoint has
+			 * moved to the new domain even though its mappings did
+			 * not all make it.  Report the failure and ask the
+			 * device to take the endpoint back to the old domain,
+			 * where the core believes it still is.  That move
+			 * dropped the old domain's mappings on the device (a
+			 * domain is freed with its last endpoint), and they are
+			 * not sent again from here: an error path should not
+			 * start another replay.  viommu_restore_endpoint()
+			 * records the replay as pending instead, so the next
+			 * attach to that domain replays.
+			 *
+			 * If the device refuses to take the endpoint back, or
+			 * there was no old domain, leave the endpoint where it
+			 * is and record no domain for it: a domain the core
+			 * does not keep for this endpoint must not be counted,
+			 * and the endpoint is not left unattached either (a
+			 * device that enables bypass would pass it through).
+			 */
+			if (old_vdomain &&
+			    !viommu_revert_attach(vdev, old_vdomain))
+				/* the old domain lost its mappings with it */
+				viommu_restore_endpoint(old_vdomain);
+			else
+				vdev->vdomain = NULL;
+			viommu_put_endpoint(vdomain);
 			return ret;
+		}
+		viommu_replayed(vdomain);
 	}
 
-	vdomain->nr_endpoints++;
 	vdev->vdomain = vdomain;
 
 	return 0;
@@ -800,14 +1005,27 @@ static int viommu_attach_identity_domain(struct iommu_domain *domain,
 	if (ret)
 		return ret;
 
+	/*
+	 * The endpoint has moved: retire it from the old domain now.  Doing it
+	 * before the request would leave that domain's count decremented if the
+	 * ATTACH failed, and a later detach of the same endpoint would then
+	 * decrement it again.
+	 */
 	if (vdev->vdomain)
-		vdev->vdomain->nr_endpoints--;
-	vdomain->nr_endpoints++;
+		viommu_put_endpoint(vdev->vdomain);
+	/* the identity domain has no mappings of its own to replay */
+	if (viommu_get_endpoint(vdomain))
+		viommu_replayed(vdomain);
 	vdev->vdomain = vdomain;
 	return 0;
 }
 
 static struct viommu_domain viommu_identity_domain = {
+	/*
+	 * The endpoint helpers take mappings_lock for every domain, including
+	 * this static one, which is not allocated by viommu_domain_alloc_paging().
+	 */
+	.mappings_lock = __SPIN_LOCK_UNLOCKED(viommu_identity_domain.mappings_lock),
 	.domain = {
 		.type = IOMMU_DOMAIN_IDENTITY,
 		.ops = &(const struct iommu_domain_ops) {
@@ -835,7 +1053,7 @@ static void viommu_detach_dev(struct viommu_endpoint *vdev)
 		req.endpoint = cpu_to_le32(fwspec->ids[i]);
 		WARN_ON(viommu_send_req_sync(vdev->viommu, &req, sizeof(req)));
 	}
-	vdomain->nr_endpoints--;
+	viommu_put_endpoint(vdomain);
 	vdev->vdomain = NULL;
 }
 
@@ -847,7 +1065,6 @@ static int viommu_map_pages(struct iommu_domain *domain, unsigned long iova,
 	u32 flags;
 	size_t size = pgsize * pgcount;
 	u64 end = iova + size - 1;
-	struct virtio_iommu_req_map map;
 	struct viommu_domain *vdomain = to_viommu_domain(domain);
 
 	flags = (prot & IOMMU_READ ? VIRTIO_IOMMU_MAP_F_READ : 0) |
@@ -857,26 +1074,11 @@ static int viommu_map_pages(struct iommu_domain *domain, unsigned long iova,
 	if (flags & ~vdomain->map_flags)
 		return -EINVAL;
 
+	/* viommu_add_mapping() queues the MAP if the device knows the domain */
 	ret = viommu_add_mapping(vdomain, iova, end, paddr, flags);
 	if (ret)
 		return ret;
 
-	if (vdomain->nr_endpoints) {
-		map = (struct virtio_iommu_req_map) {
-			.head.type	= VIRTIO_IOMMU_T_MAP,
-			.domain		= cpu_to_le32(vdomain->id),
-			.virt_start	= cpu_to_le64(iova),
-			.phys_start	= cpu_to_le64(paddr),
-			.virt_end	= cpu_to_le64(end),
-			.flags		= cpu_to_le32(flags),
-		};
-
-		ret = viommu_add_req(vdomain->viommu, &map, sizeof(map));
-		if (ret) {
-			viommu_del_mappings(vdomain, iova, end);
-			return ret;
-		}
-	}
 	if (mapped)
 		*mapped = size;
 
-- 
2.55.0

