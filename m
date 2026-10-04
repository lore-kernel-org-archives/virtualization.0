Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C5F39CCFE;
	Sun,  4 Oct 2026 13:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791118893; cv=none; b=PoHG17IM6OksiG9oVDZCve89bXEHWkxNpJxUvvmaKt4Oi1qf1ew27fGSonaBQqrFRMrWfRuzef64WAYyxp8PnZgRkiHBXHieg4KsfRJZjPRT47moRzOi3H05giG9B5wDGRTddcGY1dCxzgKRKCTJu9ZW9+5axyHxwwwc2cQgbGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791118893; c=relaxed/simple;
	bh=c/AWwlyiYSQcp6lEsGAa1BN+9ZscB5YX+Ed0bVdOrZM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Zqa5GcxKYTwOrEZ650Byx7MheiRIgSl5HgQV8FVQQlplawgnbRVVvNbun/Ye+xZEgtdbKB+5K2o8bagleZvsf93Z9KEaDuPHhdiekGYgwPASKPhtzQ0m99zk5R+qDGfj1u6FiBwHgQlyViB8cGx8awJaAbFb6RUNTunaVQFLpek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ujlXy2Vf; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ujlXy2Vf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1791118886; bh=4rgW499D0FprHN7uLiRg4PBA8h9moqhzZ62f/fAZFAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ujlXy2VfHpP2qMNsDTvj1+YVP7cPunJy4a0pCwmADuMIflBahBan4eZzgFjUp2Yse
	 87LppGcPvq5KMycOlBZtxl1kprFtJT/zEspYVuwbJ+PIy4qPBp2B31vDNuF9ol+YLr
	 LLzv88SkQA2AXdwI4FJj0P1hQxwWEsxOi81FSWR0=
Received: from xiuos ([2001:da8:201:1175:6e92:bfff:fe3b:37c3])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 4EAF2BA; Sun, 04 Oct 2026 21:01:14 +0800
X-QQ-mid: xmsmtpt1791118883tsc56pkgz
Message-ID: <tencent_3459CDE83AD42E569670D36C0A1FAB7C840A@qq.com>
X-QQ-XMAILINFO: OMR9O8S7q+mYh8XX5MLalZEH4+31C1yDCCgwX2Cq3yYSEbSX9YFpC/zye0M57Y
	 JRPST+t/UZshRIBxaIgtN+66MSOl4w4rCHfVrcVxZATgRaMAMLFTblgj6Q2UxWjZvV588yfjr9Bq
	 xna7aYmLnZ89gsSHSBIA5gZLNZ6LBtL4COfDEkv50V2fCI9KCACNrOnkYthQEPRPOzL2gFxl+odF
	 XLAkFpmVSSt1aJ3AydaTbnH62+VS1W4tU/CXElQaT+oUIBHvpALJ/GXpOUk1wITXjs2aPQbtXvbL
	 ZyUy+1KBZFyEvnycpUiDFkmF9vK9ubxeaKMssP5j+7JHso28m01vT/gUqMuAgMS/B9w1M9NfIRtt
	 oDzN90KWKmS5g29BFnty7IidH11loH7JgtiW536ET0VrYbHh0tkXVkxEIuS22mjSHD2Wa02Kghz+
	 OsvrOs2HWmViu0vnt1mOwxNrTtzXwY3Cwbe1/by/wrrJ1E+ulCw2j+yzffxNuLe8bnx2AumFxeJa
	 VU7nSx8WiMWynd+0VPLuXHsdKjzu8T3CjcivJnFzYOkICBp2hrJVjHIMgmU49ZJWn3Kw6elLCSYm
	 nPLqVqu4IoKNQ2d3UUlV852vMTaJ5u+Pw9jS4FcrEoDBq8wrKxJoe0uv7L9MxnnBay+ccWBXAXMM
	 sKaOp4hCZdvvOdvTkLwvjQ0k+fR9Q/jbwQn/BBeJmvnY4iK44UNAcxmHjOnQye6IDe4uu5M6/Giw
	 od6baUwGiOnzp8AxP2rRT0xRnASfvE6RfeaxdwvMMqqglM3ZvgDX/rieerNXjeH8d3/EN8dzKLH1
	 0+FNkEIp0DnC0TVxjfC1403uGpQ8MGXd5wA3pDQNqIaLJh5UlcQlM45tWTchhkHsesnExF8wweox
	 9zA/vjE+QJpW1F5V2lRNEe9NRqPH4nhU84kNRdbfvemuUXvrxlzrQYLed3N44CzmE+nJ9xyv0YNR
	 EGN7q+x8KqRpcRTYirBJaHZOq5w6aGhQhK539bXEAMq30Fh5j8t2Qjo6tfSfpm3UtXphcexZ/iTb
	 cksKEdLfz/yzesv5M1lVY5ZVMaygKfjxgZoUaQM2cVdVrr26gLSJJmtCdzHgA5wtHD8vpMFcN/qt
	 jwwqnS7uL8qKJ4l+fHiQYIbtKWGb6l9ucETQX6Iqs+lnPRgFltbKXNE5fYTrMm9i2SV3Tjeu0HuZ
	 D7yRmONc5S0ET6DYkP7cctqORCGcs0dwq/WEURiHeWuENXfQ==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Anlai Lu <agicy@qq.com>
To: Jean-Philippe Brucker <jpb@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	virtualization@lists.linux.dev,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Anlai Lu <agicy@qq.com>
Subject: [PATCH v2 2/6] iommu/virtio: queue an UNMAP for every removed mapping
Date: Sun,  4 Oct 2026 13:01:09 +0000
X-OQ-MSGID: <20261004130113.3225005-2-agicy@qq.com>
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

viommu_unmap_pages() removed whole mappings from the tree and then, with
mappings_lock dropped, queued a single UNMAP built from the range the
caller asked for. Both halves are wrong in the direction the device's
semantics are strict about: a device must not split a mapping, so the
driver removes whole mappings - and an UNMAP whose range begins or ends
inside another mapping invalidates nothing there, leaving the device
mapping memory the driver has released; and between the removal and the
queueing a concurrent map_pages() of the same range can put its MAP in
front of the UNMAP.

Queue the UNMAPs in the critical section that removes the mappings, one
request per contiguous run of removed mappings, covering exactly the
mappings' own ranges: a run's mappings are removed together and its
request covers all of them, nothing else. If a request cannot be queued,
the mapping being examined stays in the tree and the walk stops there,
and the run whose request could not be queued is not reported as
unmapped. That is not an atomic rollback: the run's mappings were already
removed from the tree and freed, and the caller is told the bytes that
really were unmapped, not that the whole range failed to unmap. The
request itself is still allocated on the unmap path here; the next patch
moves that allocation to the map path, where it is allowed to fail.

Fixes: edcd69ab9a32 ("iommu: Add virtio-iommu driver")
Signed-off-by: Anlai Lu <agicy@qq.com>
---
 drivers/iommu/virtio-iommu.c | 97 ++++++++++++++++++++++++++----------
 1 file changed, 71 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 0cccb36ba8e5..bb328f29ba71 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -402,20 +402,28 @@ static int viommu_add_mapping(struct viommu_domain *vdomain, u64 iova, u64 end,
  * @vdomain: the domain
  * @iova: start of the range
  * @end: end of the range
+ * @queue_unmap: queue an UNMAP for each run of removed mappings; false when
+ *               the device has already dropped the mappings
  *
- * On success, returns the number of unmapped bytes
+ * Returns the number of bytes unmapped, i.e. the mappings removed from the
+ * tree.  A run whose UNMAP could not be queued is not counted, and the walk
+ * stops there: later mappings stay in the tree.
  */
 static size_t viommu_del_mappings(struct viommu_domain *vdomain,
-				  u64 iova, u64 end)
+				  u64 iova, u64 end, bool queue_unmap)
 {
 	size_t unmapped = 0;
 	unsigned long flags;
-	struct viommu_mapping *mapping = NULL;
+	bool spanning = false;
+	u64 span_start = 0, span_end = 0;
 	struct interval_tree_node *node, *next;
 
 	spin_lock_irqsave(&vdomain->mappings_lock, flags);
 	next = interval_tree_iter_first(&vdomain->mappings, iova, end);
 	while (next) {
+		struct viommu_mapping *mapping;
+		size_t size;
+
 		node = next;
 		mapping = container_of(node, struct viommu_mapping, iova);
 		next = interval_tree_iter_next(node, iova, end);
@@ -428,13 +436,69 @@ static size_t viommu_del_mappings(struct viommu_domain *vdomain,
 		 * Virtio-iommu doesn't allow UNMAP to split a mapping created
 		 * with a single MAP request, so remove the full mapping.
 		 */
-		unmapped += mapping->iova.last - mapping->iova.start + 1;
+		size = mapping->iova.last - mapping->iova.start + 1;
+
+		/*
+		 * Queue one UNMAP per contiguous run of removed mappings, in the
+		 * same critical section that removes them, so that a concurrent
+		 * map of the same range cannot put its MAP in front of it.  The
+		 * range is the mappings' own: the caller's requested range can
+		 * begin or end inside another mapping and would then invalidate
+		 * nothing at all, and a range spanning a gap would drop a
+		 * mapping that is not being removed.
+		 */
+		if (queue_unmap && vdomain->nr_endpoints) {
+			if (spanning && mapping->iova.start == span_end + 1) {
+				span_end = mapping->iova.last;
+			} else {
+				if (spanning) {
+					struct virtio_iommu_req_unmap unmap = {
+						.head.type	= VIRTIO_IOMMU_T_UNMAP,
+						.domain		= cpu_to_le32(vdomain->id),
+						.virt_start	= cpu_to_le64(span_start),
+						.virt_end	= cpu_to_le64(span_end),
+					};
+
+					if (viommu_add_req(vdomain->viommu, &unmap,
+							   sizeof(unmap))) {
+						unmapped -= span_end - span_start + 1;
+						dev_warn_ratelimited(vdomain->viommu->dev,
+								     "could not queue an unmap\n");
+						goto out;
+					}
+				}
+				spanning = true;
+				span_start = mapping->iova.start;
+				span_end = mapping->iova.last;
+			}
+		}
 
 		interval_tree_remove(node, &vdomain->mappings);
 		kfree(mapping);
+		unmapped += size;
+	}
+
+	if (spanning) {
+		struct virtio_iommu_req_unmap unmap = {
+			.head.type	= VIRTIO_IOMMU_T_UNMAP,
+			.domain		= cpu_to_le32(vdomain->id),
+			.virt_start	= cpu_to_le64(span_start),
+			.virt_end	= cpu_to_le64(span_end),
+		};
+
+		if (viommu_add_req(vdomain->viommu, &unmap, sizeof(unmap))) {
+			unmapped -= span_end - span_start + 1;
+			dev_warn_ratelimited(vdomain->viommu->dev,
+					     "could not queue an unmap\n");
+		}
 	}
+out:
 	spin_unlock_irqrestore(&vdomain->mappings_lock, flags);
 
+	/*
+	 * What was really unmapped: a run whose UNMAP could not be queued is not
+	 * reported as one.
+	 */
 	return unmapped;
 }
 
@@ -483,7 +547,7 @@ static int viommu_domain_map_identity(struct viommu_endpoint *vdev,
 	return 0;
 
 err_unmap:
-	viommu_del_mappings(vdomain, 0, iova);
+	viommu_del_mappings(vdomain, 0, iova, false);
 	return ret;
 }
 
@@ -757,7 +821,7 @@ static void viommu_domain_free(struct iommu_domain *domain)
 	struct viommu_domain *vdomain = to_viommu_domain(domain);
 
 	/* Free all remaining mappings */
-	viommu_del_mappings(vdomain, 0, ULLONG_MAX);
+	viommu_del_mappings(vdomain, 0, ULLONG_MAX, false);
 
 	if (vdomain->viommu)
 		ida_free(&vdomain->viommu->domain_ids, vdomain->id);
@@ -1089,29 +1153,10 @@ static size_t viommu_unmap_pages(struct iommu_domain *domain, unsigned long iova
 				 size_t pgsize, size_t pgcount,
 				 struct iommu_iotlb_gather *gather)
 {
-	int ret = 0;
-	size_t unmapped;
-	struct virtio_iommu_req_unmap unmap;
 	struct viommu_domain *vdomain = to_viommu_domain(domain);
 	size_t size = pgsize * pgcount;
 
-	unmapped = viommu_del_mappings(vdomain, iova, iova + size - 1);
-	if (unmapped < size)
-		return 0;
-
-	/* Device already removed all mappings after detach. */
-	if (!vdomain->nr_endpoints)
-		return unmapped;
-
-	unmap = (struct virtio_iommu_req_unmap) {
-		.head.type	= VIRTIO_IOMMU_T_UNMAP,
-		.domain		= cpu_to_le32(vdomain->id),
-		.virt_start	= cpu_to_le64(iova),
-		.virt_end	= cpu_to_le64(iova + unmapped - 1),
-	};
-
-	ret = viommu_add_req(vdomain->viommu, &unmap, sizeof(unmap));
-	return ret ? 0 : unmapped;
+	return viommu_del_mappings(vdomain, iova, iova + size - 1, true);
 }
 
 static phys_addr_t viommu_iova_to_phys(struct iommu_domain *domain,
-- 
2.55.0


