Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDB0455173;
	Sun,  4 Oct 2026 13:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791118900; cv=none; b=hIIPo+v46+JOjdTR02P7xTFRA/UtWr/gmWsW6FJoqp/knuyjHM7oZpmozugPkc7LpW1CNNgguI1pwtWPjzfrCuVuXjjtNxS3kd+TVlBPB/CWyWL9CzZTrVtoJKAw4E2UCr5rl8xC1ahb0MPIs7bI+4lN79DZjIHCGLlzVgKfEeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791118900; c=relaxed/simple;
	bh=6vqZ00V+E3OK79muU/neuFKzs/C88IDoBvO3KKAZoZw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=bUXOoirO6E97kUdLNwwP8m6v+0ZEiZ21cOYRlUYAEo0UqXWq0M1t2LOIqkLmZmBFpaJD1juk7wUcLPQzPAVzY3dzmyZO8Npubi20k/0Tg+2ekzrhxF3pz0FmUUPP5s4WzpDKcSeCEKbh2Nslh2xSG5Me1pq8hg1InWyczqQqVKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=BDYcI8uB; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="BDYcI8uB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1791118892; bh=cHDq25Y+yV6vFs0FX/h+j9mrQ8fofdiTpT1pMjUdHnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BDYcI8uBGOljbUl7wiGishGHV3l1JHMEFERGjhonRsl6+MpHWeVBWYMmVv64OfMPl
	 yyMAoNr4c+r4iLBlRdubsMJ5Nx3a3IcNIGWMDr4OebmusXzYYnLd1ktKmYnUWpu1a0
	 Y46XOZckjU+QYcVHBEs84PxmRkzm9s2TK67nTwSw=
Received: from xiuos ([2001:da8:201:1175:6e92:bfff:fe3b:37c3])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 4EAF2BA; Sun, 04 Oct 2026 21:01:14 +0800
X-QQ-mid: xmsmtpt1791118889tzgcyoi7v
Message-ID: <tencent_7A12897B7DF3E958E903DD2A4557A8F6BC05@qq.com>
X-QQ-XMAILINFO: M7+MjJVZrEre4641XOEaUBTq92Lbal5hBBuEI1qlohfO5ImTyOfOf/akJPzVnA
	 x3s4uxo0uy98kcyjQuHDF89vn/fTuUldnM++ZbgO5r+RLfb4a2/uN+6cv9PE5wKVPUMgCKNX//EY
	 YOsPn9yCW0A5ITCNdPLMrW4sA1vROEkzXzN9KEU2jj3XSf/rwcTfHcS1XMuUGOjtkXKIRXhyyf3v
	 yLOWWuc5HzAquLHQiFdTpvqmkyPreeWJTveED4YWKd7jt9Bcb5rculnwgNxyyTNSlnwqYEQhWdOo
	 pc9bQBT2fnP6+F/qVT+eGu35JKzEPRtg7+tK4jrThXwSGaz8PZLmO2mcsDKLiOWwPPXwF5bOFgKV
	 oT4/Kz14Iqr95tSPJFSmzcGGQREg1UIKvt7e2RzmSRRusBkC1RCkJMnF0iuzV6Kc4M7DD9pJETE+
	 L7kxerGQqfal5SLr4SIVIuGlRE9FdwyLJkyipwz6hZeN+8yn1nKsY6VVA4CrbuPPLY4R3JUuYnGF
	 NsdaZ3CQp5kNbKx7gapVFNX2NlYE3NvdUR95mX5DaIyl4kncZt25fI+AlBRFUUHRK4aBXwi7wpKU
	 dpla1YgG/qru4kLYclQ20kqk19/4ASue/2fgaFpDdfYNpQbNBm6vFY/8ak7iaX32sqGKMlWKa6ie
	 wpr79UBa+PhvAfzuon2kRSGbsJlYdhXVldZPuqJV732euL1kz8hsIJL0qgFeCRVSwEldKYlJESdZ
	 qqcwzVCjooMImKm/fZkQT9KyINmNeBcRKDHrEv87w1OuFj9FeGeCS3kC4ST+GYSIZtexUyjtOliQ
	 iuBzBuGbvP/qbTEEu141nzEPU5A/Jdmr4dxs7VA1wM2i2oPIZty4gSUWpi0XRUakxU+lpw3OH9ez
	 8KpidBZmaZ+B0A0vLqqNNuvQ8/aM2uGVX1s1IczmGIV99Z/XxhU8Pmjza5Vv+usly3kaR+xaWmb4
	 fNWniCm5743ZbtCMRvJ6rQVTA+8n9YPDBLmsAevDSyAtD4QsZeqz/6fk4gUjh+EzE+mEclSXOgBn
	 miK9Do+pQ6uUNHMnoOOBfTdI88kM/J5UIiE8mQHMoVyeOEygpOm2ES0IUTkdeExGlKVcMmwS46u/
	 XexO436osZCFObOHITtrRsAyMOc/2V5qX6ev5zM2C5VGC+RvSIQaN4b79Mjfp1fG9UtxHPUEGp2o
	 flaFoVR3Ov/msMGDMghhwLwMU93kvY1TwJIhijPwz/BjcGspP53s309I3Bc/P2Mb5hzOs=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Anlai Lu <agicy@qq.com>
To: Jean-Philippe Brucker <jpb@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	virtualization@lists.linux.dev,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Anlai Lu <agicy@qq.com>
Subject: [PATCH v2 6/6] iommu/virtio: batch the mapping replay on domain attach
Date: Sun,  4 Oct 2026 13:01:13 +0000
X-OQ-MSGID: <20261004130113.3225005-6-agicy@qq.com>
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

viommu_replay_mappings() sent every mapping of a domain to the device
with a synchronous request, holding mappings_lock - and with it
interrupts - across the whole walk, so the IRQ-off window grew with the
number of mappings: 233 ms for 8192 4K mappings, 29 s for a million.

Queue them instead and wait once. One mapping per mappings_lock section,
so that a full virtqueue - the only wait in there - bounds a single lock
hold rather than the whole walk; the walk is a single pass, because the
endpoint was published before it (a mapping inserted while it runs is
queued by map_pages() itself) and a mapping removed meanwhile has its
UNMAP queued in the section that removed it. The requests carry the
device's errno back - the first error it reported - so a rejected replay
fails the attach with the device's own status, and a device that goes
away fails it with -ENODEV rather than reporting a replay that never
happened; a duplicate MAP, which a replay can legitimately produce, is
answered S_INVAL - the spec says a duplicate MAP SHOULD be rejected and
MUST NOT change the existing mapping - and is not treated as a rejection.
A rejected MAP on the map path is still ignored, as before.

Measured, N=8192 4K mappings: max IRQ-off window 233.7 ms -> 1.4-2.5 ms,
and no longer growing with N (1.4-2.5 ms from N=64 to 32768, against
3.6/45/233 ms on the unpatched driver); attach ioctl 218.9/249.0 ->
50.3/48.8 ms (48-67 ms across runs); viommu_send_req_sync() calls 8193 ->
1; the device receives exactly the same MAPs (8244).

Signed-off-by: Anlai Lu <agicy@qq.com>
---
 drivers/iommu/virtio-iommu.c | 149 +++++++++++++++++++++++++++--------
 1 file changed, 117 insertions(+), 32 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 8a93d5f0668f..523fa8fa8aa7 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -73,6 +73,19 @@ struct viommu_mapping {
 	struct viommu_request		*unmap_req;
 };
 
+/* Where a queued request reports a rejection, or NULL */
+struct viommu_req_status {
+	bool				*rejected;
+	/*
+	 * Errno to treat as success: a replayed MAP can be a duplicate,
+	 * which the spec says the device SHOULD reject with S_INVAL and
+	 * MUST NOT change the existing mapping.
+	 */
+	int				ignore_errno;
+	/* The first error the device reported, for the caller to return */
+	int				err;
+};
+
 struct viommu_domain {
 	struct iommu_domain		domain;
 	struct viommu_dev		*viommu;
@@ -104,6 +117,8 @@ struct viommu_request {
 	void				*writeback;
 	unsigned int			write_offset;
 	unsigned int			len;
+	/* Where to report a failure of this request, or NULL */
+	struct viommu_req_status	*status;
 	char				buf[] __counted_by(len);
 };
 
@@ -144,6 +159,19 @@ static bool viommu_domain_has_endpoint(struct viommu_domain *vdomain)
 	return has;
 }
 
+/* Same, for callers that do not hold request_lock */
+static bool viommu_device_alive(struct viommu_dev *viommu)
+{
+	unsigned long flags;
+	bool live;
+
+	spin_lock_irqsave(&viommu->request_lock, flags);
+	live = viommu_device_live(viommu);
+	spin_unlock_irqrestore(&viommu->request_lock, flags);
+
+	return live;
+}
+
 static int viommu_get_req_errno(void *buf, size_t len)
 {
 	struct virtio_iommu_req_tail *tail = buf + len - sizeof(*tail);
@@ -216,6 +244,16 @@ static int __viommu_sync_req(struct viommu_dev *viommu)
 			viommu_set_req_status(req->buf, req->len,
 					      VIRTIO_IOMMU_S_IOERR);
 
+		if (req->status) {
+			int err = viommu_get_req_errno(req->buf, req->len);
+
+			if (err && err != req->status->ignore_errno) {
+				*req->status->rejected = true;
+				if (!req->status->err)
+					req->status->err = err;
+			}
+		}
+
 		write_len = req->len - req->write_offset;
 		if (req->writeback && len == write_len)
 			memcpy(req->writeback, req->buf + req->write_offset,
@@ -286,6 +324,7 @@ static int __viommu_queue_req(struct viommu_dev *viommu,
  * @buf: pointer to the request buffer
  * @len: length of the request buffer
  * @writeback: copy data back to the buffer when the request completes.
+ * @status: where to report a rejection of this request, or NULL
  *
  * Allocate a request object, fill it and queue it.  When @writeback is true,
  * data written by the device, including the request status, is copied into
@@ -295,7 +334,7 @@ static int __viommu_queue_req(struct viommu_dev *viommu,
  * Return 0 if the request was successfully added to the queue.
  */
 static int __viommu_add_req(struct viommu_dev *viommu, void *buf, size_t len,
-			    bool writeback)
+			    bool writeback, struct viommu_req_status *status)
 {
 	int ret;
 	off_t write_offset;
@@ -312,6 +351,7 @@ static int __viommu_add_req(struct viommu_dev *viommu, void *buf, size_t len,
 		return -ENOMEM;
 
 	req->len = len;
+	req->status = status;
 	if (writeback) {
 		req->writeback = buf + write_offset;
 		req->write_offset = write_offset;
@@ -325,13 +365,14 @@ static int __viommu_add_req(struct viommu_dev *viommu, void *buf, size_t len,
 	return ret;
 }
 
-static int viommu_add_req(struct viommu_dev *viommu, void *buf, size_t len)
+static int viommu_add_req(struct viommu_dev *viommu, void *buf, size_t len,
+			  struct viommu_req_status *status)
 {
 	int ret;
 	unsigned long flags;
 
 	spin_lock_irqsave(&viommu->request_lock, flags);
-	ret = __viommu_add_req(viommu, buf, len, false);
+	ret = __viommu_add_req(viommu, buf, len, false, status);
 	if (ret)
 		dev_dbg(viommu->dev, "could not add request: %d\n", ret);
 	spin_unlock_irqrestore(&viommu->request_lock, flags);
@@ -354,6 +395,7 @@ static int viommu_queue_prealloc_req(struct viommu_dev *viommu,
 
 	spin_lock_irqsave(&viommu->request_lock, flags);
 	req->len = len;
+	req->status = NULL;
 	req->writeback = NULL;
 	memcpy(req->buf, buf, write_offset);
 	ret = __viommu_queue_req(viommu, req, write_offset);
@@ -374,7 +416,7 @@ static int viommu_send_req_sync(struct viommu_dev *viommu, void *buf,
 
 	spin_lock_irqsave(&viommu->request_lock, flags);
 
-	ret = __viommu_add_req(viommu, buf, len, true);
+	ret = __viommu_add_req(viommu, buf, len, true, NULL);
 	if (ret) {
 		dev_dbg(viommu->dev, "could not add request (%d)\n", ret);
 		goto out_unlock;
@@ -462,7 +504,7 @@ static int viommu_add_mapping(struct viommu_domain *vdomain, u64 iova, u64 end,
 			.flags		= cpu_to_le32(flags),
 		};
 
-		ret = viommu_add_req(vdomain->viommu, &map, sizeof(map));
+		ret = viommu_add_req(vdomain->viommu, &map, sizeof(map), NULL);
 		if (ret) {
 			interval_tree_remove(&mapping->iova, &vdomain->mappings);
 			spin_unlock_irqrestore(&vdomain->mappings_lock, irqflags);
@@ -656,23 +698,57 @@ static int viommu_domain_map_identity(struct viommu_endpoint *vdev,
 }
 
 /*
- * viommu_replay_mappings - re-send MAP requests
+ * viommu_replay_mappings - send every mapping of the domain again
  *
- * When reattaching a domain that was previously detached from all endpoints,
- * mappings were deleted from the device. Re-create the mappings available in
- * the internal tree.
+ * Used when reattaching a domain that was previously detached from all
+ * endpoints: the device dropped its copy then (it frees a domain together with
+ * its last endpoint).
+ *
+ * The device is not waited for between mappings: they are all queued, one per
+ * mappings_lock section, and waited for once at the end.  A full virtqueue is
+ * the only wait in the loop, so it bounds a single lock hold rather than the
+ * whole walk.  A mapping that was sent concurrently is harmless: the spec says
+ * a duplicate MAP SHOULD be rejected with S_INVAL and MUST NOT change the
+ * existing mapping, and the replay treats that rejection as success.
+ *
+ * A rejected MAP is reported by returning an error, which fails the attach: the
+ * domain would be missing a mapping its driver believes in.  Nothing else is
+ * done about it.
  */
 static int viommu_replay_mappings(struct viommu_domain *vdomain)
 {
-	int ret = 0;
+	bool rejected = false;
+	struct viommu_req_status status = {
+		.rejected	= &rejected,
+		.ignore_errno	= -EINVAL,
+	};
 	unsigned long flags;
-	struct viommu_mapping *mapping;
-	struct interval_tree_node *node;
-	struct virtio_iommu_req_map map;
+	int ret = 0;
+	struct interval_tree_node *node = NULL;
+
+	/*
+	 * A single pass is enough: the endpoint was published before this ran,
+	 * so a mapping inserted while the walk progresses is queued by
+	 * map_pages() itself, and one inserted before it is in the tree when
+	 * the walk starts.  A mapping removed meanwhile is simply not there any
+	 * more, and its UNMAP was queued in the same section that removed it,
+	 * so it cannot end up after a MAP this walk sends.
+	 */
+	u64 next_iova = 0;
+	bool done = false;
+
+	while (!done) {
+		struct viommu_mapping *mapping;
+		struct virtio_iommu_req_map map;
+
+		spin_lock_irqsave(&vdomain->mappings_lock, flags);
+		node = interval_tree_iter_first(&vdomain->mappings, next_iova,
+						-1UL);
+		if (!node) {
+			spin_unlock_irqrestore(&vdomain->mappings_lock, flags);
+			break;
+		}
 
-	spin_lock_irqsave(&vdomain->mappings_lock, flags);
-	node = interval_tree_iter_first(&vdomain->mappings, 0, -1UL);
-	while (node) {
 		mapping = container_of(node, struct viommu_mapping, iova);
 		map = (struct virtio_iommu_req_map) {
 			.head.type	= VIRTIO_IOMMU_T_MAP,
@@ -682,26 +758,35 @@ static int viommu_replay_mappings(struct viommu_domain *vdomain)
 			.phys_start	= cpu_to_le64(mapping->paddr),
 			.flags		= cpu_to_le32(mapping->flags),
 		};
+		ret = viommu_add_req(vdomain->viommu, &map, sizeof(map), &status);
 
-		ret = viommu_send_req_sync(vdomain->viommu, &map, sizeof(map));
-		if (ret) {
-			/*
-			 * The endpoint was published before this walk, so a
-			 * map_pages() racing it can have sent the same MAP
-			 * already: the spec says a duplicate MAP SHOULD be
-			 * rejected with S_INVAL, and the device MUST NOT
-			 * change the existing mapping.
-			 */
-			if (ret != -EINVAL)
-				break;
-			ret = 0;
-		}
+		if (mapping->iova.last == ULONG_MAX)
+			done = true;
+		else
+			next_iova = mapping->iova.last + 1;
+		spin_unlock_irqrestore(&vdomain->mappings_lock, flags);
 
-		node = interval_tree_iter_next(node, 0, -1UL);
+		if (ret)
+			break;
 	}
-	spin_unlock_irqrestore(&vdomain->mappings_lock, flags);
 
-	return ret;
+	/* Wait for all of them outside the lock: this is the batched drain */
+	viommu_sync_req(vdomain->viommu);
+
+	/*
+	 * A device that went away did not take anything: the status pointers of
+	 * the requests still queued are on this frame, so report it here rather
+	 * than pretending the replay delivered the mappings.
+	 */
+	if (!viommu_device_alive(vdomain->viommu))
+		return -ENODEV;
+
+	/* The queueing failure, or what the device said */
+	if (ret)
+		return ret;
+
+	/* Report what the device said, like the synchronous replay did */
+	return rejected ? (status.err ?: -EIO) : 0;
 }
 
 static int viommu_add_resv_mem(struct viommu_endpoint *vdev,
-- 
2.55.0

